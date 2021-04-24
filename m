Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E0C36A0C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhDXLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhDXLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:07:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D305C06174A;
        Sat, 24 Apr 2021 04:06:19 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 310B222221;
        Sat, 24 Apr 2021 13:06:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619262375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7M0YInSrJVuiA5lwdzxZcXOgwbg2liKjyKQ6cDRhvY=;
        b=PBDRJy2WO1jvaNq/RGYAME6EuYOylj1MqmG6ZE379RZzKD072mWpOoFcFd5IE9mIDNTjgn
        DP+jS1bUaIFrI80dhdciJ4npZZYR5H26wlN5jmC7/6sSWaeliwH4/XzjJZAEUvO5b59jCy
        7EYXDvMARK9ldSBcgyQjdNES63get6k=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/5] nvmem: core: allow specifying of_node
Date:   Sat, 24 Apr 2021 13:06:04 +0200
Message-Id: <20210424110608.15748-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210424110608.15748-1-michael@walle.cc>
References: <20210424110608.15748-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the of_node of the parent device is used. Some devices
provide more than just the nvmem provider. To avoid name space clashes,
add a way to allow specifying the nvmem cells in subnodes. Consider the
following example:

    flash@0 {
        compatible = "jedec,spi-nor";

        partitions {
            compatible = "fixed-partitions";
            #address-cells = <1>;
            #size-cells = <1>;

            partition@0 {
                reg = <0x000000 0x010000>;
            };
        };

        otp {
            compatible = "user-otp";
            #address-cells = <1>;
            #size-cells = <1>;

            serial-number@0 {
                reg = <0x0 0x8>;
            };
        };
    };

There the nvmem provider might be the MTD partition or the OTP region of
the flash.

Add a new config->of_node parameter, which if set, will be used instead
of the parent's of_node.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
 - none

Changes since RFC:
 - none

 drivers/nvmem/core.c           | 4 +++-
 include/linux/nvmem-provider.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bca671ff4e54..62d363a399d3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -789,7 +789,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->reg_write = config->reg_write;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
-	if (!config->no_of_node)
+	if (config->of_node)
+		nvmem->dev.of_node = config->of_node;
+	else if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
 	switch (config->id) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e162b757b6d5..471cb7b9e896 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -57,6 +57,7 @@ struct nvmem_keepout {
  * @type:	Type of the nvmem storage
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
+ * @of_node:	If given, this will be used instead of the parent's of_node.
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
@@ -86,6 +87,7 @@ struct nvmem_config {
 	enum nvmem_type		type;
 	bool			read_only;
 	bool			root_only;
+	struct device_node	*of_node;
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-- 
2.20.1


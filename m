Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65302344E57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCVSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:20:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58171 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhCVSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:20:07 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0F90B2224E;
        Mon, 22 Mar 2021 19:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616437206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqn5S9TybePbO422xYcFMOeKpJEHtS42X4tYuvW7Ujc=;
        b=B5+erL/5mE9scPEO1K9bRLvN+5ygbHcjGUKy5LJreaw5u0Esi4tTLx1NTyZ862NdQrRtP4
        qk1gaBPXlQQ9pOYhENcEnVz0v9DEQzWg3+szRztAUBLUIL9+tlb3U5BWUQ5vAX3ibSjPaK
        vaiQy/UauJr8gWowiU8lkxTUT2HekBg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 1/4] nvmem: core: allow specifying of_node
Date:   Mon, 22 Mar 2021 19:19:46 +0100
Message-Id: <20210322181949.2805-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322181949.2805-1-michael@walle.cc>
References: <20210322181949.2805-1-michael@walle.cc>
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
            compatible = "mtd-user-otp";
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
---
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


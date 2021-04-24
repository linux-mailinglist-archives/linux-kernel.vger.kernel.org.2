Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907F736A0C3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhDXLHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhDXLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:07:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01124C06175F;
        Sat, 24 Apr 2021 04:06:23 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0A5F422258;
        Sat, 24 Apr 2021 13:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619262381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2HvHI2OzHepSWAD3Mvat5NnUhX2ATOzMyqhqXyfREQ=;
        b=nlBxAQ0FhgmYYH+3EsT77lH3EOCvdjNbfbbaKjCfKri4HAkJGyEmNUjg7HXhF6i5JH+/0h
        m/OiBe2Ft8mXzwCSp0dY0e4vsAvmYOKxnuLD6YHsxSJwJ1tjvDllJmQ6U5I5aL34gYhgpu
        VOW0kbrwDrEp07x7pOutFxAuFRt/WyY=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 4/5] dt-bindings: mtd: spi-nor: add otp property
Date:   Sat, 24 Apr 2021 13:06:07 +0200
Message-Id: <20210424110608.15748-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210424110608.15748-1-michael@walle.cc>
References: <20210424110608.15748-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI-NOR flashes may have OTP regions and have a nvmem binding. This
binding is described in mtd.yaml.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v1:
 - none

Changes since RFC:
 - new patch

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 5e7e5349f9a1..ed590d7c6e37 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -9,6 +9,9 @@ title: SPI NOR flash ST M25Pxx (and similar) serial flash chips
 maintainers:
   - Rob Herring <robh@kernel.org>
 
+allOf:
+  - $ref: "mtd.yaml#"
+
 properties:
   compatible:
     oneOf:
@@ -82,6 +85,9 @@ patternProperties:
   '^partition@':
     type: object
 
+  "^otp(-[0-9]+)?$":
+    type: object
+
 additionalProperties: false
 
 examples:
-- 
2.20.1


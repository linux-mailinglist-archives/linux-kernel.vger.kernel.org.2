Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C17361F23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhDPLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:50:08 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42547 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhDPLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:50:03 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2BEA622259;
        Fri, 16 Apr 2021 13:49:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618573777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRkPqnjS5YDgk8NQ66Yo0tAQL/4J4zRIFEj93tKMbLs=;
        b=JRF2Zu4zYjJfSu1XdXaojzHMGqdR3HmaFuC22rIYn1V1sVux4oOUsIXnlGYjqGfF9gs5GX
        1kRRn2FXqVr9MYqFSPID+voBhdi6oYAnYeDaIF4uQNJgVXF3p3f3rmeHkCj21HbhQ0S7yk
        GrwBfAjCDBKVcDfBZWRi/zAwPkoMPU0=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 4/5] dt-bindings: mtd: spi-nor: add otp property
Date:   Fri, 16 Apr 2021 13:49:27 +0200
Message-Id: <20210416114928.27758-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416114928.27758-1-michael@walle.cc>
References: <20210416114928.27758-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI-NOR flashes may have OTP regions and have a nvmem binding. This
binding is described in mtd.yaml.

Signed-off-by: Michael Walle <michael@walle.cc>
---
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


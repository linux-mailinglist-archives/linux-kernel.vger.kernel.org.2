Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77D03FAF01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhH2WjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhH2WjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:39:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCEC061575;
        Sun, 29 Aug 2021 15:38:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b6so19706291wrh.10;
        Sun, 29 Aug 2021 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xhl34rJgOQWwrBzBPeRLlml5a/SkLfCn6IrH4KZYgxQ=;
        b=ikgiLI/gtXHHZZj4e+XH11Q9nvpa4aAgfqG0tkaPotHDBQApMpQvs9ulOY2bznOETy
         06+eek16EXEwYfGTln9rBdx4pNeb+licdyZyaLJynVub6l+PaVUMZXpfRA9FytKDl8lC
         LHLI6CboNvnpYLsiD8VsWDhNS8lIrGWlMzVWLVXiMxAp6wJx+JW0QAzJBGf6V00qHgO7
         m2hVIQGzdHxeFc28JvEgTUdAXRCgW4B6XwzGTkD5ZbsQYjvap2vVUqZI6asnVzJYNa7i
         jL3tOXUHL3l9fKTTFQCp3tMNyoKQDBTkAN1sMd01bHkPlOIZeaGJYO8K0cOBTy0xcRQK
         +a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xhl34rJgOQWwrBzBPeRLlml5a/SkLfCn6IrH4KZYgxQ=;
        b=Lgw7DpciZ5RHvnv8BAgLn4S+JImvSCLxAXERnmuJ93WHI5noz3AQlxMcjiETfFGXOu
         bs+zeFCIA8dqrpNhXwXbMsN1jZ4xGl3YDfyu5JzjzTxXgdLzvDVS325tPxWbSsZQMQPa
         qpXrbG6mv3q1DRnhpSWowcnvdAdC8mjTSuEqf6j+oFk0WqzczWfs4KKsFZraiE7QBO2D
         N5NKYAP+AC72LIAoabx+aJv2H4O3eJaXRA2NLIctI0GKpxqLuWeFef/9zcnI0k8XdEko
         zhjfO4Ik1h4IHQ2+08T1G7JSPmaxivTFtJfkza/66vcqOYhTbEpBY1O/9JI6CIzxu6qf
         XRMQ==
X-Gm-Message-State: AOAM533SGHDkhLkRy/gnZABhseY1H8h6le7Tn2ZlYnAexGjmgUUm2/Cd
        RxJXKjfUF1JK62CYMNaodxQ=
X-Google-Smtp-Source: ABdhPJy3j8fRkwqM4gJvHRQPbYhrbG8zz480EEJa/1Uoup3BbUi9tUlqFftijnXGqz22oSY+5tDOrw==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr4038215wre.83.1630276699882;
        Sun, 29 Aug 2021 15:38:19 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id s7sm13603878wra.75.2021.08.29.15.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:38:19 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: dts: NSP: Fix MX65 MDIO mux warnings
Date:   Sun, 29 Aug 2021 22:37:51 +0000
Message-Id: <20210829223752.2748091-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210829223752.2748091-1-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming of this node is based upon that of the initial EA9500 dts[1].
However this does not conform with the mdio-mux format, yielding the
following message when running dtbs_check:
mdio-mii-mux: $nodename:0: 'mdio-mii-mux' does not match '^mdio-mux[\\-@]?'

Secondly, this node should be moved to within the axi node and given the
appropriate unit address. This also requires exposing the axi node via a
label in bcm-nsp.dtsi. This fixes the following warning:
Warning (unit_address_vs_reg): /mdio-mii-mux: node has a reg or ranges property, but no unit name

[1]https://patchwork.ozlabs.org/project/linux-imx/patch/20180618174159.86150-1-npcomplete13@gmail.com/#1941353

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi                | 2 +-
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 180827500f25..1c08daa18858 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -166,7 +166,7 @@ periph_clk: periph_clk {
 		};
 	};
 
-	axi@18000000 {
+	axi: axi@18000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18000000 0x0011c40c>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 57d0c5eb9749..102acd85fab2 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -70,10 +70,12 @@ led-5 {
 			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
+};
 
-	mdio-mii-mux {
+&axi {
+	mdio-mux@3f1c0 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
-		reg = <0x1803f1c0 0x4>;
+		reg = <0x3f1c0 0x4>;
 		mux-mask = <0x2000>;
 		mdio-parent-bus = <&mdio_ext>;
 		#address-cells = <1>;
-- 
2.27.0


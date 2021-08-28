Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0183FA571
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhH1L2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhH1L2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:28:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADAFC061756;
        Sat, 28 Aug 2021 04:27:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q11so14504891wrr.9;
        Sat, 28 Aug 2021 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtdvqBLnGJeFcUQ8P25Sc5NT2f22a2Ti1OcxmVZfC98=;
        b=ttLtsX/Hh5mZqoxl9F5ksDxDDO46zTu9WaEt7f/uq68DCCPjwRg35oElHvO/UQipjE
         25QkaZwf3M62il1hQDxXP1s1M1rG2iVikAdvl1JyaBYdFdIKAG1yVjCIqsWfR9m6DbcD
         KxbcQ1QWTqAOGDW6yYP+fTi543YtisyRPyLn2VJC7N18lXwO0Ec9A7cK/Xu8EUPi0kX5
         PPWPe9BbjD52VMuejikSm+zWF/wNYeFqaZai5PM/3uOCo2Ukucy8oa9eZerthQi7n6Oo
         EQIn0FHgmYOOznsQCPJhb4dil0V9PbLJvAs01ngfTiAmipA67LhrTF6CDAu+2zsbEgRR
         e9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtdvqBLnGJeFcUQ8P25Sc5NT2f22a2Ti1OcxmVZfC98=;
        b=Vzukn0vUl9543Xxw3XBhR3V7D8hJ/zxO2cRIg4z+SIb5jix5GhccxZjvtARRiKDfuz
         oxXmvKxFo7iSRcrxdeoYNpcZ63JiknZYR9dcW2RwC/HICQuG7cdUBsDOvY1h94XUyjQB
         X1sqr0bxWDeXiREhbS4m7NPh6nwnnRMzWl1Y/73qDY+wFKA4ctFxPUqJJAhuAt5Z7hB/
         I3vkMhdLqP/vFOWC2CVJCm4n6HkaNP/0zwp9rue0Fu+FEPIvG4TLwl4YXFClwXIB/nXg
         oaDPFNQMACURY4KxHfTD25M/njJL322IQDyUmjoAGcTj0U4teRUJEv8WUUpSLapRsrFt
         UDLg==
X-Gm-Message-State: AOAM530VnhnhFW5FuRV1aesNEW3fi2XuJnuEh9w5K9CLGtDvY3zRrcC9
        CZqSBzEHQLkP1EvFuVXJiug=
X-Google-Smtp-Source: ABdhPJwfqKxw1N7/ofNHP1vy7wbbVKhipx5wRgkc0elHEmK2MS2p4ZrH3FCo3UXP9dumCJtCniFgHw==
X-Received: by 2002:a05:6000:186:: with SMTP id p6mr16000078wrx.210.1630150059071;
        Sat, 28 Aug 2021 04:27:39 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id d145sm13571021wmd.3.2021.08.28.04.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:27:38 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: NSP: Fix mpcore, mmc node names
Date:   Sat, 28 Aug 2021 11:27:00 +0000
Message-Id: <20210828112704.2283805-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210828112704.2283805-1-mnhagan88@gmail.com>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following message by appending "-bus" to mpcore node name:
mpcore@19000000: $nodename:0: 'mpcore@19000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Secondly this fixes the mmc node name. Leave the label name as is.
sdhci@21000: $nodename:0: 'sdhci@21000' does not match '^mmc(@.*)?$'

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 745d1d9d7414..6f2ccd059e73 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -77,7 +77,7 @@ pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	mpcore@19000000 {
+	mpcore-bus@19000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19000000 0x00023000>;
 		#address-cells = <1>;
@@ -219,7 +219,7 @@ dma: dma@20000 {
 			status = "disabled";
 		};
 
-		sdio: sdhci@21000 {
+		sdio: mmc@21000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x21000 0x100>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.27.0


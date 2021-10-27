Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7C43D1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbhJ0TkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbhJ0TkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:40:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF4C061745;
        Wed, 27 Oct 2021 12:37:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z11so2747775plg.8;
        Wed, 27 Oct 2021 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlCdU5zouJbzVDOk8Ea867d7FfdiiRN5l9ui9mRuc+o=;
        b=Ws3+WredrrfaZYQpExt1B9xl4/OoL7LgR2/+qZwE7z7CRPhmNrJaW3alQql2WE8t2p
         ih9f06N2t4vtL0aXMWiTd1xUxzY76uyyT3CS6akLF0E1XY+AaWU6XM9T1PGU+8vj9KVD
         N1zZFUE1GIUfFp5p20VR3ILyIrw2L6fZqKEvOBB1RVHJ/ISYlgnei3J7p8AQv8z0ZLa4
         KVnz+uOra1iHe6fTOKHIlzGpNbxen+B2N9zoLoqijLvABfUGlpPA8iE3JCGig8ksBvzs
         K1YSKD1LsUR2YQ2Br4JENLEkQ+bqMB2KOHK+kGRakyVU8Kfj5Yvx2aourQd5CUtAZr4e
         WJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlCdU5zouJbzVDOk8Ea867d7FfdiiRN5l9ui9mRuc+o=;
        b=MatIHfZ9mN4sXduWKbLMfstdUq6sqpMAdF+Htf1xgXYh7EeKrRZYDxcrkmrbENYbEF
         mX45OEscOFFlX13q6J01kom5PFZbP8chwguw4mG+c4joOAqdTeCwFl0nduKKXnQgM9Q9
         gc9C6sS3rnkBojCCzpCVJG0tTsJw8Unb4pm7ZVhTF9ovRMXu/XvrB4Ci2ZkY6UR8htsp
         AYLd80b8O/i7AjEYVByJP0Q0nZoKsPVkZ4rdwuvoXDhw2MTYRyAgj2j/POG7fyLZihvN
         m8+bjBL+m921vhtlEmQYRstPw7+7pCBHyspcSdKqqSQ/B79vUyqOJCrK5Y/xNGobvu6I
         bC3Q==
X-Gm-Message-State: AOAM530xIa8gfN6fSikVXEgmWjmb7kLHbntjgDxWl0Oby00dT1uo51Ij
        GW8aNL2LjRxGFbgFLa2qavc=
X-Google-Smtp-Source: ABdhPJwc9AW48PUeNYOhon0nYLGCBbq7y8T04U21uu37hdFYGKFLhrVkCCV0YwRECbm8zVcyR3cD2Q==
X-Received: by 2002:a17:903:1111:b0:13f:d1d7:fb5c with SMTP id n17-20020a170903111100b0013fd1d7fb5cmr30413888plh.47.1635363454022;
        Wed, 27 Oct 2021 12:37:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y16sm694497pfl.198.2021.10.27.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:37:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     chunkeey@gmail.com, mnhagan88@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM5301X ARM
        ARCHITECTURE), Rob Herring <robh+dt@kernel.org>,
        Jon Mason <jonmason@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301X: Fix I2C controller interrupt
Date:   Wed, 27 Oct 2021 12:37:29 -0700
Message-Id: <20211027193730.3941945-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C interrupt controller line is off by 32 because the datasheet
describes interrupt inputs into the GIC which are for Shared Peripheral
Interrupts and are starting at offset 32. The ARM GIC binding expects
the SPI interrupts to be numbered from 0 relative to the SPI base.

Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index f92089290ccd..ec5de636796e 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -408,7 +408,7 @@ uart2: serial@18008000 {
 	i2c0: i2c@18009000 {
 		compatible = "brcm,iproc-i2c";
 		reg = <0x18009000 0x50>;
-		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-frequency = <100000>;
-- 
2.25.1


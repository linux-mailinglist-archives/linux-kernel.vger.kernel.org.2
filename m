Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB28C41B4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhI1RLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbhI1RLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:11:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A5C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bd28so24352796edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AapyUGMwZdZlGfkJRVj63XggLC45SeYx0cvXnnFw9IE=;
        b=BQXl1PqUkxYCqFSecsSFdQjjMZKGgfeTiyQ/wZLF8XVMDsTgzJYbmx81+c603HJdQl
         Wz3AnzV8fj78DOdzSmzuDrzzNRhJlzC4kvKdCnLYjoNLKbD9G/rH4QCYnog4pfmk7lk8
         lCLKHA4Sud2npi2lowoLSSN6VNnCNlVnd2vAhdlEfDrIlaurFE91jJEVbVfCk4DHOJNV
         FDM1bO8Gwkys1GA7tyxmTZEXjFsnYctVwiifD+4UVpiw1vJrICiJmFKUoH3UhzxhudJs
         ZHC+iQdv9xinoyLNQF/q6/OZBPWGQPOyKo01ekgPaMocBo/1ji9z+CN6Uh2oqjeL3Yc+
         T4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AapyUGMwZdZlGfkJRVj63XggLC45SeYx0cvXnnFw9IE=;
        b=N8DHQZcgJB1vaGAnMMWhWev4FirZFaJq/G2HReEQEJ3RFS2zKYvb0NO9tD619qRGeT
         2pZ1ci3Y+nEf8EkzQv/CxQYt2/VK2HOaZly08LDnpyqpOdAGLHvyN8E70tkXxWcXUrFP
         tbKW4+Kh5KU1BDMDEt3c4GQzeWj7Qq3/Ttyt9627MBMZkJLDZkxMI9Pwh56OowXc3Jdu
         7HYcis3r18Wca0jE0k7+KX1IJ3VuX9SB+VObUCJYo650hY8gsmLfcrE9Y4S0krSXynr4
         dk+oMlPN7yu12PwRiLGYB4hyTHH6BORLxDWaubYDXjHIAwiD4SjZ0zSOR805ZR/aFpKr
         cY1Q==
X-Gm-Message-State: AOAM532AS9IQl2QKlp2npRn/bmr8kbcBe0OH1Etb2F0F4Zj6l/EFbPmu
        bfG8kFMXFFXQrD/Jj0vw3WpehQ==
X-Google-Smtp-Source: ABdhPJyw2H/EV65V+ox2y/9HJNMx1dx1fAN9rtzH/5xFHPU3JqdWmM81U1UiNiYVyED0BCq0mbveww==
X-Received: by 2002:a17:906:c055:: with SMTP id bm21mr8051018ejb.350.1632848964117;
        Tue, 28 Sep 2021 10:09:24 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-231-cbl.xnet.hr. [94.253.144.231])
        by smtp.googlemail.com with ESMTPSA id bj21sm10806129ejb.42.2021.09.28.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:09:23 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 1/3] arm64: dts: marvell: espressobin-ultra: fix SPI-NOR config
Date:   Tue, 28 Sep 2021 19:09:17 +0200
Message-Id: <20210928170919.691845-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI config for the SPI-NOR is incorrect and completely breaking
reading/writing to the onboard SPI-NOR.

SPI-NOR is connected in the single(x1) IO mode and not in the quad
(x4) mode.
Also, there is no need to override the max frequency from the DTSI
as the mx25u3235f that is used supports 104Mhz.

Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Add Fixes tag
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index c5eb3604dd5b..610ff6f385c7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -71,10 +71,6 @@ &sdhci1 {
 
 &spi0 {
 	flash@0 {
-		spi-max-frequency = <108000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D49360F74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhDOPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhDOPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:53:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80EC061574;
        Thu, 15 Apr 2021 08:53:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i10so4061926lfe.11;
        Thu, 15 Apr 2021 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWC2MC72dgX7erfaiK0WF/mEIAVWPqcVzYbZe8V5Z1E=;
        b=NIfyHh1/PRmS+9vlJuhVugsnRZ6stFNyFEhxN5B4sVKKsp6mAb29+DAaFaoSGLzl+j
         kB7i0+Kdn1JaNr89rQ7uUjyZXvqBm3h02KWgcPFwvSCOMog9/ENOTM3CdQPTdEpMyME0
         W4f9ECChsCIsL8s8MwZG3O1IrDlEHDdkhrjiQctZFjP1FZRORvYCmpO8gg5H8YFAg8/7
         TgnjY/s/871YpFDhEU9bv76gJ3VwUe8cetHG3IbZQHk8uaCxfklBHn7mHSKbXCE8OmTv
         MFCjCXkgZVDC0p7rRjw3tqsPqQ+nS17Ri/cbBv+0JUHR1x+8rryyOdZ8zxExS15upiUa
         MJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWC2MC72dgX7erfaiK0WF/mEIAVWPqcVzYbZe8V5Z1E=;
        b=AkLp+cJYs9eLRci9h7UytHbFepG/YpCwCIsmH6WVwVY4pcNsFqF89ulUOiqCDzp1A/
         QRqhxKRedTW8V++9oQKvyTWqEifYlS5yGsGOywfUtafEsdI5lpQsPco2G2nT6sH23XwZ
         uChLZ5t/cRaZPEFaIYjyD1CiYGmvsYauQ2HqL4YkZiMlaE7XEVzuRRAwp1Jeh/VImdB8
         q6qtdPpPXvp/gxVftTF5T9kBU/GdnoB4tT4q1+larcnUtcv0fH0awY7/xzeJ3dRiMSx6
         wBeQ+zFKywcVA8VBOdsfvsh18zKieEDftZmukFn/KGKtcEj40EY58Z1IqHN9VGvXI7JF
         vGuw==
X-Gm-Message-State: AOAM532ln9w/NMoiANdtzzF+kjc/ISsk3L9+sUsfOXzqjqoJA7UDmRXl
        giu61QKPZZomPjFSkNat1sA=
X-Google-Smtp-Source: ABdhPJw1hchhMCsax9EV0N/YbpI2KvNmp+q3ewQiaZLc00QNf4RW4J0wPjOl5hNgeyEJbgWUWIENVQ==
X-Received: by 2002:a19:3849:: with SMTP id d9mr2943775lfj.388.1618501999617;
        Thu, 15 Apr 2021 08:53:19 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id s7sm674074ljg.31.2021.04.15.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:53:19 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Enable all used I2C busses
Date:   Thu, 15 Apr 2021 18:52:59 +0300
Message-Id: <20210415155300.1135-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all I2C busses that are used in AMD EthanolX CRB:
 i2c0 - APML P0
 i2c1 - APML P1
 i2c2 - FPGA
 i2c3 - 24LC128 EEPROM
 i2c4 - P0 Power regulators
 i2c5 - P1 Power regulators
 i2c6 - P0/P1 Thermal diode
 i2c7 - Thermal Sensors
 i2c8 - BMC I2C

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index ac2d04cfaf2f..6aeb47c44eba 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -151,6 +151,31 @@ &i2c1 {
 	status = "okay";
 };
 
+//FPGA
+&i2c2 {
+	status = "okay";
+};
+
+//24LC128 EEPROM
+&i2c3 {
+	status = "okay";
+};
+
+//P0 Power regulators
+&i2c4 {
+	status = "okay";
+};
+
+//P1 Power regulators
+&i2c5 {
+	status = "okay";
+};
+
+//P0/P1 Thermal diode
+&i2c6 {
+	status = "okay";
+};
+
 // Thermal Sensors
 &i2c7 {
 	status = "okay";
@@ -196,6 +221,11 @@ lm75a@4f {
 	};
 };
 
+//BMC I2C
+&i2c8 {
+	status = "okay";
+};
+
 &kcs1 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0x60>;
-- 
2.25.1


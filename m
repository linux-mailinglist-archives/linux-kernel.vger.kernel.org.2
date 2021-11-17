Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9D454811
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhKQOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbhKQOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:05:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:02:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so11544980edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48jpMjB7ikIGAY5IH4NRA+sLzh4QPo/RYNwFWYqiuv4=;
        b=dUS2SR7j0B4r/3q4ToNQmhhGg4WvoE5bfUdVO+ewVd2u5prBQdg4PikCaa9edENq8W
         WA3abYUryvhuFfX9eG/Bk60UNOiZyY/kymMokjqyBSLSIxftr3B4KwOpjaL4oMYZtowk
         V8eZLDBK8lvp+BVx2loNqo5JryZzLrYEpVkuqN+cu16sHJ4B94TVyWeNSnr1F6u2swOh
         ngug0eihvoNMHEjgawDVduGZxAqviQw5BaeCtNtjO9jJIWbZ+BXrnQYq9b484MBqZlvu
         b/j9CBI0EbYdcAJ4ToeKQp71xUoW8UMAInLAzS0U6ArqCQRTt6HWuOXTGHT3ffzJ3pKz
         +kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48jpMjB7ikIGAY5IH4NRA+sLzh4QPo/RYNwFWYqiuv4=;
        b=l+TcjQhZJu3w6xAqTssFgkALe1pJZU6xeqsUzoiah1kUjF64Ou10qlV+bQtsq/nVyB
         laNxEftf5+5wqX0flSmf54AAKUt+pGm0sdNb9Y7PwS0fV/u3gvLsGeGiTW4RK+CAQVKM
         iBjmCe6xsEQ23UhZqn0fMxV5mTwzYKZc5TDCdLxPw/lpkrTIsexLwdSOrBiWIASFFxDD
         EVQc6218lAitR1vxUA1m98RTthzdQGzJWYhBKnviThMLbo1+wxCkVJyB8E/jvUpcigUn
         f1P/+nL+tuyyKuL1u+jBMSjFdIUbnbDBmnPw0625tQAkGcsITfPwW9axL8mpYE0s/Tsg
         L2fA==
X-Gm-Message-State: AOAM531wNsa+vr0HIP3PQFalwItXhZOlp5S+RQWKUh/ykxgTFwr04O+U
        dY0bIC2fdjOP/VzAlaF+ZC+Jnw==
X-Google-Smtp-Source: ABdhPJx98JoRl+qaja/gfMY6n9+koVO1zpPmRMUeZF13GS79wlEvIe00MnF0trXn+b5HYmtnQQvQbw==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr23434041ejc.417.1637157748723;
        Wed, 17 Nov 2021 06:02:28 -0800 (PST)
Received: from fedora.. (dh207-98-180.xnet.hr. [88.207.98.180])
        by smtp.googlemail.com with ESMTPSA id qw27sm10725963ejc.101.2021.11.17.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:02:28 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, hauke@hauke-m.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Ron Goossens <rgoossens@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2] arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode
Date:   Wed, 17 Nov 2021 15:02:22 +0100
Message-Id: <20211117140222.43692-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orange Pi Zero Plus uses a Realtek RTL8211E RGMII Gigabit PHY, but its
currently set to plain RGMII mode meaning that it doesn't introduce
delays.

With this setup, TX packets are completely lost and changing the mode to
RGMII-ID so the PHY will add delays internally fixes the issue.

Fixes: a7affb13b271 ("arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus")

Tested-by: Ron Goossens <rgoossens@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Tested-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index d13980ed7a79..7ec5ac850a0d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -69,7 +69,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.1


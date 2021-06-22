Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2093AFC22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFVEqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVEqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:46:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D6C061574;
        Mon, 21 Jun 2021 21:43:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e22so9868099pgv.10;
        Mon, 21 Jun 2021 21:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6/Tm5shpqw/9OS5+/PUErLb83Yh9LzqaMHRoOepMhM=;
        b=J+NRlZnKzxJOmLmfXB5MYj8stHZsG87W4lKtFNjzvrU6veKVqX8ZDvu9OIvEg9qiB8
         legNgyX2G/i3yExo63yyypkJRpzonN1n8I+6PLrYt8MBsFBfhgKPsaLV86m4W05F2dkD
         ccklSEay4G7sRcvBRwm5pvn1r09g0mZ5MnDdQ6AoKOS+R1ZiI5s5LAUiWpfZsjtPYaYU
         VEBr9xNKaiWoBmf5Pi+pQsW5vRAYpTaKI1oCqAdimbBvSeOi1smZiD4kaNZCUncz+MdD
         OozH9PkadyqiXZenSpCqKqx2yi7wWEb98/NFSgZ3gsUquMNdOuZyZn7Z1rr/CwgcKEtf
         dkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6/Tm5shpqw/9OS5+/PUErLb83Yh9LzqaMHRoOepMhM=;
        b=OyGTv2cKXH8kzhTEYtx3jmodLrMLASHcCeHIgIGF2Hi1QpaBlALsmsWOF8f5UbmLuQ
         +4RD2Uu2/ys3RF4RJK5pLPxSR0bsGHDX23pnqxJ6K1bc168ylq0FlN1d4/LcDe+0JBxY
         vXm7me3tCua8mGeNX/kgNchNvxs84tS5ERH1k0aJ9NaGzBuxV0kP3a4d3X+xqG4bhxTa
         QcdhzVfMmVqHV7lVoeOtiPpZSC6TL9laWabU3XjAzZ0L5IldD4tambMcqRI+kEDS95jE
         Xb0Sr4n6ThwO4RXjidYPtBkbUTfN48iGy5+OGARVC3cLBFm5pzPTI0AbLIkIe3b+Y+qo
         ElkQ==
X-Gm-Message-State: AOAM531zuxH0CgVXmPUdEuiBINkYwhPoVgu5faRyZeaBoYWn0i7X6cpR
        rgPtDuABz0MwLAGFukpvljQ=
X-Google-Smtp-Source: ABdhPJzm53iKSRmJ2/x99PM4SPNOkyqKGBe0icyCehyexTfDoHU3tyewXM+7y7bT5e8IbcGb5JpOeA==
X-Received: by 2002:a63:e04c:: with SMTP id n12mr1888835pgj.239.1624337026407;
        Mon, 21 Jun 2021 21:43:46 -0700 (PDT)
Received: from localhost.localdomain (104.194.74.249.16clouds.com. [104.194.74.249])
        by smtp.gmail.com with ESMTPSA id v129sm8686909pfc.31.2021.06.21.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 21:43:45 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 1/2] arm64: dts: meson: improve gxl-s905x-khadas-vim wifi
Date:   Tue, 22 Jun 2021 12:43:33 +0800
Message-Id: <20210622044334.769791-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve gxl-s905x-khadas-vim wifi performance
* change freq from 60Mhz to 100Mhz

100Mhz works well same as in meson-khadas-vim3.dtsi

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 60feac0179c0..6ab1cc125b96 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -218,6 +218,8 @@ &pwm_ef {
 };
 
 &sd_emmc_a {
+	max-frequency = <100000000>;
+
 	brcmf: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
-- 
2.25.1


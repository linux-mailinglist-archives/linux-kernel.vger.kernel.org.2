Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4A32A5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578132AbhCBNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 08:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350249AbhCBMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:14:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB5C061221;
        Tue,  2 Mar 2021 04:11:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id q25so10667410lfc.8;
        Tue, 02 Mar 2021 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiatAXu0lWhq9U5RWdBwNxgOQuzIndCSuyRgNWnlqxw=;
        b=B1LgZelZza2Xk8md17v//5JYYCGTpx0XG3spYIuWR+lLTHZ6TfDyEDN1j4OHcUFz5q
         8WC+BMmPHAT/OeNX+ewqtGuCVZvKImesniikeIUsAR3MwmmQpiwLDBYlidXOLo4Tfkm9
         l8+VhfOPTzqIs8a5DYI/vxdU16cqvukKaRh8m+RRz2LHtkwtRWZ/XdPsdHcNt1TZQ4pV
         y2exNx484M0PI2h9RPs3zFLcpbdlnuTKIv4jioK2fYKGlWFWW9kgZdAAwZcs5JhHyUER
         iw5ApRbDge7z77UzpWjpXbTnIhp2GDIjV33zO9KFToUdFJdjAjAkG6l/6QETlE/rHM2q
         EVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiatAXu0lWhq9U5RWdBwNxgOQuzIndCSuyRgNWnlqxw=;
        b=VWsnHeZWPV0uPyavG5/fddMydW3v/24kuw3B9SvmOncw4ObGh4FY/cRxLBDsRqd46A
         P/zOSep6lagpBbAb6Panac/5VUuc7oWtFTXVBgCrdSA4qACgxRWEYh8hr0Na9zQ9DstJ
         PJC1EGHsYwcSxDj3967zPGTFI/+FBAAsMjbGyi9kekxOJsJ7ds6AZtrDo5hgmP20BbL6
         3sBYLVY48Itk7RGwOWWylOttMV3zPVS9TTB4CgntiB47Ody7bt2f6DLGb5VmFPYH4Xvr
         4pxrZM8umZofqVAHFsX36sCE2SPTjUN5gibdUAs96Ni0m9T0bOx1vwDUmMxVpBuXQ0fH
         Hbrg==
X-Gm-Message-State: AOAM530q6vibtb4/RJmiAAOrIdY80AC4vszh8rZVADyAJta7pzOQXkn0
        /Y4TAcc1HKUEEJf9RVtJcmM=
X-Google-Smtp-Source: ABdhPJynu7QCwDxAEUiR/j9ELrs1hbgBm2xKfm/BYGoCMCcUyAiP1iBFWRvdZT2Sw1XhpJJqc4qg8w==
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr11966414lfb.170.1614687064368;
        Tue, 02 Mar 2021 04:11:04 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id d21sm835097ljo.55.2021.03.02.04.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:11:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] ARM: tegra: acer-a500: Enable core voltage scaling
Date:   Tue,  2 Mar 2021 15:09:55 +0300
Message-Id: <20210302121003.15058-7-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302121003.15058-1-digetx@gmail.com>
References: <20210302121003.15058-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lower core voltages on Acer A500.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 40c1bab22155..8531abf329c6 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -578,7 +578,7 @@ sys_reg: sys {
 
 				vdd_core: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
 					regulator-max-microvolt = <1300000>;
 					regulator-coupled-with = <&rtc_vdd &vdd_cpu>;
 					regulator-coupled-max-spread = <170000 550000>;
@@ -619,7 +619,7 @@ ldo1 {
 
 				rtc_vdd: ldo2 {
 					regulator-name = "vdd_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
 					regulator-max-microvolt = <1300000>;
 					regulator-coupled-with = <&vdd_core &vdd_cpu>;
 					regulator-coupled-max-spread = <170000 550000>;
-- 
2.29.2


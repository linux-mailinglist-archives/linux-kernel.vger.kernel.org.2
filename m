Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13242AD25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhJLTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhJLTUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:20:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF9C061746
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:18:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so2679727pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZojLxNHDG9L7+3rBw8GD2erwwT1gR6rCpMitvc63e0=;
        b=tmFO6TcJoOdc9Uwt0V6Q6OIdANSPgpyKyYXF68sVhVU4R0xAQhislD8qKjtIimIDVa
         zdFb5nn6ehNoAp4vHMoIT9Mji+vLVRlE/PIAUQ3i0zhd+4+vxVkRLfSJ/yY3nb3aRZuC
         Kz4LQbD5By/aHvLScYZSZdZ6E4hK2Afy0xjW6q7WRBvZVy6J0UfEIAYi7MiL4pHW7oN4
         trkuplyZLAmeGJ8euR1Wavrd64RTePolxHvyxaNX+Rs9J5D0jKQk06opNsDrm24eVPnn
         ZpvqzLelSDG8dBOoyW8OYxYLXaq+Sm+AzvoonVkLFAd4ZLhxAUVQZQWiRZTgEEpCcHxg
         etbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZojLxNHDG9L7+3rBw8GD2erwwT1gR6rCpMitvc63e0=;
        b=U80O64bVE4v1HB657zrXWMK3JMiGmDNbdR8FOMYEFp1xiE9wuN1NssYliYsbb0iyOU
         E5N9fLc3SU/5b+2iADCwvmu70Q7plqtzOnVh/jFdI1LJuP5HQ7VwRS1X3fZsu04MbM2/
         WZh27Bj+hOFh0iF77Ps0rofgLWkfYy/5EBR0rahb6QVVkCGX1OlGcsnJ8QIPr4Tyj5VP
         Tfm8IlLkESbFeF60HGPdvbhcTmhFh0xhhmaAIBzPt48b9+dnsfFGYEy+wbznJfYzufLH
         Unr/CHe6284zZJDM78I0Ch0fiZv2OHPB/3iWC2dKc8UPvRHRBvbn0GLoiFxZNCevXshj
         RkPQ==
X-Gm-Message-State: AOAM530EEfG2q9hNdhPk9i5SHpEuk3jhawKj2p1zvgA26H930SiGKbXO
        0lonlJV6CpHXpawXTZs1/RYVVw==
X-Google-Smtp-Source: ABdhPJxLhhrR7V1Yrp1Bh/N/xYlCfPjHADDWFcDrI1Nm4TmYW4ilTk5/Ck9mf1567yZUtUrCDO9JhQ==
X-Received: by 2002:a17:903:1207:b0:13d:b9b1:ead7 with SMTP id l7-20020a170903120700b0013db9b1ead7mr31653976plh.63.1634066297097;
        Tue, 12 Oct 2021 12:18:17 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1000:35e0:e8e2:9471:3c5b:c7c4])
        by smtp.gmail.com with ESMTPSA id z11sm11586812pfk.204.2021.10.12.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:18:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Benoit Cousson <bcousson@baylibre.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH] ARM: dts: am335x: Add rtc node as system-power-controller
Date:   Tue, 12 Oct 2021 12:13:12 -0700
Message-Id: <20211012191311.879838-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

PMIC_PWR_EN pin of RTC on am335x-evm, bone, and boneblack is connected to
PMIC on board, so flag rtc node as system-power-controller to allow
software to poweroff boards.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 0ccdc7cd463b..56ae5095a5b8 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -399,6 +399,7 @@ &sham {
 &rtc {
 	clocks = <&clk_32768_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
+	system-power-controller;
 };
 
 &pruss_tm {
-- 
2.27.0


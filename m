Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69B3D52BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhGZE2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhGZE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:28:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C9C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:08:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d1so2919931pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q19QZx3IM7uTYknYeZNzKDjl5AnKkceiIehImoXzjxY=;
        b=CZwPjWqV6j/Knp8s+qP42VKurVJ7iRtYSe7bZAsIb0X+kP/kjIqY9XEyX+FF/s0oXS
         OVkuYjiP7st6B/JKf5Mcff0AmZmDvoBaE6dDbA8MLHCfceW0Vyit7zkCByRGqUVTKHPj
         B0BNVVDg/Nx+woF7Ld5wL/jT3mYvue9wtfkTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q19QZx3IM7uTYknYeZNzKDjl5AnKkceiIehImoXzjxY=;
        b=es8VKa0VRF8YUu2yoxmROhL4mfOgstBsgL/c0QSfjYA8VutKtOoHE9F8xWjk4T9GRS
         DJLRr7QyEtSqFXU3g7I4itotWw0shXaWUg0eSHAOd3ZX8lF9y7r6pTsZH+Th6ELvDIOh
         k3mflt37NK6P8hewgJeSxt0aHmsD/nCkFWiwk7bwwPiz7kUM/7NoeelAKy2jDO/87Rdi
         iYJPeHZJkRIc3hm36bBKvijBKhDL4iwPV1Bn6nu2McFsQ4nMHHiDPXVkONJQ+M/M9pxl
         r0V1EpWZ5csYX0rvbCcrVTITTMh1lsEa7ipiYG510xkqdrvnMrZXX0M3XdLlyugkp7bL
         DSyg==
X-Gm-Message-State: AOAM532V+lyCrhPjYS7qIzsRYPxs6v4xOcXTRS3JshPiKGwZke+UZPl3
        3mfXmyOB+F92kprC30pg9+Xk6A==
X-Google-Smtp-Source: ABdhPJxNYNIzJ6h+knYVR+R+nInHYQ0LoXhr0E0f86kyTkieRytU+Cg57mNifxFausYXPKEyySAXsQ==
X-Received: by 2002:a17:902:c10a:b029:12b:565f:637a with SMTP id 10-20020a170902c10ab029012b565f637amr13037468pli.57.1627276123312;
        Sun, 25 Jul 2021 22:08:43 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:24d6:d449:2832:1652])
        by smtp.gmail.com with ESMTPSA id a20sm39810768pfv.101.2021.07.25.22.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 22:08:42 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
Date:   Mon, 26 Jul 2021 13:08:31 +0800
Message-Id: <20210726050831.1917982-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use aliases to mmc nodes so the partition name for eMMC and SD card will
be consistent across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94fc..ed499e17b6570 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -13,6 +13,8 @@
 / {
 	aliases {
 		serial0 = &uart0;
+                mmc0 = &mmc0;
+                mmc1 = &mmc1;
 	};
 
 	chosen {
-- 
2.32.0.432.gabb21c7263-goog


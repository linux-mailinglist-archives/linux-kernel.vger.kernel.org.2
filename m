Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136AF36E727
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhD2Ij2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhD2Ij0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:39:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD0C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:38:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g14so17868841edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4WPoZQIZ1kvkVufh+qEP9zP3pw5rW8jLhJq9sIj904=;
        b=IgozPNfcNZh3SwfuiOVHikpsuKvtyq7T9Za5Oh1Jszmvf4rzk1b73g0p1DgzEY09Nv
         mvt+HK76Hu85mdMLosxGGlK56/jynJd45gUlQmCdHXzKqe+WW9VpIlXezo1hRimAWler
         oTCZfhu0CWFOWi0VNIAtBVHaq/JhfNrwJb8Ejqh/vQJvnpr2AI/6aphYa0fO8PHXfLUa
         R9xydeBTmrwJb8pDMah7fXzrSpA789fMei0X5en2SGXgqTsu+xpeLCqJ6BjeCkkvLj3r
         l/7Wa8iLepHsi7PVNJopsuFldMBfBBx2GXg0EpIHVmuqx6P06UYeo9KsrW8RBHV4tp5n
         4d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4WPoZQIZ1kvkVufh+qEP9zP3pw5rW8jLhJq9sIj904=;
        b=oocHEuFRBy2BHPsxLT60qr1UyAfdxzB95DCb/KTGdk3J5wB6/9rS3e0aElQwLpfek5
         4k5pnmDw4gFwzq3RyXeSEiHLsFeWANFbScv1fI+sRE0XsJtVi8lkCo1YYhmxfHMUvl1/
         pnAXVXa6lvy8P1GuQ9bJOwmvYx+kUglygpLBlIH7EIEFs2wlWnGiWD70/aaM7Rwc9T+3
         yg9h/q5GP94sLWYsbsG/xqCt++BAQzEChXANX6lP5IneCgR68ipsf/lC934+LDoAwAv5
         BMUJDgYQqrbmUS+5h1Yel54PZxAXhv4fuP9ytD1Qg/KzNN7HpdnyraG+NXFDvIWWXp6R
         /t9w==
X-Gm-Message-State: AOAM533PiHVX5z2tErBRaNG68KBIpe5BLi/R5lzCRKwR1pGB4LpcTiJE
        pxS4OVVnDP3qrSnx5PVjNRpTZQ==
X-Google-Smtp-Source: ABdhPJw/uG7z0S3jYVdM8GLT8Zryvd2mD2Bcig9/CCVXyJhaEGwQUisy9MFDRZf0bsFixgvhhRhZiQ==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr16596562edt.187.1619685517668;
        Thu, 29 Apr 2021 01:38:37 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n10sm1387941ejg.124.2021.04.29.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:38:37 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RESEND] arm64: meson: select COMMON_CLK
Date:   Thu, 29 Apr 2021 10:38:23 +0200
Message-Id: <20210429083823.59546-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix the recent removal of clock drivers selection.
While it is not necessary to select the clock drivers themselves, we need
to select a proper implementation of the clock API, which for the meson, is
CCF

Fixes: ba66a25536dd ("arm64: meson: ship only the necessary clock controllers")
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..a3fdffcd1ce8 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -168,6 +168,7 @@ config ARCH_MEDIATEK
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
+	select COMMON_CLK
 	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
-- 
2.31.1


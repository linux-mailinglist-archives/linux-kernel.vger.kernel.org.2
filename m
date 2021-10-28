Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8959243E36E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhJ1OW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhJ1OWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7FCC061226;
        Thu, 28 Oct 2021 07:20:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso1488553wmf.0;
        Thu, 28 Oct 2021 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9UTPRxPPIM85WFH39byVhI0Wop1oatVXrCc+qxiWlw=;
        b=qXON4UmKXQcP3NyhCCpnEw7n2l5yB9V8mlAogARYrAB3yclwFzmLFQ/ndWp9T6CMTY
         ztl8rrU+HBOIlZwo9wUdrS7gRpDB23pgvHskYu5INA9Ne/uoohF4H0KKhxVTd39MLxgb
         OCuLdYH9tL6kVMbEYs1qWb81bC2bMbLAr9H9d3ZmVzAZ6U65Y6gKTVTfSaQJHWvZf8E8
         8h7WN22vOD1L2sxDA4eAQzexsiB6soe4/k2tPxVqWue76hG1CDfRA6Y1PSYhmoQkpyNl
         Q6lVcW6L55qvTE6mH/cxuaWQXREKcMuLHSY+c11NNIob5it5e7F5Cqp8jY3sl+HqszXb
         UC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9UTPRxPPIM85WFH39byVhI0Wop1oatVXrCc+qxiWlw=;
        b=yi7h2K4EPrc/6qLu4HxoMth3ZNa7yTqqzAv352w63Vx2Kz2xptysq+FC71sH8XIgsS
         rFVNXr0Sa56TT7n13+VbvTDOKRj0+nGGqnDdMzfl0zisosRbRykjrsLxfbMdh1UBaiDE
         npkz7rGytPIQwP6DTaosB5qseyw/mJ5mkNBNtqDQ3R6Ib0rHaXDTvKMP3JarcOXwLPWo
         VqpdFh+T+BHluHKxsuAJKpeTq07ZCj7lFgKbYfTgyBxpt9UpaGKHMBN475QKATpod7PT
         eNLdl/3kM9Hc5zwIj5UXlrdS4AxVDPecC4bpgfOgzOUmj5qPAGZQ3H4Yi3dLy/I6rzMn
         mxdg==
X-Gm-Message-State: AOAM531v+/J3F74j2L/WmBw8ZNdZL+0vjem1OjFAFEGAniHsysgsHKiV
        1ykPtHslWq77y1Atz6yUbqE=
X-Google-Smtp-Source: ABdhPJwTApopXsu78VNhZKnyHSCssVCqkMXqxaLoxvpVRe0ZrqH/I2RaRROEgoJ+KRMawHk/qDAl1w==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4958277wmk.51.1635430815273;
        Thu, 28 Oct 2021 07:20:15 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 10/13] arm: nomadik: drop selecting obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK
Date:   Thu, 28 Oct 2021 16:19:35 +0200
Message-Id: <20211028141938.3530-11-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 85b6fcadcf66 ("clocksource/drivers/ux500: Drop Ux500 custom
SCHED_CLOCK") removes a sched_clock workaround and its corresponding
config CLKSRC_NOMADIK_MTU_SCHED_CLOCK. Since then, selecting
CLKSRC_NOMADIK_MTU_SCHED_CLOCK in ./arch/arm/mach-nomadik/Kconfig has no
effect and ./scripts/checkkconfigsymbols.py warns:

CLKSRC_NOMADIK_MTU_SCHED_CLOCK
Referencing files: arch/arm/mach-nomadik/Kconfig

Simply drop selecting the obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-nomadik/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index e98429be2b18..ab52b1abc453 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -5,7 +5,6 @@ menuconfig ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_NOMADIK_MTU
-	select CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	select CPU_ARM926T
 	select GPIOLIB
 	select MFD_SYSCON
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF17327E71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhCAMhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhCAMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:36:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6EC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 04:36:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b21so11460955pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C88FmiAqxDnJbB9m5EGVR/CJ40sQ0nT98Az9DhqgecU=;
        b=k25ODqx0AJ9FiPd1SEWkoupl4VkvfyH//7e4sw3S9SizNEvqDBmeG8PMTbrw8Wud2p
         jPT/5r8AUEOc+6GCoMClwE2m9U12dn/IyaSPGBhnWNegGzlei+RJ5Q0GhZ1do2ME2bob
         0valpUCI4R32euZNZJguYY2Uh3+rSnvly1/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C88FmiAqxDnJbB9m5EGVR/CJ40sQ0nT98Az9DhqgecU=;
        b=Jq94h1ZwUTlOAZj5m3mkQo2efOvuI83jhInv/haFgPocv9qDpMy48vqsUBitLERbOG
         Ui/R0nzGccwm9ju7R2Sic/dtnEYNuzHW4SoPOPZvxWS0ioEuR8QAOcJG+ySXHJbtDKVE
         bLTIlJq420IcWB63Ux0Dwk3EBw6rFBVH4gB4CSLccpEwVCjHxANtefrmeXJjcmSzjFD7
         f0YFeQRtlbNU4k/hgjHyr6LCOJZslZS9u3HO9JF+c/B2czl1WUNk6pEmlYu8V92VtcFB
         2yMiTDuk2IXZtjyUEU/V3nMzCRGmi2EdyfGybZOz3ifMPs6NyrF7iYnOLn7WVaR9Nyib
         ss0g==
X-Gm-Message-State: AOAM530ee+MTXHyC48JPvohhWyq9sKhIWzPETCunsmLEzr6f290HVpfI
        RECzURmxl5oGKAabUp/QWhg/Vw==
X-Google-Smtp-Source: ABdhPJy4edf/KQypinIj/0pMZbp3pGG1yVFbUE7VPL2CwLLI5GWeL1N/ukAkzUJwOZk8lI2iMzCeTQ==
X-Received: by 2002:a62:ed0b:0:b029:1ee:7568:5ab9 with SMTP id u11-20020a62ed0b0000b02901ee75685ab9mr7010492pfh.79.1614602178032;
        Mon, 01 Mar 2021 04:36:18 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id 8sm18130928pfp.171.2021.03.01.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:36:17 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     arnd@kernel.org, olof@lixom.net, w@1wt.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] ARM: mstar: Select MSTAR_MSC313_MPLL
Date:   Mon,  1 Mar 2021 21:35:40 +0900
Message-Id: <20210301123542.2800643-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301123542.2800643-1-daniel@0x0f.com>
References: <20210301123542.2800643-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the ARCH_MSTARV7 chips have an MPLL as the source for
peripheral clocks so select MSTAR_MSC313_MPLL.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index 576d1ab293c8..cd300eeedc20 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_MSTARV7
 	select ARM_GIC
 	select ARM_HEAVY_MB
 	select MST_IRQ
+	select MSTAR_MSC313_MPLL
 	help
 	  Support for newer MStar/Sigmastar SoC families that are
 	  based on Armv7 cores like the Cortex A7 and share the same
-- 
2.30.1


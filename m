Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCA44054B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJ2WJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJ2WJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:09:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7AFC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:07:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y10so10762939qkp.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvugqhuJUn7EVZO6Gy15kKWUVnZr2PLbZtifxIeae/4=;
        b=jHT03enmBoB+Qxh+IJbT15nmFnHdeqUqiifGJvw0/wWNnQR9wkcgQ1S6zGedMWiXe/
         nktDDM+yYYqqah+TjEqub2x+1fY/dSatdPUpINxV/3QfAJm88cFs9ljC2BCBoCYQCHi6
         OZoLES9MoExPe1UYQ9Uc7jcEX0mTGXJq5Ge7ccJHJIFzMHpeJPbisEkiHqombgj3s1lP
         e+WsxdFYokN/BMM1B2q4kX6w4Ksnvmf8mLU+WVN2zFit0oxD48d4gyNfwXINlk3Xe9Sk
         ET3dzLpHpdZPqikczF6P97R7C9lixASroTAe/JBN1YyR0SdOu8pTuVw99cpDbfnFvPSE
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bvugqhuJUn7EVZO6Gy15kKWUVnZr2PLbZtifxIeae/4=;
        b=EU7NAaHNG9SV4ORUkw1Nd3wpQ6oLpX1nNXqM4A08YeYA373OuPu6ucrAmi+XYkVZeb
         ZY3/p1QBK7fKWhsg/yj5lBztd6XkL2zfFeNag/4F1fLHIn7rQzX2vGSE5gSck7nXC0M2
         2Yaru3tGjb7T39cCfQpIwR26z7KemipL+ZSPnQKB3pvLL0G1bWs+KjQuqnMOZAF8O3dB
         SCCxyKq4N6Y5s5OB1OU5RxGvFn1yBjWR+SbW+am310bUqX14kWk6Mf4hRDuaZFMC6oe/
         wrWdLAJbdcY8Ki+PAxcxWdfXiUp9qQJAF2YQ1L2LgAYcVNQBAv9gkmDpFKLYzkVx1jpr
         0Ipw==
X-Gm-Message-State: AOAM533/DyZs01IRn03o07rygZYsXnC37tt5cEYWkNN6z18M8JpcrAH7
        nP5SB0/9LoLoDm7VrLgjJVc=
X-Google-Smtp-Source: ABdhPJxIHxTmDz9dbS/mmXYgUAUzgQMf0Ody82Fmpq3+crgrEJW1OD+XEzMVzi//0kibz0/EqIb6YA==
X-Received: by 2002:a05:620a:28cc:: with SMTP id l12mr3626391qkp.423.1635545234828;
        Fri, 29 Oct 2021 15:07:14 -0700 (PDT)
Received: from ubuntu-mate-laptop.eecs.ucf.edu ([132.170.15.255])
        by smtp.gmail.com with ESMTPSA id p9sm4580739qki.51.2021.10.29.15.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:07:14 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     nsekhar@ti.com, brgl@bgdev.pl, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] ARM: davinci: fix unmet dependency on PINCTRL for PINCTRL_SINGLE
Date:   Fri, 29 Oct 2021 18:07:13 -0400
Message-Id: <20211029220713.24420-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARCH_DAVINCI is enabled and PINCTRL is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
  Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
  Selected by [y]:
  - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y]

This is because ARCH_DAVINCI selects PINCTRL_SINGLE
without selecting or depending on PINCTRL, despite
PINCTRL_SINGLE depending on PINCTRL.

This unmet dependency was detected by Kismet, a
static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/arm/mach-davinci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 1d3aef84287d..a9ae3ba4536c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -9,7 +9,7 @@ menuconfig ARCH_DAVINCI
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	select REGMAP_MMIO
 	select RESET_CONTROLLER
-	select PINCTRL_SINGLE
+	imply PINCTRL_SINGLE
 
 if ARCH_DAVINCI
 
-- 
2.30.2


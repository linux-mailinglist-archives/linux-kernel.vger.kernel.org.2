Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF943E372
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJ1OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJ1OWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC5C0613B9;
        Thu, 28 Oct 2021 07:20:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so10527891wrg.5;
        Thu, 28 Oct 2021 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7gwbG6UFkkaU6lNQMINz/kDW0z+hx1/TQcDms7EvjA=;
        b=lQ5OcjGIeh4NWjsNWv6j+yKcMQtIziyKvbwOas0MSzkEbju8H0ZnDckxAxYW/du82l
         ca5gAa3XAltOr/QYzm/K2OZmNEz+PuC8je4ThTALteh3btLgk95l6/8WtQuvVIC1mXoX
         ZgZKg7OhgK5stvkpFa72LQm4n+b7fhxu6d5FXxc3M/+fg9tNh1oMyx3NGqSTmB804FWq
         8vLzv2I7+Jv3SyrFkE1bRNm++K7Bjjfr+SDFvVgTcI8sksFNwxZQ/TFUObSGWv4qWzqV
         07w+Ht6Xpu0MzgMwihImF6bIhjuT5JCvNcgLT8evs1rJgoqHw4ra+7yHAbZGa4t/LFPo
         o9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7gwbG6UFkkaU6lNQMINz/kDW0z+hx1/TQcDms7EvjA=;
        b=DQNKbTHSMp1AA78N+y68iLZQKL02LajrniKVCRP/2G9ZyJinyWZyovvaT/NuioL4qf
         DHDmndzHnypVZXXFshSgOTr7z9+YtkPY5Q3/LdATP5DlbTCqvhP6OdAQXr+6krZL6UpK
         d7YjIjit7uAGrzsHlGJT7bWBWP7N9c8OFMJxVnCFG86dx4jfgXcRkI9CdnCdKPTnfZNv
         AVF7bm68ibZaFZsNK4ceLf1BqfCBIdwMJM7OKi1CVNwLJZaY09d8uMTMGajWv9BaMJdm
         dYvJE3V4Qlmx+6ki6nFi5GYy1CG+hGD5jwHuq/BMHimpOqGlIWnZ0e5VqgnyJ2e8PJCf
         iohg==
X-Gm-Message-State: AOAM532I2ZMXYogF1RBPHc/T2ZtE26urQNfWvG/jJVxQk2UG9yZqpUBS
        iadWuU/mRnr9G8kpmZkHgEI=
X-Google-Smtp-Source: ABdhPJxAB1fxVvguMzzS9pPQar0ZSLiVaHnPSqayVPTb0W96ZibRfHgK6i+ws94hG/4IbD/xNcdZfg==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr6162936wrf.365.1635430820014;
        Thu, 28 Oct 2021 07:20:20 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:19 -0700 (PDT)
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
Subject: [PATCH 12/13] arm: socfpga: always select PL310_ERRATA_753970
Date:   Thu, 28 Oct 2021 16:19:37 +0200
Message-Id: <20211028141938.3530-13-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fbc125afdc50 ("ARM: socfpga: Turn on ARM errata for L2 cache") adds
some selects in ./arch/arm/mach-socfpga/Kconfig, with one select being
conditionally selected on the non-existing Kconfig symbol PL310.

Hence, ./scripts/checkkconfigsymbols.py warns:

PL310
Referencing files: arch/arm/mach-socfpga/Kconfig

Assuming that this errata should actually be selected for
ARCH_INTEL_SOCFPGA, simply select this config unconditionally.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 43ddec677c0b..c21df17202a6 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -16,7 +16,7 @@ menuconfig ARCH_INTEL_SOCFPGA
 	select ARM_ERRATA_775420
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select PL310_ERRATA_753970 if PL310
+	select PL310_ERRATA_753970
 	select PL310_ERRATA_769419
 
 if ARCH_INTEL_SOCFPGA
-- 
2.26.2


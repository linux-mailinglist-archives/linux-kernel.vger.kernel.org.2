Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9C3AD33C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFRT74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhFRT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:59:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0AC061574;
        Fri, 18 Jun 2021 12:57:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i68so13784040qke.3;
        Fri, 18 Jun 2021 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37+/bJDLIApjJOabHdvoQrAss7FfPxN4WhCrNaoRcQ8=;
        b=VVK5tqIQzPOB/pClQcuBsJaDAbUUEnkPPKfulh8+2myK665uuDo09ot8XCi6sHxLZR
         y8fj3mrgXvbx9A3B+ONtPw+fgzGSVSenp/EXoiY0gWROqGi4Fn1A3bfSSLUZAqRutrON
         y6/Z4NVEd0pCnvPql7ZC2qz0kpv16hGqhZjcz6pRzjZpd2pCUk/Rx0NTK3mRSSCCeTNz
         w7VxyKoNdVRfMd0+aNfUIgW7eUgGosp5ty6Jf/80ptGfWLaf+TpH/azKTIXsZyVE7lva
         yo1XLSjlzAKK3hQ6WsNhDDGl4EuKC+ZgpibQ7FiIqr2BIgGmALXcE/0yLnEA8FN0OU8x
         W31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37+/bJDLIApjJOabHdvoQrAss7FfPxN4WhCrNaoRcQ8=;
        b=YmxhhOl6Qibz9qgEb2d9ie6+dTv9JIqkkiMEjnMq8PLh/CzuNUIuEUbqhMGpNv7jfF
         R2a9EUMFk/7Xms3skIGCWgIJyuLh3/1YXcgyD1fILIiGJUhvRlslAmcdsd3pxJw5AvSX
         +ybCDIlT2G2suhFt9/fqN2liCW2UPWmoWqQAq1GSvOh5ICLm20vpROIKRpK5WxuYucqB
         WdBraYPmIFI3PGnAThoKRVe/peM8yVzEtjOcRhbZQUJSLc1BzGJ0rnEdVCQaT24SRd9A
         Ee6Fxtlfzep44+yvNhSjC/3g/38HuFEAdxh8U8kseyS+6is1jBqYmQlhx4lX8/558c/2
         dQEw==
X-Gm-Message-State: AOAM531VGBhnA3AgeZoFzav74wMO64IDPtKwpzT1ozcYBmZDvE/7AdD8
        IWtKUGiZyNGz4TMO4g2EYGQ=
X-Google-Smtp-Source: ABdhPJwsBoaPQpmygNhzzHbhxJYWLoAgyxjLlepBLO8ruFcZoLk3lMO3BSYI+s1NjI072I/BF0YnWg==
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr11002088qko.452.1624046261378;
        Fri, 18 Jun 2021 12:57:41 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 7sm6015448qtx.33.2021.06.18.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:57:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/3] Replace for_each_*_bit_from() with for_each_*_bit() where appropriate
Date:   Fri, 18 Jun 2021 12:57:35 -0700
Message-Id: <20210618195735.55933-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618195735.55933-1-yury.norov@gmail.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of kernel functions call for_each_*_bit_from() with start
bit equal to 0. Replace them with for_each_*_bit().

No functional changes, but might improve on readability.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/apic/vector.c         | 4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++--
 drivers/hwmon/ltc2992.c               | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fb67ed5e7e6a..d099ef226f55 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -760,9 +760,9 @@ void __init lapic_update_legacy_vectors(void)
 
 void __init lapic_assign_system_vectors(void)
 {
-	unsigned int i, vector = 0;
+	unsigned int i, vector;
 
-	for_each_set_bit_from(vector, system_vectors, NR_VECTORS)
+	for_each_set_bit(vector, system_vectors, NR_VECTORS)
 		irq_matrix_assign_system(vector_matrix, vector, false);
 
 	if (nr_legacy_irqs() > 1)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 4102bcea3341..42ce3287d3be 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1032,7 +1032,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 {
-	unsigned int i = 0;
+	unsigned int i;
 
 	dev_err(gpu->dev, "recover hung GPU!\n");
 
@@ -1045,7 +1045,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 
 	/* complete all events, the GPU won't do it after the reset */
 	spin_lock(&gpu->event_spinlock);
-	for_each_set_bit_from(i, gpu->event_bitmap, ETNA_NR_EVENTS)
+	for_each_set_bit(i, gpu->event_bitmap, ETNA_NR_EVENTS)
 		complete(&gpu->event_free);
 	bitmap_zero(gpu->event_bitmap, ETNA_NR_EVENTS);
 	spin_unlock(&gpu->event_spinlock);
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 2a4bed0ab226..7352d2b3c756 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -248,8 +248,7 @@ static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 
 	gpio_status = reg;
 
-	gpio_nr = 0;
-	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
+	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
 		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
 			set_bit(gpio_nr, bits);
 	}
-- 
2.30.2


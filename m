Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EE3C7CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhGNDWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhGNDWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:22:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14CC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:20:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m83so800070pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpsH7mIcXqvQoo7xmLF/2aa6XMVIAHRRWDLOhYJdccM=;
        b=exIQaQBU3X0JT6wmWUXd6kAxACmjf23dI3nG1rlDlnC/fI0EDqHEc2xPy8NnUUec9z
         XSCO5lzQ8eGi8OypTjRCcD4OBBcLiJNtmYC0fXO6UEYmdHwx9rWlB+szKkeIJ0Jt/Arz
         7F1+20Xuz+EMaH8T32w26MtkbzseGg9t71/fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpsH7mIcXqvQoo7xmLF/2aa6XMVIAHRRWDLOhYJdccM=;
        b=SVurwZ0RIqUwA4Cih+v3rig4Grs+AZAOcx3Inm/+AeRgJYX0O3IxUIMw6a2G0TJI6p
         KocaX2zEVOtuoC6OF/FHplRQf1MVqMJUii6MeeA0OBPaYWl5O/NpA4rm2YXOTfO2VSAn
         z0EnCGJ13PStqSMEHPUBb7JuxeQkOqAkdZa/N65EnYevFdr3IbpdDCyUYu497ksK+1J5
         y3hS6knHk1w0NDF3AienSyxAR/rp08V8ZFB8bKaSiwtIWM5VHka78oG46hRZpQcPwcMQ
         MYVTjxiKfrPBRfNv7lX17edGa/b0c2SDnjQI2zuDUkfV4Q1eeD1s3WBiDo7dnSP9MQns
         YPXQ==
X-Gm-Message-State: AOAM533sUm6tKhrsHUQVQn6Rbu5b5Td7Un11ObumkzlbqN0tqh4/JrgT
        0T2XvzD+EBfKIq5HzJrIy8kyMA==
X-Google-Smtp-Source: ABdhPJzOVvGLyGiNzawM6Viy1d2MdKlXSmP4iW8i14wLOD5oabfZ0EUyG/CZfoceK0ZK9nKoEgR90w==
X-Received: by 2002:a05:6a00:170b:b029:32a:3950:f51b with SMTP id h11-20020a056a00170bb029032a3950f51bmr7770393pfc.64.1626232802699;
        Tue, 13 Jul 2021 20:20:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t26sm569424pgu.35.2021.07.13.20.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:20:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        bowsingbetee@pm.me, Mikhail Morfikov <mmorfikov@gmail.com>,
        stable@vger.kernelo.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] mm: page_alloc: Fix page_poison=1 / INIT_ON_ALLOC_DEFAULT_ON interaction
Date:   Tue, 13 Jul 2021 20:19:35 -0700
Message-Id: <20210714031935.4094114-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=keescook@chromium.org; h=from:subject; bh=U6MyozWPzcduXf+KzHAMxmKTs+aNnI1dvJ/+PKKtCNA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg7lfG9y1F5wstRYTqbG4LzbstCIJIACpar5PRh85M YgemSkCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYO5XxgAKCRCJcvTf3G3AJivxD/ wLKbiaTdFdcJ2auwyD8LrRpRRvxdIm0vySRmwi4OKlsjhRX3L+HY1c4TPIaKAYV2t99KdFl/LPHXWA Q/d1MTwBauC/OqqTYORwkso383gxzC8WcHCcOZcQep6fexIdCANDkcR2JQDH/LEZRMeO+wfoQbXmKw JvqW5X2NxuaXChhAhmsWGSx6WDXmYattgmf+mkl0rldwG5P3acTM3BKLh0XdL7gXDup49IiHZ/Krrd 3KkaY4qq8FagiFqHzyI4cPqhDz2v+sCJbNXisc/bW/Kt3CJNSGYIWZoLGp6tE1mv79z6WeZjegbPnt GMgupTmGumSYZ7Tmvc7dWWB0yRcWF1Q0H2F9hoAyRNHO1jYebpsJyWMO9g8M5HUxOzaSzqKo6zsBB1 /TuB9HanA5bSvcJyDv5PfOwPeZo6QXaRPV6Uo5LU9lE2tljsjKfKh7NXe5/PvReGQr1YSfY5RC7O9B G+ZokHmmRGOcAx/L8AYo9fU3ppmNO0LTXBtavDFYkVA3T0lS7bQwAKLwhNJ5qjaXzBw9G4snXL05bj NTs+RaQ/ZBzZnz+WvPNgWPRt58Ui2E7IQt6CgGMer7Gu2EPoYTbDK3KtPdFczX2cokfrLp6GXZrIaA UkMN25RqPTDoVWYwscqcVSMeggk2t+5jDpcHQxll206XX44c2AY+A3Vawisg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>

To reproduce the failure we need the following system:
  - kernel command: page_poison=1 init_on_free=0 init_on_alloc=0
  - kernel config:
    * CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
    * CONFIG_INIT_ON_FREE_DEFAULT_ON=y
    * CONFIG_PAGE_POISONING=y

    0000000085629bdd: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    0000000022861832: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00000000c597f5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    CPU: 11 PID: 15195 Comm: bash Kdump: loaded Tainted: G     U     O      5.13.1-gentoo-x86_64 #1
    Hardware name: System manufacturer System Product Name/PRIME Z370-A, BIOS 2801 01/13/2021
    Call Trace:
     dump_stack+0x64/0x7c
     __kernel_unpoison_pages.cold+0x48/0x84
     post_alloc_hook+0x60/0xa0
     get_page_from_freelist+0xdb8/0x1000
     __alloc_pages+0x163/0x2b0
     __get_free_pages+0xc/0x30
     pgd_alloc+0x2e/0x1a0
     ? dup_mm+0x37/0x4f0
     mm_init+0x185/0x270
     dup_mm+0x6b/0x4f0
     ? __lock_task_sighand+0x35/0x70
     copy_process+0x190d/0x1b10
     kernel_clone+0xba/0x3b0
     __do_sys_clone+0x8f/0xb0
     do_syscall_64+0x68/0x80
     ? do_syscall_64+0x11/0x80
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Before the 51cba1eb ("init_on_alloc: Optimize static branches")
init_on_alloc never enabled static branch by default. It could
only be enabed explicitly by init_mem_debugging_and_hardening().

But after the 51cba1eb static branch could already be enabled
by default. There was no code to ever disable it. That caused
page_poison=1 / init_on_free=1 conflict.

This change extends init_mem_debugging_and_hardening() to also
disable static branch disabling.

CC: Alexander Potapenko <glider@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: linux-mm@kvack.org
Reported-by: bowsingbetee@pm.me
Reported-by: Mikhail Morfikov <mmorfikov@gmail.com>
Fixes: 51cba1ebc60d ("init_on_alloc: Optimize static branches")
Cc: stable@vger.kernelo.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Link: https://lore.kernel.org/r/20210712215816.1512739-1-slyfox@gentoo.org
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/page_alloc.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..1f19365bc158 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -840,21 +840,24 @@ void init_mem_debugging_and_hardening(void)
 	}
 #endif
 
-	if (_init_on_alloc_enabled_early) {
-		if (page_poisoning_requested)
-			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-				"will take precedence over init_on_alloc\n");
-		else
-			static_branch_enable(&init_on_alloc);
-	}
-	if (_init_on_free_enabled_early) {
-		if (page_poisoning_requested)
-			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-				"will take precedence over init_on_free\n");
-		else
-			static_branch_enable(&init_on_free);
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	    page_poisoning_requested) {
+		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+			"will take precedence over init_on_alloc and init_on_free\n");
+		_init_on_alloc_enabled_early = false;
+		_init_on_free_enabled_early = false;
 	}
 
+	if (_init_on_alloc_enabled_early)
+		static_branch_enable(&init_on_alloc);
+	else
+		static_branch_disable(&init_on_alloc);
+
+	if (_init_on_free_enabled_early)
+		static_branch_enable(&init_on_free);
+	else
+		static_branch_disable(&init_on_free);
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;
-- 
2.30.2


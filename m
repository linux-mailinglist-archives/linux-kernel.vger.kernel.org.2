Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9567C42D091
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhJNCoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhJNCoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:44:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839BAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3704980pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WoQqGZDhSh6g9d8WgYHgl0GFeP5kf9LZakSmuU/NGk=;
        b=SKHdtp70QOF4LlSP3b6pLf5WNPpG8utQOZD/Q9asKW488DJ0wsRwnJUbeegeOVUxok
         0t0qRvJ2vZrw+fRu77f7aQ/ciVwecAfzUpd97XgS0ovbNZbBv0y84dJdUyPeKw1YhJBf
         jClUNXwsX5aJADJ7z5LQgWAUkdZ2oRKMuCr/sFM/rY3kvs254Ye3248oCCjIxwjLxJDv
         PMcwmun1km3Blve459EIEWHfeaueSh909+UH47ncr0HYC0RQcu3SvyOCGTckmZ3H+BhD
         yoISZJjWw1AxGcqA7qienFuENbcxrBfNNghtH46XFASHeZsfh7EMZYcIaSUKNGIDIxqU
         YE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WoQqGZDhSh6g9d8WgYHgl0GFeP5kf9LZakSmuU/NGk=;
        b=d0wwABcJkeH9j+Tl/Wl2Ev7LLi4N/G1+bD0G/HYbEOWqY4yhWLYYA+v6f3tH2fHcqm
         dWKBG6Cm7umTkzjPrJaxpAV0/S2cl70NAwM/2ZWij0fSsC7mXJnue6H8/6Kjs1cc5fCe
         GxyHv4X75OVbaGUITlBQCh05LAWSL5eLVnNLCZV3iiniAWP36JABQtj2BxA9O++NFtyv
         L7gjAxmIyRgx58qyRfXcR2X+L6C+9Q6MMHLl3sUY70NPsNYSN35WAM3pZPqLOS+gb2NZ
         EF3zdALqJSWk1vF5/N7bCKn24p5Z0Y4Qpka/MPd5NzRS7/RLtNDP2aWYvYdV1cyzrHqZ
         vGXQ==
X-Gm-Message-State: AOAM530/V1fdo/eeHpQbztekbix2VNpjhBZqhKe7fZPtJvmGXx33j2cL
        7ommam/B4DEF26cmWS5JSspOdacy6Q==
X-Google-Smtp-Source: ABdhPJyMbp9R8aklrE3eebrtF9NPiD4c781OyXfi7Vxb4UiIV4YJvsUkfIVnQXxdjt8To6WlqmhocA==
X-Received: by 2002:a17:902:6f02:b0:13e:5dce:eb9e with SMTP id w2-20020a1709026f0200b0013e5dceeb9emr2730228plk.64.1634179331951;
        Wed, 13 Oct 2021 19:42:11 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m28sm818403pgl.9.2021.10.13.19.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:42:11 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv3 1/4] kernel/watchdog: trival cleanups
Date:   Thu, 14 Oct 2021 10:41:52 +0800
Message-Id: <20211014024155.15253-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014024155.15253-1-kernelfans@gmail.com>
References: <20211014024155.15253-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No reference to WATCHDOG_DEFAULT, remove it.

And nobody cares about the return value of watchdog_nmi_enable(),
changing its prototype to void.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/nmi.c | 8 ++++----
 include/linux/nmi.h     | 2 +-
 kernel/watchdog.c       | 5 +----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..8dc0f4e820b0 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
  * sparc specific NMI watchdog enable function.
  * Enables watchdog if it is not enabled already.
  */
-int watchdog_nmi_enable(unsigned int cpu)
+void watchdog_nmi_enable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1) {
 		pr_warn("NMI watchdog cannot be enabled or disabled\n");
-		return -1;
+		return;
 	}
 
 	/*
@@ -295,11 +295,11 @@ int watchdog_nmi_enable(unsigned int cpu)
 	 * process first.
 	 */
 	if (!nmi_init_done)
-		return 0;
+		return;
 
 	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
 
-	return 0;
+	return;
 }
 /*
  * sparc specific NMI watchdog disable function.
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..b7bcd63c36b4 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
-int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..6e6dd5f0bc3e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -30,10 +30,8 @@
 static DEFINE_MUTEX(watchdog_mutex);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	1
 #else
-# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED)
 # define NMI_WATCHDOG_DEFAULT	0
 #endif
 
@@ -95,10 +93,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-int __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_nmi_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
-	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
-- 
2.31.1


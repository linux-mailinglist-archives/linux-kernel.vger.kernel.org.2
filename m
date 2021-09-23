Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BB4160C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhIWOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbhIWOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:11:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m21so6401301pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FS357D1JN+J32aJwqQjXs575AlGsgPXFPWkIjeHrV54=;
        b=CvZOIj/j0pFPrOj71e5xR8+3k4YaYDGBJetOHCEfBAhyqDELNxM4aIXSe7vsiPLtGS
         +5zBvFYxtIYZO2i74iyzj1Ec1LCK1RKmuNctpt/hKiGbN48T5b+HipGAaspMsM1NO9V9
         SLQAfPoor4T5Y4thUv0U2W8w19Aqw6U7sw3o8PqdEm1yNti5qNVVcpL0DbH4JGew3Qzk
         7HkmmshRsMFFZSqVxY1y33L7pyNAUceGVa2Xdb3BiQcDDQySeT+MfwqseyDB+tGK3sJB
         RsNFjsjxZakXZtgVEFSLiXEizUB/auKG2iVpUfm2Zt/uz3/4hs2hlsIlSRQBA2tCRuid
         k3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FS357D1JN+J32aJwqQjXs575AlGsgPXFPWkIjeHrV54=;
        b=YDtCj6MBLvY3UD+ePOd0Ukl4phyAowEN+QdE76PHowuFMlSML7Bh1WM03l+d0/5ygI
         VpAj3dpn3cnUB+U4wdPOGF8YXu9CtGbsPe/P9CRSewwk7y7GA6TXs0DHbWSRUwSNtTQM
         jhrRVxVhicFYzsrSGwoN4Mpz2buqq5Lct+glWotG4heWc85sm8KIs72dCyOZmju7NnJF
         lItjfULOskxLzG/GCxLTBuxVSDon2Lkrko5WF5fcOMM/xn6POciQeGGOn6hOyqAZWBqr
         jJXhO3XT1HKYDm9wg+Qkz7UPihG1IFGmjD75MMSLnj44lPqZ+KI0NOzHsQ0FsacS9+9r
         6Dbw==
X-Gm-Message-State: AOAM532TUl5m1nYO4+K2NEGZB4aUVTqCGAIDoDyfbQnpM0CAiPMJCuau
        c/YvaZpuvqhReWLPlCYiL86rZ3U57Q==
X-Google-Smtp-Source: ABdhPJypXnfLVjr+Sgh6uT0qpa3411a/9d02yi2MrJaKQAsCyE8gR+ZgXjmu1ZhNk4ktfT41wtUykw==
X-Received: by 2002:a65:47cd:: with SMTP id f13mr4378454pgs.439.1632406223667;
        Thu, 23 Sep 2021 07:10:23 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm5800766pfn.107.2021.09.23.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:10:22 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 1/4] kernel/watchdog: trival cleanups
Date:   Thu, 23 Sep 2021 22:09:48 +0800
Message-Id: <20210923140951.35902-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923140951.35902-1-kernelfans@gmail.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
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
 include/linux/nmi.h | 2 +-
 kernel/watchdog.c   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

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


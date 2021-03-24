Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C1347143
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhCXFu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhCXFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:50:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05268C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:50:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so15422847qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDOEV3CitODtZE7WDhEdTJHsluYHKAtRONfq9xlx6BQ=;
        b=s74wFrrEGz/q6vkAjL8f7SdfQIBhW5AhGz8c2LZf3KQI7qfZkHH0+LW0tR/7pC9o6J
         qGZT0KdV0CcRVzTqwUQyYh6+DweyIGeq7UP/1JRqcbqnwCDzJPwhW/sz+kMlUHpT/duh
         Q56PKx8SpHON51LEbVBCywy0Z4btXJv30rpvfyNtPXzDJsrd3APq/9EB+NxsfhKpost1
         ylJWwtRaO9AJo7wm3AqYICMbRAP705X0Nn4gNdfYW4Z4a1AFWKsN6zpfOPToDkFf8gW+
         EjOiRoJcVzo4v2yc314qajXtQxXB+qYLx0mezfbNnceGv9kWyghOjVoc1aPvbIFJ7e77
         uFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDOEV3CitODtZE7WDhEdTJHsluYHKAtRONfq9xlx6BQ=;
        b=P4apCBervrZ9pDUz0SeRwXI/HyT8Q9/eJA2f2f5JZGU+cIKDm9K3Fz7JW+dawyTWXu
         yDJxNBc3to33DiRyQPgeP1ALmKTsDQ09S32K2+9ozuxLv2b2PcV8XDfFDufrqu2h1W/g
         RDztyZkjNDWYP8CjLZl8Iqp9VwpcLqKlSGA/SNMGL4X3ScXab4XzvDpodf7A9e7AiPsW
         yipvP7AC+D6GPSBD1unXrNkm1ZJPb/YCzJDAQCB+WCQB0U1ukg4MyAMFUe/V4Fr5xYI7
         CUiE99zH4yxaDGhI+GbDORVsQoO0nee5d9HSJ0EZQQwfn4MfjtLCJ/fIHi9SkmQhf7yR
         AQYQ==
X-Gm-Message-State: AOAM532GRXSZmt7c5WK4Sxp8pvDT2Py4j7dz4yaDJmt414I4rqajkap7
        ExSKxmUs+RYBuXCNCp2y6Cg=
X-Google-Smtp-Source: ABdhPJz6BqyCSyPEz0sCmomXzRl2cUSO2ljw6xdMw1m9ARzA+ptI1XOskiBfVr7171eUNxO1Gt23zg==
X-Received: by 2002:a37:c92:: with SMTP id 140mr1551385qkm.177.1616565032253;
        Tue, 23 Mar 2021 22:50:32 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id z8sm830676qtn.12.2021.03.23.22.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 22:50:31 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     vgupta@synopsys.com, axboe@kernel.dk, gustavoars@kernel.org,
        unixbhaskar@gmail.com, tglx@linutronix.de,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] arc/kernel/signal.c: Fix couple of typos
Date:   Wed, 24 Mar 2021 11:22:13 +0530
Message-Id: <20210324055213.26775-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/unconditonally/unconditionally/
s/gaurantees/guarantees/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arc/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index a78d8f745a67..cf1788fd3812 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -259,7 +259,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 		regs->r2 = (unsigned long)&sf->uc;

 		/*
-		 * small optim to avoid unconditonally calling do_sigaltstack
+		 * small optim to avoid unconditionally calling do_sigaltstack
 		 * in sigreturn path, now that we only have rt_sigreturn
 		 */
 		magic = MAGIC_SIGALTSTK;
@@ -391,7 +391,7 @@ void do_signal(struct pt_regs *regs)
 void do_notify_resume(struct pt_regs *regs)
 {
 	/*
-	 * ASM glue gaurantees that this is only called when returning to
+	 * ASM glue guarantees that this is only called when returning to
 	 * user mode
 	 */
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
--
2.30.1


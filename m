Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F42316915
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBJO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhBJO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:26:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F4DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:25:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g6so2757042wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eTJkKmfzZLKUowysp2lExKyd3mTVmr/L/f8kXE31MM=;
        b=gE6Ohjn9+gt+qj4kmYHGQpNxkb/NbLmsxMzDX7s4TXgdimpg0ze5D8iRNUPzqL8M+P
         MGyHnWq6n+4LP2yyffDi4VnPn8K+e4D6R3FpWMw+CGFJkLTy91z11UAoqACGJZe1ZSnR
         fEZWLAjMX+VzNys60Lo41Tf47cpy/pkhCDOE42fRrGwYHR3VWFEXrNd/4xdSUlKkjE8W
         MFaNzPXggg/NcyXb1ddBQyEL5fLFfmCepX1svexMakzyrwFayM5vqCPwj9ucmCKk/lY5
         A/rhcicfDA0uFGdJEmWXM6XIa+sNHkrml8g9/HIiY8+LPQJe633wcYgNRqkiT/S9Sobi
         MqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eTJkKmfzZLKUowysp2lExKyd3mTVmr/L/f8kXE31MM=;
        b=o8FPi1FQAV+sAiRlaf1Uda9DmbSXDvyBbR6a1cVU7r6PeY7dY2qDK7DP9DMnzR0s4d
         p4L7hfICy8E2VKfX21Ur7+OveLEYQmTFz5ELbvfnXaD3bdurnDXORQaf0iccdzifLHiS
         kD0mRnfKIYVvEDSErLw1LjJUmdJHz6rULP47i9EnuFIumgL1ZYf935Yfheqk0PwdVlvR
         bYVxEvdWNALFXOSoC3HHqXdEhHV03rM0PD0knd3/ZzpT9qOdPAkWPffubhr+jyGMbYOI
         huv/7lau4rdbcIGHzELXk2ynLUiT/MVJS4UagXuCKGGNf2NdWH1DNZbjv9wsw2q7L7GX
         k7YA==
X-Gm-Message-State: AOAM530z/Y6SzaLdc0snzztLr3QWqMbjT4gCIxo5NcA5I69D6nYdSTrn
        ns5ROjq5DoMBS4suywA9EDH0dw==
X-Google-Smtp-Source: ABdhPJw9+xUG1EkKDCxCi7tzLU6RhGxv/YJR5hcuLAlBr9JtISIAHqa16xsOodwj+j2+jCMDYFcaJw==
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr4105000wrd.114.1612967136310;
        Wed, 10 Feb 2021 06:25:36 -0800 (PST)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r17sm3284581wrx.33.2021.02.10.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 06:25:35 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kgdb-bugreport@liss.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] kgdb: Remove kgdb_schedule_breakpoint()
Date:   Wed, 10 Feb 2021 14:25:25 +0000
Message-Id: <20210210142525.2876648-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To the very best of my knowledge there has never been any in-tree
code that calls this function. It exists largely to support an
out-of-tree driver that provides kgdb-over-ethernet using the
netpoll API.

kgdboe has been out-of-tree for more than 10 years and I don't
recall any serious attempt to upstream it at any point in the last
five. At this stage it looks better to stop carrying this code in
the kernel and integrate the code into the out-of-tree driver
instead.

The long term trajectory for the kernel looks likely to include
effort to remove or reduce the use of tasklets (something that has
also been true for the last 10 years). Thus the main real reason
for this patch is to make explicit that the in-tree kgdb features
do not require tasklets.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    During this cycle two developers have proposed tidying up the
    DECLARE_TASKLET_OLD() in the debug core. Both threads ended with a
    suggestion to remove kgdb_schedule_breakpoint() but I don't recall
    seeing a follow up patch for either thread... so I wrote it myself.

 include/linux/kgdb.h      |  1 -
 kernel/debug/debug_core.c | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 0d6cf64c8bb12..0444b44bd156d 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -325,7 +325,6 @@ extern char *kgdb_mem2hex(char *mem, char *buf, int count);
 extern int kgdb_hex2mem(char *buf, char *mem, int count);

 extern int kgdb_isremovedbreak(unsigned long addr);
-extern void kgdb_schedule_breakpoint(void);
 extern int kgdb_has_hit_break(unsigned long addr);

 extern int
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 7f22c1c0ffe80..b636d517c02c4 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -119,7 +119,6 @@ static DEFINE_RAW_SPINLOCK(dbg_slave_lock);
  */
 static atomic_t			masters_in_kgdb;
 static atomic_t			slaves_in_kgdb;
-static atomic_t			kgdb_break_tasklet_var;
 atomic_t			kgdb_setting_breakpoint;

 struct task_struct		*kgdb_usethread;
@@ -1084,31 +1083,6 @@ static void kgdb_unregister_callbacks(void)
 	}
 }

-/*
- * There are times a tasklet needs to be used vs a compiled in
- * break point so as to cause an exception outside a kgdb I/O module,
- * such as is the case with kgdboe, where calling a breakpoint in the
- * I/O driver itself would be fatal.
- */
-static void kgdb_tasklet_bpt(unsigned long ing)
-{
-	kgdb_breakpoint();
-	atomic_set(&kgdb_break_tasklet_var, 0);
-}
-
-static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
-
-void kgdb_schedule_breakpoint(void)
-{
-	if (atomic_read(&kgdb_break_tasklet_var) ||
-		atomic_read(&kgdb_active) != -1 ||
-		atomic_read(&kgdb_setting_breakpoint))
-		return;
-	atomic_inc(&kgdb_break_tasklet_var);
-	tasklet_schedule(&kgdb_tasklet_breakpoint);
-}
-EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
-
 /**
  *	kgdb_register_io_module - register KGDB IO module
  *	@new_dbg_io_ops: the io ops vector

base-commit: 19c329f6808995b142b3966301f217c831e7cf31
prerequisite-patch-id: 6d9085a2ef51882c80a4f13264cd12a14dcceb54
prerequisite-patch-id: c0a2cb664281d00a6e32867896374a617aafb358
prerequisite-patch-id: 6bbcef7ce98747090ecb13fd3eda74a241e47249
prerequisite-patch-id: 8bf7c51993c06ff88809d49ed59cbace3d94604e
--
2.29.2


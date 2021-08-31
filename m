Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F23FCC99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhHaRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhHaRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA500C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x4so17568102pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJlB8ZY7yHVZxgEBARqkpvW9BJ7wLiC17X25hPTUEuE=;
        b=vCaVamJPif3/hLJUQa/omzG/veIHnSQwtHEc8+u+EzVM9RYbp9NTR9l1DJgY1st96/
         JrqnvCH9lHD2VGB+pS14EMS9rdsrXsSP3EWhcxT3cibJtk3SharFGvxE65EanHAKjqss
         Er0njOLDiTaP3EBaz+TcMuu6SKBJQw7QmvQ0rEm0NSZE3okrnlkUajfCI5WQkEt+x+Pj
         JAMCEwfkFpJxfALcIh7ZPWlhp/CS83EMHTcbnAvuPurdoCpAJMOqkA/or4oNRGuCXBi9
         KFlJ9q9qEvo//yAvpWi4Hf6/jY/P7+I88GZgn1DBhenYde3CR/5tJQBCnl1BrIgXus6u
         ql0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJlB8ZY7yHVZxgEBARqkpvW9BJ7wLiC17X25hPTUEuE=;
        b=LsNRVVArxmdhwm3Tc3Xft82fnOu7I7fBiGc3Mc22tMy2yH/Rn/bchbLEvOI3NKG+WC
         u7+fW3SOOaXpblzgWoGn//wkZUffmkQCwKqTJO4ohUafqG209NyFNkfvLzqGbmwrm1vd
         0XvHpyeGN8I/tWMmwvS3Ga36Pq1b7aGaCOSLcNF+SVGTfSwXxIcDPwB6rBM0TSXi+Hcl
         FsMQMQsxR+M9LAE+79YDdxpfBS8O1Vz13CLtQDvHf72FYdKGec1soZH++DgbOUGAaO6J
         xepR1XIbVmH6/bFFAzAR0M6xA5ciS2GDEAktVBCtM+gl5cSqqGUdQdQd+KGSdxdOPAXM
         srzg==
X-Gm-Message-State: AOAM5338Gr1rpyYPKkQEn+0g+ZvEVh1ZCKj+xuUUkFz73FLL533dMU1n
        nsc2uMHB2378sj8f9oI/yLQtZS+8WS8=
X-Google-Smtp-Source: ABdhPJzS/RIxZjhDJ+nAr+pHeK316IkbvMBSqw4jVJrfI7TycorXRthXxLeYC6Rk4m3OhGOZ3ZLOJw==
X-Received: by 2002:a63:517:: with SMTP id 23mr20396452pgf.245.1630432311017;
        Tue, 31 Aug 2021 10:51:51 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id n1sm6806806pfv.209.2021.08.31.10.51.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:50 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 13/24] x86/traps: Mark sync_regs() and fixup_bad_iret() as static __always_inline
Date:   Wed,  1 Sep 2021 01:50:14 +0800
Message-Id: <20210831175025.27570-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

They have solo caller and are used only in traps.c.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c       | 5 +++--
 arch/x86/include/asm/traps.h | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index ab9866b650e7..40722a2f61ae 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -683,7 +683,8 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  * to switch to the normal thread stack if the interrupted code was in
  * user mode. The actual stack switch is done in entry_64.S
  */
-asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
+static __always_inline
+struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
 	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
 	if (regs != eregs)
@@ -734,7 +735,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 }
 #endif
 
-asmlinkage __visible noinstr
+static __always_inline
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 {
 	/*
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7b51a8081ae4..5c41a279c1e0 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,9 +11,6 @@
 #include <asm/trap_pf.h>
 
 #ifdef CONFIG_X86_64
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
-asmlinkage __visible notrace
-struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 asmlinkage __visible notrace struct pt_regs *do_error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
-- 
2.19.1.6.gb485710b


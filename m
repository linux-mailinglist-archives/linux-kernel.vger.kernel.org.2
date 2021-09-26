Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98344189D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhIZPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhIZPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B90C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t4so10045905plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xM1TAP6SyPkZxt3oLXVa7SXk4E9KPeiVLhno6SESzGQ=;
        b=pj10YR1rWKjBsiBKbKtWBHD+JpivgWCgaBnTx8bicvg3J4n0aR9cprJJ+rEyACggi3
         dw1AR5XOlZCobey6BtMtlrGICjw8CXuV0mAWg843w1mjfUMXJJvLbeM/p5fF2zjpsqV4
         t1oqkF34rRT5PaF7YPh8Eqq0fVNbIl9voL6cyCuHLIcdpJ0vN143zGjAI6b0FeYcBCNA
         /UMkKXQeZ0u4yQ7Ztgke57GJaBB2I6EZd8gadxq2IrFq6fVd7ETQNCrM4QGaeP2x/RkM
         u3Tch4QtCwVx5Ya0sOmVFR52E/1KWTlaUrdpDGIpbzpITun/l+wosBndG4PBOT35+vuV
         xIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xM1TAP6SyPkZxt3oLXVa7SXk4E9KPeiVLhno6SESzGQ=;
        b=VcnN8qQZtrqV7TT9r3aE+Lns4UbAOK1fT5OLEBUBb9lQeqHVdTNE6BXE/GZxc7oyeu
         PZK117+KtPSykVf7r6/gAeXbfr2Npg39s6NS8M37SpDm0x5I2mW6Y2pYoewxcQhLk+Lo
         7W1fe4kn6vCbMaSFbZQWSzkc9753M4eNnFXoVCAFehQBC8YuC/+K9SKBn+FjE7NV5U2i
         kYyBvA9k+5ZvnSGzT04GWSRn5CraPla6AV0PufOgeDMWqdYivx3040oTy8LBHE7he11l
         opZH6lzYkc9TgyR3vPsC+6FoiZDubDAyJrYceWuW7z6OYPOEdYod8YKlVgiCR5my8vNy
         ebnQ==
X-Gm-Message-State: AOAM533j+fbrEACWj2lagV0gLf82sWLkg3lN82oHsn69FsPLS9VSJ14x
        rieAflpfu7jA4h5GAHoQ0BHD/sonfwH2CQ==
X-Google-Smtp-Source: ABdhPJzgUUbg6wU5Hmi03CwUi3nQYfWPFM1Y8aao1c49b6fzqcTvVWekPzTyod6swlqa8NVbxVUScg==
X-Received: by 2002:a17:902:d48e:b0:13a:60a5:f410 with SMTP id c14-20020a170902d48e00b0013a60a5f410mr18266310plg.64.1632669151266;
        Sun, 26 Sep 2021 08:12:31 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id a9sm11595278pfl.203.2021.09.26.08.12.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:30 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 34/41] x86/doublefault: Use C entry code
Date:   Sun, 26 Sep 2021 23:08:31 +0800
Message-Id: <20210926150838.197719-35-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 12 ++----------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 72a1610bb540..db108f8cd554 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -544,16 +544,8 @@ SYM_CODE_START(\asmsym)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
-
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7935b0abc65d..99e1ae3f5c7d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -401,6 +401,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
-- 
2.19.1.6.gb485710b


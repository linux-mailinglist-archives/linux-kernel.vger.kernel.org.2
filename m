Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420E63FF8CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhICCOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhICCOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 22:14:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0121C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 19:13:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w8so4031738pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+XAQjpy3voMJtgNo0A7+OxFPeHQFWTfc/Hy03A+UH8=;
        b=kUfxGGYOfeAn5/qdDBXYBIDbf6/QETKDQtIYAdRoxhFjUqHzUKKGKGuFLErzLqOkMV
         /eQqV91tZFSAoSzY9AynOjzac/NYreg9cTzD2dwgJRpiZMjU79/V7FBwhRKx4T8OMJs8
         DQF4a9ql7+Nhw6B5OBXbN7OQPHaC/G7/OcsvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+XAQjpy3voMJtgNo0A7+OxFPeHQFWTfc/Hy03A+UH8=;
        b=HWXGBc3gyOkbrgnxeU+b26dXXTfxgyATwlkqWdJ346bV9lbmriSOQo1s3pucWEAxXD
         EpYDp5bMORwrp7TDEnBPLtDt6gFFt/rZApo/miqmo35lX3UZNR7kNq5N7BPselknutMd
         w6ZM5luQK2CxwCdQV3QWWXSS/lKcGX2a6X2OYBeEuIj2Z4lmXaWkoP4igIU/ACGSrYeL
         6hPR/UmxBYUV9Z2gapKPSZlxaS14y70Je7ipO6i0JH3j/E7aj4sLF4b0sKNZaQoCkefA
         wVqAK6sz7xDRZNHMSV8ni5WQGavmM7li1z97AwB1eJH2RUSFWNyUnqWGGsItOYfAXDs9
         OpQA==
X-Gm-Message-State: AOAM5307SHSNSuAhHxG6hxC8iXqo+t+70wus2+Pa/jEM+NHb8znOn7QT
        9BXpzVC7/a8eH0vNh6gb7q41cA==
X-Google-Smtp-Source: ABdhPJxSJskTO3jhEWqczy6z+fz+6n3MzfmH722vj0aa5DDm9U6PSelxFQrBWS8lZ0nA8GImDUvmqw==
X-Received: by 2002:a63:ff51:: with SMTP id s17mr1320135pgk.415.1630635210502;
        Thu, 02 Sep 2021 19:13:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y11sm3394931pfl.198.2021.09.02.19.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 19:13:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marios Pomonis <pomonis@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Date:   Thu,  2 Sep 2021 19:13:26 -0700
Message-Id: <20210903021326.206548-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=keescook@chromium.org; h=from:subject; bh=4yGeYqi5n+vG90FVozltwZqHG3Ed2jD74ZA9Kjgcndo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMYTFaJBgBwA+UlQ+r4U9BYCrKDcxscsgdiHGD0vj BPd8P+WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTGExQAKCRCJcvTf3G3AJlVaD/ 4mhv3iy3PhorNRJD6cjnDEP3exfTlkA5ntXcOelGRE/5uersM4Q/DlQbMCCAIEfkwzvk7YZjqGaFN2 hBHaBJQVyeyLcwHZCZBVo+Hjp5fCchbRL0Ssd6wZ8TpluGaTO5PoDKSRR0AnGtxGb1SHGC1byxXEoQ 5afuBboTU8eCshHAA3KHbMi71mZMlRaFBWdQoHwidPniEU9RFMgWVCHlTMPZWN1f2rXVFGt5qSTmrd 4w6gxIVpnL30wasZCBpiwCj67ZvtEl1Nnp/QM66s+nCQEGFaYGiHpnzQF3szUkdvedZfiMpAYJ/lpH 6nciXB1/U5q9TlWEQrX6M4A2aZTJ6MnRK8yjdbHffGTS4dVRzLzHJTT95PWXXLKBMmwiDbVguIbjyT KyMbecX6oJGJw3H4PMWSWH7SEe13ZmLPzOqpRbjBlykca9QOiDWcQ454XlTnSlf9X01TBMq5+REM40 s4z91wsuhqjeDrOJ9eKjWSEsOUkoC1sRLprbpNPTEXnE11Ff3AEsf5tEn94CRaiqf27WXVFAQLiZOm KAK1SPgQfQg2cP2IXonbx3HcPqNDtYFA8l/XU4Qn2mFnQ/0o7B6FoGHzufQQdJBLVsv9uLKx10T1AF u1JPx9E17KCbmw6BLJhX9pbfseHgFn+DBWSLzBNRFl7DCYoFYrJsd7MpRnUw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

Fix a bug in the ORC unwinder when kretprobes has replaced a return
address with the address of `kretprobes_trampoline'. ORC mistakenly
assumes that the address in the stack is a return address and decrements
it by 1 in order to find the proper depth of the next frame.

This issue was discovered while testing the FG-KASLR series[0][1] and
running the live patching test[2] that was originally failing[3].

[0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
[1] https://github.com/KSPP/linux/issues/132
[2] https://github.com/lpechacek/qa_test_klp
[3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Marios Pomonis <pomonis@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/unwind_orc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a1202536fc57..8c5038b3b707 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,6 +7,7 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
+#include <asm/kprobes.h>
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
@@ -414,6 +415,15 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
 	return false;
 }
 
+static bool is_kretprobe_trampoline(unsigned long ip)
+{
+#ifdef	CONFIG_KRETPROBES
+	if (ip == (unsigned long)&kretprobe_trampoline)
+		return true;
+#endif
+	return false;
+}
+
 bool unwind_next_frame(struct unwind_state *state)
 {
 	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
@@ -540,7 +550,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->sp = sp;
 		state->regs = NULL;
 		state->prev_regs = NULL;
-		state->signal = false;
+		state->signal = is_kretprobe_trampoline(state->ip);
 		break;
 
 	case UNWIND_HINT_TYPE_REGS:
-- 
2.30.2


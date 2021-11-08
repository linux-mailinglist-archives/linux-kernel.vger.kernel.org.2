Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D35B449EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhKHWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 17:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239019AbhKHWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 17:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636410974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yn5fSO01zEpaLNN07yTLVji3YLZ1c6tMonU4Wpi0BV8=;
        b=I0eOh90ZzJd321McWPPua29zlT1LDkz1RjrRyjraTfUB0Klw0t/FM3wbSeuVPXRFpma6MY
        H9C6595AIzQ6OSPoooJrqUYpkkxXOdkHSWTPxQLo7Dt0fEmqp02w7yATfDtnhWcNRs3RFB
        PJ39Hcc3Uqt5mGDsPFOtka30qDwiaLQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-kadrLVImMkOpu5nzoGBcrQ-1; Mon, 08 Nov 2021 17:36:12 -0500
X-MC-Unique: kadrLVImMkOpu5nzoGBcrQ-1
Received: by mail-qk1-f200.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so11950580qkd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 14:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn5fSO01zEpaLNN07yTLVji3YLZ1c6tMonU4Wpi0BV8=;
        b=2iZTzL6p47Rjxvukr/S9R7HSSPBM4Ng9FUpycLex1AUBizjoHLw69jfQVjbjrXonrR
         FKiKdVmfAE92MjBBad/V+gYGo3cIIBA337ofgqnYv4q2MCComcvLQs0GlHEijR3NIElt
         J/2ETFlpOzJr9wMtcHeamnL/zhCjQzx0Kiod2N71r1fMUyjcl1JRA4iHgOkG3RzQXwid
         V7Ge4s6NZmcGKaWFdP8u3/KvRaA+H7jzLT6p8ZpEVG84vGRB08KxhPA0hE03NBCNqPHE
         5HyMMIAvz1KnFAru3MzdLsm0Gmwva1kbuN5U1i2aBHATvn1fvpBG+qBQs0P5Qjm7HwyK
         43Mw==
X-Gm-Message-State: AOAM531diCzAMIEYN6knUwpgkpnNlHrofc7s/SQ7TCMvBjMpqFXivbL7
        KnzGIFNqIQuMciENqw46iAgSehFqjHOLiJbsZ8dbERGQl+RZnp3LquxBTOt0WVkyQhJmeEyhmMj
        PdhqxjX53zqA2Yg0BjVFqug4H
X-Received: by 2002:a05:6214:dc2:: with SMTP id 2mr2435215qvt.39.1636410970929;
        Mon, 08 Nov 2021 14:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKsYfr0CsyaG055SX01C3Ub/o1Mj7n6ObGzjBi9HvhAl6jrG79J+3mlBsJr8egJtQfXDU7MA==
X-Received: by 2002:a05:6214:dc2:: with SMTP id 2mr2435198qvt.39.1636410970750;
        Mon, 08 Nov 2021 14:36:10 -0800 (PST)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u3sm2282489qta.74.2021.11.08.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 14:36:10 -0800 (PST)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] compiler.h: Fix annotation macro misplacement with Clang
Date:   Mon,  8 Nov 2021 14:35:59 -0800
Message-Id: <0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang and CONFIG_TRACE_BRANCH_PROFILING, there are a
lot of unreachable warnings, like:

  arch/x86/kernel/traps.o: warning: objtool: handle_xfd_event()+0x134: unreachable instruction

Without an input to the inline asm, 'volatile' is ignored for some
reason and Clang feels free to move the reachable() annotation away from
its intended location.

Fix that by re-adding the counter value to the inputs.

Fixes: f1069a8756b9 ("compiler.h: Avoid using inline asm operand modifiers")
Fixes: c199f64ff93c ("instrumentation.h: Avoid using inline asm operand modifiers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/compiler.h        | 4 ++--
 include/linux/instrumentation.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d5af56337bd..429dcebe2b99 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -121,7 +121,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.reachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_reachable() __annotate_reachable(__COUNTER__)
 
@@ -129,7 +129,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index fa2cd8c63dcc..24359b4a9605 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -11,7 +11,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -50,7 +50,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
-- 
2.31.1


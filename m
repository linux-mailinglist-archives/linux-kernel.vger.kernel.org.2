Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4334349B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJTLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D6C061768
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=78XW1AsO+8MnkAYP+XvZStkDp17xrVCnSVPHSo82AaI=; b=FvVuA4OH8HZ1GNihsz3Xx0GDQd
        Q1MdLjuQ358aGk1ErpOzgoCxwpgrX7Flgic8EwBdUkTdi/ScW6C10mgEUrsDCAo6SYKuKf34H7+GL
        EAb+u9YLBgLqxiIYldagGm2oJH3SbXvCadKDaYbihwHSUOTqFF49MNfpf3fUdaRD6L1oHxcshUZD8
        LOUsV+cVPKw58cyL81hGOV/GYowNv8RcoxbvgZqNVukLDGaO1vX/772mt+lUTnRxIZsmmohEKw6va
        nC08du9yqxYj6CHYZ+OvzztsHnwnMNThnR2+N+FEXz1SQtOv7OChs61c7MWhKmVaVeQonI96cYczK
        /4WmxQbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR14-9W; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36022300EAF;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1E95E201BB3C7; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105843.223005077@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 12/14] x86/alternative: Add debug prints to apply_retpolines()
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we can see the text changes when booting with
'debug-alternative'.

Example output:

 [ ] SMP alternatives: retpoline at: __traceiter_initcall_level+0x1f/0x30 (ffffffff8100066f) len: 5 to: __x86_indirect_thunk_rax+0x0/0x20
 [ ] SMP alternatives: ffffffff82603e58: [2:5) optimized NOPs: ff d0 0f 1f 00
 [ ] SMP alternatives: ffffffff8100066f: orig: e8 cc 30 00 01
 [ ] SMP alternatives: ffffffff8100066f: repl: ff d0 0f 1f 00

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -487,9 +487,15 @@ void __init_or_module noinline apply_ret
 			continue;
 		}
 
+		DPRINTK("retpoline at: %pS (%px) len: %d to: %pS",
+			addr, addr, insn.length,
+			addr + insn.length + insn.immediate.value);
+
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
+			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D23343CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:34:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0vA8v9PIlA3602r5Gvnd3ciKxNHPDECOL/poy4vzm0=; b=HVNIumIsXwi9mrYvFu6ATFspjJ
        /C10nGoS83U5afokpiyfTwI7aMA22CAxR3oNWhi70gU8q2vOi90HsiPqR2Uho4GPqZ08frgCClmAG
        zVHDgtjmBsWwJude8sfsa8S4QAv/K074kbD3yZC6VvlM0d9y4P2FZ4c+gJR/nFFBtO6BVDjipddrj
        J1u7CXnGxlqCASYIOgqXJHC4TFETOuOqumyhkuiQVVjsuTbBqn0vjaQgp92z/rmQgyxk7JKPdSQCF
        ucVwpUQTvs4pAqKRG2vf4GctyR790CQ4Zcr2viHuZ0UGBRrrwYBfV3UCeAlMVt68vVZCRMPYN71P6
        8bb2Z5Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOGvd-008H1F-Hy; Mon, 22 Mar 2021 09:33:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6D72301A32;
        Mon, 22 Mar 2021 10:32:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC9392CE39137; Mon, 22 Mar 2021 10:32:52 +0100 (CET)
Date:   Mon, 22 Mar 2021 10:32:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "mbenes@suse.com" <mbenes@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
Message-ID: <YFhkRN8dxHqItHy8@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.580212227@infradead.org>
 <f7a36237052f4c09ad101431653038a5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a36237052f4c09ad101431653038a5@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 05:18:14PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 18 March 2021 17:11
> > 
> > Due to commit c9c324dc22aa ("objtool: Support stack layout changes
> > in alternatives"), it is possible to simplify the retpolines.
> > 
> ...
> > Notice that since the longest alternative sequence is now:
> > 
> >    0:   e8 07 00 00 00          callq  c <.altinstr_replacement+0xc>
> >    5:   f3 90                   pause
> >    7:   0f ae e8                lfence
> >    a:   eb f9                   jmp    5 <.altinstr_replacement+0x5>
> >    c:   48 89 04 24             mov    %rax,(%rsp)
> >   10:   c3                      retq
> > 
> > 17 bytes, we have 15 bytes NOP at the end of our 32 byte slot. (IOW,
> > if we can shrink the retpoline by 1 byte we can pack it more dense)
> 
> I'm intrigued about the lfence after the pause.
> Clearly this is for very warped cpu behaviour.
> To get to the pause you have to be speculating past an
> unconditional call.

Please read up on retpoline... That's the speculation trap. The warped
CPU behaviour is called Spectre-v2.

For others, the obvious alternative is the below; and possibly we could
then also remove the loop.

The original retpoline, as per Paul's article has: 1: pause; jmp 1b;.
That is, it lacks the LFENCE we have and would also fit 16 bytes.



---
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -15,8 +15,7 @@
 	call    .Ldo_rop_\@
 .Lspec_trap_\@:
 	UNWIND_HINT_EMPTY
-	pause
-	lfence
+	int3
 	jmp .Lspec_trap_\@
 .Ldo_rop_\@:
 	mov     %\reg, (%_ASM_SP)
@@ -27,7 +26,7 @@
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
 
-	.align 32
+	.align 16
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \



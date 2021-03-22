Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4075A343F01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCVLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:07:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCVLHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:07:40 -0400
Received: from zn.tnic (p200300ec2f06670063ce2fe2d87b4e47.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6700:63ce:2fe2:d87b:4e47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0221F1EC0374;
        Mon, 22 Mar 2021 12:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616411255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yebnAM04kqo0Y3gumygngXabGwhPrWwTAVUbDzRwA2U=;
        b=CKsnFcX08p4OA4OImibBpvy/4i3KTXP5s6PVr3KQkvc7NH1WZn12adajRTqNuCzUp2RJay
        nvaGZrsLiI76hVeGNK93Am47QUctt1Uk+sXGdjX7TPZoeBCTYKTapsHgzk3mBxWOmKdIq0
        0g+LbNY1YGY5zjO2rVmJl0IY3g2THpQ=
Date:   Mon, 22 Mar 2021 12:07:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] x86/alternatives: Optimize optimize_nops()
Message-ID: <20210322110734.GC6481@zn.tnic>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.520075106@infradead.org>
 <20210321120647.GB14446@zn.tnic>
 <YFhStWee0OrxBn5F@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFhStWee0OrxBn5F@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:17:57AM +0100, Peter Zijlstra wrote:
> You've make it only replace a single stream of NOPs. Which is probably
> fine, but... :-)

Yap, since I added the padding thing there should be no need to put NOPs
in the middle.

> So mine, while a little more complicated, will replace any number of NOP

A little? I had to sprinkle printks to figure out what it does :)

And what it does is, it calls the instruction decoder on every byte and
advances by the length of each insn it decoded. But that is unnecessary
because the possible opcode bytes you should get to see in any possible
location are:

[(insn).* NOP*]

i.e., 0 or more instructions which are non-NOPs followed by 0 or more
NOPs. Thus my simpler solution to scan past the non-NOPs and patch the
rest.

So I don't see the need for the complexity, frankly.

Btw, yours needs some adjusting to the DUMP_BYTES indices call:

[    0.145789] SMP alternatives: SKIP feat: 8*32+16, old: (entry_SYSCALL_64_after_hwframe+0x49/0xc5 (ffffffff81a0006d) len: 23), repl: (ffffffff89764c3f, len: 23)
[    0.146699] SMP alternatives: ffffffff81a0006d:		 old_insn: 48 c7 c0 90 90 00 00 90 90 90 cd 30 90 90 90 90 90 90 90 90 90 90 90
[    0.148121] SMP alternatives: ffffffff89764c3f: 		 rpl_insn: 48 bb ef be ad de 00 00 00 00 48 31 c0 48 b9 be ba ee ff c0 00 00 00
[    0.149405] SMP alternatives: ffffffff81a0006d:   [7:3) optimized NOPs: 48 c7 c0 90 90 00 00 0f 1f 00 cd 30 90 90 90 90 90 90 90 90 90 90 90
[    0.150700] SMP alternatives: ffffffff81a0006d: [11:11) optimized NOPs: 48 c7 c0 90 90 00 00 0f 1f 00 cd 0f 1f 84 00 00 00 00 00 0f 1f 00 90

[7:3) and [11:11) look weird.

The thing I'm testing with is:

        ALTERNATIVE "mov $0x9090, %rax; .byte 0x90,0x90,0x90; int $0x30", "mov $0xdeadbeef, %rbx; xor %rax, %rax; mov $0xc0ffeebabe, %rcx", \
                X86_FEATURE_XENPV

which is arbitrary, ofc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

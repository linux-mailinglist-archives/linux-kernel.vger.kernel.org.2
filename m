Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA53A189A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhFIPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbhFIPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:10:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bGSDp9v/6VI6NXx/o7FnCwfsLH/DQ2C/TbgATT+JAzk=; b=alauMrl6iIqgexH+GlokqYcd9d
        kTXvMTkzYzT3PGba8L5NL/J5yDhxneLXYhCPfHxazp9MzeYV8fQB26UyJHU8HmNWk2GrZyIgoahab
        eQjUDubGZLWp6ipbY8nDZp8HrGKIdgjXKtH0AyJZHwooQUHg5EtrtDCNZMaVUu4M3H25y/z0uF5Jd
        6R/XSDqQZ4OXAGy/+5SzrXNpbz7GEI9LrbT+EA8sR0AMNE40Tzjyo5ojrAkBBWTwy+sy2dSqJYAyJ
        YuEuoo53lA8DWANTzo355nn3lJbD07P4VrVKFFBGp7PychvnATZ+N2Fo4Xu4FNyVG0mFJyUwp6r50
        4q340DQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqzoG-0057e5-CX; Wed, 09 Jun 2021 15:08:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3A239867D0; Wed,  9 Jun 2021 17:08:04 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:08:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210609150804.GF68208@worktop.programming.kicks-ass.net>
References: <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
 <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
 <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
 <CAFJ_xbp5YzYNQWEJLDySyC_bWUsirq=P03k8HHW=B4sH0V_uUg@mail.gmail.com>
 <YMBrqDI0Oxj9+Cr/@hirez.programming.kicks-ass.net>
 <CAFJ_xbodWTQQaJ-3yJ4ZQOiTFFXo6M+cn_F0p157o=80BwrQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xbodWTQQaJ-3yJ4ZQOiTFFXo6M+cn_F0p157o=80BwrQAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 02:23:28PM +0200, Lukasz Majczak wrote:
> śr., 9 cze 2021 o 09:20 Peter Zijlstra <peterz@infradead.org> napisał(a):
> >
> > On Wed, Jun 09, 2021 at 09:11:18AM +0200, Lukasz Majczak wrote:
> >
> > > I'm sorry I was on vacation last week - do you still need the requested debugs?
> >
> > If the patch here:
> >
> >   https://lkml.kernel.org/r/YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net
> >
> > does not fix things for you (don't think it actually will), then yes,
> > please send me the information requested.
> 
> Ok, it didn't help. Peter, Josh I have sent you a private email with
> requested information.

OK, I think I've found it. Check this one:

 5d5:   0f 85 00 00 00 00       jne    5db <cpuidle_reflect+0x22>       5d7: R_X86_64_PLT32     __x86_indirect_thunk_r11-0x4


+Relocation section '.rela.altinstructions' at offset 0 contains 14 entries:
+    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend

+0000000000000018  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5d5
+000000000000001c  0000009200000002 R_X86_64_PC32          0000000000000000 __x86_indirect_alt_call_r11 + 0

Apparently we get conditional branches to retpoline thunks and objtool
completely messes that up. I'm betting this also explains the problems
Nathan is having.

*groan*,.. not sure what to do about this, except return to having
objtool generate code, which everybody hated on. For now I'll make it
skip the conditional branches.

I wonder if the compiler will also generate conditional tail calls, and
what that does with static_call... now I have to check all that.

---

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 24295d39713b..523aa4157f80 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -747,6 +747,10 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
 		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
 			continue;
 

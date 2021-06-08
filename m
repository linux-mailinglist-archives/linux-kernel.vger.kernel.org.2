Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F004539FECE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhFHSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhFHSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:19:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CBEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Co//ogi0KDTBikV6nydb3Go2X95ksXSe8+9miI8T9iQ=; b=XqG0jOqyMCpsVnKu6OAOf7cesn
        E2JdDxB74rXo3x/fdJ0BvS0gKeX4k33xRx8wC9uGxxVTZVym9FQC5Y2MTpuJs70UmH2mLtDOrvx91
        bKyb10iErePQdNSqez88N+ot10ovaWpWn9WhBjRo7GQBnjceqjtMwivxyVxr3Uagdff4QZ/QF9vgr
        d8jwpb9jiib0/c2daiqQNzBN9sGxLDfmXC6PnNiTjs5YsbhXOUTc797gqQ/RcL+bS/90l5JutDeqk
        u97O/WQvaOnEl3VYhGSaqiVr4f0SHJWNNjLZ/VK6d5IKL7HTX56PbO8F3k5lB7CYsF87cza87RzTr
        QghaaP/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqgHq-004pSJ-40; Tue, 08 Jun 2021 18:17:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7418030018A;
        Tue,  8 Jun 2021 20:17:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE37201D304F; Tue,  8 Jun 2021 20:17:20 +0200 (CEST)
Date:   Tue, 8 Jun 2021 20:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
References: <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:29:56AM -0700, Nathan Chancellor wrote:
> On 6/8/2021 10:22 AM, Peter Zijlstra wrote:

> > Since it's a VM, can you use the gdb-stub to ask it where it's stuck?
> > 
> 
> Unfortunately, this is the VM provided by the Windows Subsystem for Linux so
> examining it is nigh-impossible :/ I am considering bisecting the transforms
> that objtool does to try and figure out the one that causes the machine to
> fail to boot or try to reproduce in a different hypervisor, unless you have
> any other ideas.

Does breaking Windows earn points similar to breaking the binary
drivers? :-) :-)

The below should kill this latest transform and would quickly confirm if
the that is causing your problem. If that's not it, what was your last
known working version?


diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..d0f231b9c5a1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1857,10 +1857,10 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be after add_special_section_alts(), since this will emit
 	 * alternatives. Must be after add_{jump,call}_destination(), since
 	 * those create the call insn lists.
-	 */
 	ret = arch_rewrite_retpolines(file);
 	if (ret)
 		return ret;
+	 */
 
 	return 0;
 }

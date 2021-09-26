Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AD418877
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhIZMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZMBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3BE961038;
        Sun, 26 Sep 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632657578;
        bh=JxAHqSs54HWLkzs8GGZKJGY7bzgrYrkSWME5INakZyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxh+fFUD1g/hRnnkLHEPpYjqqiYncuArFCrHTi931PG1iVh0J7kA2jONkBuRdolrI
         LvrVp3x4PT1MaHv/ZG2c+JKJYhQI2D2HdD9Qt8gXaaT0s1wzxKdJMi+1rafk9R335h
         rd6GSygsN+Xbg8q3IiPcHga74r7ykB63OXY8BLSgJzHaQDxDOtkAMF8JO1vcyyTjrw
         9tzkdYpD7kE3Vm/GIc5Ee+B7THAxUw2UQveeIp0pMnXOPd9xz06DSJRzYtN92BZDsD
         QKxBgcLFRQZ1hPAnrkaMQlmOMzM+lzqbPCu7pYrVuJ/Qb8tcDwGzi/C02J/EedKkUP
         BssCo0M7lxZPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F460410A1; Sun, 26 Sep 2021 08:59:35 -0300 (-03)
Date:   Sun, 26 Sep 2021 08:59:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH v4] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Message-ID: <YVBgp57askJVro9S@kernel.org>
References: <20210923161843.751834-1-irogers@google.com>
 <YU4gyQg1ntTeTL98@kernel.org>
 <20210925133944.a0648549c28b047bd9aeaeff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925133944.a0648549c28b047bd9aeaeff@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 25, 2021 at 01:39:44PM +0900, Masami Hiramatsu escreveu:
> On Fri, 24 Sep 2021 16:02:33 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Thu, Sep 23, 2021 at 09:18:43AM -0700, Ian Rogers escreveu:
> > > From: Numfor Mbiziwo-Tiapo <nums@google.com>
> > > 
> > > Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> > > these are forms of undefined behavior.
> > > 
> > > These problems were identified using the undefined behavior sanitizer
> > > (ubsan) with the tools version of the code and perf test. Part of this
> > > patch was previously posted here:
> > > https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> > 
> > Masami, if you're ok, just process it including the tools/ bit.
> 
> Hi Arnaldo,
> 
> This version updates the tools/ too, so I think this is OK.
> (do I need re-Ack?)

So you want me to process it?

- Arnaldo
 
> Thank you, 
> 
> > 
> > - Arnaldo
> >  
> > > v4. Fixes a typo.
> > > 
> > > v3. Is a rebase picking up a fix for big endian architectures.
> > > 
> > > v2. removes the validate_next check and merges the 2 changes into one as
> > > requested by Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  arch/x86/lib/insn.c       | 4 ++--
> > >  tools/arch/x86/lib/insn.c | 4 ++--
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> > > index 058f19b20465..c565def611e2 100644
> > > --- a/arch/x86/lib/insn.c
> > > +++ b/arch/x86/lib/insn.c
> > > @@ -37,10 +37,10 @@
> > >  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> > >  
> > >  #define __get_next(t, insn)	\
> > > -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > > +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > >  
> > >  #define __peek_nbyte_next(t, insn, n)	\
> > > -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> > > +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> > >  
> > >  #define get_next(t, insn)	\
> > >  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> > > diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> > > index c41f95815480..797699462cd8 100644
> > > --- a/tools/arch/x86/lib/insn.c
> > > +++ b/tools/arch/x86/lib/insn.c
> > > @@ -37,10 +37,10 @@
> > >  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> > >  
> > >  #define __get_next(t, insn)	\
> > > -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > > +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > >  
> > >  #define __peek_nbyte_next(t, insn, n)	\
> > > -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> > > +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> > >  
> > >  #define get_next(t, insn)	\
> > >  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> > > -- 
> > > 2.33.0.464.g1972c5931b-goog
> > 
> > -- 
> > 
> > - Arnaldo
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4C417FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhIYElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 00:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhIYElW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 00:41:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C0360F70;
        Sat, 25 Sep 2021 04:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632544787;
        bh=zPdgx5ZT+r+BrD+V07Yxv3l9pb88yMRgA9tQRZuqifU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+iv1oDnkD1W6a+1we9hREN83qPFMaVwkUYlIv1M/mlkTCpm0YV4vIamA61eg+Lsp
         w+5734SOezlppCF5YOsnM3iTnjeYjxbXUjStIWoViZT/dKOjVdx2EHoQzK5r0Y+m7j
         giinQj8jfrmXMpTSIAPrfCsLRYEBfjU//MxcguqAUXJCmtEQigFDGS0jNtOQfoIfL3
         RDN20aJGPTcmNrlNQJjFfVbdiHds9EbN3/c1z0c1S/00OqGmfuADFUuL6oKcdYxHii
         7U1Qd3orKLB3002Gbhut8tiEYFlEjfcX+WNjyDfBwb9D8ncxORQD4Q4JzxFV76lT21
         wpnUXkoFYjBYg==
Date:   Sat, 25 Sep 2021 13:39:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH v4] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Message-Id: <20210925133944.a0648549c28b047bd9aeaeff@kernel.org>
In-Reply-To: <YU4gyQg1ntTeTL98@kernel.org>
References: <20210923161843.751834-1-irogers@google.com>
        <YU4gyQg1ntTeTL98@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 16:02:33 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Sep 23, 2021 at 09:18:43AM -0700, Ian Rogers escreveu:
> > From: Numfor Mbiziwo-Tiapo <nums@google.com>
> > 
> > Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> > these are forms of undefined behavior.
> > 
> > These problems were identified using the undefined behavior sanitizer
> > (ubsan) with the tools version of the code and perf test. Part of this
> > patch was previously posted here:
> > https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> 
> Masami, if you're ok, just process it including the tools/ bit.

Hi Arnaldo,

This version updates the tools/ too, so I think this is OK.
(do I need re-Ack?)

Thank you, 

> 
> - Arnaldo
>  
> > v4. Fixes a typo.
> > 
> > v3. Is a rebase picking up a fix for big endian architectures.
> > 
> > v2. removes the validate_next check and merges the 2 changes into one as
> > requested by Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/x86/lib/insn.c       | 4 ++--
> >  tools/arch/x86/lib/insn.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> > index 058f19b20465..c565def611e2 100644
> > --- a/arch/x86/lib/insn.c
> > +++ b/arch/x86/lib/insn.c
> > @@ -37,10 +37,10 @@
> >  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >  
> >  #define __get_next(t, insn)	\
> > -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> >  
> >  #define __peek_nbyte_next(t, insn, n)	\
> > -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> > +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> >  
> >  #define get_next(t, insn)	\
> >  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> > diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> > index c41f95815480..797699462cd8 100644
> > --- a/tools/arch/x86/lib/insn.c
> > +++ b/tools/arch/x86/lib/insn.c
> > @@ -37,10 +37,10 @@
> >  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> >  
> >  #define __get_next(t, insn)	\
> > -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> > +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> >  
> >  #define __peek_nbyte_next(t, insn, n)	\
> > -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> > +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
> >  
> >  #define get_next(t, insn)	\
> >  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> > -- 
> > 2.33.0.464.g1972c5931b-goog
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>

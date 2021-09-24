Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB062417B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbhIXTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346035AbhIXTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32BE060E97;
        Fri, 24 Sep 2021 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632510156;
        bh=4NxIqTflfhfqaUe2RRhcz/Q/LBzaoiPooJpvQFfcryU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPFZfxfLd/csjrEKgFH3vmou92f1gYHFt5SbX+JcGDiMjWrDWDhjU3TAoVa1Pe2uG
         yB/KAd1f6QnK0Kf+2gEUb+cTM9NwLpUEZJV3PeA6FlGjRrFcPw+2Z9DNplNcpKfFqn
         IQlr2jyMTeUY/PyAK7IJN4179R9pOc6RLCF8Tq8PqVr7fX768aF7p6Z5JPnvdOcbVW
         /Yg/W0TtJMYXgDegI7jOQszqFLq4bkAc2tR3jknESXgVThMi7HiDoqbjUDIdAsvYC6
         pH70cixcpBM2NZfxq/1wdf2fJyM9slnw3GEDLTVL9P8YuAcQacQQUBypB5sZQJyc/R
         bZuygnwbV9KKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB923410A1; Fri, 24 Sep 2021 16:02:33 -0300 (-03)
Date:   Fri, 24 Sep 2021 16:02:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YU4gyQg1ntTeTL98@kernel.org>
References: <20210923161843.751834-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923161843.751834-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 23, 2021 at 09:18:43AM -0700, Ian Rogers escreveu:
> From: Numfor Mbiziwo-Tiapo <nums@google.com>
> 
> Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> these are forms of undefined behavior.
> 
> These problems were identified using the undefined behavior sanitizer
> (ubsan) with the tools version of the code and perf test. Part of this
> patch was previously posted here:
> https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

Masami, if you're ok, just process it including the tools/ bit.

- Arnaldo
 
> v4. Fixes a typo.
> 
> v3. Is a rebase picking up a fix for big endian architectures.
> 
> v2. removes the validate_next check and merges the 2 changes into one as
> requested by Masami Hiramatsu <mhiramat@kernel.org>
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/lib/insn.c       | 4 ++--
>  tools/arch/x86/lib/insn.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 058f19b20465..c565def611e2 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -37,10 +37,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
> -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
>  
>  #define get_next(t, insn)	\
>  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index c41f95815480..797699462cd8 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -37,10 +37,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
> -	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
> +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
>  
>  #define get_next(t, insn)	\
>  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> -- 
> 2.33.0.464.g1972c5931b-goog

-- 

- Arnaldo

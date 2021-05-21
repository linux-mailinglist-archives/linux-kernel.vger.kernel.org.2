Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AD638CE51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbhEUTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234945AbhEUTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4B76613D8;
        Fri, 21 May 2021 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621626114;
        bh=lY6l1bcM56C5xaC0VQOKMH+TYbNysU9jlkdLIYOFVI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thSNW2lx97g+dEKEClLf0Ot+k35yCE2AHSqpT4nG6i57X5n5Z06qm5XGfN6zPZ/gX
         NFnnawQTbubJwJpR8dlL0jB4hqaf7I5eqZauaW1O25u3tBs5dQcQ56ynrlMp1qyqb5
         BCHUF1VxwLs7fY4p/8ClpBEqrczHM61IxCkG7vyuUK3r+Cq5UAuphiseW92k7JLagh
         0ERW/BVnBRR9ZHkeFGH2XFLKJZerxYnnInHx6SwZT4BZj1+XFkfTsyXeh4uk0tua0p
         h3aQejZnIgYBzJyxxdnLLZA8eEHUvHU+LiWLFr7n3s4S2hgGgY6XE+fwMkWjA7/r/v
         DaLsODv4r1q2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AEAD4011C; Fri, 21 May 2021 16:41:51 -0300 (-03)
Date:   Fri, 21 May 2021 16:41:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Add missing PERF_IP_FLAG_CHARS for VM-Entry
 and VM-Exit
Message-ID: <YKgM/yVofI1Wy3SU@kernel.org>
References: <20210521175127.27264-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521175127.27264-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 21, 2021 at 08:51:27PM +0300, Adrian Hunter escreveu:
> Add 'g' (guest) for VM-Entry and 'h' (host) for VM-Exit.

Thanks, applied.

- Arnaldo

 
> Fixes: c025d46cd932c ("perf script: Add branch types for VM-Entry and VM-Exit")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 6 +++---
>  tools/perf/Documentation/perf-script.txt   | 7 ++++---
>  tools/perf/util/event.h                    | 2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index 8d6cce062a5f..e382dbd4ff0a 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -108,9 +108,9 @@ displayed as follows:
>  
>  	perf script --itrace=ibxwpe -F+flags
>  
> -The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
> -system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
> -in transaction, respectively.
> +The flags are "bcrosyiABExgh" which stand for branch, call, return, conditional,
> +system, asynchronous, interrupt, transaction abort, trace begin, trace end,
> +in transaction, VM-entry, and VM-exit respectively.
>  
>  perf script also supports higher level ways to dump instruction traces:
>  
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 5b8b61075039..48a5f5b26dd4 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -183,14 +183,15 @@ OPTIONS
>  	At this point usage is displayed, and perf-script exits.
>  
>  	The flags field is synthesized and may have a value when Instruction
> -	Trace decoding. The flags are "bcrosyiABEx" which stand for branch,
> +	Trace decoding. The flags are "bcrosyiABExgh" which stand for branch,
>  	call, return, conditional, system, asynchronous, interrupt,
> -	transaction abort, trace begin, trace end, and in transaction,
> +	transaction abort, trace begin, trace end, in transaction, VM-Entry, and VM-Exit
>  	respectively. Known combinations of flags are printed more nicely e.g.
>  	"call" for "bc", "return" for "br", "jcc" for "bo", "jmp" for "b",
>  	"int" for "bci", "iret" for "bri", "syscall" for "bcs", "sysret" for "brs",
>  	"async" for "by", "hw int" for "bcyi", "tx abrt" for "bA", "tr strt" for "bB",
> -	"tr end" for "bE". However the "x" flag will be display separately in those
> +	"tr end" for "bE", "vmentry" for "bcg", "vmexit" for "bch".
> +	However the "x" flag will be displayed separately in those
>  	cases e.g. "jcc     (x)" for a condition branch within a transaction.
>  
>  	The callindent field is synthesized and may have a value when
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 8a62fb39e365..19ad64f2bd83 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -100,7 +100,7 @@ enum {
>  	PERF_IP_FLAG_VMEXIT		= 1ULL << 12,
>  };
>  
> -#define PERF_IP_FLAG_CHARS "bcrosyiABEx"
> +#define PERF_IP_FLAG_CHARS "bcrosyiABExgh"
>  
>  #define PERF_BRANCH_MASK		(\
>  	PERF_IP_FLAG_BRANCH		|\
> -- 
> 2.17.1
> 

-- 

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9213310AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhCHOUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DB23650BA;
        Mon,  8 Mar 2021 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615213251;
        bh=WTkLm9uQeTnTJoFyHRxnIzZvsqC+/A3g8k9P2rX93co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WF4fRC4vR21XVtueCMnWQ2FwIFvLf9OKSjqwuQ/BSY9QavaYPiWmsyFHnf5oDjy2N
         cu0APjy2oWqKQpRZqBdoriEphcpRCOZx9hgWcZ85xCJqXvKrcVrBYfid2rGMx20nRy
         ecpJOm8yq1DJtCMOhkYuGVZGNP3AfpUzJCEwkU3ou6XvwZz1WyqTR8ubALP1K3cCK6
         kZP/UnHV5Psr9tgXn2r0JHM7h5xcrkGLRpGbyJTD23TsPLtC+0MHfgxBk0PLug8c8S
         5exCZFdRvDaya6X5Einj8ZjTI1MsJ13KaiGR126UZrR3wmcxEJrv4cywOhvuFpOCSA
         utL/pStUMDVaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F0A940647; Mon,  8 Mar 2021 11:20:48 -0300 (-03)
Date:   Mon, 8 Mar 2021 11:20:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: turn dso__fprintf_symbols_by_name into
 void function
Message-ID: <YEYywJBiPjN0YHie@kernel.org>
References: <1615193704-19876-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615193704-19876-1-git-send-email-yang.lee@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 08, 2021 at 04:55:04PM +0800, Yang Li escreveu:
> This function always return '0' and no callers use the return value.
> So make it a void function.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  tools/perf/util/dso.h            | 2 +-
>  tools/perf/util/symbol_fprintf.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index cd2fe64..d7ebf21 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -364,7 +364,7 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
>  
>  void dso__reset_find_symbol_cache(struct dso *dso);
>  
> -size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
> +void dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
>  size_t dso__fprintf(struct dso *dso, FILE *fp);
>  
>  static inline bool dso__is_vmlinux(struct dso *dso)
> diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
> index 35c936c..031584e 100644
> --- a/tools/perf/util/symbol_fprintf.c
> +++ b/tools/perf/util/symbol_fprintf.c
> @@ -59,10 +59,9 @@ size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp)
>  	return __symbol__fprintf_symname_offs(sym, NULL, false, false, fp);
>  }
>  
> -size_t dso__fprintf_symbols_by_name(struct dso *dso,
> +void dso__fprintf_symbols_by_name(struct dso *dso,
>  				    FILE *fp)
>  {
> -	size_t ret = 0;
>  	struct rb_node *nd;
>  	struct symbol_name_rb_node *pos;
>  
> @@ -70,6 +69,4 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
>  		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
>  		fprintf(fp, "%s\n", pos->sym.name);
>  	}
> -
> -	return ret;

The class__fprintf* functions follow the fprintf semantics, i.e. return
how many bytes were printed, so the fix should instead be the one below,
that I've commited to my tree, thanks for reporting!

- Arnaldo

commit 210e4c89ef61432040c6cd828fefa441f4887186
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Mar 8 11:17:51 2021 -0300

    perf symbols: Fix dso__fprintf_symbols_by_name() to return the number of printed chars
    
    The 'ret' variable was initialized to zero but then it was not updated
    from the fprintf() return, fix it.
    
    Reported-by: Yang Li <yang.lee@linux.alibaba.com>
    cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    cc: Ingo Molnar <mingo@redhat.com>
    cc: Jiri Olsa <jolsa@redhat.com>
    cc: Mark Rutland <mark.rutland@arm.com>
    cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    Fixes: 90f18e63fbd00513 ("perf symbols: List symbols in a dso in ascending name order")
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 35c936ce33efa6ea..2664fb65e47ada94 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -68,7 +68,7 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 
 	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
 		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
-		fprintf(fp, "%s\n", pos->sym.name);
+		ret += fprintf(fp, "%s\n", pos->sym.name);
 	}
 
 	return ret;

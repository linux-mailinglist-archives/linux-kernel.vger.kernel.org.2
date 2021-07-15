Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270173CAE02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhGOUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235972AbhGOUjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DFD5613D4;
        Thu, 15 Jul 2021 20:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381381;
        bh=qWFQ91w7Drwc+LMGTbz4n4hkc/PAiybe38t1z6unfr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0uqSirnK8Ds9cxHtJXyhq1iojKOvP0gan/9fqhocybfUeJgKGM00oztlxWRN+1TN
         lz8oCRz2Kb2E1CdSF1BTLLQCbcnPK2NOxBr0mN4oFRJz+FWolWagjpR58h+L+A/xrf
         7/alsDSrGvFMkG6H6CRLJzH0pldXK7uYsHbC809gfHc0TdHj07QXp8JKcql/xagUls
         LORWHmlMqXFqqH169ru5mHqt9lckp/JbeDwGNDJadaG/sf5tGxd2BkRHqPeZrRG/j9
         1wErQoeK9seR92hzctfhZVPw28eqodJeBeuvRK4xqcBFA/J1tHWpDHv88BRqx2hKsa
         OgxWQghuw8BNg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C302403F2; Thu, 15 Jul 2021 17:36:19 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:36:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 18/20] perf trace: free strings in
 trace__parse_events_option
Message-ID: <YPCcQ5qrryTLoNaS@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <34d08535b11124106b859790549991abff5a7de8.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d08535b11124106b859790549991abff5a7de8.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:23PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks running the perf test
> "88: Check open filename arg using perf trace + vfs_getname".
> The fourth of these leaks is related to some strings never being freed
> in trace__parse_events_option.
> 
> This patch adds the missing frees.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d9c65d55a9ae7526..4a677f3ff273887a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4659,6 +4659,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
>  		err = parse_events_option(&o, lists[0], 0);
>  	}
>  out:
> +	free(strace_groups_dir);
> +	free(lists[0]);
> +	free(lists[1]);
>  	if (sep)
>  		*sep = ',';
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo

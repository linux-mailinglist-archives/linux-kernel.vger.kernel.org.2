Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B633D494
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhCPNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCPNHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:07:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 113706505E;
        Tue, 16 Mar 2021 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615900059;
        bh=InzVTDbkRPUamCbCr2DtBClQ+kQDWvoD4IiHp+kvbps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V41AezsBa/v3tkujow7wtm9Tht4tlv4VTP3+JUQr+YpnO/NiSN1Hi+gV5NcurjHcF
         LAIYFipFTuuZiaf+AArZiuEjQ3OEvxC+0HgoPtOteFCoe7odDzJWmMwe9s1YkWD/xp
         MpKSpqEqpr+BCNY1oWAwTQfRk9k6fXWoPdX2TbJ8G6NBHo3SXlEzZKsA2arI1ky8aM
         Dsshm0zhSPkGHvshSOsLkFxa1EDxuAYgOq4dWftZeP+yOqFOKXNsg1pxWQ6Z214I0B
         TByOdtEpiqPf6XDZSzEKWAhQZkdMo4w+c10op5CjB5MiIpRTxbVGguAZ3QyIKQChmy
         VKezkYJjhrkZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D19BC40647; Tue, 16 Mar 2021 10:07:36 -0300 (-03)
Date:   Tue, 16 Mar 2021 10:07:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        gustavoars@kernel.org, mliska@suse.cz,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com
Subject: Re: [PATCH v5] perf annotate: Fix sample events lost in stdio mode
Message-ID: <YFCtmEBqsgKnkaV7@kernel.org>
References: <20210316021759.257503-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316021759.257503-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 16, 2021 at 10:17:59AM +0800, Yang Jihong escreveu:
> In hist__find_annotations function, since different hist_entry may point to same
> symbol, we free notes->src to signal already processed this symbol in stdio mode;
> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
> 
> However, there is a problem, for example, run the following command:
> 
>  # perf record -e branch-misses -e branch-instructions -a sleep 1
> 
> perf.data file contains different types of sample event.
> 
> If the same IP sample event exists in branch-misses and branch-instructions,
> this event uses the same symbol. When annotate branch-misses events, notes->src
> corresponding to this event is set to null, as a result, when annotate
> branch-instructions events, this event is skipped and no annotate is output.
> 
> Solution of this patch is to remove zfree in hists__find_annotations and
> change sort order to "dso,symbol" to avoid duplicate output when different
> processes correspond to the same symbol.

You forgot to add your Signed-off-by tag, i.e.:

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Please take a look at Documentation/process/submitting-patches.rst.

Regards,

- Arnaldo

> ---
>  tools/perf/builtin-annotate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..92c55f292c11 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>  		} else {
>  			hist_entry__tty_annotate(he, evsel, ann);
>  			nd = rb_next(nd);
> -			/*
> -			 * Since we have a hist_entry per IP for the same
> -			 * symbol, free he->ms.sym->src to signal we already
> -			 * processed this symbol.
> -			 */
> -			zfree(&notes->src->cycles_hist);
> -			zfree(&notes->src);
>  		}
>  	}
>  }
> @@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)
>  
>  	setup_browser(true);
>  
> +	/*
> +	 * Events of different processes may correspond to the same
> +	 * symbol, we do not care about the processes in annotate,
> +	 * set sort order to avoid repeated output.
> +	 */
> +	sort_order = "dso,symbol";
>  	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
>  		sort__mode = SORT_MODE__BRANCH;
>  		if (setup_sorting(annotate.session->evlist) < 0)
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo

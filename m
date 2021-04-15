Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598653609A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhDOMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhDOMnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:43:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B88610E8;
        Thu, 15 Apr 2021 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618490567;
        bh=3M573xfs0hNXfcCF4OhMwhysBCpFoK9x2zhcPMH6MCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhibKjm+E0PTHJnnjSg49QkkkTHu4PodN1IM//rzWAFkVF16V4LsZudMr8F9m73Fr
         K8PKDiOYBfmp6aXurI7V5oe4Y/kaosCZswDnj51KwjKtJpG/OYTnglASt/irGE177S
         khD1g/6sm4uPAHnDcj4GTFw4BeZ8scOkVw/J97ECOuTI6SzEJ+eHE3/w8U1kcuUYJ5
         EpkUlsGpkGFK5I2EYSBQzJfKtNQKAQMlSnLd5s38LuINBESudy3S57jfCKPeJrjtsp
         z6tjrHrB4VJTmHRrnz6M84Umsp1rtRCBL/40w3KJDBrk6rGYHXLzL4DoBFA9lPIhBO
         NBMjfLckfNINw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 138E040647; Thu, 15 Apr 2021 09:42:44 -0300 (-03)
Date:   Thu, 15 Apr 2021 09:42:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf map: Fix error return code in maps__clone()
Message-ID: <YHg0wyanA+UxqXWi@kernel.org>
References: <20210415092744.3793-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415092744.3793-1-thunder.leizhen@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 15, 2021 at 05:27:44PM +0800, Zhen Lei escreveu:
> Although 'err' has been initialized to -ENOMEM, but it will be reassigned
> by the "err = unwind__prepare_access(...)" statement in the for loop. So
> that, the value of 'err' is unknown when map__clone() failed.

You forgot to research and add this:

Fixes: 6c502584438bda63 ("perf unwind: Call unwind__prepare_access for forked thread")

So that the stable@kernel.org guys can pick this up automagically and
apply this fix to the stable kernels.

I've added it.

Thanks, applied.

- Arnaldo
 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  tools/perf/util/map.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index fbc40a2c17d4dca..8af693d9678cefe 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -840,15 +840,18 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  int maps__clone(struct thread *thread, struct maps *parent)
>  {
>  	struct maps *maps = thread->maps;
> -	int err = -ENOMEM;
> +	int err;
>  	struct map *map;
>  
>  	down_read(&parent->lock);
>  
>  	maps__for_each_entry(parent, map) {
>  		struct map *new = map__clone(map);
> -		if (new == NULL)
> +
> +		if (new == NULL) {
> +			err = -ENOMEM;
>  			goto out_unlock;
> +		}
>  
>  		err = unwind__prepare_access(maps, new, NULL);
>  		if (err)
> -- 
> 2.26.0.106.g9fadedd
> 
> 

-- 

- Arnaldo

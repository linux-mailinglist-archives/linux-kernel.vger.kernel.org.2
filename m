Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C936085F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhDOLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhDOLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618486636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwPqtcgmrKCFLbG+4l49abPvq6SvAM83sbdeBFnVipU=;
        b=hfWNYqKfKPgESc3rDTm1o4+RQvpGByMVp8oWKfgxcJsu2SFGRhWx3fCp2Tm/ho80tOF2E2
        c0aQ0XHsTgInF4KWf1NyynZTfVn9RGIilY+X9N7NXorpehpzuvgX/7DT851rbCb/E+Q3hD
        iDqBAFA+Vqj0tgULyzT6Jahfwu5p3U0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-7ghcpfrLPUy5UsyEsppFSQ-1; Thu, 15 Apr 2021 07:37:14 -0400
X-MC-Unique: 7ghcpfrLPUy5UsyEsppFSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1CB86D241;
        Thu, 15 Apr 2021 11:37:12 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id DADAA610A8;
        Thu, 15 Apr 2021 11:37:10 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:37:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf map: Fix error return code in maps__clone()
Message-ID: <YHglZSAF/iUGloPY@krava>
References: <20210415092744.3793-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415092744.3793-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 05:27:44PM +0800, Zhen Lei wrote:
> Although 'err' has been initialized to -ENOMEM, but it will be reassigned
> by the "err = unwind__prepare_access(...)" statement in the for loop. So
> that, the value of 'err' is unknown when map__clone() failed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

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


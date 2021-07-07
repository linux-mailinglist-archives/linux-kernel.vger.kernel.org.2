Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6463E3BEDC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhGGSQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhGGSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rJ11vEGolL0CsQ0bW2KSCPOtjG7fcFPdao2YCIE2kg=;
        b=Ey16xfuJzv7kB1kPPILb6iQ6zP1bzpoArE+HK6I3LM0pms32p6xETXL0Monv5l1DLJ3wZ0
        nWjbtf2rRxxRWKUuxWghmDrYTr9bpRPjIgszwCUYSNOxHlPc3NzUDHJbidi2eEahy2LkaJ
        w01VZWeqbPNF55+1QXSwY3Dfc2Xd5pI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-lilC36VUOqmBBHysKcoVrA-1; Wed, 07 Jul 2021 14:14:09 -0400
X-MC-Unique: lilC36VUOqmBBHysKcoVrA-1
Received: by mail-wr1-f69.google.com with SMTP id u13-20020a5d6dad0000b029012e76845945so1057680wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rJ11vEGolL0CsQ0bW2KSCPOtjG7fcFPdao2YCIE2kg=;
        b=n/tElNRUjMcisLi5Xr128Dcw8rXP/zom9jj1XpSi/hfcSPL7J/+JeTuiRqdWNS6w4N
         keLRtAjnN9OCpz4zFFV6Zv2821gD7yVYiJ03cyfWgNh0wkJYurEAUM6MEpVtRVG5aCfP
         pRLxXXRKyLvrUDH6Owg+kY/Jcogw3tA1vSSGKGkFZ7d4YsDDEqk2YqKmllobOH89zFVk
         ay6D92no11hjU3Au2DP8HoduxBjF4HQ3uHLwFkUh0dScOL8K/GCH1zgavhCX9Tsf0z4Q
         +Zj1oRGMJjw7+36pM6pq0MWA1MJ3aQiR+wZfmt1XkgrkvMnrPaT7TTkgfvgrX/BAfhL2
         E9aA==
X-Gm-Message-State: AOAM530sPOG5mBCWiIABAoHnjfM8ODQYkSBGONDhS6iGu1xNwBIQUDHi
        sRc0WCtzaWGfStsL8EuQ2T3m38iSCX+25wPkTUdfNhXEsOf+zsaeiF3dJRa0WcM4exonOmrVPez
        JB95KAzmr/VftMS15f0/IDNju
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr26491528wrt.251.1625681648411;
        Wed, 07 Jul 2021 11:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpk+uUcfOJdRYj06sTwADzln4PNWPCzs2W9QGRHenPJa1Gwn70Dlib1jqaBcWcgPKSPZy2kw==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr26491488wrt.251.1625681648168;
        Wed, 07 Jul 2021 11:14:08 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id p9sm20681891wrx.59.2021.07.07.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:14:07 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:14:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/7] libperf: Move leader to perf_evsel::leader
Message-ID: <YOXu7PPoaJ0cpeQI@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-4-jolsa@kernel.org>
 <YOW/5+Ep7JpL4qLL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW/5+Ep7JpL4qLL@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 11:53:27AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:17:00PM +0200, Jiri Olsa escreveu:
> > Moving evsel::leader to perf_evsel::leader, so we can move
> > the group interface to libperf.
> 
> I also had to apply this, because you didn't build with
> BUILD_BPF_SKEL=1, right?

ah right.. I also plan to build in arm/s390/ppc,
so I'll take what you have in tmp.perf/core

thanks,
jirka

> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 1d0b9742f7271966..8150e03367bbafad 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -353,7 +353,7 @@ static int bperf_check_target(struct evsel *evsel,
>  			      enum bperf_filter_type *filter_type,
>  			      __u32 *filter_entry_cnt)
>  {
> -	if (evsel->leader->core.nr_members > 1) {
> +	if (evsel->core.leader->nr_members > 1) {
>  		pr_err("bpf managed perf events do not yet support groups.\n");
>  		return -1;
>  	}
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19993BEE8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGGSWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232508AbhGGSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUZtc6YTxu6uc+g3cz8GTAgNxWs+3+Q4JhAXHke+bh8=;
        b=Guolkxw488Zcd1FEwwsshAQafqxU2Jj9uYDP+7ezHV5TUWfbH2ovngNTjoJR4JIV18VjRa
        KBZHQObnAdOwSitgzEVYnGNUtplf4ZHKOQpJUMtFmwiWbZJZ4xFeU08kT8z4+yo7urz01y
        V01YDPmEyn7n1kftH/s06qskXf7V6wA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-lfcGfRC3PS2aNhBRaVKBBw-1; Wed, 07 Jul 2021 14:18:43 -0400
X-MC-Unique: lfcGfRC3PS2aNhBRaVKBBw-1
Received: by mail-wm1-f72.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so1306219wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUZtc6YTxu6uc+g3cz8GTAgNxWs+3+Q4JhAXHke+bh8=;
        b=EIwAwfOSiu7VoQk2tCqOXAhPTQLyQ9ZIWoDAmckCyeqW8XAERaYS6Mtg7UwG/4iFgq
         zymqfBz9H9sIcnra2ooNwsfRTK+AFRRNykWjtSlsYK4ImvVx8SO6qJPVPhH+1r/mXjkL
         FPTfooXi0YhOEw2wJBCB6GSz366KyLkVUtBIAA9KMGMZ/xharAveus+WveJeVdE/yTAZ
         NGSIeF1lbKXIMV0Gqhwf03TPcjhRJ6lQcI+63ru58bJqF0bH0sxWrpviO3fILOHhvOnN
         l5rw5Mae9RKea9yw9R8cFkbXpI05Bfh3VKIm9qKRNgXfQV5tnuQpSbAU69tvUL0pa7Me
         FryQ==
X-Gm-Message-State: AOAM531VSWjXt9qoBnDlmRw53OIRtyVVk5ggQebUFDm2Y+58y8emVUTt
        wRYG8jDUlmvUjwwY+3cc4nPlncmMArfZf3Yhlr1rA26iKWXGoF3uaR0zuyWyIDy8MDrZf284sKV
        HxWbNUFc8IO621reRlkFaHKHS
X-Received: by 2002:adf:eb82:: with SMTP id t2mr29306322wrn.337.1625681922601;
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxChd/l3ejyQib0minlOQI1nNvHZOrogkwK3oGggmkVVpeCgVcl9kJF3ZUdjP7i1a2esUVi8Q==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr29306316wrn.337.1625681922493;
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id u2sm14420778wmc.42.2021.07.07.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:18:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOXv+wlbqv4yQ9qH@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
 <YOW+3yhgNgMOrE99@kernel.org>
 <YOXo1F8BlX07JfHC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXo1F8BlX07JfHC@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 02:48:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 07, 2021 at 11:49:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> > > Moving evsel::idx to perf_evsel::idx, so we can move
> > > the group interface to libperf.
> 
> You forgot these:
> 
> $ find tools/perf/ -name "*.[ch]" | xargs grep 'evsel->idx'
> tools/perf/ui/gtk/annotate.c:							     evsel->idx + i);
> tools/perf/ui/gtk/annotate.c:						    evsel->idx);
> $

aaah we still have that :-) thanks

as I wrote earlier, I'll take what you have in tmp.perf/core and go from
there with your changes

thanks,
jirka

> 
> That running 'make -C tools/perf build-test' caught, so I'm adding this
> to this patch as well:
> 
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index a7dff77f20184f1f..c266ed4fa015842d 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -135,12 +135,12 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
>  				ret += perf_gtk__get_percent(s + ret,
>  							     sizeof(s) - ret,
>  							     sym, pos,
> -							     evsel->idx + i);
> +							     evesl->core.idx + i);
>  				ret += scnprintf(s + ret, sizeof(s) - ret, " ");
>  			}
>  		} else {
>  			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos,
> -						    evsel->idx);
> +						    evesl->core.idx);
>  		}
>  
>  		if (ret)
> 


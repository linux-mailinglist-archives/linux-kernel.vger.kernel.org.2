Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1344F924
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhKNQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbhKNQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636908343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoFiN2BeuuneYmBzR1Avi/ftAkvwS1Pn1GsZePUSVR8=;
        b=PrNaGnoTXomA7LMdZ2inzewCsVTjcL1PYfJJF5tEhNH05qdownvzclRMUqDBMD3vG1lmiU
        wazR0BnEM0oOfVvxuCvyveVHGbsgdogG6rd1LTgREV52Nd+PFBK7BgDmrqVFjJpz1bsBFt
        7kLtjiGgq97/DGLFSKE7QiYSdR+lrdE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-HGSEMVvbOoOvju26taJdxw-1; Sun, 14 Nov 2021 11:45:42 -0500
X-MC-Unique: HGSEMVvbOoOvju26taJdxw-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso9175507qkp.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QoFiN2BeuuneYmBzR1Avi/ftAkvwS1Pn1GsZePUSVR8=;
        b=T4zN5yJ64FxfuOvGkR4bS+p3MfcpMu9gHbKBff0/ei/XIAvAPP6AXL2EIIv7U+dmR7
         naGx7id31QEVjHVRQJkBwDKxkQoOWxJWetYNS/DOZZIGnqteEs17d4RdA4vfgzIcYiLp
         kDtB+zMEdrmIcWBRVD/mMDx9ySVO2le+GDD/vbHVk0M1s19UXsgm44cH4ahJmskol/nA
         i+3dh/++3rjYpIIp3iHw2mRNQoqLnRwc6TFKuOzN+fWvn3oeBb5MwWXyYHuAAQ3pcvdT
         u9P+OlZePRNOB6mccLTUTuzaN2HDheN+JWhh+GYgZwwJzz8BpcIk1KIkx/jZWimzc9zN
         JcXQ==
X-Gm-Message-State: AOAM533hymibzwHw1UesDzZn1jWkNDTsqNGEfae2ViWgGRV3a451gs0W
        KetJqw35+IFcLBaP+rUrTF6cEN7PqVbW+0iCaQcJlZSCU/glKRvAJzefT9hINFMyiEZLGg7NwzW
        /GXEWKkXNMpdK2MQixh0kEQEH
X-Received: by 2002:a05:620a:1226:: with SMTP id v6mr25339490qkj.240.1636908341407;
        Sun, 14 Nov 2021 08:45:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTryy8Pyh13onNw+q4N8CRdW/BIdUIn4ZiRaanr7SxiBqH2XcgsEPVTMavQy6d+9KAS6D8sg==
X-Received: by 2002:a05:620a:1226:: with SMTP id v6mr25339476qkj.240.1636908341234;
        Sun, 14 Nov 2021 08:45:41 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r20sm1832287qkp.21.2021.11.14.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:45:40 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:45:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Oleg Latin <oleglatin@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, nfraser@codeweavers.com,
        peterz@infradead.org, dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH] perf: add missing cpu entry in json output
Message-ID: <YZE9MT6b2QmYedMm@krava>
References: <20211112115738.175001-1-oleglatin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112115738.175001-1-oleglatin@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 02:57:38PM +0300, Oleg Latin wrote:
> After converting perf.data with 'perf covert data --to-json' the
> resulting json file missing cpu entries:
> 
> 	{
> 	    "timestamp": 5716840788599,
> 	    "pid": 79661,
> 	    "tid": 79661,
> 	    "comm": "python3",
> 	    "callchain": [
> 		{
> 		    "ip": "0xffffffffafd05fc0"
> 		}
> 	    ]
> 	},
> 
> Seems addr_location::thread::cpu is never assigned during
> machine__resolve() call. This patch uses addr_location::cpu to store it
> in json file.
> 
> Signed-off-by: Oleg Latin <oleglatin@yandex-team.ru>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/data-convert-json.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index f1ab6edba446..b0e3d69c6835 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -168,8 +168,8 @@ static int process_sample_event(struct perf_tool *tool,
>  	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
>  	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
>  
> -	if (al.thread->cpu >= 0)
> -		output_json_key_format(out, true, 3, "cpu", "%i", al.thread->cpu);
> +	if (al.cpu >= 0)
> +		output_json_key_format(out, true, 3, "cpu", "%i", al.cpu);
>  
>  	output_json_key_string(out, true, 3, "comm", thread__comm_str(al.thread));
>  
> -- 
> 2.25.1
> 


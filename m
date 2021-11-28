Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519634607C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358548AbhK1RFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358617AbhK1RDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638118813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv3mUN/Ti1jWQO+IHXGJK90zoQnHriwLvawJYNBsi0M=;
        b=QNfHzDMeG/nofNCRfDIY9l6p/YfetgEIiLoIDO60rFhXeTUA3SQ07o1eMPzBlcQVtWJsNu
        0wqT/solC81jRGCMbUqp4Rty64GCawr62xOKrjBZ5QRv2GIH5kw28DLOED1gKxRoCHkirT
        6bLqQbAuCxCovdHFBJTamVF8bSSNHnI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-3mQ3sPNJMt6_155FhDEZyA-1; Sun, 28 Nov 2021 12:00:12 -0500
X-MC-Unique: 3mQ3sPNJMt6_155FhDEZyA-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso9072083wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hv3mUN/Ti1jWQO+IHXGJK90zoQnHriwLvawJYNBsi0M=;
        b=skMwGju2QtYErw9FJg6wSW6SlpqEEkU28v7KoGZ6Qj66i6OeLdXD69ll34nPRsugfS
         hTq8ksHy/kNw5C2+EyZgKWSuXLDVHoz+R4RQmtjzQ81WYl9D/nrXDDBymnDzFnrehz2U
         FBOLkNBl4Rfl4nRzesTh41etTc4UIeVc52Mg+TDXcsFxArp1k5kveEuLz8IfylzZNL3c
         4CrpX+xBXrm7ZMxmk6x9qKslz1/DnaXYy3LN+OXzJ3AWXGfBlOWrT+aGXJztyXToq4o5
         10GmVgJFBkxA6a46Qj3FzydgXj9DrdzmGmC0J8kUHuZye1HlOBjzgkiY9McZfIr4hGSf
         UX6A==
X-Gm-Message-State: AOAM532IdwGCk3ksE1ocQz9vSLJW4F9lUgVrMJOKaZUOUE0hXXaZqWxJ
        fu09AJIKIkPhDKuZJp2uXOotntUqcBI4PQS3ORsok0QzMtsR4Xg81vF7o45Fpd72Km9PuT+GLq7
        6qFGBqrw4BhHkFWk81qQHPTIm
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr27762991wrp.79.1638118810644;
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhNeic8ASk3JN4l+USlK6zRcaKtMEX2TtZEIKpe/ZHIMchluzOnJC7qMWZIxiEBPDrZ3fbaA==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr27762967wrp.79.1638118810466;
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u23sm12141760wru.21.2021.11.28.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:00:10 -0800 (PST)
Date:   Sun, 28 Nov 2021 18:00:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     cgel.zte@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] perf tools: remove unneeded variable
Message-ID: <YaO1mETPEL+QLPak@krava>
References: <20211122014159.25317-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122014159.25317-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 01:41:59AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./tools/perf/util/evlist.c:1303:5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/evlist.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 5f92319ce258..d64fe767f583 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1300,7 +1300,6 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  {
>  	struct perf_cpu_map *cpus;
>  	struct perf_thread_map *threads;
> -	int err = -ENOMEM;
>  
>  	/*
>  	 * Try reading /sys/devices/system/cpu/online to get
> @@ -1325,7 +1324,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  out_put:
>  	perf_cpu_map__put(cpus);
>  out:
> -	return err;
> +	return -ENOMEM;
>  }
>  
>  int evlist__open(struct evlist *evlist)
> -- 
> 2.25.1
> 


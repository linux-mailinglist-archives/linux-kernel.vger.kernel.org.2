Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6D4145BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhIVKHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234496AbhIVKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632305143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMP5wJz1SHIDgcm5MxB8VYl8yfFUZTjIQI233ATUQYQ=;
        b=NbNJjnGW6o65EXx+n7AqIR/m1kAWgh88qVaNCzHltrFXi3r43RC0N9JALg7oZP/SftJj5K
        JsD3nToCxZX8BX4Bp765ojjSt5rZS0ir9k2CYIGgAUsd67s/api+UgQW7URSSc52c0uhvw
        SUNyejpUctvtN9B13BUKgTCmnHYo7D0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-Bu4Z_RLSNISO5Fa6sGkZ3g-1; Wed, 22 Sep 2021 06:05:41 -0400
X-MC-Unique: Bu4Z_RLSNISO5Fa6sGkZ3g-1
Received: by mail-ed1-f72.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so2434787edv.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pMP5wJz1SHIDgcm5MxB8VYl8yfFUZTjIQI233ATUQYQ=;
        b=5GxhHBgM1Ui4/Ik+rQrTIz2q0tOqgo+aRwyaHHCEA9Z32eRW1xLqw2RoZ09y7EJb/t
         9WWuyFC/YbX5YZCkwE4OlCG1y8J6w6w7SJNPRaQpDtV3FJgZOjbNgy3LXFR6pIB5yBI5
         0q52H/gHImm3QjjcQEnOOxOyvvhV0WjD3bWwG5YKBk32mbvqD0yLRimXCsilB+WKpnRg
         mYI10DTKM00qC4r2J9a8ebG7m7eQqXTKEpm6hXRpDyEaUPS6TmCyg2YbbMJdRdUlHP5m
         qXTd6wEapSJVGzmKkwGk19tabc3/c5X/SPuSGnXj25HF29xSjQtH9WljgTmxIH/RSnWo
         jGRQ==
X-Gm-Message-State: AOAM532RcwLnqeQ4VzZWTNIIRDk2sSOoEMKbC9twiNDtlmiiRoK/ljRr
        /RvUhvMuwn4m15nU2uM98AOazhISUy3Ot3bYy9/peSNK5VhbD4zIxVzgsWnfmc5+G+cSgFUt76Y
        hMX1d0y/SyxCc3yKLHKxAu69+XINtslmFQ+pdzxeXv3rs4xnti2VxzOO304oujvBVD+7jft5SQb
        U=
X-Received: by 2002:a05:6402:21d6:: with SMTP id bi22mr10593425edb.40.1632305140640;
        Wed, 22 Sep 2021 03:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTvre8uD4ncscLueG/Kzl9lr/C1AT7Vj4qlFIMsLWoCN/WKl+ftIKLe9FSDBFUqumJfDB9tQ==
X-Received: by 2002:a05:6402:21d6:: with SMTP id bi22mr10593406edb.40.1632305140407;
        Wed, 22 Sep 2021 03:05:40 -0700 (PDT)
Received: from x1.bristot.me (host-87-1-201-231.retail.telecomitalia.it. [87.1.201.231])
        by smtp.gmail.com with ESMTPSA id fx4sm820295ejb.113.2021.09.22.03.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:05:40 -0700 (PDT)
Subject: Re: [PATCH v2] tracing: fix missing osnoise tracer on max_latency
To:     Jackie Liu <liu.yun@linux.dev>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20210922025122.3268022-1-liu.yun@linux.dev>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <1bd5f7fe-5f55-5bcf-7fa5-a52c62127994@redhat.com>
Date:   Wed, 22 Sep 2021 12:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922025122.3268022-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 4:51 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> The compiler warns when the data are actually unused:
> 
>   kernel/trace/trace.c:1712:13: error: ‘trace_create_maxlat_file’ defined but not used [-Werror=unused-function]
>    1712 | static void trace_create_maxlat_file(struct trace_array *tr,
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> [Why]
> CONFIG_HWLAT_TRACER=n, CONFIG_TRACER_MAX_TRACE=n, CONFIG_OSNOISE_TRACER=y
> gcc report warns.
> 
> [How]
> Now trace_create_maxlat_file will only take effect when
> CONFIG_HWLAT_TRACER=y or CONFIG_TRACER_MAX_TRACE=y. In fact, after
> adding osnoise trace, it also needs to take effect.
> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  kernel/trace/trace.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..bc677cd64224 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1744,16 +1744,15 @@ void latency_fsnotify(struct trace_array *tr)
>  	irq_work_queue(&tr->fsnotify_irqwork);
>  }
>  
> -/*
> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> - *  defined(CONFIG_FSNOTIFY)
> - */
> -#else
> +#elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
> +	|| defined(CONFIG_OSNOISE_TRACER)
>  
>  #define trace_create_maxlat_file(tr, d_tracer)				\
>  	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
>  			  &tr->max_latency, &tracing_max_lat_fops)
>  
> +#else
> +#define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
>  #endif
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> @@ -9473,9 +9472,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  
>  	create_trace_options_dir(tr);
>  
> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>  	trace_create_maxlat_file(tr, d_tracer);
> -#endif
>  
>  	if (ftrace_create_function_files(tr, d_tracer))
>  		MEM_FAIL(1, "Could not allocate function filter files");
> 


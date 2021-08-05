Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990793E0E48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhHEGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236647AbhHEGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628144685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ppu8LAVKBJzzCpRrnKNJ3LVN/Bsl61rA1bx5qS1zVOA=;
        b=Tw2M1rrN6GV7IYdY7kmkHLhy++tHxCe9kn6reR9JSyw0kTAmXJ/vSd1NhDl++srY+dwN7J
        vYaWuKEX9p4zVr3zTUB2vm70gOlLQ8xN1u9R2MzZ5vzpBQjFQKeQDaCbw51aVLkSo0Tv8T
        J0pQ79JvvS6ysqYWCuBHq97o7GuIHSI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-wuaJ3jcBPq6eDR6GoCEoqg-1; Thu, 05 Aug 2021 02:24:43 -0400
X-MC-Unique: wuaJ3jcBPq6eDR6GoCEoqg-1
Received: by mail-ej1-f70.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso1651846ejb.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 23:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ppu8LAVKBJzzCpRrnKNJ3LVN/Bsl61rA1bx5qS1zVOA=;
        b=pkucqPMLPedcdCcDkEH6uvPbO4Ui5p7gFvrio0k6ZVUi4w6YqFb+zvj06IqjfFTpIx
         Osb7vu/wgPN40uB9YaiTmKQnaD/jBkiy+Kez1OmzRwHsdh/JGtFo3yxYyrbcFHAA92/a
         MOmzKiAQynnB/hWGXndNWkzsalqkvrA7MvR7LqWuLcS7axEGEP3YpsAWnTSOwxwoPUN9
         VncI98gWIVHEUxE1EkDcn8FN70hhJyYUWHH5HPpqZ7VRb9/x105B5dWesHiq/ko2H0iW
         HVNis1ljXsTQLZFM9lfNnBIEd8D5dcwqBqguALrm7SrEvIlFpE1LgW6JvkI7PLUL1QrC
         BVFQ==
X-Gm-Message-State: AOAM531OH1tnaq24HviYSEriUzp91bsECUjXg/qvj6izZJhzhwvFYvIc
        /Cj7GX7yqjJ4HCSi6YvYR1JAqePqh558gzo7w6K8iXPGAEaBr5ItO7O5Q+f4GJKBQftWcDQm1g5
        0c8CZZOvNXlSRvphfxxv/Izru
X-Received: by 2002:aa7:df96:: with SMTP id b22mr4394928edy.324.1628144682104;
        Wed, 04 Aug 2021 23:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbQBxJ6qimbYBNLOWXB4yr/dhfZSSueV6Y0AuvgR4hjp+mp6MpuDFFlAc6pTW8+gxSKaXyZg==
X-Received: by 2002:aa7:df96:: with SMTP id b22mr4394912edy.324.1628144681908;
        Wed, 04 Aug 2021 23:24:41 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id h10sm1784404edb.74.2021.08.04.23.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 23:24:41 -0700 (PDT)
Subject: Re: [PATCH] tracing: Quiet smp_processor_id() use in preemptable
 warning in hwlat
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210804141848.79edadc0@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <072faff2-41d9-11e7-3f85-8ab9dc4b31bc@redhat.com>
Date:   Thu, 5 Aug 2021 08:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804141848.79edadc0@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 8:18 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The hardware latency detector (hwlat) has a mode that it runs one thread
> across CPUs. The logic to move from the currently running CPU to the next
> one in the list does a smp_processor_id() to find where it currently is.
> Unfortunately, it's done with preemption enabled, and this triggers a
> warning for using smp_processor_id() in a preempt enabled section.
> 
> As it is only using smp_processor_id() to get information on where it
> currently is in order to simply move it to the next CPU, it doesn't really
> care if it got moved in the mean time. It will simply balance out later if
> such a case arises.
> 
> Switch smp_processor_id() to raw_smp_processor_id() to quiet that warning.
> 
> Fixes: 8fa826b7344d ("trace/hwlat: Implement the mode config option")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

> ---
>  kernel/trace/trace_hwlat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index a6c0cdaf4b87..14f46aae1981 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -327,7 +327,7 @@ static void move_to_next_cpu(void)
>  
>  	get_online_cpus();
>  	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
> -	next_cpu = cpumask_next(smp_processor_id(), current_mask);
> +	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
>  	put_online_cpus();
>  
>  	if (next_cpu >= nr_cpu_ids)
> 


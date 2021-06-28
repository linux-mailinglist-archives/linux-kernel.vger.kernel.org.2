Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B183B66B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhF1Q2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhF1Q2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624897552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szPPpM0IRYZHyybzvSsKA6U9RSjoM8tbLnN20d8AF80=;
        b=TRC2MkmsbAtKYxoYacDBtMtWkaB9u4it1kNzpfVLT2Avk+4KFQ4vxaOuFZLZtLV2CrwClH
        tA/3SIdChLRuEF9UH+B5kVs4spx4eR8t/aaoSsBGmqShp08MMoK7g56LXQJVpNrTHcQ0hv
        Mfg9snIjNOB241d6HVcqd/ScEt6p18Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-xEM_1Cd5PaWNOuV-AmvgTA-1; Mon, 28 Jun 2021 12:25:49 -0400
X-MC-Unique: xEM_1Cd5PaWNOuV-AmvgTA-1
Received: by mail-ej1-f69.google.com with SMTP id d21-20020a1709063455b02904c609ed19f1so434755ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szPPpM0IRYZHyybzvSsKA6U9RSjoM8tbLnN20d8AF80=;
        b=pXf4KahGVxQiNpKFfdEC/3iokzd0G7eeY3TMV+pK2eE0PpNhd9sCYNDhkAH8mTJZSW
         9m6STdt/DwC4WvqmTzj1viqIn6GpjTxlcsWf7unLnmNOylmQ9KCICSoyyQ8lFOEOgSd6
         Q8RhgHct8RarB0M9kCMQsYefsSr2bkynLFNdewM/LjPHi62xzyfotO42ARN98ewdTLgs
         /ihiawrRc3lGQq8mf/koyNJuA8xjHLhn/wKPSnosD7k0LGiM6Rv8vUbGLDFL5I1DarwH
         pOoBYDGZblOJgvE+zsQyltwukhJZp53Z6ECJ/QWT7iRKx8cPPvUN7Lf+wx/YMWYBdNvD
         rJmA==
X-Gm-Message-State: AOAM531h2yEM3X1sFSMKocG0uApu/Ttq6gCWc2k7e+SHFqUe132Lgv/I
        Xsa0c/3N507/Ckp3Gn4n9xGi85iXrURPLb/0lCf3Xds5l7X7ulMlM1ix0hLxgvboU5CI35EfjZ0
        FTzFCOldaHJPCsnKMxV9tq7Q3
X-Received: by 2002:a17:906:2dd3:: with SMTP id h19mr25530452eji.272.1624897548264;
        Mon, 28 Jun 2021 09:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKhbsQ2EI1Aix+tMKNCVbsQuPTNgF7wCDp8UH4rzHUEXHyi1EiLhyvE9BTxAy23gLWwr+Q/Q==
X-Received: by 2002:a17:906:2dd3:: with SMTP id h19mr25530440eji.272.1624897548104;
        Mon, 28 Jun 2021 09:25:48 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id n2sm9701405edi.32.2021.06.28.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 09:25:47 -0700 (PDT)
Subject: Re: [PATCH] tracing: Have osnoise_main() add a quiescent state for
 task rcu
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210628114953.6dc06a91@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <8f16ef64-b06e-b3bf-4b6f-8fc4a15b2801@redhat.com>
Date:   Mon, 28 Jun 2021 18:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628114953.6dc06a91@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 5:49 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> ftracetest triggered:
> 
>  INFO: rcu_tasks detected stalls on tasks:
>  00000000b92b832d: .. nvcsw: 1/1 holdout: 1 idle_cpu: -1/7
>  task:osnoise/7       state:R  running task     stack:    0 pid: 2133 ppid:     2 flags:0x00004000
>  Call Trace:
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? trace_hardirqs_on+0x2b/0xe0
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   ? trace_clock_local+0xc/0x20
>   ? osnoise_main+0x10e/0x450
>   ? trace_softirq_entry_callback+0x50/0x50
>   ? kthread+0x153/0x170
>   ? __kthread_bind_mask+0x60/0x60
>   ? ret_from_fork+0x22/0x30
> 
> While running osnoise tracer with other tracers that rely on
> synchronize_rcu_tasks(), where that just hung.
> 
> The reason is that osnoise_main() never schedules out if the interval
> is less than 1,

and there is no other task setting need resched (it has a regular cond_resched()
on the run_osnoise() loop).

and this will cause synchronize_rcu_tasks() to never
> return.
> 
> Fixes: bce29ac9ce0bb ("trace: Add osnoise tracer")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

> ---
>  kernel/trace/trace_osnoise.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 38aa5e208ffd..556d530af805 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1216,8 +1216,11 @@ static int osnoise_main(void *data)
>  		 * differently from hwlat_detector, the osnoise tracer can run
>  		 * without a pause because preemption is on.
>  		 */
> -		if (interval < 1)
> +		if (interval < 1) {
> +			/* Let synchronize_rcu_tasks() make progress */
> +			cond_resched_tasks_rcu_qs();
>  			continue;
> +		}
>  
>  		if (msleep_interruptible(interval))
>  			break;
> 


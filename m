Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE883B3BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFYEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhFYEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624595684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOXNcn3ihA08/BMWoG801AKuWrravimbcKyetF5H5nA=;
        b=Y303ecXRLrvJjuBaj8zspdN4oGfK8RvySOMCXkfsHdQJaXXgx97ARiMTaXGYr8jRiLH6KX
        TbduX1nOnh6UEWXgCmjQ4w2NijtqLrrudzrQRkViVlhAh1Gjw0CcBdrwwQX6eHe2mGFsnM
        4LTAZDOQqWmHOBaXiXrIxcJD16wHMUg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-2WCXRcmGP_-HaHy_li18Ug-1; Fri, 25 Jun 2021 00:34:42 -0400
X-MC-Unique: 2WCXRcmGP_-HaHy_li18Ug-1
Received: by mail-ed1-f69.google.com with SMTP id l9-20020a0564022549b0290394bafbfbcaso4537726edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 21:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOXNcn3ihA08/BMWoG801AKuWrravimbcKyetF5H5nA=;
        b=Pxl9bFXXhyDDkRqZUd0f32lsRqt0wMGCeKti2Iay7acmkpypR5ddHHbcP/tyKodkEz
         3kj3VIpSYiP+yYKwlqt37DA9UpxdFqMYbhkuqq/ZFWx8ZANHHqXUluDsNwiz77cPgPKG
         qTaZwWS3jx5jO8Dipjh9yTj26E+i6y+yNdYjn/o9BykgYpdpqDjF6BpFiXZtZ55hI2Al
         VEqrIPTtkidA322eVU3RA2As/7Al6djLpbDR8qATB1FUoD0V5/zA5mnsDLjtRWwkdDXX
         XYlfll39+r+boLQkB5lNBfNmxuvVyiWFmDompfpqGzuRBbgZs4Nck3x7DuBO2tSwemyd
         vxNA==
X-Gm-Message-State: AOAM530CJ5wIa+Jb69qkbJrRnL4BHhNoxOZ1EoZldq2lGfBSsr0W1e8R
        GgKLDRlmZsoBTRMGOMErj68awhwkrhfqxOUgzQNRjk3iZOBC3NsAZvnp5qXtJz9X29OkGOQCick
        p1B93RfNrw9cAnbEM9OaXqjKJhv86G3pXPClVUNlVY3mjBkw3BUU/g6ImOMUHBP1NarItO8RCop
        U=
X-Received: by 2002:a17:907:d06:: with SMTP id gn6mr8668903ejc.447.1624595681551;
        Thu, 24 Jun 2021 21:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy94UZESp6JhkKfkZN/zLYR04uj5C5EiXTnt9xX8ABk3z1fHh1RbBaG5kYakIHzmbIxq1K0Ww==
X-Received: by 2002:a17:907:d06:: with SMTP id gn6mr8668871ejc.447.1624595681278;
        Thu, 24 Jun 2021 21:34:41 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id h19sm1274024edt.87.2021.06.24.21.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 21:34:41 -0700 (PDT)
Subject: Re: [PATCH V5 12/14] trace: Protect tr->tracing_cpumask with
 get/put_online_cpus
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1624372313.git.bristot@redhat.com>
 <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
 <20210624173902.57f4f34f@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <84a00fe6-5f6e-ab17-ada6-018d6394c65f@redhat.com>
Date:   Fri, 25 Jun 2021 06:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624173902.57f4f34f@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 11:39 PM, Steven Rostedt wrote:
> On Tue, 22 Jun 2021 16:42:30 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 52fc9438b7b4..c14f33db147e 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -5053,7 +5053,13 @@ int tracing_set_cpumask(struct trace_array *tr,
>>  	arch_spin_unlock(&tr->max_lock);
>>  	local_irq_enable();
>>  
>> +	/*
>> +	 * tracing_cpumask is read by tracers that support CPU
>> +	 * hotplug.
>> +	 */
>> +	get_online_cpus();
>>  	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
>> +	put_online_cpus();
>>  
>>  	return 0;
> 
> Hmm, the tracing_cpumask is only touched in he work function, with the
> necessary locks. How is get_online_cpus() protecting it here?
> 
> That is, tracing_cpumask isn't touched in the path of bringing up or
> taking down a CPU, and shouldn't be an issue here.

You are right, it is not needed with the new hotplug method.

> Should I just drop this patch?

Yes! drop it.

Thanks Steven!
-- Daniel

> 
> -- Steve
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D03E1770
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhHEO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235307AbhHEO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628175546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKfktGoBccm3g2YvE4pKqdpXN4O5Me1QiwLaOMs8jPc=;
        b=gRB+CZMv4I2A+FjqLZJ9HQnfE5JsIxNkF43tt9wJI5du0k/olJH4YWKmomJ2O9eXO3roGC
        FVGd555P7zS0socs6uMbjiM6t3Uj9IS8PpCGOb9LotG4vUsYgk7bX4Q1Lf2o3KbkLxq8gu
        s7rjLHiMG0Y6BqoWJp2HV5d1gzwgPJY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-jFyhDjR1NZWndyvmkVQhbA-1; Thu, 05 Aug 2021 10:59:05 -0400
X-MC-Unique: jFyhDjR1NZWndyvmkVQhbA-1
Received: by mail-qv1-f69.google.com with SMTP id v18-20020a0cdd920000b0290344e08aac15so4011916qvk.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 07:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OKfktGoBccm3g2YvE4pKqdpXN4O5Me1QiwLaOMs8jPc=;
        b=a/7ENJ4XGO0X9DsK/OgYr7Fp4nxPJvTW/ZwqhWpmvdInouG3+8FpLCFusYJ7oy60KC
         3LlPRVFIoqtu8r50bSBxmfZQvGrqf5xVScHn8fQiH9zS8gC7xrLe+blcEsbV/I3rjF0U
         sqaLIWIO7Ma3y5ZWqOcNyMZbmkQVTbCy9UBrPcNz5GrZuRYT1EL8g1b7EHGYMbzBJyJO
         HclNcMXDra352DWBd0O6qhbqeTU6VY7l3FhaxXFwBtA8orbvtpcyPLsQ5eNeLcMi1qC/
         ohd2UVIkFt33KcZMjtYmj05jMW0jGAdstXCy/AmZbG5jCZ9HfL18DuUa+YfIRzK09ViS
         4gZA==
X-Gm-Message-State: AOAM530pxRyJe9G3wp857z6Q8GoSOiivODFvE7irD4e8WyPqma3zVizw
        7KgN0aZoRuBJ5LnKIDR5dTNlofQEQCUN9EHMCyxAdYIS1q4dHSxLGQnndL81MKFEMOc7kMYvj84
        b4biPCvBKPCPROMD91UEbvSa2
X-Received: by 2002:a05:620a:12c8:: with SMTP id e8mr5535554qkl.142.1628175544616;
        Thu, 05 Aug 2021 07:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg6rRdW39I9pEP8NMxxWQhjY1kC3FKoIKRIqXEPgbK8rILgKGjjCZ9Fe6rdzfPLJw0i0pMew==
X-Received: by 2002:a05:620a:12c8:: with SMTP id e8mr5535537qkl.142.1628175544427;
        Thu, 05 Aug 2021 07:59:04 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i123sm3309601qkf.60.2021.08.05.07.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 07:59:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 15/63] locking: Add base code for RT rw_semaphore and
 rwlock
To:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <llong@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.018846923@linutronix.de>
 <710fff58-1db3-d0c2-21db-b1837d37bfee@redhat.com> <87o8ac1cv8.ffs@tglx>
Message-ID: <4040ac0a-970b-bd47-1ffb-14eee56c672a@redhat.com>
Date:   Thu, 5 Aug 2021 10:59:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o8ac1cv8.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 5:04 AM, Thomas Gleixner wrote:
> On Wed, Aug 04 2021 at 15:37, Waiman Long wrote:
>> On 7/30/21 9:50 AM, Thomas Gleixner wrote:
>>> +static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>>> +				     unsigned int state)
>>> +{
>>> +	struct rt_mutex_base *rtm = &rwb->rtmutex;
>>> +	unsigned long flags;
>>> +
>>> +	/* Take the rtmutex as a first step */
>>> +	if (rwbase_rtmutex_lock_state(rtm, state))
>> This function is used here before it was defined in next patch (patch 16).
> Correct and there are more I think. But that's a hen and egg
> problem:
>
> The base code cannot be compiled without the actual implementation for
> either rw_semaphore or rw_lock substitutions. The implementations cannot
> be compiled without the base code.
>
> So I chose to split it up so the base logic is separate.
>
> Thanks,
>
I realize that after the fact that the code introduced by this patch 
won't be compiled until the later patch is merged. So it is all OK.

Thanks,
Longman


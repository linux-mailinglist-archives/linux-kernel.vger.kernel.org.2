Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10C3E45F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHIMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233806AbhHIMxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628513572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9n7ilQ/jZQShw/lv6UZt5QMdO7+QAD+IE5YP5J7ceE=;
        b=BhernUFGFNZKQ42JryJKo/baHDxJAF9PQa8yuh+ElL5q99p8vtB7VVSH12aRKR/xXcbQ5l
        h+GCUyuBZK7jAmeIUiFL+uxN0XmAgKkBF+COmfN3nENH/mISRvYYT1ElQpsj5lC0NPFMQa
        QXlOXUF2Ymyokk9Zr2MA0c3WjG4gNYk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-4HuzDPvXMAyFzsMuExSgTg-1; Mon, 09 Aug 2021 08:52:50 -0400
X-MC-Unique: 4HuzDPvXMAyFzsMuExSgTg-1
Received: by mail-qv1-f71.google.com with SMTP id v19-20020ad455530000b029032620cab853so12218938qvy.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y9n7ilQ/jZQShw/lv6UZt5QMdO7+QAD+IE5YP5J7ceE=;
        b=IrIGnUHcrFdl7k5DebotO5d5nTJRW3ER3grK62qa2ixnuEfaL0itV1+xsd+Q4g0OA+
         gFNDH2q7kJpeeaOf0LoDusF1Jie1W08hkHBwfQXL3nVr4SX4nAkU/uqCQoPA2yjduwNE
         FwY7cLJQsJtmcjzRrCWcikI5YkUjfOB3BTkyv6xNknTdlrjS/m+OE1iYCAtXECzP5JO2
         uyWrXer90ZXpxXIzHCWxc+RILPwhEdRYLADO6gNIFFkqo45vBdg9MPrp59fq+OpayP/k
         vJrSxZyiprXm6XN+314A9YFuK7zq84xSg4AkMz59RjfldtVRpm5fYQeVOB211z+ATWqD
         YKOA==
X-Gm-Message-State: AOAM530Jm3ISfN65Xm7qS2j9wUb8uIpikZ4QsnoOjd5bpUWJz2kMKcDJ
        /4VgpoSRrrwzA9eWLF8gEdsfDkknmUr7b20bAOMDfN3pAtJC9envfYhL+ljlwdGxt0zggURxewi
        Bgw2+vSulP9bHZJgZEiZUUSsX
X-Received: by 2002:ad4:4972:: with SMTP id p18mr23280408qvy.26.1628513570423;
        Mon, 09 Aug 2021 05:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSTxvOKVdldJV8XjyLO3Qkmc93SmmUfXz6tQOHAE06DB4NzXZqyjTHk25Oql1BTGJFV+7NYA==
X-Received: by 2002:ad4:4972:: with SMTP id p18mr23280394qvy.26.1628513570267;
        Mon, 09 Aug 2021 05:52:50 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id p187sm8946260qkd.101.2021.08.09.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 05:52:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Xiaoming Ni <nixiaoming@huawei.com>,
        Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
 <1a5b0f50-b071-2d1c-5277-b6d7f652c257@huawei.com>
Message-ID: <65fe396a-b10d-2388-8229-05fd43d58927@redhat.com>
Date:   Mon, 9 Aug 2021 08:52:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a5b0f50-b071-2d1c-5277-b6d7f652c257@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 11:51 PM, Xiaoming Ni wrote:
> On 2021/8/9 11:01, Waiman Long wrote:
>>
>> I think it is simpler to just put a "might_sleep()" in 
>> __down_common() which is the function where sleep can actually happen.
>>
>
> If the actual atomic context hibernation occurs, the corresponding 
> alarm log is generated in __schedule_bug().
>     __schedule()
>         --> schedule_debug()
>             --> __schedule_bug()
>
> However, "might_sleep()" indicates the possibility of sleep, so that 
> code writers can identify and fix the problem as soon as possible, but 
> does not trigger atomic context sleep.
>
> Is it better to put "might_sleep()" in each down API entry than 
> __down_common() to help identify potential code problems? 

Putting "might_sleep()" in each down_*() functions mean that whenever we 
add a new API function, we have to remember to add "might_sleep()". If 
we put it in down_common(), it will work for any newly added API 
function in the future even though I doubt we will add any.

Cheers,
Longman


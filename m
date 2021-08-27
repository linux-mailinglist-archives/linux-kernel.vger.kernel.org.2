Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1983FA08B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhH0U15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhH0U14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630096026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvUFmdthk7jLPef6R9/TSXU1gnYsUf+KUTcBRx1p1DE=;
        b=HySl7sKOPEmpBN0Ae1fjGQL5B35kBQVzxAxWSMETTCVeoxt9qf76LwuQ0d3Rl97eEO38wQ
        fJeOYwrE99yAEP28Bl76TVdydQfeE5ZuKi04HQhyg4BfjB+fOWvHZjiRkqn/ykyyvbRjf8
        4qvDoGMtZi9YvMqN0q8fVMCRg6S99Zo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Vzh89-jCMrOGgb2sg_WeHg-1; Fri, 27 Aug 2021 16:27:03 -0400
X-MC-Unique: Vzh89-jCMrOGgb2sg_WeHg-1
Received: by mail-qk1-f200.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so457899qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JvUFmdthk7jLPef6R9/TSXU1gnYsUf+KUTcBRx1p1DE=;
        b=Ht8r3ayee3iDUUMDa1qEfnTZ9dmm4e2RgeGJOi3SynpD5VcbPRwMPixVTKAgOuSrAD
         +5YYJXzAPAmFAJNjL1e9SCyjrCbXPfaJ/YoYDUr5KPje1tfeUoywVkecQ/epnoJ3wMxP
         i/AzBbaCuZt9Nd4Z2jPMQ9lG5aFj/Z/fWkr24Gg1izXXRmoEjosf1sd3nVPWXGZjBhJG
         TuaFeaWQHT5O7poyGeKtxuE4zr87RsXBYSygTLcDBBrz4YDyue3dTGxm/THeG6ObeeC7
         dkw7lmdwUBpbeXegHfq0KlQU/19jDbmbY3RFFGqNDVcaPn35tOHSofEF/V9PB/JoWmJj
         XbXQ==
X-Gm-Message-State: AOAM530aMdDxY5/PXhiqBs5q9ZFNn1PN35CoIt0NMXvU4BMJDbUfnEZk
        U5tfIVhw6w2hPVvXsJqqxuEyp5oCtzQh9vS6WtlCUqo6lPQSsP3KHPiZpqHJ9ebF/PbmYornOYl
        /AA6JZwjb9eRfeimiop0qxyDb
X-Received: by 2002:ac8:47d7:: with SMTP id d23mr10075289qtr.73.1630096022618;
        Fri, 27 Aug 2021 13:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaVC191a1tAlIadHotO6wANwljm8N7F7Z8+S2yDbcvImQy/MRUKFShJP3VGOS4gvfCCav+Pg==
X-Received: by 2002:ac8:47d7:: with SMTP id d23mr10075280qtr.73.1630096022406;
        Fri, 27 Aug 2021 13:27:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m8sm5202923qkk.130.2021.08.27.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 13:27:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
To:     paulmck@kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org
References: <20210827022122.15816-1-longman@redhat.com>
 <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <34cbf3f5-9485-a82d-2548-272e87033ab2@redhat.com>
Date:   Fri, 27 Aug 2021 16:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 2:34 PM, Paul E. McKenney wrote:
> On Thu, Aug 26, 2021 at 10:21:22PM -0400, Waiman Long wrote:
>> Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
>> PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
>> rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
>> The rcu_read_unlock_strict() call is only needed if the performance
>> sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
>> option isn't set for most production kernels while the function call
>> overhead remains.
>>
>> To provide a slight performance improvement, the
>> CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
>> rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
>> call can be compiled out in most cases.
>>
>> Besides, the GPL exported rcu_read_unlock_strict() also impact the
>> the compilation of non-GPL kernel modules as rcu_read_unlock() is a
>> frequently used kernel API.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Nice, and good eyes!!!
>
> I have queued this for v5.16, that is, not the upcoming merge window
> but the one after that.
>
> I did my usual wordsmithing, so please check the following in case I
> messed something up.  I intentionally omitted the EXPORT_SYMBOL_GPL()
> discussion because:
>
> 1.	Kernels built with CONFIG_PREEMPT=y have the same issue
> 	with the __rcu_read_lock() and __rcu_read_unlock() functions.
>
> 2.	Many other RCU functions are EXPORT_SYMBOL_GPL() and have
> 	been for almost two decades.
>
> But if someone does use RCU readers within CONFIG_PREEMPT=n kernels from
> a binary module, I will happily refer them to you for any RCU issues
> that they encounter.  ;-)
>
> I am also CCing the BPF guys in case my interpretation of the code in
> the BPF verifier is incorrect.
>
> 							Thanx, Paul
>
It looks good to me. Thanks for the rewording. I did regret mentioning 
about about the GPL export symbol in the commit log and it is good that 
you had taken it out.

Cheers,
Longman


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC93EBC32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhHMSsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhHMSsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628880458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXcjuY/PIpdtcTym8ORH9MoqgdSPJS5LvBrctQchlTE=;
        b=OKkUm9vQ1942uHzSEaZe6b9QehiViAgGCUTdsaKVpsR0An/7tihIzrPiwMVrvnv84d3hKt
        N3UGLsTnYDd9SNg5sXff+dW/U7C9/eRTJPkK/mrJruxg5wRGmtso8ze5VvXch+P+gVLCuU
        beXKI8NCT3vuTXHRCscSKfMXOWcqj40=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-h2FfXV0nOZWLAaQOKMRX6g-1; Fri, 13 Aug 2021 14:47:37 -0400
X-MC-Unique: h2FfXV0nOZWLAaQOKMRX6g-1
Received: by mail-qt1-f197.google.com with SMTP id v1-20020a05622a1441b02902977bfc6bbeso4663349qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jXcjuY/PIpdtcTym8ORH9MoqgdSPJS5LvBrctQchlTE=;
        b=cKoJCGzx3P8qrgEu6P6aIAubmNfoN0X7+rZVBTMC8lpi5N6LR8b6T6dzt+EWgBIPD4
         7x923hHCXE9e1qV3cHJn1uy+zA0m6UQK4yszP54jdgEce2B1FpNPWE7GU1WuttfkjPLv
         Tj21jWT6k3njMSD13OqgtGLuvLjTTOVKCmotXaKV5FunhQcoixRl35/t5k6sstnXTGrc
         /lNtld5TnQPo/o4yiO8Pd9L4mHUV30VQz4SkueBW2288UubpJ7VFu0TrFKEvz/N7NTUB
         yPRjX8sQmnliHKCrjIkOH5a08kSL2yuJ2kpfexmxwiqC5Z+qK+k1UX5ZkdE9SJLehpin
         faVw==
X-Gm-Message-State: AOAM531ASXIGF68ZxUzpmrR7UzIp3XgxE/dOmTnAHKx7+VhFazebyoMP
        ALA+ABIBDMdyCNVw3YVijhocLmc5xPEL25nrSv1FHZ/Pi+Fe5XnxLe5ZPKEoJ0lafYXJNtIviAv
        DIIvLiVl6fXReRoxZqWzsAGsA
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr3251627qtu.178.1628880456992;
        Fri, 13 Aug 2021 11:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8LMDWziWnee6dus8LtzBf1uuvwFlsgWW/+F+SwsA30rYAcNS3+ggXDoWjIXsn0oN5GVObFA==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr3251619qtu.178.1628880456829;
        Fri, 13 Aug 2021 11:47:36 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k21sm942129qkh.110.2021.08.13.11.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 11:47:36 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <llong@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com> <877dgpp852.ffs@tglx>
Message-ID: <41bddbee-948a-987c-eb72-108a465a7082@redhat.com>
Date:   Fri, 13 Aug 2021 14:47:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <877dgpp852.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 1:27 PM, Thomas Gleixner wrote:
> On Sun, Aug 08 2021 at 23:01, Waiman Long wrote:
>> On 8/8/21 10:12 PM, Xiaoming Ni wrote:
>>> Semaphore is sleeping lock. Add might_sleep() to down*() family
>>> (with exception of down_trylock()) to detect atomic context sleep.
>>> @@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
>>>    	unsigned long flags;
>>>    	int result = 0;
>>>    
>>> +	might_sleep();
>>>    	raw_spin_lock_irqsave(&sem->lock, flags);
>>>    	if (likely(sem->count > 0))
>>>    		sem->count--;
>> I think it is simpler to just put a "might_sleep()" in __down_common()
>> which is the function where sleep can actually happen.
> No. Putting it in __down_common() is wrong, because that covers only the
> contended case.
>
> But we want to cover the potential sleep, i.e. checking even in the
> non-contended case, which is what might_sleep() is about.

You are right. Thanks for the correction.

Cheers,
Longman


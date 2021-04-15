Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81647361078
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhDOQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhDOQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618505592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOZmiQsPM2z8JFg2yCo7YvOl2YlV7mTl6vjBKTI8sno=;
        b=V7Bj+N3Ca0kjhDsDS7JbFcB6UhwqQqrge9p/MgMKXC74nldcGfJzy4MCj+GBDXRDSXEW5G
        Jsn1TF5LUaMTgSj5wC5wPGOpcZuMU93XAst8k4HEfOmstvt/g7t+ao01vddq1areM9qgBc
        LdaAV89RQmAOegKKKFPj9oC8nzEeu5k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-lgFYKKD_NY6R0yas26HLPA-1; Thu, 15 Apr 2021 12:53:08 -0400
X-MC-Unique: lgFYKKD_NY6R0yas26HLPA-1
Received: by mail-qt1-f198.google.com with SMTP id o15-20020ac872cf0000b02901b358afcd96so4408069qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mOZmiQsPM2z8JFg2yCo7YvOl2YlV7mTl6vjBKTI8sno=;
        b=ZESB8yqpbaOiuoLw0b/z6vkLl1YTfn80vnMGSd0Cneb0xZMZLeIu2zFcLWlfNxhYbP
         igACZCcMzTDRtzMSCRO4j6BIVkFpb4BPukyKQBfxpWX8JTDoBULYwLUvXqwSjBEOKvwH
         g4+dISVY4P5hMweJmLLFvWwf2MqDzM5Tdfovgd5jVSm+raNqO9K7thY6CBszeWYhyg8l
         GIxmbBurpscCZ740aDU3N0NonrUJFL8SdKnjKa1kOUMZZMsZ4bZjAUxNcLNF6KF/Eybp
         OlBOI+3urBI0rX8fC+W6vuIq8qaQE4NJNtHFYStSU5M3EH2KSh28Pzq54ATGd0x3T3Q8
         nPcw==
X-Gm-Message-State: AOAM530G3VyeOtG/S/vVqZXaVaQG3YfX2SfRSrg/iaD/UzqmQqCf4CxV
        Iq+LA1cyf/3kPSV4Jk7CSe76IIum9I55+DliYiUMZEp5Dln6OImS5ak369T15947DixyzXch7+p
        9HzN+fPphQzEOBGhJyohwjiS7
X-Received: by 2002:ae9:eb8a:: with SMTP id b132mr4255235qkg.296.1618505587822;
        Thu, 15 Apr 2021 09:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrDSSW59HtlgLMvEXKM92wd1+sNACdsKWQFt9qD/GAPiFXLioBFNt+Mx3E93UmMiShqhM9ug==
X-Received: by 2002:ae9:eb8a:: with SMTP id b132mr4255216qkg.296.1618505587640;
        Thu, 15 Apr 2021 09:53:07 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i5sm2356913qka.126.2021.04.15.09.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:53:07 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/qrwlock: Fix ordering in
 queued_write_lock_slowpath
To:     Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, stable@vger.kernel.org,
        steve.capper@arm.com
References: <20210415150228.GA26439@willie-the-truck>
 <20210415162646.9882-1-alisaidi@amazon.com>
 <20210415164525.GC26594@willie-the-truck>
Message-ID: <c288c94a-a545-492a-79c1-3d741c001504@redhat.com>
Date:   Thu, 15 Apr 2021 12:53:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415164525.GC26594@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 12:45 PM, Will Deacon wrote:
>
>>> With that in mind, it would probably be a good idea to eyeball the qspinlock
>>> slowpath as well, as that uses both atomic_cond_read_acquire() and
>>> atomic_try_cmpxchg_relaxed().
>> It seems plausible that the same thing could occur here in qspinlock:
>>            if ((val & _Q_TAIL_MASK) == tail) {
>>                    if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
>>                            goto release; /* No contention */
>>            }
> Just been thinking about this, but I don't see an issue here because
> everybody is queuing the same way (i.e. we don't have a mechanism to jump
> the queue like we do for qrwlock) and the tail portion of the lock word
> isn't susceptible to ABA. That is, once we're at the head of the queue
> and we've seen the lock become unlocked via atomic_cond_read_acquire(),
> then we know we hold it.
>
> So qspinlock looks fine to me, but I'd obviously value anybody else's
> opinion on that.

I agree with your assessment of qspinlock. I think qspinlock is fine.

Cheers,
Longman


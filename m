Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC73B871A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF3QdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhF3QdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625070650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HlIY3UNOLlrHaAG2NmBwkHfzmTIdb2LeCvkzBEmSo8=;
        b=GlklLOKGQRY1SUq5gQzww/fCQhglH+wwGM4/TaEArgNDpFg6uK7A/pknehFHYzSIl+GUAK
        Rc3Dejp5jq7fXgdh6dodADVNxAD61MQXje1bSB8AqIHu/jO1z5gPlDwSKk0icwhb8K2MNm
        UqvDYRkssYHB3BSmLHo5e6MQmYel5AU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-AkzPgZYEM0-cfdkN0Jg8kQ-1; Wed, 30 Jun 2021 12:30:46 -0400
X-MC-Unique: AkzPgZYEM0-cfdkN0Jg8kQ-1
Received: by mail-qk1-f200.google.com with SMTP id z3-20020ae9c1030000b02903b44440a9a9so573422qki.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 09:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2HlIY3UNOLlrHaAG2NmBwkHfzmTIdb2LeCvkzBEmSo8=;
        b=GDdcG7pt/+4qSI1XQkFnFBaEFq/arSE6mKgiT1mxqehKkdCdHK3/I8FezIoFvzhqBf
         kSVyQCWkoPvqTgGmTmUroDLPVDgJzlI+pGRHyexPsmW8SZuEdDDvjp8NaetW3+3w9WKn
         lUgk3U+pjD1tux7oMHvygzsYk328uBnXbAEjZiZRRKAJFzHCJ+Dr/n8MUl5EPF4gH+HK
         Qx/z15L5erfAeP4GsyKLeGOB07S8Og08h3YPdJ1xThi+wGU2AMQWK+eHe9qup8WFk+Rr
         K5oTQZa9wVnnOlN8cs07l1V9EdnaPB2i3BWhM8m1wopb+lG6s1jlaroAfbR9hDATOlmy
         pcZQ==
X-Gm-Message-State: AOAM531dfeFcM/sRNADVVQOXgFv8L8u7QGiJxuz7stAfDrHyCve7iG6X
        /l3qydHQ8YKO2cUJ5Jfjt+C/jjEyMm9czEXcTajl68IjCsmuSSniCOuDPNH1Ip7uxYNhB7nKVId
        OUB+in0KM3gLXqubOyW1sHdOJ
X-Received: by 2002:a05:620a:5ee:: with SMTP id z14mr36705160qkg.83.1625070645883;
        Wed, 30 Jun 2021 09:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNeb5qvsOfDli6P3q7iRgk4pFA8CjOSsIZxC/Txo001Bb1cAvZGDZSUwD53noDyNIIlimMzA==
X-Received: by 2002:a05:620a:5ee:: with SMTP id z14mr36705123qkg.83.1625070645612;
        Wed, 30 Jun 2021 09:30:45 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id u184sm9356270qkd.53.2021.06.30.09.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 09:30:44 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC][PATCH 3/4] locking/mutex: Introduce
 __mutex_trylock_or_handoff()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        boqun.feng@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, yanfei.xu@windriver.com
References: <20210630153516.832731403@infradead.org>
 <20210630154114.958507900@infradead.org>
Message-ID: <9c47a47c-0c95-4f8f-8b62-a1aff10be748@redhat.com>
Date:   Wed, 30 Jun 2021 12:30:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210630154114.958507900@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 11:35 AM, Peter Zijlstra wrote:
> Yanfei reported that it is possible to loose HANDOFF when we race with
> mutex_unlock() and end up setting HANDOFF on an unlocked mutex. At
> that point anybody can steal it, loosing HANDOFF in the process.
>
> If this happens often enough, we can in fact starve the top waiter.
>
> Solve this by folding the 'set HANDOFF' operation into the trylock
> operation, such that either we acquire the lock, or it gets HANDOFF
> set. This avoids having HANDOFF set on an unlocked mutex.
>
> Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/locking/mutex.c |   58 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 35 insertions(+), 23 deletions(-)
>
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -91,10 +91,7 @@ static inline unsigned long __owner_flag
>   	return owner & MUTEX_FLAGS;
>   }
>   
> -/*
> - * Trylock variant that returns the owning task on failure.
> - */
> -static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
> +static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, bool handoff)
>   {
>   	unsigned long owner, curr = (unsigned long)current;
>   
> @@ -104,39 +101,56 @@ static inline struct task_struct *__mute
>   		unsigned long task = owner & ~MUTEX_FLAGS;
>   
>   		if (task) {
> -			if (likely(task != curr))
> +			if (flags & MUTEX_FLAG_PICKUP) {
> +				if (task != curr)
> +					break;
> +				flags &= ~MUTEX_FLAG_HANDOFF;

I think you mean "flags &= ~MUTEX_FLAG_PICKUP". Right:-)

Cheers,
Longman


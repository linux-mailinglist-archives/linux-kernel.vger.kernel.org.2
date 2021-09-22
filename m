Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9041514B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhIVUVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhIVUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632341975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HcjgPehk1OEseGbNZ/ELG+DEQeorkyBbrpqwUI1U0c=;
        b=UTNzT3o8VbQJBcHCQBATZsGqKex3b1ZCktj+jXeSoup5+Fl6MwHbt5W34az7sID08VcL5S
        mov6aT7ne0SlIor8Ga1XE/QH9Tch/zlyImws4ouEg6iIQA6m3PKs1DTkH9Q8LRR5a1mcF9
        WVla60QkXI0yDIqnXKmlb1ZFyJWhfoc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-e3X8xds5MC-TFBGiim8QDg-1; Wed, 22 Sep 2021 16:19:33 -0400
X-MC-Unique: e3X8xds5MC-TFBGiim8QDg-1
Received: by mail-qv1-f72.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so13241934qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/HcjgPehk1OEseGbNZ/ELG+DEQeorkyBbrpqwUI1U0c=;
        b=sNdfxEOOYjUKqUv3rtqZ33F7biJ7/1mvDGwpFlnMiPKgntHIabWCRj3DCeFU/yR3pR
         0dGLLJ+H9h1dp+UxRPd/KoKJPzT5NHpivd/xUrU7pfJEN0BAWDBjjNSzPVp5682Ie3J2
         sys9BKMBe0fEPEgPV5w0nj1QAEeGLSN5G5/1JubkIy/CVyDveqqi9XhVcyZGubIOT3Tc
         ZYn9U4GBb5CRa9JsNL4qEgN2pGPFEiscurpXVoQqPs+JFQ5QFgTmfZJVe/LxpNJi4vhZ
         rlEKCzXxYotChHzwlwtd/gBBPaNJH79gpvglfl1mlqUyLsdTL+NiMJ4coeoDNCEQI8zZ
         m99g==
X-Gm-Message-State: AOAM533Tsbpqal7tMPiSs3I3Msh22MOCdxfLY1De0VKuu9/XE5UqXEF1
        x5X/3HaXfNynV/vB/Cj05g3UNue08kSrJnkWmq9Gt1nYj46aE9QmsZDhqkzBKk74iGwcw3HPGM9
        l5vK7dvJ5GpxLPGfKAhYToTEg
X-Received: by 2002:a37:a095:: with SMTP id j143mr1213695qke.277.1632341973350;
        Wed, 22 Sep 2021 13:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXs5QgS7oSP8cFafh2iA6W41xyOYbvOAY3XursXzZ7dQhjchXZpxBj/jVvsV7Lbcv71nfoIQ==
X-Received: by 2002:a37:a095:: with SMTP id j143mr1213677qke.277.1632341973117;
        Wed, 22 Sep 2021 13:19:33 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b14sm1350929qkl.81.2021.09.22.13.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 13:19:32 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] locking/rwsem: Add upgrade_read()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20210922193657.29461-1-longman@redhat.com>
 <YUuMv6fA+TpqH3wb@hirez.programming.kicks-ass.net>
Message-ID: <000af44f-6f24-5a2d-8700-452469b3d6b3@redhat.com>
Date:   Wed, 22 Sep 2021 16:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUuMv6fA+TpqH3wb@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 4:06 PM, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 03:36:57PM -0400, Waiman Long wrote:
>> Currently there are about 12 instances in the kernel where an up_read()
>> is immediately followed by a down_write() of the same lock. For example,
>>
>>    drivers/tty/n_tty.c:		up_read(&tty->termios_rwsem);
>>    drivers/tty/n_tty.c-		down_write(&tty->termios_rwsem);
> And TTY is a high performance issue, that requires hacks like this?
I won't call it a hack. I consider it a better documentation what the 
real intention is.
>
>> Since we have already provided a downgrade_write() function, we may as
>> well provide an upgrade_read() function to make the code easier to read
>> and the intention clearer.
>>
>> If the current task is the only reader, the upgrade can be done by a
>> single atomic operation. If not, the upgrade will have to be done by a
>> separate up_read() call followed by a down_write(). In the former case,
>> the handoff bit is not considered and the waiter will have to wait a
>> bit longer to acquire the lock.
>>
>> The new upgrade_read() function returns a value of 0 for safe upgrade
>> where rwsem protected data won't change. Otherwise a value of 1 is
>> returned to indicate unsafe upgrade where rwsem protected data may
>> change during the upgrade process.
> Yuck...
>
> Is there any workload where this is a massive win? I'm thinking that
> either the lock is contended and you get the unsafe option which is the
> same as today, or the lock isn't contended and you would've gotten
> fast-paths and you barely safe anything anyway.
>
> Also, -ENODATA
>
Yes, the best case saving is just just an atomic op.

This is just a RFC. I can look for workloads that can benefit from using 
this.

Cheers,
Longman


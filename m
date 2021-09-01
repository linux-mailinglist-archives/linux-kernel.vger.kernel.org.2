Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCF3FE273
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbhIASe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245252AbhIASe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630521240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CoTPuq9YzYCOqMUWEF6uWhloFZ+Cm12Nm9b+QIj+Jk=;
        b=QqTH18zOdlgd9V4Y/L5FPFnkQ24fN2suRwcmjSbRDEJbPIUbnaTX5C0Sjoec5Y4G6Ik8G9
        0Ha0BxPTLh2YOfYgILk/GCFQyQPGjwqOwrk090gjjKdS9iiCwevnlKwBpzVHCMxMT4kzsP
        3B46JxjpUYFB27IdslbaSwgS1TQl89k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-3ND2Nc7aNLCyhm7eaNdDAA-1; Wed, 01 Sep 2021 14:32:56 -0400
X-MC-Unique: 3ND2Nc7aNLCyhm7eaNdDAA-1
Received: by mail-qt1-f200.google.com with SMTP id f34-20020a05622a1a2200b0029c338949c1so375569qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0CoTPuq9YzYCOqMUWEF6uWhloFZ+Cm12Nm9b+QIj+Jk=;
        b=QgZPCdNRQ4Ecf9MvgnPksO3cOBrgVSCiOQ2byNQBwsd5eSZepj4TVgE88vb/zz8aK5
         eGvBcqRMP/TU1BFhcmoHK0jBubqIo8zS1elx0Xcz1shc4XTQ67wrAt896wMyCNgWWUYS
         flgND5mCiiFLEp9ujuHtItfqkHCJBD9BRz63hz7KpwpWhSd1DbZUETTlUlyRkU92Krrs
         Jl9gF7Lq4pzz0HuaS8zXP1QSkA1lVy4ZIFEGdat/sumQS2CPfZB15qFgCZReRBP33MO1
         RoKLeSY7emnH+6Xzt1cc1fN8f3IapPE7K9XknG4i/jvyK5WYvu8PXysyNvPZ1dgVZHjc
         IxfQ==
X-Gm-Message-State: AOAM531/7v7YpHOlt7jRpyX91PXh+GZ8qJi9S8mZG5hfKOaPkzZnkSB7
        zjC7++0dahzcgzGnfM+KYcJ9doxhkgz/ELYV1AjcQcqUNQFcahhcPAQvqjYzE8EJBtA432nJ1UH
        h+6+WHzV1MC+RFAsUJMziicKe
X-Received: by 2002:a05:620a:29c7:: with SMTP id s7mr1043097qkp.186.1630521176302;
        Wed, 01 Sep 2021 11:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwqujBA8w+lcIHJrlFcTQmC4TiAHAd3NMdpbDWMHkLwTtt9aDqUqkAPxwBEyx2V+ulvpz1Gw==
X-Received: by 2002:a05:620a:29c7:: with SMTP id s7mr1043072qkp.186.1630521176094;
        Wed, 01 Sep 2021 11:32:56 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a189sm205323qkf.114.2021.09.01.11.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:32:55 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] lockdep: Let lock_is_held_type() detect recursive read as
 read
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
Message-ID: <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
Date:   Wed, 1 Sep 2021 14:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 12:22 PM, Sebastian Andrzej Siewior wrote:
> lock_is_held_type(, 1) detects acquired read locks. It only recognized
> locks acquired with lock_acquire_shared(). Read locks acquired with
> lock_acquire_shared_recursive() are not recognized because a `2' is
> stored as the read value.
>
> Rework the check to additionally recognise lock's read value one and two
> as a read held lock.
>
> Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> On a related note: What exactly means read_lock_is_recursive() in terms
> of recursive locking? The second items mentions QRW locks. Does this
> mean that a pending WRITER blocks further READER from acquiring the
> lock?
>
>   kernel/locking/lockdep.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index f15df3fd7c5a6..39f98454a8827 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5366,7 +5366,9 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
>   		struct held_lock *hlock = curr->held_locks + i;
>   
>   		if (match_held_lock(hlock, lock)) {
> -			if (read == -1 || hlock->read == read)
> +			if (read == -1 ||
> +			    (read == 0 && hlock->read == 0) ||
> +			    (read == 1 && hlock->read > 0))
>   				return LOCK_STATE_HELD;
>   
>   			return LOCK_STATE_NOT_HELD;

I think the check can be simplified as

     if (read == -1 || read == !!hlock->read)

Cheers,
Longman


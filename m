Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86536B966
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhDZSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239257AbhDZSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619463112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfK9lfoYc+03KHKdRUvmbZAZpf80F/z+G4/xc8L1eD8=;
        b=F7B3bs2ZxniFFcrCPI6MSgxCrYKQh+CHOn4VsCNwzB30bMBL2ditGS2HfbniVBKbMBWT4y
        JG+7FAdqFqkJqjvm6f/xx/M2WyDrCDngX9r+9R4lMQOdNITK6FRVFsMgeeCz/LpfOhcxcv
        gmI011e3fAL+iYufF/B7MhOwm9zTRBk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-p6Bc3WkVPaSfWewEvY2tTw-1; Mon, 26 Apr 2021 14:51:50 -0400
X-MC-Unique: p6Bc3WkVPaSfWewEvY2tTw-1
Received: by mail-qk1-f198.google.com with SMTP id e4-20020a37b5040000b02902df9a0070efso21344395qkf.18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HfK9lfoYc+03KHKdRUvmbZAZpf80F/z+G4/xc8L1eD8=;
        b=f8usDYbN4cO+j2cEem/BUlTCD+jpAzF+8t2C1QZCWoHQH9ad7zi0cbyzWR8futBtZ2
         Mg+IW9uvpmYCQc6OYQUei6tVb70qR2A+wgGac7VyMFXkjH1zaR0+AmpSnDiND48pn6H2
         HRZhpgD6slPpLg0j9fb6GegdWQeCuIo2A/cyaWnFaLwPt6MeUooKJAzU1+FKmIizN1/6
         Dqa373gCbxDGvds2dxrJBjd567e+/2pkN8UiXF8U3Zlr/5lxn2S4/PfZSnTEqaGXiQqf
         5fk7EOuzp2Yw6NHxq2qpabPq9BE64mWGJ13zJSyq2PU/KuyfDkJNhT1V6RDFYCVipZAV
         Z0ug==
X-Gm-Message-State: AOAM531dRvnhVf/gHS0vmOVnGNr7UmO3d3guf6nxD7fsMntEuD7YU1bp
        7rImH4Mw/TuWUKbxpQx/aOsTwIuR0b+CXPXfj2DELlCGumZzUlETljINOBC/Kif/qwjjNT3gD6f
        cea6Kbjb2NPSTDWEwFOaB4kAN
X-Received: by 2002:a37:8181:: with SMTP id c123mr19150369qkd.287.1619463110180;
        Mon, 26 Apr 2021 11:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS8X/VzurSrpDlNhl+L1bACm1B5oJnNe8qn+lgbdD5zkt3ZBvGh0XvLtQ/7lrv2aslazYIJg==
X-Received: by 2002:a37:8181:: with SMTP id c123mr19150347qkd.287.1619463109942;
        Mon, 26 Apr 2021 11:51:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id e13sm13047982qtm.35.2021.04.26.11.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:51:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>
References: <20210426185017.19815-1-longman@redhat.com>
Message-ID: <e603e511-6d58-38ea-d936-ed2f4efafc41@redhat.com>
Date:   Mon, 26 Apr 2021 14:51:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210426185017.19815-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 2:50 PM, Waiman Long wrote:
> Make the code more readable by replacing the atomic_cmpxchg_acquire()
> by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
> to atomic_or().
>
> For architectures that use qrwlock, I do not find one that has an
> atomic_add() defined but not an atomic_or().  I guess it should be fine
> by changing atomic_add() to atomic_or().
>
> Note that the previous use of atomic_add() isn't wrong as only one
> writer that is the wait_lock owner can set the waiting flag and the
> flag will be cleared later on when acquiring the write lock.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/qrwlock.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index b94f3831e963..ec36b73f4733 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -66,12 +66,12 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>   	arch_spin_lock(&lock->wait_lock);
>   
>   	/* Try to acquire the lock directly if no reader is present */
> -	if (!atomic_read(&lock->cnts) &&
> -	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
> +	if (!(cnts = atomic_read(&lock->cnts)) &&
> +	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
>   		goto unlock;
>   
>   	/* Set the waiting flag to notify readers that a writer is pending */
> -	atomic_add(_QW_WAITING, &lock->cnts);
> +	atomic_or(_QW_WAITING, &lock->cnts);
>   
>   	/* When no more readers or writers, set the locked flag */
>   	do {

Sorry, I missed the "v2" in the title.

Cheers,
Longman


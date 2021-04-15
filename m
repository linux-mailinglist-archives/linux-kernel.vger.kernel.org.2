Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7C36114F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhDORq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhDORqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618508761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAQgrrs/fT5iNfRVmF2BgfffAf7Nhr3HzWZJ/IDRqis=;
        b=OOvJC6R4otrdzb9op85ngGLWPLClzSK6qLqk8GbD8PzTOaRDRo9I9GQ5hk9ZlmE4WzPP2M
        8up2yvrGoAroazETU1J810OV3yWtO+IeZxs6zgLme+oWBkO8j1ObtQ9wJzInaXZzmLaYlc
        XMr5QrzXZkGUMOJc8gu9BWTR2QOb+Mc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-mBfLwsDRMdeX73fu5-sRUQ-1; Thu, 15 Apr 2021 13:45:57 -0400
X-MC-Unique: mBfLwsDRMdeX73fu5-sRUQ-1
Received: by mail-qt1-f198.google.com with SMTP id x7-20020a05622a0007b029019d73c63053so4500667qtw.16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mAQgrrs/fT5iNfRVmF2BgfffAf7Nhr3HzWZJ/IDRqis=;
        b=n1iRENn0FIHmEy+WRbik1h0Rp6MvAvEm+7Psny6sYilBTXosdgOwqYRpZDqZUdVTUz
         MJRrdMumT/KfD+zH0U6pfv76RK744GKNDrCvO8zc7RA16V713yHTVU3it0LrUJ9TUSO1
         tCO0+OTTT8F2SHmNIXn5AM8PXExMcwaUHkTLNuIkcpl+Q1XI4ew1kTwUDqRttB2sT12x
         7GFa/rovmVF5rLxgLzIqcEY4gM9MuaQtosXtzaOQHeOWxEH6nEOD0lecORXhRJFlH/fQ
         BNkPfEBjXkA8CynsZE+NiSyJImjgmuxFvSROSr4mz864DXunMdV485NmjOH7A6IMi31t
         7i1w==
X-Gm-Message-State: AOAM533s9pRl1MUZPD/7PgSodO8nrhn4hltJfJalvWu/HoFLp3BQ5mb8
        sGK4HysVZAbxCpxk1lv+m8yq1H3X9GbAMTrcDSfL/R9tLqTJ1i6yonO5ulQZ05m72Dx1onUt3u7
        2oYwWT/DYZORsCrXajSzqkT7N
X-Received: by 2002:ac8:594:: with SMTP id a20mr4035562qth.295.1618508757084;
        Thu, 15 Apr 2021 10:45:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiT8Jqne8RPHHOTMVAUMxBUqZMQ4EbB4wRNPSvpefvx4TGPTVunaMkrSKpc7DZg2DEUwpeWQ==
X-Received: by 2002:ac8:594:: with SMTP id a20mr4035543qth.295.1618508756868;
        Thu, 15 Apr 2021 10:45:56 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c23sm2375540qkk.24.2021.04.15.10.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:45:55 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] locking/qrwlock: Fix ordering in
 queued_write_lock_slowpath
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, steve.capper@arm.com,
        benh@kernel.crashing.org, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20210415172711.15480-1-alisaidi@amazon.com>
Message-ID: <e9dfb6c2-3efc-5f4c-ebba-2f26f14295d5@redhat.com>
Date:   Thu, 15 Apr 2021 13:45:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415172711.15480-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 1:27 PM, Ali Saidi wrote:
> While this code is executed with the wait_lock held, a reader can
> acquire the lock without holding wait_lock.  The writer side loops
> checking the value with the atomic_cond_read_acquire(), but only truly
> acquires the lock when the compare-and-exchange is completed
> successfully which isn’t ordered. This exposes the window between the
> acquire and the cmpxchg to an A-B-A problem which allows reads following
> the lock acquisition to observe values speculatively before the write
> lock is truly acquired.
>
> We've seen a problem in epoll where the reader does a xchg while
> holding the read lock, but the writer can see a value change out from under it.
>
> Writer                               | Reader 2
> --------------------------------------------------------------------------------
> ep_scan_ready_list()                 |
> |- write_lock_irq()                  |
>      |- queued_write_lock_slowpath()  |
>        |- atomic_cond_read_acquire()  |
>                                       | read_lock_irqsave(&ep->lock, flags);
>     --> (observes value before unlock)|  chain_epi_lockless()
>     |                                 |    epi->next = xchg(&ep->ovflist, epi);
>     |                                 | read_unlock_irqrestore(&ep->lock, flags);
>     |                                 |
>     |     atomic_cmpxchg_relaxed()    |
>     |-- READ_ONCE(ep->ovflist);       |
>
> A core can order the read of the ovflist ahead of the
> atomic_cmpxchg_relaxed(). Switching the cmpxchg to use acquire semantics
> addresses this issue at which point the atomic_cond_read can be switched
> to use relaxed semantics.
>
> Fixes: b519b56e378ee ("locking/qrwlock: Use atomic_cond_read_acquire() when spinning in qrwlock")
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Cc: stable@vger.kernel.org
> Acked-by: Will Deacon <will@kernel.org>
> Tested-by: Steve Capper <steve.capper@arm.com>
> Reviewed-by: Steve Capper <steve.capper@arm.com>
>
> ---
>   kernel/locking/qrwlock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 4786dd271b45..10770f6ac4d9 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -73,8 +73,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>   
>   	/* When no more readers or writers, set the locked flag */
>   	do {
> -		atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
> -	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
> +		atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
> +	} while (atomic_cmpxchg_acquire(&lock->cnts, _QW_WAITING,
>   					_QW_LOCKED) != _QW_WAITING);
>   unlock:
>   	arch_spin_unlock(&lock->wait_lock);

Acked-by: Waiman Long <longman@redhat.com>


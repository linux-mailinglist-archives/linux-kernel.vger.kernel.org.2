Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A08381A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhEOTDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 15:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231558AbhEOTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 15:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621105342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak4YzMd3ThrCMBkvcDEWIGdqfAk+9WtH0c1YVFOWIxc=;
        b=X5ggL2sHVlBjDt2ImIudahhbZCUqwN5/stDPDcVp3XJGnb0YAnDhB/tWFvrjGikLx4ZFUM
        mi5CFso2TdSm2g39vYSCaIHDW5LGdvEQqWOtuFZagCq0NmACw/GbHXZfEbrjC2AUk+WtRf
        0gVLWmgEkgFehure7ZgAYQGEwpvYcAc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-0bi7IuLJOaaGLTxpYlv2bg-1; Sat, 15 May 2021 15:02:20 -0400
X-MC-Unique: 0bi7IuLJOaaGLTxpYlv2bg-1
Received: by mail-qk1-f200.google.com with SMTP id n142-20020a3727940000b02902fa8eadfa9eso1771569qkn.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 12:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ak4YzMd3ThrCMBkvcDEWIGdqfAk+9WtH0c1YVFOWIxc=;
        b=nFkBZ+R6P4XSpVH4oZK2aUwTeSsZbidt/IJaNPjKwfC6oKaG6IkoTIHO7//KTpWq+q
         uIP1Gw1uq9S3ncOBQMxJGLE9hKT2nu+Go1fczHj10ElpDCOX//XwSbRObijsTw1vaoii
         FRAVGijJfvc7dc3YaqJTlMu75JfLEAHWPk5uoAtv7rsJTAGnvyo1YsTHgvv7t1N6FmPp
         qadZ5Y8IDlezw6dQlRCbgoEB1xz1RJHHz7OYeEC2rtgoVA/Uawwj961haIxrcWn9mO9y
         WpX309S2s2z3ZsbEhJ+TA6lGXXJVCrVA65/qiMtUMcaM6mBoae7JspNhy0rRb6egq2Aa
         hvsg==
X-Gm-Message-State: AOAM533ENXTIWtL9LzQxJwgZbj/940omcAcTUPV/LNuLr/jdj/mI8WW5
        KiGry99cN19LB2cpKZ3bzdD9223T/obkHvTNK0a948WVQiZiRuKM9FrVKhyme/QVMRKTg7xXQ16
        SOxC7MepXwfnMeDL5Lqh+IBDCvni4a9lbSx21klJ9q/Q9LdNaaYbJZ0eu9QGziXYklU4aSrBe
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr52438854qva.41.1621105339636;
        Sat, 15 May 2021 12:02:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqmV4G1t80slyl2t75x+/jUZO9PjefR85XoWDx0cJP2O8rtq7qlKsggDYsQRPjg+daixxtCg==
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr52438825qva.41.1621105339326;
        Sat, 15 May 2021 12:02:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q185sm6855309qkd.69.2021.05.15.12.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 12:02:18 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/mutex: clear MUTEX_FLAGS if wait_list is empty
 due to signal
To:     qiang.zhang@windriver.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210515023010.102985-1-qiang.zhang@windriver.com>
Message-ID: <5507033a-9815-3b2f-a93b-88fe924473e6@redhat.com>
Date:   Sat, 15 May 2021 15:02:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210515023010.102985-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 10:30 PM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
>
> Clear MUTEX_FLAGS when call mutex_lock_interruptible()
> interrupted by a signal and the lock->wait_list is empty.
>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>   kernel/locking/mutex.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index cb6b112ce155..4ac354ca092b 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -1081,6 +1081,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   err:
>   	__set_current_state(TASK_RUNNING);
>   	mutex_remove_waiter(lock, &waiter, current);
> +	if (likely(list_empty(&lock->wait_list)))
> +		__mutex_clear_flag(lock, MUTEX_FLAGS);
>   err_early_kill:
>   	spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);

I can see that the error path is missing the flag clearing code. As 
Peter had said, you have to be more clear of what problem you are trying 
to fix. Do you have any reproducer? How often do you see this kind of 
problem?

Cheers,
Longman


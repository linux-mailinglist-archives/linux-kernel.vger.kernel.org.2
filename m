Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB937ED21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbhELUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243909AbhELS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:57:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A2C061351
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:55:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v5so17232862edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l7bWInGcVI/26yfA/vnejw5BYKhWxrtGfh6mEKo1dk4=;
        b=VwxWfvAtwu8QGuwEOsPyo5tUwFGfky7CC3qTOPBGMLrnGr8CrCKtEcPmiA19PZnuu3
         1rQhGhChLTaEJDGARfebrWnNQZ3Xm+NMRS88JdC8H4cXBCBzCwOkxjEPCkqfZdamTbsw
         Hdm2L0KbclM9YDw+lszvsHGLgYnEJ7+a5TduwdoNzoyAnbE8ev4v/kzp+sVtcnD81g+Y
         pjJwfLRaYlPpZcRHFOOsEX5TyiBCHadn9GZswkPGOdbHF3q3gdI1xj020PqUJHCURv2H
         LzLUa3bI6D4RHdPN9AuNHRzDj+ambRqNOEx7zSEtb+KQU6f5ey+w1oX3wxsuDShc7ts9
         UBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l7bWInGcVI/26yfA/vnejw5BYKhWxrtGfh6mEKo1dk4=;
        b=oXzHplPykKbnttBdysM9kPBDu26n3cqs9mcGwjMvDMB5iw1+/clTOr7pztHq6mLUMU
         RHm2D2R6YTMjJbeFOq4rn2TfTCd1JPr7Gt4XX8NnSgjRYCIImv40hmQSoOX8DOoI1Ph+
         zzTUPjZSk5PUm4NrIvElf5iE2DWWVQ75PoHR9H76c89EZVt1QKA2KWtUx6v6r7MtwzCH
         yLnrAlp2SBux1PohQdqLv3iV3iMDp/PB6JuQh45lN+8RgQmzO5irEKq0BZcZEp98NEI6
         lWehWfcVqhvqEWLhbsZWfauyMA+ysmbXkRAUgKYj1E1Ov6kUd3a00/UsvDTde3GvUHSy
         RtNA==
X-Gm-Message-State: AOAM533c1JDNYGEwTvCHZgBxM78fsDO3FaWTTyqJXpBdPaNkgsJpaHSM
        AF+SzlPYiY3gMpdLrP6j2kTT9g==
X-Google-Smtp-Source: ABdhPJxrvFtffWSRR0Y6KSUy9mc/olLDqp/fCUFLUSfH8M8sBVIeQWpCqoujUNGe2dEzFTCBD436Dg==
X-Received: by 2002:aa7:c749:: with SMTP id c9mr5334269eds.65.1620845716390;
        Wed, 12 May 2021 11:55:16 -0700 (PDT)
Received: from localhost.localdomain (p200300d997048700813060682b44a2a4.dip0.t-ipconnect.de. [2003:d9:9704:8700:8130:6068:2b44:a2a4])
        by smtp.googlemail.com with ESMTPSA id jw9sm378268ejc.48.2021.05.12.11.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 11:55:15 -0700 (PDT)
Subject: Re: [PATCH v4] ipc/mqueue, msg, sem: Avoid relying on a stack
 reference past its expiry
To:     Varad Gautam <varad.gautam@suse.com>, linux-kernel@vger.kernel.org
Cc:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20210510102950.12551-1-varad.gautam@suse.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <d1360f03-40ef-7930-e8af-9a3c77fdb5de@colorfullife.com>
Date:   Wed, 12 May 2021 20:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510102950.12551-1-varad.gautam@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Varad,

On 5/10/21 12:29 PM, Varad Gautam wrote:
> do_mq_timedreceive calls wq_sleep with a stack local address. The
> sender (do_mq_timedsend) uses this address to later call
> pipelined_send.
>
> This leads to a very hard to trigger race where a do_mq_timedreceive call
> might return and leave do_mq_timedsend to rely on an invalid address,
> causing the following crash:
[...]
> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
> Fixes: 8116b54e7e23ef ("ipc/sem.c: document and update memory barriers")
> Fixes: 0d97a82ba830d8 ("ipc/msg.c: update and document memory barriers")
> Signed-off-by: Varad Gautam <varad.gautam@suse.com>
> Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> ---
> v2: Call wake_q_add before smp_store_release, instead of using a
>      get_task_struct/wake_q_add_safe combination across
>      smp_store_release. (Davidlohr Bueso)
> v3: Comment/commit message fixup.
> v4: - v2 / v3 have potential for introducing lost wakeups. Return to v1
>      as the path-of-least-surprises to fix the race at hand.
>      - Also fix ipc/msg.c and ipc/sem.c which have the same usage
>      pattern.(Manfred Spraul)
>
Acked-by: Manfred Spraul <manfred@colorfullife.com>

I would recommend that you add cc:stable. The patch is obvious, and it 
is a bugfix.

>   
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f6c30a85dadf..7d9c06b0ad6e 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -784,12 +784,14 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>   static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
>   					     struct wake_q_head *wake_q)
>   {
> -	get_task_struct(q->sleeper);
> +	struct task_struct *sleeper;
> +
> +	sleeper = get_task_struct(q->sleeper);
>   
>   	/* see SEM_BARRIER_2 for purpuse/pairing */

This collides with a spelling correction.
s/purpuse/purpose/ required.


--

     Manfred


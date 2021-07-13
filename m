Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34063C77A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhGMUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhGMUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626206647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMwwo9Z03P1xPmlSAjlgboxWwQXBeQH9rvnZzFcM2hw=;
        b=FG+NFvGDhjtvyBsxjBwlXvaCNwjcRSPVv4x9fDYwXJgMS7fUWBlJ5Z8XClthVdz+StYH5b
        nld0PK8OYpCB08OwAiYZxFwgLwFLxs9tZXDuDJ76bnD/Uny+Nr11L4NhUsEB6Z39nKBs+n
        DmrMs3JzFSD6cZp4GACWyY2iWJ1XggQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-sHvR1TVoPs6Z5SbJ6dWOoQ-1; Tue, 13 Jul 2021 16:04:06 -0400
X-MC-Unique: sHvR1TVoPs6Z5SbJ6dWOoQ-1
Received: by mail-qv1-f69.google.com with SMTP id u40-20020a0cb9280000b0290290c3a9f6f1so18451056qvf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MMwwo9Z03P1xPmlSAjlgboxWwQXBeQH9rvnZzFcM2hw=;
        b=QeLJCUVDFz0X3wVXEmWpr/A0xxh/SnkJaCA5Fe04dKEO4TKBnsPdldWKtW975bFbRc
         Bf32wbfd2/aL7Ms6xtzzzYbyY0zYigPAo+4o87d52tQqcSe6AHZWfPRe4XkeXnodS4k+
         tTzafjv4fd3ieMU1Xe0BQ8+NyYEJgVT/BGxf1NKjHDXnwrq1fdDX5vW2VVxspAZ5S46/
         6Y2ArJGL6CoetkjbSsjWuXiHIovermDlAjIR3MgR8BMPayqgy80VPrgRqweBaeuOxXsm
         wNB1MwYDNBdVqLyVKhzmyn7VCXMt4dP4SarPIrGt+sn/RaX0t4Nvdi7E4ggpteJXpjnq
         qk2w==
X-Gm-Message-State: AOAM532NhKzfZHEEIilb1GEAlvOHQLblDhhWCECpct46pkdntKRcKCLR
        KUfxeDRH9AmetcS2AJfBGK/whtYf2/aya+Wyk8w2ixVbMMrMOIr6wDA0WQtij377pv3rh39pc0c
        0Kl96PKXQAe/hoYyhvASvqARw
X-Received: by 2002:a37:7841:: with SMTP id t62mr6079964qkc.412.1626206645633;
        Tue, 13 Jul 2021 13:04:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuma4CEImTLJP0gtEzN65QBChv5GVjLLtrbwUWKC2R5DQb1PvucdjgmENwTwAM2E1tuvJsyQ==
X-Received: by 2002:a37:7841:: with SMTP id t62mr6079941qkc.412.1626206645454;
        Tue, 13 Jul 2021 13:04:05 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o13sm7351469qti.84.2021.07.13.13.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 13:04:05 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 04/50] sched: Rework the __schedule() preempt argument
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160746.314640213@linutronix.de>
Message-ID: <b079e04a-c3f9-af01-91c3-91e952f0bf6d@redhat.com>
Date:   Tue, 13 Jul 2021 16:04:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713160746.314640213@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 11:10 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> PREEMPT_RT needs to hand a special state into __schedule() when a task
> blocks on a 'sleeping' spin/rwlock. This is required to handle
> rcu_note_context_switch() correctly without having special casing in the
> RCU code. From an RCU point of view the blocking on the sleeping spinlock
> is equivalent to preemption because the task might be in a read side
> critical section.
>
> schedule_debug() also has a check which would trigger with the !preempt
> case, but that could be handled differently.
>
> To avoid adding another argument and extra checks which cannot be optimized
> out by the compiler the following solution has been chosen:
>
>   - Replace the boolean 'preempt' argument with an unsigned integer
>     'sched_mode' argument and define constants to hand in:
>     (0 == No preemption, 1 = preemption).
>
>   - Add two masks to apply on that mode one for the debug/rcu invocations
>     and one for the actual scheduling decision.
>
>     For a non RT kernel these masks are UINT_MAX, i.e. all bits are set
>     which allows the compiler to optimze the AND operation out because it is
>     not masking out anything. IOW, it's not different from the boolean.
>
>     RT enabled kernels will define these masks seperately.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/sched/core.c |   36 +++++++++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 11 deletions(-)
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5822,6 +5822,20 @@ pick_next_task(struct rq *rq, struct tas
>   #endif /* CONFIG_SCHED_CORE */
>   
>   /*
> + * Constants for the sched_mode argument of __schedule().
> + *
> + * The mode argument allows RT enabled kernels to differentiate a
> + * preemption from blocking on an 'sleeping' spin/rwlock by having seperate
> + * mask values for SM_MASK_PREEMPT and SM_MASK_STATE while on a non RT
> + * enabled kernel the masks have all bits set which allows the compiler to
> + * optimize the AND operation out.
> + */
> +#define	SM_NONE			0x0
> +#define	SM_PREEMPT		0x1
> +#define SM_MASK_PREEMPT		UINT_MAX
> +#define SM_MASK_STATE		SM_MASK_PREEMPT

Nit: Inconsistent use of space/tab after #define.

Cheers,
Longman



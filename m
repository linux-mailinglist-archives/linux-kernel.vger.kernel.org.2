Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63FA3C7785
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhGMTzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhGMTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626205936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPHSvGkDiMMPXIFplHP8bLAISSbph/BRAundHlvbEtM=;
        b=M20CxwSZMBWAO9gBbt7ZWNlrGbsBp/oiWDmfbxzhuIzw41yApWZzZMepPhTMLmpnL/hICI
        dC2k2mxWngS3b1M2ROFUC047OsQyfnKZ/4vHCnazyKKNA/JUqh+ks3uHfKrjLfyxKohajV
        CE50Jqv6AzUsVvUZSaKYbFCO1t1DVpk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Jtqf9OMrOyehOhD-Tnwe7w-1; Tue, 13 Jul 2021 15:52:15 -0400
X-MC-Unique: Jtqf9OMrOyehOhD-Tnwe7w-1
Received: by mail-qv1-f72.google.com with SMTP id d10-20020a0ce44a0000b02902c99dfad03fso18514004qvm.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MPHSvGkDiMMPXIFplHP8bLAISSbph/BRAundHlvbEtM=;
        b=kF/rkPLBfkh46Bdort+3FZCYa1fHop2cm/ZoJdUZmIGxptrF81xB7r7u4msVv1vdKY
         YnDoiE7hjkuUQ1DJ9DQynFQ2or79lblxEvoVn2OQqZyVdZqPQ61udZnP9fDr8a1SBfnN
         /Jd1VEleFI7USLx5otHv2CZ36nyT775wtiyZOOUqNkkeaI2lzy/tFWFnQI1jlwBTv5qX
         MKNVV5DQAg8r1ke4sQTZoBlM2OagER2mY2KVO5ucdHQ7d0ErMvHTmrd0WQn7KUE0nFFv
         H3VAx24hlOu+AGbdQiTr0QBMNV3M2W2l+UTnCyeMYF8dUqj2vNkax7NTzsGLZnAAzU7R
         0lIg==
X-Gm-Message-State: AOAM533sJRk9doSuqeGe8YxBThS4+c4mSy6tmx2A9Tt0+8Rl2Z4fc2En
        3jBl8Q1hRJwf8Ic8Z0LyOZcnFAqrb+ZdM5c8cWwnhMoZy3MovZUJ/MmjTIFuCcwYF5HD9EtGJU9
        qCD6iWzV7Lta2NACMfNPcPq6z
X-Received: by 2002:a0c:f808:: with SMTP id r8mr1598616qvn.10.1626205934517;
        Tue, 13 Jul 2021 12:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3OVAA7ldrVchEKoknI9/pSdMiFA8g29AAH20BPMbRJ4hBcriAUJyLSujTyFT9feZKgDaFmg==
X-Received: by 2002:a0c:f808:: with SMTP id r8mr1598590qvn.10.1626205934220;
        Tue, 13 Jul 2021 12:52:14 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id g15sm8384799qkl.104.2021.07.13.12.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:52:13 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 03/50] sched: Prepare for RT sleeping spin/rwlocks
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
 <20210713160746.207208684@linutronix.de>
Message-ID: <eff38e55-dd1b-8dc5-0125-c8f88a43ae64@redhat.com>
Date:   Tue, 13 Jul 2021 15:52:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713160746.207208684@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 11:10 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
> preserving. Any wakeup which matches the state is valid.
>
> RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
> an issue vs. task::state.
>
> In order to block on the lock the task has to overwrite task::state and a
> consecutive wakeup issued by the unlocker sets the state back to
> TASK_RUNNING. As a consequence the task loses the state which was set
> before the lock acquire and also any regular wakeup targeted at the task
> while it is blocked on the lock.
>
> To handle this gracefully add a 'saved_state' member to task_struct which
> is used in the following way:
>
>   1) When a task blocks on a 'sleeping' spinlock, the current state is saved
>      in task::saved_state before it is set to TASK_RTLOCK_WAIT.
>
>   2) When the task unblocks and after acquiring the lock, it restores the saved
>      state.
>
>   3) When a regular wakeup happens for a task while it is blocked then the
>      state change of that wakeup is redirected to operate on task::saved_state.
>
>      This is also required when the task state is running because the task
>      might have been woken up from the lock wait and has not yet restored
>      the saved state.
>
> To make it complete provide the necessary helpers to save and restore the
> saved state along with the necessary documentation how the RT lock blocking
> is supposed to work.
>
> For non-RT kernels there is no functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/sched.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/core.c   |   33 +++++++++++++++++++++++
>   2 files changed, 103 insertions(+)
> ---
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -155,6 +155,27 @@ struct task_group;
>   		WRITE_ONCE(current->__state, (state_value));		\
>   		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
>   	} while (0)
> +
> +
> +#define current_save_and_set_rtlock_wait_state()			\
> +	do {								\
> +		raw_spin_lock(&current->pi_lock);			\
> +		current->saved_state = current->__state;		\
> +		current->saved_state_change = current->task_state_change;\
> +		current->task_state_change = _THIS_IP_;			\
> +		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
> +		raw_spin_unlock(&current->pi_lock);			\
> +	} while (0);
> +
> +#define current_restore_rtlock_saved_state()				\
> +	do {								\
> +		raw_spin_lock(&current->pi_lock);			\
> +		current->task_state_change = current->saved_state_change;\
> +		WRITE_ONCE(current->__state, current->saved_state);	\
> +		current->saved_state = TASK_RUNNING;			\
> +		raw_spin_unlock(&current->pi_lock);			\
> +	} while (0);
> +
>   #else
>   /*
>    * set_current_state() includes a barrier so that the write of current->state
> @@ -213,6 +234,47 @@ struct task_group;
>   		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
>   	} while (0)
>   
> +/*
> + * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
> + *
> + * RT's spin/rwlock substitutions are state preserving. The state of the
> + * task when blocking on the lock is saved in task_struct::saved_state and
> + * restored after the lock has been acquired.  These operations are
> + * serialized by task_struct::pi_lock against try_to_wake_up(). Any non RT
> + * lock related wakeups while the task is blocked on the lock are
> + * redirected to operate on task_struct::saved_state to ensure that these
> + * are not dropped. On restore task_struct::saved_state is set to
> + * TASK_RUNNING so any wakeup attempt redirected to saved_state will fail.
> + *
> + * The lock operation looks like this:
> + *
> + *	current_save_and_set_rtlock_wait_state();
> + *	for (;;) {
> + *		if (try_lock())
> + *			break;
> + *		raw_spin_unlock_irq(&lock->wait_lock);
> + *		schedule_rtlock();
> + *		raw_spin_lock_irq(&lock->wait_lock);
> + *		set_current_state(TASK_RTLOCK_WAIT);
> + *	}
> + *	current_restore_rtlock_saved_state();
> + */
> +#define current_save_and_set_rtlock_wait_state()			\
> +	do {								\
> +		raw_spin_lock(&current->pi_lock);			\
> +		current->saved_state = current->state;			\
> +		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
> +		raw_spin_unlock(&current->pi_lock);			\
> +	} while (0);
> +
> +#define current_restore_rtlock_saved_state()				\
> +	do {								\
> +		raw_spin_lock(&current->pi_lock);			\
> +		WRITE_ONCE(current->__state, current->saved_state);	\
> +		current->saved_state = TASK_RUNNING;			\
> +		raw_spin_unlock(&current->pi_lock);			\
> +	} while (0);
> +
>   #endif
>   

The difference between the 2 versions of 
current_save_and_set_rtlock_wait_state() is just the handling of 
current->saved_state_change. I think it will be cleaner to add helper 
macros to just save and restore saved_state_change and break out 
current_save_and_set_rtlock_wait_state() and 
current_restore_rtlock_saved_state() into its own block. They can also 
be put under CONFIG_PREEMPT_RT with an alternate null implementations so 
that they can be used outside of CONFIG_PREEMPT_RT conditional block.

Cheers,
Longman



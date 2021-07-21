Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249AC3D0A41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhGUHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234363AbhGUHVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626854548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uh86klSvWJeXWjuC8u4ShkXNhr7jcN9emlcyDr3ARaM=;
        b=Lg/kFOTSS68/vqF+lKhi0DGajBj9ViG0WGHN6EVOhKWV5yz2TLYIsVFllmv8ojC55sQL9T
        YAD/dBCJMNMtNRzkTIS7Ml/KccOMa7xoDzbfPRLg3gPSbLMD5J+Gw/eMLRDPCrQtsTU2ZE
        mbgdxVNL5TQhw51IHaLZbzl+QEJTyvE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-zt3tRAn3MGao0sUUvjzZew-1; Wed, 21 Jul 2021 04:02:22 -0400
X-MC-Unique: zt3tRAn3MGao0sUUvjzZew-1
Received: by mail-wr1-f69.google.com with SMTP id t8-20020a05600001c8b029013e2027cf9aso614584wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uh86klSvWJeXWjuC8u4ShkXNhr7jcN9emlcyDr3ARaM=;
        b=W85XfpUzXLdqGGl/m3/YbCmAlzWNdGIWHMjpk1bQM6OIPIKPhcacLK4gzIZy/y+IhG
         uGyqVvcVKxpw1fSvxNWXPHhH8ORGZsexEOqfsc5o/ZJjopF2+dvRYXEKicPxlp2emo2F
         /GgMXr2402bDdS13QW4zm+MJD0vGf+LjY479j6/wGCn0fxmv96Apu0L9GpjrCmdrXhjn
         exyCVxyAdPInHPg4xPJtWkSeTXabtwwrUrykG+/Zb674OM0Y7+/w0F/GwYEbqZofDfkf
         J87dUe62z1OqVc9poTLsNq6F/0ND+7KsqZO0qQwCqkDyY3iMFNEuzDUF4znlPIZiYm9B
         5uRg==
X-Gm-Message-State: AOAM532aZPcmc2L7bY+qYqxkZnw0b9Vf6P5Oa5ndj1qHgSZNuzBlTJSn
        P6CIleQU0umYBt59XY+5WtnJ46rZX0e6osZScAv1Qt23IfUOsso0KST9Wzq9yw4geSdT7lEuLqM
        vH8FzRUHVJdr0Tnw0gUtbh0gx
X-Received: by 2002:a05:600c:3593:: with SMTP id p19mr35390642wmq.33.1626854541011;
        Wed, 21 Jul 2021 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3wuhejTcrsCykLyKIBVHs6iXl5oh0x4VtsCQdeJ+1w2jg9+s3DJGo9yEmZib5OwfCyapJrA==
X-Received: by 2002:a05:600c:3593:: with SMTP id p19mr35390619wmq.33.1626854540729;
        Wed, 21 Jul 2021 01:02:20 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c3.dip0.t-ipconnect.de. [91.12.101.195])
        by smtp.gmail.com with ESMTPSA id o18sm889881wmh.0.2021.07.21.01.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 01:02:20 -0700 (PDT)
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210718214134.2619099-1-surenb@google.com>
 <20210718214134.2619099-2-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] mm: introduce process_mrelease system call
Message-ID: <6ab82426-ddbd-7937-3334-468f16ceedab@redhat.com>
Date:   Wed, 21 Jul 2021 10:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718214134.2619099-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.21 23:41, Suren Baghdasaryan wrote:
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
> 
> Previously I proposed a number of alternatives to accomplish this:
> - https://lore.kernel.org/patchwork/patch/1060407 extending
> pidfd_send_signal to allow memory reaping using oom_reaper thread;
> - https://lore.kernel.org/patchwork/patch/1338196 extending
> pidfd_send_signal to reap memory of the target process synchronously from
> the context of the caller;
> - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> support for process_madvise implementing synchronous memory reaping.

To me, this looks a lot cleaner. Although I do wonder why we need two 
separate mechanisms to achieve the end goal

1. send sigkill
2. process_mrelease

As 2. doesn't make sense without 1. it somehow feels like it would be 
optimal to achieve both steps in a single syscall. But I remember there 
were discussions around that.

> 
> The end of the last discussion culminated with suggestion to introduce a
> dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> The reasoning was that the new variant of process_madvise
>    a) does not work on an address range
>    b) is destructive
>    c) doesn't share much code at all with the rest of process_madvise
>  From the userspace point of view it was awkward and inconvenient to provide
> memory range for this operation that operates on the entire address space.
> Using special flags or address values to specify the entire address space
> was too hacky.
> 
> The API is as follows,
> 
>            int process_mrelease(int pidfd, unsigned int flags);
> 
>          DESCRIPTION
>            The process_mrelease() system call is used to free the memory of
>            a process which was sent a SIGKILL signal.
> 
>            The pidfd selects the process referred to by the PID file
>            descriptor.
>            (See pidofd_open(2) for further information)
> 
>            The flags argument is reserved for future use; currently, this
>            argument must be specified as 0.
> 
>          RETURN VALUE
>            On success, process_mrelease() returns 0. On error, -1 is
>            returned and errno is set to indicate the error.
> 
>          ERRORS
>            EBADF  pidfd is not a valid PID file descriptor.
> 
>            EAGAIN Failed to release part of the address space.
> 
>            EINVAL flags is not 0.
> 
>            EINVAL The task does not have a pending SIGKILL or its memory is
>                   shared with another process with no pending SIGKILL.
> 
>            ENOSYS This system call is not supported by kernels built with no
>                   MMU support (CONFIG_MMU=n).
> 
>            ESRCH  The target process does not exist (i.e., it has terminated
>                   and been waited on).
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   mm/oom_kill.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index d04a13dc9fde..7fbfa70d4e97 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -28,6 +28,7 @@
>   #include <linux/sched/task.h>
>   #include <linux/sched/debug.h>
>   #include <linux/swap.h>
> +#include <linux/syscalls.h>
>   #include <linux/timex.h>
>   #include <linux/jiffies.h>
>   #include <linux/cpuset.h>
> @@ -755,10 +756,64 @@ static int __init oom_init(void)
>   	return 0;
>   }
>   subsys_initcall(oom_init)
> +
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +	struct pid *pid;
> +	struct task_struct *task;
> +	struct mm_struct *mm = NULL;
> +	unsigned int f_flags;
> +	long ret = 0;

Nit: reverse Christmas tree.

> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +
> +	/*
> +	 * If the task is dying and in the process of releasing its memory
> +	 * then get its mm.
> +	 */
> +	task_lock(task);
> +	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> +		mm = task->mm;
> +		mmget(mm);
> +	}

AFAIU, while holding the task_lock, task->mm won't change and we cannot 
see a concurrent exit_mm()->mmput(). So the mm structure and the VMAs 
won't go away while holding the task_lock(). I do wonder if we need the 
mmget() at all here.

Also, I wonder if it would be worth dropping the task_lock() while 
reaping - to unblock anybody else wanting to lock the task. Getting a 
hold of the mm and locking the mmap_lock would be sufficient I guess.


In general, looks quite good to me.

-- 
Thanks,

David / dhildenb


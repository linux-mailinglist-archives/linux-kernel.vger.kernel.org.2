Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FDC42227F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhJEJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233472AbhJEJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633426716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2ablajv2gCgBYeJPHEpMUrKIOVkNd+b3atjbSFrddc=;
        b=JZY5f0h9QOvA9nzVeNAjm90Q9Wn6IXulYPD81UPvfSWVNI4AB46NSudfd2BXvVkSPS7tS+
        A3rHiZtA9Cbyl0tWdfgyGaApOwBKYWB+Vq6Wqn3Bv6myunTUucyyp5FsnIe5t7uf+kawt2
        wocBuQqReotixbdUCcZqmLfDb7lgk6E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-WqZ4gM_zMPCJraNKzfXDGA-1; Tue, 05 Oct 2021 05:38:35 -0400
X-MC-Unique: WqZ4gM_zMPCJraNKzfXDGA-1
Received: by mail-ed1-f70.google.com with SMTP id k2-20020a50ce42000000b003dadf140b15so8388060edj.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n2ablajv2gCgBYeJPHEpMUrKIOVkNd+b3atjbSFrddc=;
        b=05+1m0DKzSGCf6d+TaNdDXUzxEQEXbkh9ULSdme3NhwVkrkXKZUKUrIK0Q4JHbO9lV
         DDhcNDQ5aTRxsGt9b+gudDb67/hS3duTTDfTn59IHYgDeUD2NhXOPR8tHyaoEZ9F/bfe
         W5VOYM+pPnHxKi3ZTdMYZRuDXecViLpV5V63CCgFvUMnT4D/9f0+ec7TPCQFCe1hJrZ/
         fI7vFic54iLvV1fMzFEvqky7+PcsT1qXg7F59SqlUwfoOXYZdwEAGvE9dlhBv4uKXJRr
         rH1DJxxV0xuTnJHhCDMlzagr3qskgTPCqxeKryZZlaY6eu6j0bqo1DGh3Ui0EZfdsgCp
         MOcQ==
X-Gm-Message-State: AOAM53320t2inYqru7BgDjlAjyIafLOK71OS0Nz28uc0QZq6j67Awafl
        ilK78wB3jTJCo+tK73PyaYQk9V124tBHIBa2NiVbvKh1WiZ40w+wUIKJdto8lErs+k3pPKsQJ/0
        DbcNl27k8mw4Wy4zMuMWu/j/y
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr25080409edc.14.1633426714366;
        Tue, 05 Oct 2021 02:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK+KMnSyUT3I651YmFN7W2jovRftriuXTNGSfTjg/rZz3ZiIye/SpfUhktb5wXtw619xAHhA==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr25080386edc.14.1633426714120;
        Tue, 05 Oct 2021 02:38:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id bt24sm7563604ejb.77.2021.10.05.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 02:38:33 -0700 (PDT)
Message-ID: <e734691b-e9e1-10a0-88ee-73d8fceb50f9@redhat.com>
Date:   Tue, 5 Oct 2021 11:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v1] KVM: isolation: retain initial mask for kthread VM
 worker
Content-Language: en-US
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com, mtosatti@redhat.com,
        tglx@linutronix.de, frederic@kernel.org, mingo@kernel.org,
        nilal@redhat.com, Wanpeng Li <kernellwp@gmail.com>
References: <20211004222639.239209-1-nitesh@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211004222639.239209-1-nitesh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Wanpeng]

On 05/10/21 00:26, Nitesh Narayan Lal wrote:
> From: Marcelo Tosatti <mtosatti@redhat.com>
> 
> kvm_vm_worker_thread() creates a kthread VM worker and migrates it
> to the parent cgroup using cgroup_attach_task_all() based on its
> effective cpumask.
> 
> In an environment that is booted with the nohz_full kernel option, cgroup's
> effective cpumask can also include CPUs running in nohz_full mode. These
> CPUs often run SCHED_FIFO tasks which may result in the starvation of the
> VM worker if it has been migrated to one of these CPUs.

There are other effects of cgroups (e.g. memory accounting) than just 
the cpumask; for v1 you could just skip the cpuset, but if 
cgroup_attach_task_all is ever ported to v2's cgroup_attach_task, we 
will not be able to separate the cpuset cgroup from the others.

Why doesn't the scheduler move the task to a CPU that is not being 
hogged by vCPU SCHED_FIFO tasks?  The parent cgroup should always have 
one for userspace's own housekeeping.

As an aside, if we decide that KVM's worker threads count as 
housekeeping, you'd still want to bind the kthread to the housekeeping 
CPUs(*).

Paolo

(*) switching from kthread_run to kthread_create+kthread_bind_mask

> Since unbounded kernel threads allowed CPU mask already respects nohz_full
> CPUs at the time of their setup (because of 9cc5b8656892: "isolcpus: Affine
> unbound kernel threads to housekeeping cpus"), retain the initial CPU mask
> for the kthread by stopping its migration to the parent cgroup's effective
> CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>   virt/kvm/kvm_main.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7851f3a1b5f7..87bc193fd020 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -56,6 +56,7 @@
>   #include <asm/processor.h>
>   #include <asm/ioctl.h>
>   #include <linux/uaccess.h>
> +#include <linux/sched/isolation.h>
>   
>   #include "coalesced_mmio.h"
>   #include "async_pf.h"
> @@ -5634,11 +5635,20 @@ static int kvm_vm_worker_thread(void *context)
>   	if (err)
>   		goto init_complete;
>   
> -	err = cgroup_attach_task_all(init_context->parent, current);
> -	if (err) {
> -		kvm_err("%s: cgroup_attach_task_all failed with err %d\n",
> -			__func__, err);
> -		goto init_complete;
> +	/*
> +	 * For nohz_full enabled environments, don't migrate the worker thread
> +	 * to parent cgroup as its effective mask may have a CPU running in
> +	 * nohz_full mode. nohz_full CPUs often run SCHED_FIFO task which could
> +	 * result in starvation of the worker thread if it is pinned on the same
> +	 * CPU.
> +	 */
> +	if (!housekeeping_enabled(HK_FLAG_KTHREAD)) {
> +		err = cgroup_attach_task_all(init_context->parent, current);
> +		if (err) {
> +			kvm_err("%s: cgroup_attach_task_all failed with err %d\n",
> +				__func__, err);
> +			goto init_complete;
> +		}
>   	}
>   
>   	set_user_nice(current, task_nice(init_context->parent));
> 


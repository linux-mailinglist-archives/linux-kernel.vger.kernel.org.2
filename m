Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC93F42284F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhJENvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234274AbhJENvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633441797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwRUK5QQPWeF1trrs+wsxCyXJhcpX/CxoItjVPGldec=;
        b=PRGbZCbzMcFOi+fGoLF/axb2SgsjO6eSGjNe5Y+zVl4GSlrd5DNqBm2Xbh3iWD2F2NG5Hf
        shUAZyAd32o0yZHB7iNTLIc9JHM/F7Q2QFcBz4ST+dc7ggIytVzWQU9u5g0+bJDxZ1rcQR
        58H4gSw9NNR0bdjznlgbGlvsrhUf0zg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-vCvt23nVNgSvAGL_de4iRg-1; Tue, 05 Oct 2021 09:49:56 -0400
X-MC-Unique: vCvt23nVNgSvAGL_de4iRg-1
Received: by mail-lf1-f71.google.com with SMTP id x29-20020ac259dd000000b003f950c726e1so9003911lfn.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwRUK5QQPWeF1trrs+wsxCyXJhcpX/CxoItjVPGldec=;
        b=ZuvCHKW8eV+bA8IVYFGDe8CnY3/8Em1Gg7FrJKXYM04G9YK0gK7mNbBgwjqPs/34mt
         YXr+N5ev0cuKTn8oDKpQmKJAeHe9DNK9EFdYN6lkWYSJAhO7YuORDnIJU1AcZep7Bf4I
         ThkNcw+TRWCSrIKmEQhQBfoakofstD5BZfE1SxR1MatFhmpvcOpmOlcn8A+dm7JexKxT
         Jf21VBArx7dFPLtv6KEza/NCj7f/n7fz8u6r1eLddYPvtGiQnr4/SNuwkrYPvHu4Cg7n
         RyUsyLrwvQ8Iuf5Xn/xrWA/GBNRm8027ZnA267hOsNjVmQWG5iTPs7jWg+hNJKExO4Vy
         k9Lg==
X-Gm-Message-State: AOAM531HQy3LxTmpvD7eZhKDo9NwEjaTTs5+8rEGXehiJYx+/g9Ug2a3
        uinwFL8rJ8T3DzhTAUHas0cw/uhIFqQkxVFPHzYCwX2ht5L5KJJcy10gawRW9ybWB7VHyjR15jR
        jx1cydCuqJqvvWwSOoh99vdIGZUP4fF4rHluAR6K1
X-Received: by 2002:a2e:978a:: with SMTP id y10mr22201373lji.317.1633441795114;
        Tue, 05 Oct 2021 06:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTSOKxo8w5tu1zRnqUEtSRVav6LKD5IoSfTUbcxbGCkSh6Fdwm9ShQmWQsDK/EbuKsGt3x0bh9Xr9XmV9fZJA=
X-Received: by 2002:a2e:978a:: with SMTP id y10mr22201346lji.317.1633441794875;
 Tue, 05 Oct 2021 06:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211004222639.239209-1-nitesh@redhat.com> <e734691b-e9e1-10a0-88ee-73d8fceb50f9@redhat.com>
 <20211005105812.GA130626@fuller.cnet> <96f38a69-2ff8-a78c-a417-d32f1eb742be@redhat.com>
 <20211005132159.GA134926@fuller.cnet>
In-Reply-To: <20211005132159.GA134926@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Tue, 5 Oct 2021 09:49:43 -0400
Message-ID: <CAFki+LmR9bL67D9+dim25J8w3N71eA_BkNcNi3_dEmAB-J553A@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: isolation: retain initial mask for kthread VM worker
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 9:22 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Tue, Oct 05, 2021 at 01:25:52PM +0200, Paolo Bonzini wrote:
> > On 05/10/21 12:58, Marcelo Tosatti wrote:
> > > > There are other effects of cgroups (e.g. memory accounting) than just the
> > > > cpumask;
> > >
> > > Is kvm-nx-hpage using significant amounts of memory?
> >
> > No, that was just an example (and not a good one indeed, because
> > kvm-nx-hpage is not using a substantial amount of either memory or CPU).
> > But for example vhost also uses cgroup_attach_task_all, so it should have
> > the same issue with SCHED_FIFO?
>
> Yes. Would need to fix vhost as well.
>
> >
> > > > Why doesn't the scheduler move the task to a CPU that is not being hogged by
> > > > vCPU SCHED_FIFO tasks?
> > > Because cpuset placement is enforced:
> >
> > Yes, but I would expect the parent cgroup to include both isolated CPUs (for
> > the vCPU threads) and non-isolated housekeeping vCPUs (for the QEMU I/O
> > thread).
>
> Yes, the parent, but why would that matter? If you are in a child
> cpuset, you are restricted to the child cpuset mask (and not the
> parents).

Yes, and at the time of cpuset_attach, the task is attached to any one of
the CPUs that are in the effective cpumask.

>
> > The QEMU I/O thread is not hogging the CPU 100% of the time, and
> > therefore the nx-recovery thread should be able to run on that CPU.
>
> Yes, but:
>
> 1) The cpumask of the parent thread is not inherited
>
>         set_cpus_allowed_ptr(task, housekeeping_cpumask(HK_FLAG_KTHREAD));
>
> On __kthread_create_on_node should fail (because its cgroup, the one
> inherited from QEMU, contains only isolated CPUs).
>

Just to confirm, do you mean fail only for unbounded kthreads?


-- 
Thanks
Nitesh


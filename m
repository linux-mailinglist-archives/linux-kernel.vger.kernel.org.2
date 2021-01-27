Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9935F3064C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhA0UJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhA0UJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:09:11 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:08:31 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e7so3070559ile.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qtr4/UsyDkpIQ8U8d9McR2WPMXf3/1f68QaCIUjLUM4=;
        b=n/qI9B9hkvHTblIJpBpxFCHU118DO2sb/JJFStdA9xz7u1nsgpUKyEzFerPSC4h9WU
         3hO2roxCuHrI7izOAlYY4Wi+O5+pxtIPg+gjMOUc5UW2jg8FWSyVpG6KvW6jKBY8UHWF
         r1AxjtlO67xDW1lxE+L+0yItxlVDegxkZFmcRGZQ37eFT8t3jnJnTP9pugFB1JpuBxB9
         7KN4UbBMn/ijRXV3OQJGvpKp/b7TYPTxbGnH2yy6kGJ7RVSHhfEhkAdyJsb42yJO55F7
         NSvAZ0M1c+OhrfKvNyKG5+PjQV+UH5k8MWPgkP96HMBuvMyaQI0LsI50LKETZUya7+fx
         Nvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qtr4/UsyDkpIQ8U8d9McR2WPMXf3/1f68QaCIUjLUM4=;
        b=MONnZaPUVALJlHnR71EUwXfUgdxaZJNGlh9JgfadllNB5M2DjuKRaN/OGrqzpxQRh1
         PFUy0hXNtZyLcIQNE4FBL38XpgK8rBZH51ahECVQjxpOCEMsXTZlzhDyToM1luEceS5j
         c8ShuRQtUd8DxL3T+oyoA1IPSJVB5y4bl6ePqyo2K6E9lkrrMSr+HLfg3+PPHZXtLDWB
         lFq9aMdyNMEpZRRWkp3vwS7JViuwPGHsjcB9tI0scEopsmweBwhcTB1gPN6WxGISeWRX
         hBfDIMiKIx8Or7UC4LJ8YqqgLkCx4aS9JKKS6yYY4XPFpT9zEm6esseP+XRdUrfEWcrq
         n4Tg==
X-Gm-Message-State: AOAM532AL9ABQuKZGwkgTJKs8YFm293WThhJYX/KCHaVRSKMRE1qcfeq
        ydC7gjdQuOdEgsB0P1qiZ9kgSTRYFnNUJCA+TD+xTA==
X-Google-Smtp-Source: ABdhPJz8sEIFWpW+7sSR7uXmCSqfZlQd96FlhohFXqBaHkyKDHeDSfASNlJ+QdEIK802FV1rQJz4umf3jV8DEK1cWj8=
X-Received: by 2002:a92:cbce:: with SMTP id s14mr5351480ilq.306.1611778110766;
 Wed, 27 Jan 2021 12:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-16-bgardon@google.com>
 <YAjIddUuw/SZ+7ut@google.com> <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
 <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com> <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
 <f1ef3118-2a8e-4bf2-b3b0-60ac4947e106@redhat.com>
In-Reply-To: <f1ef3118-2a8e-4bf2-b3b0-60ac4947e106@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 27 Jan 2021 12:08:19 -0800
Message-ID: <CANgfPd9FaPhQiEkJ=VHKiVWZ_5S3k2uWHU+ViCi4nEF=GU4qsw@mail.gmail.com>
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:48 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/01/21 19:11, Ben Gardon wrote:
> > When I did a strict replacement I found ~10% worse memory population
> > performance.
> > Running dirty_log_perf_test -v 96 -b 3g -i 5 with the TDP MMU
> > disabled, I got 119 sec to populate memory as the baseline and 134 sec
> > with an earlier version of this series which just replaced the
> > spinlock with an rwlock. I believe this difference is statistically
> > significant, but didn't run multiple trials.
> > I didn't take notes when profiling, but I'm pretty sure the rwlock
> > slowpath showed up a lot. This was a very high contention scenario, so
> > it's probably not indicative of real-world performance.
> > In the slow path, the rwlock is certainly slower than a spin lock.
> >
> > If the real impact doesn't seem too large, I'd be very happy to just
> > replace the spinlock.
>
> Ok, so let's use the union idea and add a "#define KVM_HAVE_MMU_RWLOCK"
> to x86.  The virt/kvm/kvm_main.c MMU notifiers functions can use the
> #define to pick between write_lock and spin_lock.

I'm not entirely sure I understand this suggestion. Are you suggesting
we'd have the spinlock and rwlock in a union in struct kvm but then
use a static define to choose which one is used by other functions? It
seems like if we're using static defines the union doesn't add value.
If we do use the union, I think the advantages offered by __weak
wrapper functions, overridden on a per-arch basis, are worthwhile.

>
> For x86 I want to switch to tdp_mmu=1 by default as soon as parallel
> page faults are in, so we can use the rwlock unconditionally and drop
> the wrappers, except possibly for some kind of kvm_mmu_lock/unlock_root
> that choose between read_lock for TDP MMU and write_lock for shadow MMU.
>
> Thanks!
>
> Paolo
>

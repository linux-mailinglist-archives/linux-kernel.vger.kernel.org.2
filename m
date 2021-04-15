Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4135FF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhDOBal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhDOBak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618450217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NuT37Vpiz4KczvJjbLuhVhLsnc1sKQ6bWyp9Fysxc0M=;
        b=SKhq/xnRzymw3OROtwY8Am/xi4wnDKFx6mlhKxf3ulA5LZ0UsKhsYL0ilIA/HsK7JbMUFM
        FfWHcbHQL1OtIZV1bfto5mYPQr+DUpRAxiBQXwK+lhCTMrVGyP275AyoSnogh9+QFPs1uK
        C5yPAWVNvZHCOLh9hrAryxbpT7ASXVM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-9jAwT0nEPPKts27nH5mKvw-1; Wed, 14 Apr 2021 21:30:16 -0400
X-MC-Unique: 9jAwT0nEPPKts27nH5mKvw-1
Received: by mail-lf1-f69.google.com with SMTP id t11-20020ac24c0b0000b02901aa03303b72so1755217lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 18:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuT37Vpiz4KczvJjbLuhVhLsnc1sKQ6bWyp9Fysxc0M=;
        b=WILkc0RkVMvf1uBRiq4dhfG//wTWzc925wAonTUJ927Jd17HhHHHYvvDGOn49bJE8L
         D+P4kxIB/TrdD88j2NAzKfnFwDQZ9AGu5PtTf4O/eEcmEAFBYCx5r8D0rhTEqet+3hU1
         Zo0Goy2fYVJee7tiN98pmSjQ9BzTKbGWlgVAtusvVT9Z4Zf/RzIla7C5cA1nH/DfS/g4
         qU1NPg/2LmnWIz+Gyq3/qQC1rbs6xDiKbNneXUgQKVzany4fZnsrD/rY8JQYtnrrsUuy
         DqjBeno4jy2huYEJyXPQpmxGv42zQkvGP5LSBqA3OkCDdG+qbdamIVB3rPxdJKg0WcI4
         GRAA==
X-Gm-Message-State: AOAM532UsbVp6HUscg4A+AXBvi+5LAfoRVBe4VZrkIW8G8UTeKmFzam8
        kgkTvicXi2nzcaloAjrpXfDAwpbBY+SkXPje1Exvsar+/Vh/CouPaoyN6C4g7n/cPyDBz6L6vzG
        yn4K3nfylplsSv8V4L/nLmjvlOWGsrQaIlnXPV9Om
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr690484lfu.16.1618450214565;
        Wed, 14 Apr 2021 18:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDYMlj20wS7v+deB0HVHfODTSDiKREGfFpV6FOtv9WxbYz6e2VspZKd9MIhgzZuDHdRBE8GCKZun9GcIddnGk=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr690469lfu.16.1618450214403;
 Wed, 14 Apr 2021 18:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de>
 <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com>
In-Reply-To: <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Thu, 15 Apr 2021 02:30:03 +0100
Message-ID: <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 3:32 AM Alexey Klimov <klimov.linux@gmail.com> wrote:
>
> On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:

[...]

Now, the patch:

>> Subject: cpu/hotplug: Cure the cpusets trainwreck
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Sat, 27 Mar 2021 15:57:29 +0100
>>
>> Alexey and Joshua tried to solve a cpusets related hotplug problem which is
>> user space visible and results in unexpected behaviour for some time after
>> a CPU has been plugged in and the corresponding uevent was delivered.
>>
>> cpusets delegate the hotplug work (rebuilding cpumasks etc.) to a
>> workqueue. This is done because the cpusets code has already a lock
>> nesting of cgroups_mutex -> cpu_hotplug_lock. A synchronous callback or
>> waiting for the work to finish with cpu_hotplug_lock held can and will
>> deadlock because that results in the reverse lock order.
>>
>> As a consequence the uevent can be delivered before cpusets have consistent
>> state which means that a user space invocation of sched_setaffinity() to
>> move a task to the plugged CPU fails up to the point where the scheduled
>> work has been processed.
>>
>> The same is true for CPU unplug, but that does not create user observable
>> failure (yet).
>>
>> It's still inconsistent to claim that an operation is finished before it
>> actually is and that's the real issue at hand. uevents just make it
>> reliably observable.
>>
>> Obviously the problem should be fixed in cpusets/cgroups, but untangling
>> that is pretty much impossible because according to the changelog of the
>> commit which introduced this 8 years ago:
>>
>>  3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside get_online_cpus()")
>>
>> the lock order cgroups_mutex -> cpu_hotplug_lock is a design decision and
>> the whole code is built around that.
>>
>> So bite the bullet and invoke the relevant cpuset function, which waits for
>> the work to finish, in _cpu_up/down() after dropping cpu_hotplug_lock and
>> only when tasks are not frozen by suspend/hibernate because that would
>> obviously wait forever.
>>
>> Waiting there with cpu_add_remove_lock, which is protecting the present
>> and possible CPU maps, held is not a problem at all because neither work
>> queues nor cpusets/cgroups have any lockchains related to that lock.
>>
>> Waiting in the hotplug machinery is not problematic either because there
>> are already state callbacks which wait for hardware queues to drain. It
>> makes the operations slightly slower, but hotplug is slow anyway.
>>
>> This ensures that state is consistent before returning from a hotplug
>> up/down operation. It's still inconsistent during the operation, but that's
>> a different story.
>>
>> Add a large comment which explains why this is done and why this is not a
>> dump ground for the hack of the day to work around half thought out locking
>> schemes. Document also the implications vs. hotplug operations and
>> serialization or the lack of it.
>>
>> Thanks to Alexy and Joshua for analyzing why this temporary
>> sched_setaffinity() failure happened.
>>
>> Reported-by: Alexey Klimov <aklimov@redhat.com>
>> Reported-by: Joshua Baker <jobaker@redhat.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Cc: Qais Yousef <qais.yousef@arm.com>

Feel free to use:
Tested-by: Alexey Klimov <aklimov@redhat.com>

The bug doesn't reproduce with this change, I had the testcase running
for ~25 hrs without failing under different workloads.

Are you going to submit the patch? Or I can do it on your behalf if you like.

[...]

Best regards,
Alexey


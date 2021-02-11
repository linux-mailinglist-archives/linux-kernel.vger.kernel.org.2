Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7F318D53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBKOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhBKOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613052594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1db50KVoxPV8DsdAaKXwwrLzCGY6SPMsnN2pRLnSac0=;
        b=RMdJEepTCqa1COsmf9XWUqTLQ/TrvG5lmR7c8g0l3p7Jr+yVhuOCkQc66r9EgVSH/AiUSP
        e65xr+gfTmOWJlvu491xC8kqXTP4NOmwpfnLMyac6rpDSJpLRkMd4Fo1mx5056WoOEE0HV
        +ULFstSMqkN6svYcTYfSwumaYEpSHpA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-fhxboqYmNdKeMAu8BtesMg-1; Thu, 11 Feb 2021 09:09:52 -0500
X-MC-Unique: fhxboqYmNdKeMAu8BtesMg-1
Received: by mail-lj1-f199.google.com with SMTP id s13so281577ljm.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 06:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1db50KVoxPV8DsdAaKXwwrLzCGY6SPMsnN2pRLnSac0=;
        b=Sl9yKNRTZl+CKk4nGR1OO0gkOSrJVmebiNSSHl3a7nBS+Tx05G+4bgpAqBK7/CnnA3
         0bzUQxoJLEGiGVidFka9aaHBUH8lcaulFCXCU4ydcn+d2fdQtxJVgphJbhSlG5forPWp
         qoEFxqQ9/+0gJHBdXOH4Q80DnGE+Pe3JBKZRsJNruTQlorsAamvY8pYeNuDzU2TZwP53
         LFxLoGbx+z5mA7UfHUulXa5Gn8M4Nzu6OfHYjos0dgIXicNxtzxDlrxG/ZaQ8WrQ056v
         iKHSfUBXPm08pEcsHZSf8j+7KAyQu72E5E4uypgYpXITCYdxUOgaw5Y71v/3qnvY69WY
         55Rg==
X-Gm-Message-State: AOAM532ZfxqiHjRaMZsvYhi2AVfsSYOEBxqE8ft+rtydxOJDx7EIv19X
        5ZZWpqAMEjpq77h8re+l/XhEbF+2konmpG/QIXQChhcgk82+NZtQ67t0hqJgkKmUqMZgmV4diWP
        lbNpwrPxed5C+3R+4bCPHvVFBOl9IBoOdVWmaSRgF
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr5078752lji.227.1613052590910;
        Thu, 11 Feb 2021 06:09:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjxxXK6iYKZ2EdAbSoUbHxDhHAH5y+j7zo5+cHMQNHTys4vr0Q/FHQHZf3JG4E2JSsuZKYcK55UPqgFawIlrk=
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr5078724lji.227.1613052590631;
 Thu, 11 Feb 2021 06:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20210204010157.1823669-1-aklimov@redhat.com> <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
 <CAFBcO+_Z1LKqPPwEKq-XGX+RnWQa+vFBVJ9D9y0MNHGUkM_4Jw@mail.gmail.com>
 <YBv5qDBdb/VAq0Vw@hirez.programming.kicks-ass.net> <87eehvz6sx.fsf@oracle.com>
In-Reply-To: <87eehvz6sx.fsf@oracle.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Thu, 11 Feb 2021 14:09:39 +0000
Message-ID: <CAFBcO+_zMa8kC0cHnjAK6axX=CEL7UvS31ak_Vxr2gBO-JnH0Q@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        tj@kernel.org, lizefan@huawei.com,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:41 AM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:

[...]

> >> > One concequence of this is that you'll now get a bunch of notifications
> >> > across things like suspend/hybernate.
> >>
> >> The patch doesn't change the number of kobject_uevent()s. The
> >> userspace will get the same number of uevents as before the patch (at
> >> least if I can rely on my eyes).
> >
> > bringup_hibernate_cpu() didn't used to generate an event, it does now.
> > Same for bringup_nonboot_cpus().
>
> Both of those call cpu_up(), which only gets a cpuset_wait_for_hotplug()
> in this patch.  No new events generated from that, right, it's just a
> wrapper for a flush_work()?
>
> > Also, looking again, you don't seem to be reinstating the OFFLINE event
> > you took out.
>
> It seems to be reinstated in cpuhp_smt_disable()?

Peter, what Daniel said.
cpuset_wait_for_hotplug() doesn't generate an event.

The offline event was moved below in the same function:

+
+ /* Tell user space about the state changes */
+ for_each_cpu(cpu, mask) {
+ dev = get_cpu_device(cpu);
+ kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+ }
+
+ free_cpumask_var(mask);

Daniel,
thanks for your comments. I'll update the patch and resend.

Best regards,
Alexey


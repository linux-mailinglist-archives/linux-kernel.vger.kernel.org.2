Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCED44E82E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhKLOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhKLOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636726127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gxQtWinlcX6lChyHWu9bMAkpP2Jfl9hUJ+4/hvRPE0g=;
        b=Aw2uaT7FCXpFOuj0HMcDK4QqdhVy6/ds2Msouy5DlRpwlIo8fb36bxaSHpPgdm6UTwYPw9
        Q/FPM7xngtewbfk9KTyfMXNK1DZcV7Di1tZDxQtatKzxJLzeDNE1bJc04igavTCBW44UF2
        HW7DooGBfPV/PxLA8w3+jkI3/zF37dU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-4So7pAh2NJ-4-mZ42wEURQ-1; Fri, 12 Nov 2021 09:08:46 -0500
X-MC-Unique: 4So7pAh2NJ-4-mZ42wEURQ-1
Received: by mail-ed1-f71.google.com with SMTP id s6-20020a056402520600b003e2dea4f9b4so8324106edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxQtWinlcX6lChyHWu9bMAkpP2Jfl9hUJ+4/hvRPE0g=;
        b=5v8dZaQJgR+5y4MmhQT8QJr5QStPh+7lJN5/wqDUEFPtb3hOt45aIZi9V6va0d3R3h
         RYD6J0yQfa+Mrsnhn1yOO2OzHWnxvldxrlPYBYBDleDA3kRBNGihs2bkqfYl3dzFoVQO
         JZOBojERdP93HX9LWrMuyegV6lSaJCQP13WOdmLhZBs0IA5TCSSmhVQDVQi7M5aH9G1z
         H6B0K0SltWAm9bts/aLtgLladxEASWqqXjepMLPkZOCtCM6fZ6/CSUcOQwFxwG+Y8cmG
         5MOAlB/HbW+4BnfitRUI8669mzeQ13365J3xUH7HmNOEZ/YHNbxdCXhioHhByP76zVb5
         g1Bg==
X-Gm-Message-State: AOAM532M4yNeMAm+ZSeoFyTVbYS6l2t38nmsKnz0UZ6PWK1z7PTAewuQ
        k+snfplwRsmIW+qk73Whg/NBYrIVB93lpYccMBA0S7MwPCRUb3vwU/OuHwbnjkZhXGHKUxjSg0y
        OE9/fkbveMOtg2ajb2nkr3JdpCUmeCeX5gvmuyoCa
X-Received: by 2002:a17:907:9723:: with SMTP id jg35mr21164271ejc.329.1636726124776;
        Fri, 12 Nov 2021 06:08:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaTUlLSe6uRh/1ws8e/19OjofJgbKjFniaT0J3MI41FU9FzGJZK8ZjBWpUK4pJbnP9j7d5PbqZp3UN3MDI/aI=
X-Received: by 2002:a17:907:9723:: with SMTP id jg35mr21164229ejc.329.1636726124497;
 Fri, 12 Nov 2021 06:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20211111195904.618253-1-wander@redhat.com> <20211111195904.618253-2-wander@redhat.com>
 <YY4pmySR3VVHAtYy@alley>
In-Reply-To: <YY4pmySR3VVHAtYy@alley>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 12 Nov 2021 11:08:33 -0300
Message-ID: <CAAq0SUmePQEOM2AvMfTw8zAnG3k+869wsGSMt9HvFj_wb81i0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by slow
 console devices
To:     Petr Mladek <pmladek@suse.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 5:45 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2021-11-11 16:59:04, Wander Lairson Costa wrote:
> > If we have a reasonable large dataset to flush in the printk ring
> > buffer in the presence of a slow console device (like a serial port
> > with a low baud rate configured), the RCU stall detector may report
> > warnings.
> >
> > This patch suppresses RCU stall warnings while flushing the ring buffer
> > to the console.
>
> I have mixed feelings about this patch.
>
> We already touch watchdogs in several situations to avoid this type
> of reports. So, there is a precedent.
>
> On the other hand, it hides a real problem. printk() might cause
> softlockups, livelockups, and even deadlocks. It might really stall
> other processes and CPUs. And the stall report might help to
> understand that the system is not longer responsive because of
> printk().
>
Indeed, other use cases might care about these stalls in printk.
One workaround is to create a syctl to make this feature optional.

> John Ogness is working on the proper solution, handling consoles
> in a kthread. It is not that easy because we need to handle situations
> when kthreads do not work, for example, during early boot, panic(),
> suspend, reboot, kexec. But I believe that we will have it rather
> sooner than later.
>
I gave a try to the print threads patch set and it does solve the
problem. I am not
opposite at all to wait for them to land if it happens in the
foreseeable future.

> A workaround, is to lower console_loglevel and show only the most
> important messages. Sometimes, a reasonable solution is to ratelimit
> repeated messages.
>
> Which brings the question. What is the motivation for this patch,
> please?
>
> Is it motivated by a particular bug report?
> Or does the experience shows that this report causes more harm than
> good?
>
QA has a test case in which they need to load hundreds of SCSI devices,
and they simulate it using the scsi_debug driver:

modprobe scsi_debug virtual_gb=1 add_host=2 num_tgts=600

This dumps a bunch of messages to print and the serial console driver
cannot keep up with the data rate, causing an RCU stall. The stall is reported
in an IRQ context, then the ring buffer flush continues from there,
and then it causes
a soft lockup.

> Best Regards,
> Petr
>

On Fri, Nov 12, 2021 at 5:45 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2021-11-11 16:59:04, Wander Lairson Costa wrote:
> > If we have a reasonable large dataset to flush in the printk ring
> > buffer in the presence of a slow console device (like a serial port
> > with a low baud rate configured), the RCU stall detector may report
> > warnings.
> >
> > This patch suppresses RCU stall warnings while flushing the ring buffer
> > to the console.
>
> I have mixed feelings about this patch.
>
> We already touch watchdogs in several situations to avoid this type
> of reports. So, there is a precedent.
>
> On the other hand, it hides a real problem. printk() might cause
> softlockups, livelockups, and even deadlocks. It might really stall
> other processes and CPUs. And the stall report might help to
> understand that the system is not longer responsive because of
> printk().
>
> John Ogness is working on the proper solution, handling consoles
> in a kthread. It is not that easy because we need to handle situations
> when kthreads do not work, for example, during early boot, panic(),
> suspend, reboot, kexec. But I believe that we will have it rather
> sooner than later.
>
> A workaround, is to lower console_loglevel and show only the most
> important messages. Sometimes, a reasonable solution is to ratelimit
> repeated messages.
>
> Which brings the question. What is the motivation for this patch,
> please?
>
> Is it motivated by a particular bug report?
> Or does the experience shows that this report causes more harm than
> good?
>
> Best Regards,
> Petr
>


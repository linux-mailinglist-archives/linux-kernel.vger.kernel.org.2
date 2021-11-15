Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5352450216
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhKOKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:14:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbhKOKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:12:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4A521FD65;
        Mon, 15 Nov 2021 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636971001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiGVPWrmmNTlf5sI8Pzksa5PXV+VV1Zp6xFl0TEHB+4=;
        b=GSItTZmuMjpl5fyS307G/JbTBXWc8NbFF/YwT4lxmxbYB6Vo7df8lChwt5Z6Ex1yB8RCnQ
        d7yAH0gK8xDETmfVxh04mRF6SeNlKsqIw0f1WW9HCUAwtJz1hQoG6RCBxgto8/IBcHZD0Z
        Qhk3Nb+d548mYHqEagUQufds15alhqo=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85AFCA3B88;
        Mon, 15 Nov 2021 10:10:01 +0000 (UTC)
Date:   Mon, 15 Nov 2021 11:10:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <YZIx+ZBEKnVHSnbO@alley>
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
 <YY4pmySR3VVHAtYy@alley>
 <CAAq0SUmePQEOM2AvMfTw8zAnG3k+869wsGSMt9HvFj_wb81i0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUmePQEOM2AvMfTw8zAnG3k+869wsGSMt9HvFj_wb81i0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-12 11:08:33, Wander Costa wrote:
> On Fri, Nov 12, 2021 at 5:45 AM Petr Mladek <pmladek@suse.com> wrote:
> > A workaround, is to lower console_loglevel and show only the most
> > important messages. Sometimes, a reasonable solution is to ratelimit
> > repeated messages.
> >
> > Which brings the question. What is the motivation for this patch,
> > please?
> >
> > Is it motivated by a particular bug report?
> > Or does the experience shows that this report causes more harm than
> > good?
> >
> QA has a test case in which they need to load hundreds of SCSI devices,
> and they simulate it using the scsi_debug driver:

I think that SCSI devices were the first sinner who motivated the work
on console offloading here at SUSE.

> modprobe scsi_debug virtual_gb=1 add_host=2 num_tgts=600
> 
> This dumps a bunch of messages to print and the serial console driver
> cannot keep up with the data rate, causing an RCU stall. The stall is reported
> in an IRQ context, then the ring buffer flush continues from there,
> and then it causes
> a soft lockup.

I usually suggest to reduce console_loglevel as a temporary solution.
But I am not sure if it is acceptable in QA.

It might be done only around this test. I mean something like:

CONSOLE_LOGLEVEL=`cat /proc/sys/kernel/printk`
IGNORE_LOGLEVEL=`cat /sys/module/printk/parameters/ignore_loglevel`
echo "3 4 1 7" >/proc/sys/kernel/printk
echo N >/sys/module/printk/parameters/ignore_loglevel

modprobe scsi_debug virtual_gb=1 add_host=2 num_tgts=600

echo $CONSOLE_LOGLEVEL >/proc/sys/kernel/printk
echo $IGNORE_LOGLEVEL  >/sys/module/printk/parameters/ignore_loglevel


Where /proc/sys/kernel/printk is a horrible interface. The first
number is important. It defines the limit used for filtering messages.
The levels are defined in include/linux/kern_levels.h.

Best Regards,
Petr

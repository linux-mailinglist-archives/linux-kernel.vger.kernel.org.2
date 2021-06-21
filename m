Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEE3AE4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFUIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:32:14 -0400
Received: from foss.arm.com ([217.140.110.172]:58396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFUIcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:32:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354C3D6E;
        Mon, 21 Jun 2021 01:29:59 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4CA3F718;
        Mon, 21 Jun 2021 01:29:53 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:29:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        boqun.feng@gmail.com, bp@alien8.de, catalin.marinas@arm.com,
        dvyukov@google.com, elver@google.com, ink@jurassic.park.msu.ru,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 01/10] thread_info: add helpers to snapshot thread
 flags
Message-ID: <20210621082951.GC37068@C02TD0UTHF1T.local>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-2-mark.rutland@arm.com>
 <87h7hth4ln.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7hth4ln.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 12:28:04AM +0200, Thomas Gleixner wrote:
> On Wed, Jun 09 2021 at 13:19, Mark Rutland wrote:
> > We have common helpers to manipulate individual thread flags, but where
> > code wants to check several flags at once, it must open code reading
> > current_thread_info()->flags and operating on a snapshot.
> 
> Who's we?

Locally I've changed that to:

| In <linux/thread_info.h> there are helpers to [...]

Please shout if there's a better way of wording that!

> > As some flags can be set remotely it's necessary to use READ_ONCE() to
> > get a consistent snapshot even when IRQs are disabled, but some code
> > forgets to do this. Generally this is unlike to cause a problem in
> > practice, but it is somewhat unsound, and KCSAN will legitimately warn
> > that there is a data race.
> >
> > To make it easier to do the right thing, and to highlight that
> > concurrent modification is possible, let's add a new helpers to
> > snapshot
> 
> let's add? Why not simply "add"?

Done.

> > +static inline unsigned long read_ti_thread_flags(struct thread_info *ti)
> 
> __always_inline() as Marco pointed out already
> 
> Other than those nitpicks:
> 
>  Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

Mark.

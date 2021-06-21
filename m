Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2A3AE4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:37:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhFUIhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:37:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC161ED1;
        Mon, 21 Jun 2021 01:35:26 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 860EA3F718;
        Mon, 21 Jun 2021 01:35:21 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:35:18 +0100
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
Subject: Re: [RFC PATCH 10/10] x86: snapshot thread flags
Message-ID: <20210621083518.GD37068@C02TD0UTHF1T.local>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-11-mark.rutland@arm.com>
 <87eecxh4hj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eecxh4hj.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 12:30:32AM +0200, Thomas Gleixner wrote:
> On Wed, Jun 09 2021 at 13:20, Mark Rutland wrote:
> > Some thread flags can be set remotely, and so even when IRQs are
> > disabled, the flags can change under our feet. Generally this is
> > unlikely to cause a problem in practice, but it is somewhat unsound, and
> > KCSAN will legitimately warn that there is a data race.
> >
> > To avoid such issues, we should snapshot the flags prior to using them.
> > Let's use the new helpers to do so on x86.
> 
>  To avoid such issues, a snapshot of the flags has to be taken prior to
>  using them. Some places already use READ_ONCE() for that, others do
>  not.
> 
>  Convert them all to the new flag accessor helpers.

I'll use that wording consistently throughout the series.

> Other than that.
> 
>  Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

Mark.

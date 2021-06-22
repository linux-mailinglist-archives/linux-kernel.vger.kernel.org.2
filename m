Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132973B07D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhFVOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:48:10 -0400
Received: from foss.arm.com ([217.140.110.172]:50546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhFVOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:48:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1292A31B;
        Tue, 22 Jun 2021 07:45:53 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0973E3F694;
        Tue, 22 Jun 2021 07:45:48 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:45:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mattst88@gmail.com, mingo@redhat.com, monstr@monstr.eu,
        paulmck@kernel.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 0/9] thread_info: use helpers to snapshot thread flags
Message-ID: <20210622144546.GB71782@C02TD0UTHF1T.local>
References: <20210621090602.16883-1-mark.rutland@arm.com>
 <20210621175452.GB29713@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621175452.GB29713@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 06:54:53PM +0100, Will Deacon wrote:
> On Mon, Jun 21, 2021 at 10:05:52AM +0100, Mark Rutland wrote:
> > As thread_info::flags scan be manipulated by remote threads, it is
> > necessary to use atomics or READ_ONCE() to ensure that code manipulates
> > a consistent snapshot, but we open-code plain accesses to
> > thread_info::flags across the kernel tree.
> > 
> > Generally we get away with this, but tools like KCSAN legitimately warn
> > that there is a data-race, and this is potentially fragile with compiler
> > optimizations, LTO, etc.
> > 
> > These patches introduce new helpers to snahpshot the thread flags, with
> > the intent being that these should replace all plain accesses.
> > 
> > Since v1 [1]:
> > * Drop RFC
> > * Make read_ti_thread_flags() __always_inline
> > * Clarify commit messages
> > * Fix typo in arm64 patch
> > * Accumulate Reviewed-by / Acked-by tags
> > * Drop powerpc patch to avoid potential conflicts (per [2])
> > 
> > [1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
> > [2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
> > 
> > Thanks,
> > Mark.
> > 
> > Mark Rutland (9):
> >   thread_info: add helpers to snapshot thread flags
> >   entry: snapshot thread flags
> >   sched: snapshot thread flags
> >   alpha: snapshot thread flags
> >   arm: snapshot thread flags
> >   arm64: snapshot thread flags
> 
> FWIW, you have two identical arm64 patches in this series, just with a
> different subject.

Whoops; I'd tried to bring arm64 in line with the other patches, but
forgot to delete the stale patch file when I did that. I'll keep the
"snapshot thread flags" version.

> For the one you decide to keep:
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

Mark.

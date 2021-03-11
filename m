Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98533794F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhCKQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234540AbhCKQ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:28:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B875A64F9A;
        Thu, 11 Mar 2021 16:28:23 +0000 (UTC)
Date:   Thu, 11 Mar 2021 16:28:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v14 8/8] kselftest/arm64: Verify that TCO is enabled in
 load_unaligned_zeropad()
Message-ID: <20210311162820.GE30821@arm.com>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
 <20210308161434.33424-9-vincenzo.frascino@arm.com>
 <20210311132509.GB30821@arm.com>
 <bd403b9f-bb38-a456-b176-b6fefccb711f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd403b9f-bb38-a456-b176-b6fefccb711f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:00:26PM +0000, Vincenzo Frascino wrote:
> On 3/11/21 1:25 PM, Catalin Marinas wrote:
> > On Mon, Mar 08, 2021 at 04:14:34PM +0000, Vincenzo Frascino wrote:
> >> load_unaligned_zeropad() and __get/put_kernel_nofault() functions can
> >> read passed some buffer limits which may include some MTE granule with a
> >> different tag.
> >>
> >> When MTE async mode is enable, the load operation crosses the boundaries
> >> and the next granule has a different tag the PE sets the TFSR_EL1.TF1
> >> bit as if an asynchronous tag fault is happened:
> >>
> >>  ==================================================================
> >>  BUG: KASAN: invalid-access
> >>  Asynchronous mode enabled: no access details available
> >>
> >>  CPU: 0 PID: 1 Comm: init Not tainted 5.12.0-rc1-ge1045c86620d-dirty #8
> >>  Hardware name: FVP Base RevC (DT)
> >>  Call trace:
> >>    dump_backtrace+0x0/0x1c0
> >>    show_stack+0x18/0x24
> >>    dump_stack+0xcc/0x14c
> >>    kasan_report_async+0x54/0x70
> >>    mte_check_tfsr_el1+0x48/0x4c
> >>    exit_to_user_mode+0x18/0x38
> >>    finish_ret_to_user+0x4/0x15c
> >>  ==================================================================
> >>
> >> Verify that Tag Check Override (TCO) is enabled in these functions before
> >> the load and disable it afterwards to prevent this to happen.
> >>
> >> Note: The issue has been observed only with an MTE enabled userspace.
> > 
> > The above bug is all about kernel buffers. While userspace can trigger
> > the relevant code paths, it should not matter whether the user has MTE
> > enabled or not. Can you please confirm that you can still triggered the
> > fault with kernel-mode MTE but non-MTE user-space? If not, we may have a
> > bug somewhere as the two are unrelated: load_unaligned_zeropad() only
> > acts on kernel buffers and are subject to the kernel MTE tag check fault
> > mode.
> 
> I retried and you are right, it does not matter if it is a MTE or non-MTE
> user-space. The issue seems to be that this test does not trigger the problem
> all the times which probably lead me to the wrong conclusions.

Keep the test around for some quick checks before you get the kasan
test support.

> > I don't think we should have a user-space selftest for this. The bug is
> > not about a user-kernel interface, so an in-kernel test is more
> > appropriate. Could we instead add this to the kasan tests and calling
> > load_unaligned_zeropad() and other functions directly?
> 
> I agree with you we should abandon this strategy of triggering the issue due to
> my comment above. I will investigate the option of having a kasan test and try
> to come up with one that calls the relevant functions directly. I would prefer
> though, since the rest of the series is almost ready, to post it in a future
> series. What do you think?

That's fine by me.

-- 
Catalin

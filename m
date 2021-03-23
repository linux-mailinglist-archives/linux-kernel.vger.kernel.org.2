Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92F346244
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhCWPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232576AbhCWPED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CC46198C;
        Tue, 23 Mar 2021 15:04:01 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:03:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
Message-ID: <20210323150358.GA10576@arm.com>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
 <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
 <20210323133217.GA11802@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323133217.GA11802@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:32:18PM +0000, Will Deacon wrote:
> On Tue, Mar 23, 2021 at 12:08:56PM +0000, Robin Murphy wrote:
> > On 2021-03-23 07:34, Yang Yingliang wrote:
> > > When copy over 128 bytes, src/dst is added after
> > > each ldp/stp instruction, it will cost more time.
> > > To improve this, we only add src/dst after load
> > > or store 64 bytes.
> > 
> > This breaks the required behaviour for copy_*_user(), since the fault
> > handler expects the base address to be up-to-date at all times. Say you're
> > copying 128 bytes and fault on the 4th store, it should return 80 bytes not
> > copied; the code below would return 128 bytes not copied, even though 48
> > bytes have actually been written to the destination.
> > 
> > We've had a couple of tries at updating this code (because the whole
> > template is frankly a bit terrible, and a long way from the well-optimised
> > code it was derived from), but getting the fault-handling behaviour right
> > without making the handler itself ludicrously complex has proven tricky. And
> > then it got bumped down the priority list while the uaccess behaviour in
> > general was in flux - now that the dust has largely settled on that I should
> > probably try to find time to pick this up again...
> 
> I think the v5 from Oli was pretty close, but it didn't get any review:
> 
> https://lore.kernel.org/r/20200914151800.2270-1-oli.swede@arm.com

These are still unread in my inbox as I was planning to look at them
again. However, I think we discussed a few options on how to proceed but
no concrete plans:

1. Merge Oli's patches as they are, with some potential complexity
   issues as fixing the user copy accuracy was non-trivial. I think the
   latest version uses a two-stage approach: when taking a fault, it
   falls back to to byte-by-byte with the expectation that it faults
   again and we can then report the correct fault address.

2. Only use Cortex Strings for in-kernel memcpy() while the uaccess
   routines are some simple loops that align the uaccess part only
   (unlike Cortex Strings which usually to align the source).

3. Similar to 2 but with Cortex Strings imported automatically with some
   script to make it easier to keep the routines up to date.

If having non-optimal (but good enough) uaccess routines is acceptable,
I'd go for (2) with a plan to move to (3) at the next Cortex Strings
update.

I also need to look again at option (1) to see how complex it is but
given the time one spends on importing a new Cortex Strings library, I
don't think (1) scales well on the long term. We could, however, go for
(1) now and look at (3) with the next update.

-- 
Catalin

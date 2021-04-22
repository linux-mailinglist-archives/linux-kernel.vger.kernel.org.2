Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1E367E56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhDVKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhDVKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:08:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619086078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Uod3Gn3SbQ2OjL0oSDhOHNu8O6HVJj9GRFERpRfpQA=;
        b=2nkjUfNSN+bQrtaO3IYEZUdLbEQRA6hLgaIX2oJgJN89hGzIrUjxpEi9GmV9LBixCQMdXJ
        yzrJ6IvFFkoeRDlcW8PVVPM7Ljx78b466Tz8jSzarRgsEFUvn3/qqBDmXLggMKNxNLQn+Y
        WdM7bvxj0XIXEIdaHX2sN1E6d+1AlPtz3YjLj1pdWZSGR01uytcpUZCBxOqwttcADW/Fb6
        oG95ctYnq+Wz7F8i7lIoBlAvk48pEA0rcP1TEZl423JI7SvaHFcMnq6/1GW5sBrZNeF8Zl
        6xDpuEyn8y1nLWVGrkPPU3VWXKT74mYcomVCQB8IDaaZGRtnNTfGKNa6HHI0ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619086078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Uod3Gn3SbQ2OjL0oSDhOHNu8O6HVJj9GRFERpRfpQA=;
        b=EIT5k2kSBYcH77gOwmtxmnm42vdS73SJ5pzFm2/DFHGU2dgYEGztJGOvc2/WXTMhIjXSKF
        6RCsBdZu3ZLliNAQ==
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykows?= =?utf-8?Q?ki?= 
        <zenczykowski@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <87v98fxjtm.ffs@nanos.tec.linutronix.de>
References: <87v98fxjtm.ffs@nanos.tec.linutronix.de>
Date:   Thu, 22 Apr 2021 12:07:58 +0200
Message-ID: <87sg3iy6m9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22 2021 at 02:08, Thomas Gleixner wrote:
> On Wed, Apr 21 2021 at 23:08, Lorenzo Colitti wrote:
> That said, even if you manage to avoid the timer hardware trainwreck on
> which your system is depending on right now, then still the underlying
> problem remains that hrtimers are not the proper tool for high frequency
> modification and never will be.
>
> There are smarter approaches to that USB/NTB problem, but that's beyond
> the discussion at hand.

And because I was looking at it anyway, here are some hints:

Buffersize: 16k
Timeout:    300us

Let's assume small packets with a size of 256 bytes each. The packets
arrive with a period of ~299us, i.e. right before the timer fires. Which
means the timer wont fire because it's moved 300us ahead each time and
the buffer is sent to the wire when it's full.

That means the 1st packet in the buffer is sent 63 * 299 us = 18.8ms
after it was queued in the buffer.

How is that supposed to be correct? I know, throughput is what matters
and correctness is overrated.

For the high volume traffic case the timer is not needed at all if
the logic is done proper.

xmit()
{
        if (!packet_fits_in_buffer())
        	send_buffer_and_cancel_timer_if_armed();

        if (first_packet_in_buffer())
        	buffer_deadline = now() + MAX_DELAY;

	add_packet_to_buffer();

        /* Are more packets available for xmit at the core? */
        if (!xmit_queue_empty())
               	return;

	/*
         * Last packet from network core for now, check how long the
         * first packet sits in the buffer.
         */
        if (buffer_deadline <= now()) {
        	send_buffer_and_cancel_timer_if_armed();
                return;
        }

        if (!timer_armed())
        	arm_timer(buffer_deadline);
}

IOW, as long as the network core has packets outstanding for xmit, there
is no point in arming the timer at all.

But yes, that needs more work and thoughts than the 'bolt and duct tape'
approach which led to the current situation.

Aside of that it would certainly be interesting to start very simple
with an experiment which does not use a timer in the first place:

xmit()
{
        if (!packet_fits_in_buffer())
        	send_buffer();

	add_packet_to_buffer();

        /* Are more packets available for xmit at the core? */
        if (!xmit_queue_empty())
               	return;

	/* Last packet from network core for now. Drain it. */
        send_buffer();
}

I wouldn't be surprised if that'd turn out to be the right thing to do
both latency-wise and throughput-wise.

But that'd be not convoluted enough and of course the commit which
introduced that magic does not explain anything at all, so I can't tell
if that was actually tried or not.

Thanks,

        tglx

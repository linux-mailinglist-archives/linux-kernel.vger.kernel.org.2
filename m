Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE453E1549
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhHENGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232931AbhHENGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BD3760525;
        Thu,  5 Aug 2021 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628168778;
        bh=6Rf3pGNX0K1ifjeDPZib5H95Dk4SVWI3B0FwMUydquc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CuEKpi9/mHcX2GeCjbcV7Uz61aekfFQlg/sLgt1eTzUaxa+rQeO/YSTKSsmteCJ2o
         WsgPQjwByE7/+2rQfBO2FnnvmhJMstMOolwz1rgYHbhCZTspUwUgCV/vbzisESxFrb
         rWS/VjbJMa+HMEpj2MhlYQ9gVHB/YiJoEWElBZ8rp182aUZ4QbpswXvAy2AwI+Rjb7
         TTDft/k0uqH/mAEiot1DpEW8VxNMCIpPv+TAkv4vfh6zWRPIKxXAbOzwUTjQ7+IuTS
         6FUWgx8Xq6UrRLn6+6xvvPxM6GAodDWHHTXCtSECpx5ST6cqSBFLR9S9j86BAMcrNo
         Vk8Cz8PpvPWvA==
Date:   Thu, 5 Aug 2021 08:06:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH net-next 1/2] timer: add fsleep for flexible sleeping
Message-ID: <20210805130616.GA1684372@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3c3f78-344c-ae03-b6ae-ea55e402c1e7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Andrew, Sajid, -cc Realtek NIC, David, netdev]

On Fri, May 01, 2020 at 11:27:21PM +0200, Heiner Kallweit wrote:
> Sleeping for a certain amount of time requires use of different
> functions, depending on the time period.
> Documentation/timers/timers-howto.rst explains when to use which
> function, and also checkpatch checks for some potentially
> problematic cases.
> 
> So let's create a helper that automatically chooses the appropriate
> sleep function -> fsleep(), for flexible sleeping
> 
> If the delay is a constant, then the compiler should be able to ensure
> that the new helper doesn't create overhead. If the delay is not
> constant, then the new helper can save some code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  Documentation/timers/timers-howto.rst |  3 +++
>  include/linux/delay.h                 | 11 +++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
> index 7e3167bec..afb0a43b8 100644
> --- a/Documentation/timers/timers-howto.rst
> +++ b/Documentation/timers/timers-howto.rst
> @@ -110,3 +110,6 @@ NON-ATOMIC CONTEXT:
>  			short, the difference is whether the sleep can be ended
>  			early by a signal. In general, just use msleep unless
>  			you know you have a need for the interruptible variant.
> +
> +	FLEXIBLE SLEEPING (any delay, uninterruptible)
> +		* Use fsleep
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index 8e6828094..cb1d508ca 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -65,4 +65,15 @@ static inline void ssleep(unsigned int seconds)
>  	msleep(seconds * 1000);
>  }
>  
> +/* see Documentation/timers/timers-howto.rst for the thresholds */
> +static inline void fsleep(unsigned long usecs)
> +{
> +	if (usecs <= 10)
> +		udelay(usecs);
> +	else if (usecs <= 20000)
> +		usleep_range(usecs, 2 * usecs);
> +	else
> +		msleep(DIV_ROUND_UP(usecs, 1000));
> +}

This is nice; I really like it because it's simpler for callers to
use.

timers-howto.rst and checkpatch advise to "use usleep_range() for the
1-20ms range" [1].  That's a very common sleep range, and making it a
special case makes things harder than they should be.  Supposedly this
is explained by the thread at [2], but I'm not really buying it.  That
thread was mostly about what the function name should be and whether
it should be implemented with timers.

AFAICT the only real argument there against making msleep() behave as
advertised for <20ms durations was that buggy drivers might depend on
msleep(1) really sleeping for ~20ms.  That's a real concern to be
sure, and Andrew apparently tripped over it [3].

But it's also a bug if msleep(1) *always* sleeps for 10-20ms, or if
the actual sleep changes drastically based on the arch or HZ.

There's a large class of 1-20ms sleeps that do things like this:

  usleep_range(1000, 2000);
  msleep(1);
  msleep(5);

that are either accurate but clumsy or inaccurate and unnecessarily
slow.  We could use fsleep() for them, but it's a little clumsy to
write "fsleep(5 * 1000)" all the time.

If we had something like this:

  static inline void fmsleep(unsigned int msecs)
  {
    fsleep(msecs * 1000);
  }

it seems like the advice could be simpler:

  - Use fsleep() for usec-range sleeps.
  - Use fmsleep() for msec-range sleeps.
  - Use usleep_range() for special cases.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/timers/timers-howto.rst?id=v5.13#n76
[2] https://lore.kernel.org/r/15327.1186166232@lwn.net
[3] https://lore.kernel.org/r/20070809001640.ec2f3bfb.akpm@linux-foundation.org/

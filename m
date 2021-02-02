Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A630CC59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbhBBTww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbhBBTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:52:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3590C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IUIuM9y+Lczp+ZHa3sPK+xoBhadiC5RTh6EMuVOso0c=; b=aB7KsjrdbERqUDA/X+dt6MdHHH
        DtAIxo5CLo6LHFqCa6v6Bw5tumjuY1kdeyIzAvh++gK/55OnHv6FT2OjUp09Z5oe7Iqm9OXujmMKI
        sNCI/sWXT4VZBinmBc2m98zV6M1SNvEWtP4YFSBssH7vKqD9ROV9OsBl0SpALEA6mOFmlDzfqY9Ii
        3G/le5dWPW2P0AtIGCM4x8YVuwmyR5XEJvqMGyGxfNkS2NAcV2WzIBGyUibCzn2M0XfSP7so5Epz/
        XJOuXO3gXEzvGisS6jyCNg1tpWULa1uLtGynx12SWq8QOICsPwyxZ0TLhUEtX7vgrTkyHsGg268iA
        jeQfSfvQ==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l71hc-0005Xp-TM; Tue, 02 Feb 2021 19:51:09 +0000
Subject: Re: [PATCH clocksource 4/5] clocksource: Provide a module parameter
 to fuzz per-CPU clock checking
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, ak@linux.intel.com, clm@fb.com
References: <20210202170437.GA23593@paulmck-ThinkPad-P72>
 <20210202170635.24839-4-paulmck@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5badf6e2-4600-4fe9-6b45-d0de94ad718b@infradead.org>
Date:   Tue, 2 Feb 2021 11:51:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210202170635.24839-4-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 9:06 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Code that checks for clock desynchronization must itself be tested, so
> this commit creates a new clocksource.inject_delay_shift_percpu= kernel
> boot parameter that adds or subtracts a large value from the check read,
> using the specified bit of the CPU ID to determine whether to add or
> to subtract.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Reported-by: Chris Mason <clm@fb.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  kernel/time/clocksource.c                       | 10 +++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9965266..f561e94 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -593,6 +593,15 @@
>  			times the value specified for inject_delay_freq
>  			of consecutive non-delays.
>  
> +	clocksource.inject_delay_shift_percpu= [KNL]
> +			Shift count to obtain bit from CPU number to
> +			determine whether to shift the time of the per-CPU
> +			clock under test ahead or behind.  For example,

It's a good think that you give an example -- it helps a little bit.
That sentence above needs to be rewritten...

> +			setting this to the value four will result in
> +			alternating groups of 16 CPUs shifting ahead and
> +			the rest of the CPUs shifting behind.  The default
> +			value of -1 disable this type of error injection.

			            disables

> +
>  	clocksource.max_read_retries= [KNL]
>  			Number of clocksource_watchdog() retries due to
>  			external delays before the clock will be marked


-- 
~Randy


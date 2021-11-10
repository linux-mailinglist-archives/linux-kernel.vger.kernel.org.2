Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF49544B9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhKJBU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhKJBU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:20:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E7E1610A3;
        Wed, 10 Nov 2021 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636507061;
        bh=MdrIE62VaL8FX5MjkmTsyO8xSb3+UdMLWwwDxbXtcgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfeRHlYJa1rFCgtfhZATl9oiKHhf6WPCd1SGVBPPAEm8dQNQPV1+7j+ZM6X2AY8bT
         jY+iyanrgtfFG1QKarthjp/AHFYARNwzwMUckjeViGV0Jvv0h1aKVNtmUalvYIKuPW
         VaaYsOQU7MdG4nAH5orbjWNkko/4Bb1qn0na7YjQD0W2PCEuXwRTDO5f5dhlWPpJa8
         gE7Pm13G+7UzhB++GgJKhiX5Y4Grp4qItyCQgqeiJBByCXaVqiAtejkciy1oL2DPx2
         1q917yF93AZpiwlO/2P/i00Deug/IhtL+0FjNh4s+vfRofVrTCoz1s5JaRxZolC+Jh
         cZ2lO7fBbK9fA==
Date:   Wed, 10 Nov 2021 02:17:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC
 & !DYNAMIC
Message-ID: <20211110011738.GD288354@lothringen>
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109151057.3489223-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 03:10:57PM +0000, Valentin Schneider wrote:
> +choice
> +	prompt "Default boot-time Preemption Model"
> +	depends on PREEMPT_DYNAMIC
> +	default PREEMPT_NONE_BEHAVIOUR
> +	help
> +	  This option defines the default preemption model of the kernel
> +	  if it hasn't been specified by the "preempt=" command line parameter.
>  
> -config PREEMPT_VOLUNTARY
> -	bool
> +config PREEMPT_NONE_BEHAVIOUR
> +	bool "No Forced Preemption (Server)"
>  
> -config PREEMPT
> -	bool
> -	select PREEMPTION
> -	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> +config PREEMPT_VOLUNTARY_BEHAVIOUR
> +	bool "Voluntary Kernel Preemption (Desktop)"
> +
> +config PREEMPT_BEHAVIOUR
> +	bool "Preemptible Kernel (Low-Latency Desktop)"
> +endchoice

The problem here is that you're duplicating the existing titles
for the static entries and you're losing all the help that text that used to come
along. The point of the BEHAVIOUR thing, further mapping to either
static or dynamic preemption, was to avoid that duplication and keep the
same titles and help for the three behaviour, whether static or dynamic.

Thanks.

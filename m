Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0FC44C57F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhKJQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhKJQ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70D3161107;
        Wed, 10 Nov 2021 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636563399;
        bh=Hqa4BSNikT6yWz7PKi1mCB3atFqqmG9v+0iXBMVM060=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzJ8HNFK2ib4Yap1JmeuHzZI10vihsuEWvWOhMr/8b6DtYCeP0QvMS5vFYyiyaMB/
         VnseNtPloTbD1TG7aSwtvSk1q9WZPNlVY6Icr6BZm8Rnpo1LS0j6oWAgLncf0Cg1Lf
         qxNYCDJ+MHQprqun/ynxHApvUpmXURnb3bMPzZkvAnDwPvYx3WvPyPJs74dJ/JpHfq
         umIx3sl3XuYrGltbWWin76jQ7xWzFnXrbUuoeXGYNzw6PbDQFAcAufGIQjOQqhUTD3
         jteR0mwwSuEG5dD4/Q33ZuNQ60+J4ETnh/jxbTadSpoJVmatTIKhniYsJwLugi4A9g
         PTYxApRVzYD/g==
Date:   Wed, 10 Nov 2021 17:56:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC
 & !DYNAMIC
Message-ID: <20211110165636.GB300656@lothringen>
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
 <20211110011738.GD288354@lothringen>
 <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
 <87h7cks16n.mognet@arm.com>
 <87bl2srrvq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl2srrvq.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:45:45PM +0000, Valentin Schneider wrote:
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..3b3226ffbafa 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4271,11 +4271,11 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
>  		   entries,
>  		   total,
>  		   buf->cpu,
> -#if defined(CONFIG_PREEMPT_NONE)
> +#if defined(CONFIG_PREEMPT_NONE_BUILD)
>  		   "server",
> -#elif defined(CONFIG_PREEMPT_VOLUNTARY)
> +#elif defined(CONFIG_PREEMPT_VOLUNTARY_BUILD)
>  		   "desktop",
> -#elif defined(CONFIG_PREEMPT)
> +#elif defined(CONFIG_PREEMPT_BUILD)
>  		   "preempt",
>  #elif defined(CONFIG_PREEMPT_RT)
>  		   "preempt_rt",

I also found those:

arch/powerpc/kernel/interrupt.c:                if (IS_ENABLED(CONFIG_PREEMPT)) {
arch/powerpc/kernel/traps.c:           IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",

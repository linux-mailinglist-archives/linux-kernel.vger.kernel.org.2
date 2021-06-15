Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2D3A8A41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFOUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOUl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D9A7611C0;
        Tue, 15 Jun 2021 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623789591;
        bh=6+oMK7wCi10jdQ9Pp1G7b0FDyy4ILCTJVB7zAEjdXsw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dR8pjiWuDoDqOmvOvHj7Lwj2jKs6IKEcw078eWGs3AQs2GR4DHlnwzmuwbN5xYDRA
         SIustUX6eCQcd8Xto3LFXibZTjzAr5Qr+jfgI9fva+QiY4ESHqvNE6clT2/O0sFjgG
         nmTJLszr0U4qCgjfFe8hBuwIP2tqqdbVTL2F6tm1Cp2Ox3iOXXiEsymxz4aDGurLOI
         eCn5Q6khmLekWnluqBClw/gSP6y6LK9/ASsWD6ULDvuMyzy/QErUQ1zIp6sAmp8+u4
         Qkx6lfGH/xJE7tkeyIkSnF6tBrCkeQhsWpCE6ozHyB6ibaTe5zrLr1nHs4tqqo1zpS
         /CTYJhOf9+Ptg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 040C35C02A9; Tue, 15 Jun 2021 13:39:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:39:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, boqun.feng@gmail.com,
        will@kernel.org, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
Message-ID: <20210615203951.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210607125653.1388091-1-elver@google.com>
 <20210609123810.GA37375@C02TD0UTHF1T.local>
 <20210615181946.GA2727668@paulmck-ThinkPad-P17-Gen-1>
 <YMj2pj9Pbsta15pc@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMj2pj9Pbsta15pc@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:51:18PM +0200, Marco Elver wrote:
> On Tue, Jun 15, 2021 at 11:19AM -0700, Paul E. McKenney wrote:
> [...]
> > Queued and pushed for v5.15, thank you both!
> > 
> > I also queued the following patch making use of CONFIG_KCSAN_STRICT, and I
> > figured that I should run it past you guys to make check my understanding.
> > 
> > Thoughts?
> 
> You still need CONFIG_KCSAN_INTERRUPT_WATCHER=y, but otherwise looks
> good.

I knew I was missing something...  :-/

> I thought I'd leave that out for now, but now thinking about it, we
> might as well imply interruptible watchers. If you agree, feel free to
> queue the below patch ahead of yours.

That works for me!  I have queued the patch below and rebased it to
precede my change to the torture-test infrastructure.

							Thanx, Paul

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Date: Tue, 15 Jun 2021 20:39:38 +0200
> Subject: [PATCH] kcsan: Make strict mode imply interruptible watchers
> 
> If CONFIG_KCSAN_STRICT=y, select CONFIG_KCSAN_INTERRUPT_WATCHER as well.
> 
> With interruptible watchers, we'll also report same-CPU data races; if
> we requested strict mode, we might as well show these, too.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/Kconfig.kcsan | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 26f03c754d39..e0a93ffdef30 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -150,7 +150,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
>  	  KCSAN_WATCH_SKIP.
>  
>  config KCSAN_INTERRUPT_WATCHER
> -	bool "Interruptible watchers"
> +	bool "Interruptible watchers" if !KCSAN_STRICT
> +	default KCSAN_STRICT
>  	help
>  	  If enabled, a task that set up a watchpoint may be interrupted while
>  	  delayed. This option will allow KCSAN to detect races between
> -- 
> 2.32.0.272.g935e593368-goog
> 

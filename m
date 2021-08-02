Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA733DD711
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhHBNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233785AbhHBNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:30:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4BDD60EFF;
        Mon,  2 Aug 2021 13:29:58 +0000 (UTC)
Date:   Mon, 2 Aug 2021 09:29:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] trace: remove redundant dependency from
 IRQSOFF_TRACER
Message-ID: <20210802092952.3047bb99@oasis.local.home>
In-Reply-To: <20210731052233.4703-3-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
        <20210731052233.4703-3-masahiroy@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021 14:22:33 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> IRQSOFF_TRACE is already guarded by a stronger condition,
> TRACING_SUPPORT.
> 
> 'depends on TRACE_IRQFLAGS_SUPPORT' is redundant.

I'm fine with the other two patches, but this one concerns me. I'm not
sure TRACING_SUPPORT really needs to depend on TRACE_IRQFLAGS_SUPPORT.
When tracing was first introduced, the main use case was the irqsoff
tracer. Today, with function graph tracing and events being introduced,
it's one of the minor use cases of tracing support.

I believe the only thing that requires the TRACE_IRQFLAGS_SUPPORT is
the irqsoff tracer (and friends), so if anything, we should remove that
dependency from TRACING_SUPPORT, not here.

-- Steve


> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  kernel/trace/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 9d3f918b5867..b39e67db644e 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -265,7 +265,6 @@ config TRACE_PREEMPT_TOGGLE
>  config IRQSOFF_TRACER
>  	bool "Interrupts-off Latency Tracer"
>  	default n
> -	depends on TRACE_IRQFLAGS_SUPPORT
>  	select TRACE_IRQFLAGS
>  	select GENERIC_TRACER
>  	select TRACER_MAX_TRACE


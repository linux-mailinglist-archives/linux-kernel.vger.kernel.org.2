Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7497939DE23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFGN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFGN5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:57:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62BFB610FB;
        Mon,  7 Jun 2021 13:55:20 +0000 (UTC)
Date:   Mon, 7 Jun 2021 09:55:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: ftrace: don't dereference a probably invalid
 address
Message-ID: <20210607095518.12694437@oasis.local.home>
In-Reply-To: <20210607032329.28671-1-mark-pk.tsai@mediatek.com>
References: <20210607032329.28671-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 11:23:30 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> Address in __mcount_loc may be invalid if somthing goes wrong.
> On our arm64 platform, the bug in recordmcount make kernel
> crash in ftrace_init().

How did it crash? The link below doesn't show any crash.

> 
> https://lore.kernel.org/lkml/20210607023839.26387-1-mark-pk.tsai@mediatek.com/
> 
> Return -EFAULT if we are dealing with out-of-range condition
> to prevent dereference the invalid address in ftrace_bug(),
> then the kernel can disable ftrace safely for problematic
> __mcount_loc.

!mod is not an out-of-range condition. It just happened that the other
bug caused this strange side-effect. A !mod does not mean a fault
happened. Just because it may have been caused by a fault in your use
case does not mean that it's a fault in all use cases. That's like
saying that your dog is a poodle, so all dogs are poodles.

A return of -EINVAL should not cause a crash. If it does, then that
needs to be fixed.

-- Steve


> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  arch/arm64/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index b5d3ddaf69d9..98bec8445a58 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -201,7 +201,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  			preempt_enable();
>  
>  			if (WARN_ON(!mod))
> -				return -EINVAL;
> +				return -EFAULT;
>  		}
>  
>  		/*


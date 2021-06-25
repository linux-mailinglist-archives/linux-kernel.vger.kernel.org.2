Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3173B4370
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhFYMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:39:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37804 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhFYMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:38:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA2CB1FE8E;
        Fri, 25 Jun 2021 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624624584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WwlFfjzZ1Gum+16nGRv3muCKcaRSIAsgxa6F7g7/oU=;
        b=OeYxvhgasMbs1C4iwauKBACmiNMDd0tSDrThewMZ6zKe8VPNyBLvZJimgJIfLDGStY1fqD
        cKyIFjs+gpxRK0TUi+Gke3O3gFGVIw0Rt1k/bWtzIqhFZubH0mQn+FRw5U5DcmjHyChpKo
        ktEb3ho5wyguj6B2R30GozD0getgIAM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B92B4A3BB4;
        Fri, 25 Jun 2021 12:36:23 +0000 (UTC)
Date:   Fri, 25 Jun 2021 14:36:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH printk v3 4/6] printk: remove NMI tracking
Message-ID: <YNXNx68CXrI9QpHD@alley>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
 <20210624111148.5190-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624111148.5190-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-24 13:17:46, John Ogness wrote:
> All NMI contexts are handled the same as the safe context: store the
> message and defer printing. There is no need to have special NMI
> context tracking for this. Using in_nmi() is enough.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/arm/kernel/smp.c       |  2 --
>  arch/powerpc/kexec/crash.c  |  3 ---
>  include/linux/hardirq.h     |  2 --
>  include/linux/printk.h      | 12 ------------
>  init/Kconfig                |  5 -----
>  kernel/printk/internal.h    |  6 ------
>  kernel/printk/printk_safe.c | 37 +------------------------------------
>  kernel/trace/trace.c        |  2 --
>  8 files changed, 1 insertion(+), 68 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 74679240a9d8..0dd2d733ad62 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -668,9 +668,7 @@ static void do_handle_IPI(int ipinr)
>  		break;
>  
>  	case IPI_CPU_BACKTRACE:
> -		printk_nmi_enter();
>  		nmi_cpu_backtrace(get_irq_regs());
> -		printk_nmi_exit();

It looks to me that in_nmi() returns false here. As a result,
nmi_cpu_backtrace() might newly call consoles immediately.

If I recall correctly, arm does not have a proper NMI.
And this is just some special case of a "normal" IRQ.

And indeed, nmi_enter() is called only from handle_fiq_as_nmi()
and it is just a boiler plate.

If I am right, we should replace printk_nmi_enter() with
printk_safe_enter_irqsave(flags) or so.

Even better solution might be to call this within
nmi_enter()/nmi_exit(). But I am not sure if this is what
the arm people want.

Best Regards,
Petr

PS: Sigh, I have skipped this patch yesterday because it already had
my Reviewed-by. And I missed it before...

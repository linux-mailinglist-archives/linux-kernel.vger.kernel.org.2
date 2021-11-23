Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312945A1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhKWLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:50:43 -0500
Received: from foss.arm.com ([217.140.110.172]:51484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236613AbhKWLuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:50:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE141063;
        Tue, 23 Nov 2021 03:47:24 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A07D23F5A1;
        Tue, 23 Nov 2021 03:47:21 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:47:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, borntraeger@de.ibm.com, bp@alien8.de,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 2/9] arm64: Add comment for stack_info::kr_cur
Message-ID: <20211123114719.GC37253@lakrids.cambridge.arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-3-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:07:30PM +0000, Mark Rutland wrote:
> We added stack_info::kr_cur in commit:
> 
>   cd9bc2c9258816dc ("arm64: Recover kretprobe modified return address in stacktrace")
> 
> ... but didn't add anything in the corresponding comment block.
> 
> For consistency, add a corresponding comment.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/stacktrace.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 6564a01cc085..686731b9df05 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -47,6 +47,10 @@ struct stack_info {
>   * @prev_type:   The type of stack this frame record was on, or a synthetic
>   *               value of STACK_TYPE_UNKNOWN. This is used to detect a
>   *               transition from one stack to another.
> + *
> + * @kr_cur:      When KRETPOLINES is selected, holds the kretprobe instance

As peter pointed out on IRC, this should be KRETPROBES, not KRETPOLINES
(which does not exist as a Kconfig symbol).

I'll fix that for v2.

Mark.

> + *               associated with the most recently encountered replacement lr
> + *               value.
>   */
>  struct stackframe {
>  	unsigned long fp;
> -- 
> 2.11.0
> 

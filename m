Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729B456596
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhKRW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhKRW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:28:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74A9061139;
        Thu, 18 Nov 2021 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637274309;
        bh=zQdXfHV9CET/NnUqJqmT9eDeVrMEQT1cQmVoaTt6XM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzy5tEpbfCI+6IDriB4eZ25kfC2j12gjkOpJGizCSSMWt0DrL1cps4w9j7R0So18d
         NQJrBSC056Ld6GPvySkJp0CP64Up667wa2TczC/TQoH24JrNrIJpjEjFXRvMBdcQbY
         ctC4DIarULHrGCUIrBIT0lwRNYiJuz1I/Md6FyvufSTijD6mQhz3ylI3CLPc6Q5Qs7
         ilqiY5R/ZCUJ16BRycUJv42tnULgbHmEpx81CHVNMpZfbfkjmQJTtwluVbRptS0Uwj
         helZ/jY92rilr7cNzN+DgcLnkZJVbv1Bpwns49f9gnYwektebW+/tpxSjyhyYOQRb1
         UcwkCigPaIbAQ==
Date:   Fri, 19 Nov 2021 07:25:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, mhiramat@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 2/9] arm64: Add comment for stack_info::kr_cur
Message-Id: <20211119072503.9834585ea5c812a63195816a@kernel.org>
In-Reply-To: <20211117140737.44420-3-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
        <20211117140737.44420-3-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 14:07:30 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> We added stack_info::kr_cur in commit:
> 
>   cd9bc2c9258816dc ("arm64: Recover kretprobe modified return address in stacktrace")
> 
> ... but didn't add anything in the corresponding comment block.

Thanks for adding the comment!

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Regards,
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
> + *               associated with the most recently encountered replacement lr
> + *               value.
>   */
>  struct stackframe {
>  	unsigned long fp;
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

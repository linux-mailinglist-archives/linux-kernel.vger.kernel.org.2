Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975083484E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhCXWti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhCXWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1346619B8;
        Wed, 24 Mar 2021 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616626150;
        bh=Cqk1Tcctuh5GKJLKrU8S+5l1h9txxfO/b7fBxXmnIGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hla6cBC0qIjxQYtBAqO+10bqJlx5C7jnm7ST7G8pgWRQCjxq9LdJk99eBvDhDbD/y
         zXw9L53n5AdTuwcWCipMRt8mPr0Jp5aTe4EJqCLhxRDlJyE1HbwM61wKHcB8GG9Iqp
         DA/DYdl90bgfC6pn1gbPhawyEPzcaePdpi+5R5SBlODVj/Fqz8ib8GoDuyaUiaVVUX
         eHrqp67s5iuHNaaqH0shJUJUDbTrEp/UNBFLWj+3n7QFjrivldJeTvjppOPfCUwe8M
         4LcXuUJJ8eJsTY0rZWWACYdOzniNUlGL8L6vVrwvD8IeG6u7InICKRCf0+Aqjn2T/D
         khe7zTbdw2WeQ==
Date:   Thu, 25 Mar 2021 07:49:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: Re: [PATCH -next] x86/kprobes: Fix old-style-declaration warning
Message-Id: <20210325074906.27fb5fd5528da9b3bee72d53@kernel.org>
In-Reply-To: <20210324144502.1154883-1-weiyongjun1@huawei.com>
References: <20210324144502.1154883-1-weiyongjun1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 14:45:02 +0000
'Wei Yongjun <weiyongjun1@huawei.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Gcc reports build warning as follows:
> 
> arch/x86/kernel/kprobes/core.c:940:1:
>  warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>   940 | static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
>       | ^~~~~~
> 
> This commit fix it by moving nokprobe_inline to the beginning
> of declaration.
> 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 89d9f26785c7..5abf251f12ec 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -937,7 +937,7 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
>  }
>  NOKPROBE_SYMBOL(reenter_kprobe);
>  
> -static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
> +static nokprobe_inline int kprobe_is_ss(struct kprobe_ctlblk *kcb)
>  {
>  	return (kcb->kprobe_status == KPROBE_HIT_SS ||
>  		kcb->kprobe_status == KPROBE_REENTER);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

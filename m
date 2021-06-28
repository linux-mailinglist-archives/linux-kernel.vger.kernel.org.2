Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD653B618D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhF1OgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhF1O16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:27:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C66D6600CD;
        Mon, 28 Jun 2021 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624890332;
        bh=JurY56NJlZghnRhWOXb3Fi/DN1f+prsVrv0WNkW0DUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZiLXuNRe3RF4Hu7375no72L5CG2gm20K3fHzF8JSy94Tvv668KpD6pyE2svvef7/P
         wNvfilLnmPbUoM1Sfq/RWw0e36Ue90L5gPi9ysjbYIA73QIHvgym56DDYUYxW+0Lk/
         co0ScxaaiK5/aKC3Aje8pPdIKZQGty05QftFSJ+lYAY3VJbjSjcRVgAvzq4QNppC4i
         yVFKJYkcy5jy77PrKvN98hJrXCUV6kRa8U28VMZU7zMnyEWvRbgqL3AzbFmGVOgHDd
         3g9Uw8zdXhMilMJlxzWc07Vfs7YhgoRLSKEKDtcgITKSqjJTwLU/jh/5wC395ShNiC
         N2u1EyepvRlaA==
Date:   Mon, 28 Jun 2021 23:25:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kprobe/static_call: Restore missing
 static_call_text_reserved()
Message-Id: <20210628232529.f4b460b9e58cbb4098fe6c6a@kernel.org>
In-Reply-To: <20210628113045.167127609@infradead.org>
References: <20210628112409.233121975@infradead.org>
        <20210628113045.167127609@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 13:24:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
> kprobes on inline static_call()s") that went walkabout.
> 
> Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/kprobes.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/static_call.h>
>  #include <linux/perf_event.h>
>  
>  #include <asm/sections.h>
> @@ -1551,6 +1552,7 @@ static int check_kprobe_address_safe(str
>  	if (!kernel_text_address((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
> +	    static_call_text_reserved(p->addr, p->addr) ||
>  	    find_bug((unsigned long)p->addr)) {
>  		ret = -EINVAL;
>  		goto out;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

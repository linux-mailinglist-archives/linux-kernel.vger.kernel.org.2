Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6343ADFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJZIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234189AbhJZIbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9F960F92;
        Tue, 26 Oct 2021 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635236925;
        bh=Kwd82lhXSuurE+nRv54nIs/dom3/8gLxuuA8+2h2+NA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dyJnd9h9xrV+Kb4rY5tMLss7pb5Ov+aweqypvRyH0bHtnlM2klm22PTffiid11MCM
         QoD0a3E6anV82+E9ArJWh7DKp1+h04I44DXArV1FOUQdLB5b/MNsHTwmYk1Gsl1pcE
         wt8ZfEqsDq0CGwdabqnOvc3qwqtQ427Tk8ElQMmdOeSgYnJXQZ2KpHeK9RwUcIZKBp
         5Ql+pM0kdIAEG+/vr+HGSk44ee7ChFCd/Ye8lRADCAgvIERsy8N0NNxcnpQs1Ll1C/
         S1h/qV3nZHCws/Z9HvFtxVEpBiLIu56UirGxscbXGvjqmcWqBQmMH79GavjevVwRZy
         kT0lXy3jEh/kw==
Date:   Tue, 26 Oct 2021 17:28:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, rostedt@goodmis.org, mingo@redhat.com,
        corbet@lwn.net, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Update KPROBES and TRACING entries
Message-Id: <20211026172842.cb6fc83f888ade50d0b6046c@kernel.org>
In-Reply-To: <1635213091-24387-5-git-send-email-yangtiezhu@loongson.cn>
References: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
        <1635213091-24387-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 09:51:31 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
> rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, so add
> git tree and missing files for KPROBES, and also use linux-trace.git for
> TRACING to avoid confusing.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This looks good to me for kprobe section.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b33791..8d26693 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10437,10 +10437,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>  F:	Documentation/trace/kprobes.rst
>  F:	include/asm-generic/kprobes.h
>  F:	include/linux/kprobes.h
>  F:	kernel/kprobes.c
> +F:	lib/test_kprobes.c
> +F:	samples/kprobes
>  
>  KS0108 LCD CONTROLLER DRIVER
>  M:	Miguel Ojeda <ojeda@kernel.org>
> @@ -18967,7 +18970,7 @@ TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Ingo Molnar <mingo@redhat.com>
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>  F:	Documentation/trace/ftrace.rst
>  F:	arch/*/*/*/ftrace.h
>  F:	arch/*/kernel/ftrace.c
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

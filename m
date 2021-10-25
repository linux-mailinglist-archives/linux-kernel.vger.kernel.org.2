Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF9438F97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJYGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhJYGkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD0560EFE;
        Mon, 25 Oct 2021 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635143905;
        bh=z9AfSLvAqdcBDNwK7tAY8htOKq62zLD9zXuFRKMxRuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pKduQhB97D7/PzCncaDpwnXXyYlWSyJ21KsmtJEZcEjDCK5cMlXT9qllvUg6bLwWg
         xJbDp3grDJ3ce4NoAGeY0Yc7vPgcM3tpdjT3txVshS+iFbMgFwwMP89tepkTz6SzFl
         Wjj012+NRA1xYbDztgu7lrjrDqRa2CPJAl3HVsCkP955+nAoOlWT/qWzeFdbCtXB1V
         AY66e2XKBcEwne8K1wfbdlD5ep5barVcUkEFzDFqJpyTcUYNOodEV33LcY5FXI031s
         0RvjlUYnnB2wbmT8AotF3M+wa/H3kCt54G7x5/o+o5d2XWT8RCbZZ62KAZlSKicDgU
         a6KC4kgG5wRug==
Date:   Mon, 25 Oct 2021 15:38:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add git tree and missing files for
 KPROBES
Message-Id: <20211025153821.baa3f5d90fd40943ee28d2e1@kernel.org>
In-Reply-To: <1635132660-5038-5-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
        <1635132660-5038-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 11:31:00 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
> rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, add them.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4372473..0e9bc60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10506,10 +10506,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git

NACK. As I said, this branch was prepared when I discussed with tip maintainer 
on kretprobe stackfix series but now it has been maintained on Steve's tracing
tree.

Steve, should we put your tree here?

Anyway, I will pick your [1/4]-[3/4].

Thank you,

>  F:	Documentation/trace/kprobes.rst
>  F:	include/asm-generic/kprobes.h
>  F:	include/linux/kprobes.h
>  F:	kernel/kprobes.c
> +F:	lib/test_kprobes.c
> +F:	samples/kprobes
>  
>  KS0108 LCD CONTROLLER DRIVER
>  M:	Miguel Ojeda <ojeda@kernel.org>
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

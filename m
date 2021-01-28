Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE889307D83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhA1SLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhA1SHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:07:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B10564E1D;
        Thu, 28 Jan 2021 18:06:23 +0000 (UTC)
Date:   Thu, 28 Jan 2021 13:06:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kretprobe: avoid re-registration of the same
 kretprobe earlier
Message-ID: <20210128130621.41d99638@gandalf.local.home>
In-Reply-To: <20210128124427.2031088-1-bobo.shaobowang@huawei.com>
References: <20210128124427.2031088-1-bobo.shaobowang@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami,

Care to review?

Thanks!

-- Steve


On Thu, 28 Jan 2021 20:44:27 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> Our system encountered a re-init error when re-registering same kretprobe,
> where the kretprobe_instance in rp->free_instances is illegally accessed
> after re-init.
> 
> Implementation to avoid re-registration has been introduced for kprobe
> before, but lags for register_kretprobe(). We must check if kprobe has
> been re-registered before re-initializing kretprobe, otherwise it will
> destroy the data struct of kretprobe registered, which can lead to memory
> leak, system crash, also some unexpected behaviors.
> 
> We use check_kprobe_rereg() to check if kprobe has been re-registered
> before running register_kretprobe()'s body, for giving a warning message
> and terminate registration process.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f7fb5d135930..5c4a884953e9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1978,6 +1978,10 @@ int register_kretprobe(struct kretprobe *rp)
>  	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
>  		return -EINVAL;
>  
> +	/* If only rp->kp.addr is specified, check reregistering kprobes */
> +	if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
> +		return -EINVAL;
> +
>  	if (kretprobe_blacklist_size) {
>  		addr = kprobe_addr(&rp->kp);
>  		if (IS_ERR(addr))


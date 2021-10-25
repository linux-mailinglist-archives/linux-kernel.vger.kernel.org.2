Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D79438F36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJYGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJYGRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:17:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF11660F02;
        Mon, 25 Oct 2021 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142520;
        bh=qyOhpd50WpRpY/Lo5509L0KMMjOyAIQWbMcSHHc+igQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e4t8tGCGTJ7UJisB6RNO3CRmsan5gSsSJeLeN1+T4zvabWObcBaJLAcoPEtvkrVWV
         s8qUaXRpZ27CjWUl+eI/d+adjpIXj7cNwqsx/RLEyUDB2fPELSM22Opt20KX2qkJHI
         W8CpdOlQ0eGwRUtQFdoYFeZVwCSR2I/P7+1GGWMyuH0m4CLjYSBprqURpBoE8FWr6h
         atdp+n7LTeCWhNR0tS7jaRzN0z4xqaaQdTOMUtYCj2aAi43GkpCrXuVmvzPNO4VAN5
         WagR70vKIYoY1I7+XdmCiQfpXhMHY6hcKjoyOa7wF2O2Ui47M8KTiOxZ2RfXylZl3u
         uaNBzoMQw70CA==
Date:   Mon, 25 Oct 2021 15:15:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] samples/kretprobes: Fix return value if
 register_kretprobe() failed
Message-Id: <20211025151517.f295f7804993e55997f0258f@kernel.org>
In-Reply-To: <1635132660-5038-2-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
        <1635132660-5038-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 11:30:57 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Use the actual return value instead of always -1 if register_kretprobe()
> failed.
> 
> E.g. without this patch:
> 
>  # insmod samples/kprobes/kretprobe_example.ko func=no_such_func
>  insmod: ERROR: could not insert module samples/kprobes/kretprobe_example.ko: Operation not permitted
> 
> With this patch:
> 
>  # insmod samples/kprobes/kretprobe_example.ko func=no_such_func
>  insmod: ERROR: could not insert module samples/kprobes/kretprobe_example.ko: Unknown symbol in module
> 
> Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  samples/kprobes/kretprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> index 5dc1bf3..228321e 100644
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -86,7 +86,7 @@ static int __init kretprobe_init(void)
>  	ret = register_kretprobe(&my_kretprobe);
>  	if (ret < 0) {
>  		pr_err("register_kretprobe failed, returned %d\n", ret);
> -		return -1;
> +		return ret;
>  	}
>  	pr_info("Planted return probe at %s: %p\n",
>  			my_kretprobe.kp.symbol_name, my_kretprobe.kp.addr);
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

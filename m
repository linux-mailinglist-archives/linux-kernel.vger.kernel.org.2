Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35471380A53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhENNVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhENNVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4C8061451;
        Fri, 14 May 2021 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620998410;
        bh=vmjZo5FsCOZVRQUnwKI9G8xEtugt5u8YaX+YGYflkls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNMsbpAlj8goNw+JaeL09CUCLqsHDlRhYHacbNpKYUh891WEyRj31HUQlhGIYaQNO
         sj+IV9dHjH7YMQ3289I8i9FlqopA6muGZvoF1Y2riXJkH5TCZmjEIqkbY5hfU8Jzxn
         ba0mDgS3bffwhZcJnuvJIx1UkYUovTI2b/84Lmy4cRjoQkUPrRP/Mzdnql1QmE34IV
         YgVAfjme+pO/GTnFG/EI4jadvWsccEC67SMAxGCwtUJRzob85B/WIbnNZfISGswQ/q
         YD/oK8LGpiDGIocG9Sx9yPBpZQeAXj50/2/aHWmgA/2Es0wffjT15z8sAgCXTiTMyQ
         ybFjhzphVmLQw==
Date:   Fri, 14 May 2021 22:20:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] samples/kprobes: Fix typo in handler_post()
Message-Id: <20210514222004.54f4c2b12099b569a872a2ee@kernel.org>
In-Reply-To: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
References: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:10:10 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It should use post_handler instead of pre_handler in handler_post().

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2: rebase on the latest mainline kernel
> 
>  samples/kprobes/kprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index c495664..602db3f 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -89,7 +89,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  		p->symbol_name, p->addr, regs->status);
>  #endif
>  #ifdef CONFIG_S390
> -	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
> +	pr_info("<%s> post_handler: p->addr, 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);
>  #endif
>  }
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

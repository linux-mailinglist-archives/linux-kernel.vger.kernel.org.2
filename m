Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C73823CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhEQFsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 01:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234022AbhEQFrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 01:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D055B60FF2;
        Mon, 17 May 2021 05:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621230366;
        bh=sHqI5E4R9RuDi2UyrLnJMV0/aoan7XflDkfAwyccFFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jersN3pWm+89QDeMW6whzaL6p/ALq9yKj948jiDHMjwB3xaLl9/E+8h25c8ZnI9rt
         wnPsgAB5s3ZPKMsJeQg82BG6Ztnw2UVhJ2zKEktl3kbw2FimF6ObEYxdsB+t/Hg7AQ
         Zf1alv9xTI3TcIsR8sAMjVPxQjR05aXW5H/OLvfIpXXM6Tzpt8emseGyivQqOQRlHM
         H6DG6wm0uQNRJIR7NlXdY6RsWq1fArjckzUdmVCaO6C7OY+x9Drh/H9dX60vkEXMSn
         8bicLWwp+jQ/Lw6mlVNGlmBz883vBkpKpJx1nMea9ZRyneCCBrHwE/G+OBa7vHuGvU
         a5IZJBt8YGBkg==
Date:   Mon, 17 May 2021 14:46:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4 1/2] samples/kprobes: Fix typo in handler_fault()
Message-Id: <20210517144600.8735f8eacc52b0a579085067@kernel.org>
In-Reply-To: <1621218083-23519-2-git-send-email-yangtiezhu@loongson.cn>
References: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
        <1621218083-23519-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 10:21:22 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Fix a defective format in handler_fault() ending with an 'n' that
> should be '\n'.
> 
> Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  samples/kprobes/kprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index c495664..d77a546 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -101,7 +101,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>   */
>  static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
>  {
> -	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
> +	pr_info("fault_handler: p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
>  	/* Return 0 because we don't handle the fault. */
>  	return 0;
>  }
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

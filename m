Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF733FC3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhHaHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240035AbhHaHln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:41:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61FA260F46;
        Tue, 31 Aug 2021 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630395649;
        bh=JWmgheTXq2SVhzYpNzzzvKdDNKRbDLeSr0ulGkgkuRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YkgJa5+ltTsj/D9KueEEYYzjBigtkMqPT0yc/F6lehDvS2AvEiWt3kfeh0Av0dKpn
         zJVLeyvKYnImTOSiiSY1hAOjDOChYqUkFCC1jrXMT1cUdw79bpDurk/WvZ9Z1n3DlB
         ggpWJuoRyBcddVEKBBv+ZsnwN6gbMXkPw/qhtC/5An9mPvB7pkSwPo4+QHwV+T0Rty
         WPhVuvlnTGv3XGLyQm86x2swDNdFZ45YFlrptM7xd4vOAlxiA+D19aVuzgDfm7F3WQ
         rM83SyEXLCTzyloE+bWSvuCNoCFRQD3njpk3Rj/94JbQVQwmFgZj3N4LWx0Zu63mVA
         qrGlUdwz4/daw==
Date:   Tue, 31 Aug 2021 16:40:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     rostedt@goodmis.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix missing return check of
 xbc_node_compose_key function
Message-Id: <20210831164046.b62e20443e2a1852d91b87bb@kernel.org>
In-Reply-To: <20210831033256.5973-1-jcfaracco@gmail.com>
References: <20210831033256.5973-1-jcfaracco@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 00:32:56 -0300
Julio Faracco <jcfaracco@gmail.com> wrote:

> The function `xbc_show_list should` handle the keys during the
> composition. Even the errors returned by the compose function. Instead
> of removing the `ret` variable, it should save the value and show the
> exact error. This missing variable is causing a compilation issue also.
> 

Oops, good catch! Hmm, I missed some intermediate patch for some commit.
Let me check.

Thanks,

> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  tools/bootconfig/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index f45fa992e01d..fd67496a947f 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -111,9 +111,11 @@ static void xbc_show_list(void)
>  	char key[XBC_KEYLEN_MAX];
>  	struct xbc_node *leaf;
>  	const char *val;
> +	int ret;
>  
>  	xbc_for_each_key_value(leaf, val) {
> -		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
> +		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
> +		if (ret < 0) {
>  			fprintf(stderr, "Failed to compose key %d\n", ret);
>  			break;
>  		}
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

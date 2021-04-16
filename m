Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32B4362534
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhDPQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236350AbhDPQJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1BD76113D;
        Fri, 16 Apr 2021 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618589358;
        bh=LT3aTtIyNMIt1ylzBHBWXlZkbbUuLb4bFY3i31NmIwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8rjvo/LVEfOfz5yV1eUDcrKDSY3OunACHttjTg60KGV2UPkwvmmfujdN9FsYfeo5
         CGX3jXPM/hQLx0Xu0eyHgg5678Kk6xT0AYs8OKZWVgPIZZDMBX04OfU9q9vj8vpEck
         g/i9KrEGfITQzkVjn9YbYmiW9RdaZZuaxJ1gX3wrlLTmAG8AxE0V70H7qFyNO+fEnf
         /Io+EK/Gdgdxd40x+16HYnx9yLxNJfSA4Z1b4oUD+uBT2y3H8kxCVsDslLvOZqEQ34
         5H0EpaQ75+U+5XdFos3GeHNCWJFPzE011/gUNhre/ha2If2RB56JzzbIabNzXE04yX
         eWDwkCRuQtJJQ==
Date:   Sat, 17 Apr 2021 01:09:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     zuoqilin1@163.com, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] tools/bootconfig: Simplify expression
Message-Id: <20210417010914.e44504e46680d09eda141f18@kernel.org>
In-Reply-To: <20210414134647.1870-1-zuoqilin1@163.com>
References: <20210414134647.1870-1-zuoqilin1@163.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 21:46:47 +0800
zuoqilin1@163.com wrote:

> From: zuoqilin <zuoqilin@yulong.com>
> 
> It is not necessary to define the variable ret to receive
> the return value of the xbc_node_compose_key() method.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>

Indeed.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  tools/bootconfig/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7362bef..5fb309b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -84,11 +84,9 @@ static void xbc_show_list(void)
>  	char key[XBC_KEYLEN_MAX];
>  	struct xbc_node *leaf;
>  	const char *val;
> -	int ret = 0;
>  
>  	xbc_for_each_key_value(leaf, val) {
> -		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
> -		if (ret < 0)
> +		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0)
>  			break;
>  		printf("%s = ", key);
>  		if (!val || val[0] == '\0') {
> -- 
> 1.9.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

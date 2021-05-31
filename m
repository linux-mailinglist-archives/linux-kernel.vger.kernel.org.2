Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C93967BE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhEaSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhEaSWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:22:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E90561263;
        Mon, 31 May 2021 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622485225;
        bh=KVPxsK67S4DEMtK/llxKJ6tK1HvNLCXUFY8DJOuS6nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9BUxpglvR6MP91AsSBt9W3b34G3moZnd/t+dcVjBIo11yUfcSAue4Ibfcsc0x+vc
         eIbs2np8fXwvdHDajUcEX6trMA0BepkWUZ7Nrd8fM03m4c4eEg11K487NAxsgI8wDf
         tyMJyxPvEXuKU4CO751CS6DAq/uM18Tr2FuJ4QAbJkD+GL5457Jojga0IdOwB5Paie
         CaAPHUQEN5+gENAHAmAflQlV/3xGnIyXt/jyXAV4hVgTNI/mWADjufjmzIiHySmzQ9
         zTY2Vx+rSedXmYGTx2FjEck6zy/9Bf3+ytS90HYcyyrlJKrtjd39grpZDZZEZbV8dT
         aa0hJfTcKGvMQ==
Date:   Mon, 31 May 2021 11:20:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     samitolvanen@google.com, wcw@google.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 5/6] pgo: modules Fixup memory leak.
Message-ID: <YLUo6HrhWmeg2g1w@Ryzen-9-3900X.localdomain>
References: <20210528201107.459362-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528201107.459362-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:11:07PM +0300, Jarmo Tiitto wrote:
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>

Similar comment to 6/6, squash this into 3/6.

> ---
>  kernel/pgo/fs_mod.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/pgo/fs_mod.c b/kernel/pgo/fs_mod.c
> index 0808d44227f1..2d1ff99e7982 100644
> --- a/kernel/pgo/fs_mod.c
> +++ b/kernel/pgo/fs_mod.c
> @@ -261,6 +261,8 @@ static int prf_module_open(struct inode *inode, struct file *file)
>  
>  				if (!pinfo->buffer) {
>  					err = -ENOMEM;
> +					kfree(pinfo);
> +					module_put(mod);
>  					goto out;
>  				}
>  			}
> @@ -373,7 +375,7 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
>  			if (strcmp(data->mod->name, mod->name) == 0) {
>  
>  				mutex_lock(&prf_mod_lock);
> -				/* remofe from profiled modules */
> +				/* remove from profiled modules */
>  				list_del_rcu(&data->link);
>  				/* mark it stale */
>  				WRITE_ONCE(data->mod, NULL);
> -- 
> 2.31.1

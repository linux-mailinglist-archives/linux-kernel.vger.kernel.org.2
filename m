Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A663AB712
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhFQPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:14:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhFQPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:14:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE08721ACB;
        Thu, 17 Jun 2021 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623942736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJaBEgLS13ix01z8I4sBTdZd9WzGYZM0wzpnPPvaRUQ=;
        b=k8TBMNzyQn1IBCLAah8LLHXhCrkANfsvZ2l0Ck0nPEV0deRHr6+s0FZ/MPeqlb6PP5bErX
        ww5DmowOrIBVwWvsfDGZtOirsB/5rax/VXb8wkZaHWqaAiCw0AGFYW74MfLt7EyFin9/rX
        leKvCsfgphzby6E7QQDJitDuIWgOMEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623942736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJaBEgLS13ix01z8I4sBTdZd9WzGYZM0wzpnPPvaRUQ=;
        b=HQOFpW9aEkehZncoyerG/cYtiuw96ujH86+m2mRPxpq+ff/zmPRKUYsgvMiKJ7srNxx8cB
        E7dzqdtMp3vqOLBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id AF14BA3B83;
        Thu, 17 Jun 2021 15:12:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 857BD1F2C68; Thu, 17 Jun 2021 17:12:16 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:12:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Pan Bian <bianpan2016@163.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] isofs: remove redundant continue statement
Message-ID: <20210617151216.GH32587@quack2.suse.cz>
References: <20210617120837.11994-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617120837.11994-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-06-21 13:08:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement in the while-loop has no effect,
> remove it.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/dir.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index b9e6a7ec78be..eb2f8273e6f1 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -235,8 +235,6 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  				break;
>  		}
>  		ctx->pos += de_len;
> -
> -		continue;
>  	}
>  	if (bh)
>  		brelse(bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

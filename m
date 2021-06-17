Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7AF3AB6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhFQPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:03:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51514 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhFQPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F1A5921AC2;
        Thu, 17 Jun 2021 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623942076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELgBROHwzhnT6WgLwbTbyP1umLLFuCti0UzM0hHAy+c=;
        b=T97VfTRaJYf/rir3j7QDFCrvLiC+COB6EUl4rthEHx7o5aqcWGSVb6RqEONqKw0mCSELr1
        vULSe1f7Bah/kKeroK9qvftSz/cGHqK0GZhjgwDQOW+QN4Q2Cq3MtXEQb+Q23ltoQl/gNj
        4AB1rKYsz+g6sX+Y9ujbX4qo26rFJJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623942076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELgBROHwzhnT6WgLwbTbyP1umLLFuCti0UzM0hHAy+c=;
        b=pDD+JdAnPYG6yMGG1OPW4t7Mny4KL5+XWbJj8O+V6US14ES+uo4QM3iMx3sOdNN33zSFVo
        INhTz7OyTx3QoPBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E6398A3BB8;
        Thu, 17 Jun 2021 15:01:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C48A51F2C68; Thu, 17 Jun 2021 17:01:16 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:01:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jan Kara <jack@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] quota: remove unnecessary oom message
Message-ID: <20210617150116.GG32587@quack2.suse.cz>
References: <20210617091627.1653-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617091627.1653-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-06-21 17:16:27, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

I agree the message is pointless. But when doing this, I guess we can just
get rid of getdqbuf() altogether and instead call kmalloc() directly in all
the places.

								Honza

> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index c5562c871c8b..b097d02bad94 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -49,11 +49,7 @@ static int qtree_dqstr_in_blk(struct qtree_mem_dqinfo *info)
>  
>  static char *getdqbuf(size_t size)
>  {
> -	char *buf = kmalloc(size, GFP_NOFS);
> -	if (!buf)
> -		printk(KERN_WARNING
> -		       "VFS: Not enough memory for quota buffers.\n");
> -	return buf;
> +	return kmalloc(size, GFP_NOFS);
>  }
>  
>  static ssize_t read_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
> -- 
> 2.25.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

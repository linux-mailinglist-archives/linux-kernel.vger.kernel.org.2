Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407A636D740
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhD1M1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:27:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235298AbhD1M1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7297BB156;
        Wed, 28 Apr 2021 12:26:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B4221E150F; Wed, 28 Apr 2021 14:26:44 +0200 (CEST)
Date:   Wed, 28 Apr 2021 14:26:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] quota: Use 'hlist_for_each_entry' to simplify code
Message-ID: <20210428122644.GD25222@quack2.suse.cz>
References: <f82d3e33964dcbd2aac19866735e0a8381c8a735.1619599407.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82d3e33964dcbd2aac19866735e0a8381c8a735.1619599407.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-04-21 10:44:19, Christophe JAILLET wrote:
> Use 'hlist_for_each_entry' instead of hand writing it.
> This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  fs/quota/dquot.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks for the cleanup. It looks good.  I'll queue it to my tree after the
merge window closes (i.e., in about two weeks).

								Honza

> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 4f1373463766..22d904bde6ab 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -288,14 +288,12 @@ static inline void remove_dquot_hash(struct dquot *dquot)
>  static struct dquot *find_dquot(unsigned int hashent, struct super_block *sb,
>  				struct kqid qid)
>  {
> -	struct hlist_node *node;
>  	struct dquot *dquot;
>  
> -	hlist_for_each (node, dquot_hash+hashent) {
> -		dquot = hlist_entry(node, struct dquot, dq_hash);
> +	hlist_for_each_entry(dquot, dquot_hash+hashent, dq_hash)
>  		if (dquot->dq_sb == sb && qid_eq(dquot->dq_id, qid))
>  			return dquot;
> -	}
> +
>  	return NULL;
>  }
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

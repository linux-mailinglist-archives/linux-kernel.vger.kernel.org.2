Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB03F5A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhHXIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:52:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhHXIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:52:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0CE922000;
        Tue, 24 Aug 2021 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629795092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SUm9DZ7VT6OGAhj+B8v8x/YoYhvTLFIbpXVrBIm1SM=;
        b=uyEIwPaZpo+FJT5NMF6ke8bf/DEOluwvxBF7e4/9Om/U1H3agGUSgas98SKrQSR+tLXhNu
        8GscnomaMAcFAyjFzXbT/yQN2L8O9GVzVIgoZm1XXnRuIWtenLk3+IQIpd6EjCFX0b7J5s
        MAPkRkrAB3uMXnov2eRmx8fae/izDsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629795092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SUm9DZ7VT6OGAhj+B8v8x/YoYhvTLFIbpXVrBIm1SM=;
        b=8MFFSxEGOm1HQRRt0CxSsCYO5MprgKVTVAB54CGQyP3mXGXGEVCqJBS65k/XeM9PeYAWgs
        CbCu//LK4tgjK6DQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8612AA3BBA;
        Tue, 24 Aug 2021 08:51:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DCCF1E0BD5; Tue, 24 Aug 2021 10:51:32 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:51:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seiji Nishikawa <snishika@redhat.com>
Subject: Re: [ghak-trim PATCH v1] audit: move put_tree() to avoid trim_trees
 refcount underflow and UAF
Message-ID: <20210824085132.GA12376@quack2.suse.cz>
References: <caba6f2509ce8eedb6c904e9b0e13ca676bd7d61.1629770243.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caba6f2509ce8eedb6c904e9b0e13ca676bd7d61.1629770243.git.rgb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-08-21 22:04:09, Richard Guy Briggs wrote:
> AUDIT_TRIM is expected to be idempotent, but multiple executions resulted in a
> refcount underflow and use-after-free.
> 
> git bisect fingered commit fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca (2019-11)
> 	("locking/refcount: Consolidate implementations of refcount_t")
> but this patch with its more thorough checking that wasn't in the x86 assembly
> code merely exposed a previously existing tree refcount imbalance in the case
> of tree trimming code that was refactored with prune_one() to remove a tree
> introduced in commit 8432c70062978d9a57bde6715496d585ec520c3e (2018-11)
> 	("audit: Simplify locking around untag_chunk()")
> 
> Move the put_tree() to cover only the prune_one() case.
> 
> Passes audit-testsuite and 3 passes of "auditctl -t" with at least one
> directory watch.
> 
> Fixes: 8432c7006297 ("audit: Simplify locking around untag_chunk()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Seiji Nishikawa <snishika@redhat.com>

Ah, that was indeed a stupid mistake. Thanks for debugging this! The patch
looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  kernel/audit_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index b2be4e978ba3..2cd7b5694422 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -593,7 +593,6 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
>  		spin_lock(&hash_lock);
>  	}
>  	spin_unlock(&hash_lock);
> -	put_tree(victim);
>  }
>  
>  /*
> @@ -602,6 +601,7 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
>  static void prune_one(struct audit_tree *victim)
>  {
>  	prune_tree_chunks(victim, false);
> +	put_tree(victim);
>  }
>  
>  /* trim the uncommitted chunks from tree */
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

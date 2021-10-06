Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00804248B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhJFVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:18:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhJFVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:18:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B761E1FEFF;
        Wed,  6 Oct 2021 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633554976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5n7l6aClaDhnZd/TVwd1w5RuwnsRNMzKDPibEDS/6M=;
        b=hMflkvTcTYsQs1jGLh6aN3/4X5VMsW5QJA1+Xib8QYHPYvGsLew6dv/1GDqoq6ukJZ2p+b
        GtbW8g6pLI45khIv1j7uhwDd4L1svW4YIgVB1MlTJjcqEEQdEci6Z4Phw/WRriHiPlxbxq
        KwJo9AX88ZSur4ZwzxPoRmNqllTUgjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633554976;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5n7l6aClaDhnZd/TVwd1w5RuwnsRNMzKDPibEDS/6M=;
        b=zn/vItLqHD0lJu/zctTfyhQiZtUP6LYD0YZHWo9t7iG93rTEbSPuJ3w22jGyynXO5n7Q+U
        +2G1MrcN4VrVfzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDFAD13E7C;
        Wed,  6 Oct 2021 21:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0SvNJh4SXmFjMgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Oct 2021 21:16:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wei Yang" <richard.weiyang@gmail.com>
Cc:     kuba@kernel.org, gregkh@linuxfoundation.org, mojha@codeaurora.org,
        jkosina@suse.cz, linux-kernel@vger.kernel.org,
        "Wei Yang" <richard.weiyang@gmail.com>
Subject: Re: [PATCH] hashtable: remove a redundant check in hash_for_each_xxx()
In-reply-to: <20211006152100.17795-1-richard.weiyang@gmail.com>
References: <20211006152100.17795-1-richard.weiyang@gmail.com>
Date:   Thu, 07 Oct 2021 08:16:11 +1100
Message-id: <163355497171.31063.8329134032738647570@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021, Wei Yang wrote:
> The three hash_for_each_xxx() helper iterate the hash table with help
> of hlist_for_each_entry_xxx(), which breaks the loop only when obj is
> NULL.
> 
> This means the check during each iteration is redundant. This patch
> removes it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/hashtable.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
> index f6c666730b8c..a15719ed303f 100644
> --- a/include/linux/hashtable.h
> +++ b/include/linux/hashtable.h
> @@ -124,8 +124,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>   * @member: the name of the hlist_node within the struct
>   */
>  #define hash_for_each(name, bkt, obj, member)				\
> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
> -			(bkt)++)\
> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>  		hlist_for_each_entry(obj, &name[bkt], member)

I think you are missing an important property of this code.
What we have here is a new loop command (hash_for_each()) that is
constructed from 2 nested loops.  This sort of construct is in general
difficult to use because in C it is common to use "break" to exit a loop
early.  'break' cannot exit two levels of loop though.  So if you aren't
careful, doing something like

  hash_for_each() {
     do something
     if (some test)
        break;
  }

might not do what you expect.  The 'break' will exit the inner loop, but
not the outer loop.  That could easily lead to buggy code.

But this macro *is* careful.  If the loop body *does* use break, then
the inner loop will abort but 'obj' will still be non-NULL.  The test
for NULL in the outer loop causes the outer loop to abort too - as the
programmer probably expected.

So by removing the 'obj == NULL' test, you would cause any usage which
breaks out of the loop to now be incorrect.

I recommend that instead of this patch, you provide a patch which
improves the documentation to make this clear. e.g.

  Note: it is safe to 'break' out of this loop even though it is a two
  nested loops.  The 'obj == NULL' test ensures that when the inner loop
  is broken, the outer loop will break too.

Thanks,
NeilBrown


>  
>  /**
> @@ -136,8 +135,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>   * @member: the name of the hlist_node within the struct
>   */
>  #define hash_for_each_rcu(name, bkt, obj, member)			\
> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
> -			(bkt)++)\
> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>  		hlist_for_each_entry_rcu(obj, &name[bkt], member)
>  
>  /**
> @@ -150,8 +148,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>   * @member: the name of the hlist_node within the struct
>   */
>  #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
> -			(bkt)++)\
> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>  		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
>  
>  /**
> -- 
> 2.23.0
> 
> 

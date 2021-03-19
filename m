Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF52341A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhCSKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:37:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhCSKhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:37:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D5C4ACC6;
        Fri, 19 Mar 2021 10:37:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B6301F2B5B; Fri, 19 Mar 2021 11:37:01 +0100 (CET)
Date:   Fri, 19 Mar 2021 11:37:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     jack@suse.cz, Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated locking documentation for journal_head
Message-ID: <20210319103701.GC4910@quack2.suse.cz>
References: <9864e9792b56bce87b016582a8759890079f7766>
 <20210319091819.113326-1-alexander.lochmann@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319091819.113326-1-alexander.lochmann@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 10:18:17, Alexander Lochmann wrote:
> LockDoc's results show that t_list_lock has been
> replaced by j_list_lock for b_next_transaction,
> b_tnext, and b_tprev.
> We, therefore, updated the documentation
> accordingly.
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

Yeah, I think that was a typo since the beginning. Thanks for the fix. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/journal-head.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/journal-head.h b/include/linux/journal-head.h
> index 75bc56109031..d68ae72784eb 100644
> --- a/include/linux/journal-head.h
> +++ b/include/linux/journal-head.h
> @@ -80,13 +80,13 @@ struct journal_head {
>  	 * Pointer to the running compound transaction which is currently
>  	 * modifying the buffer's metadata, if there was already a transaction
>  	 * committing it when the new transaction touched it.
> -	 * [t_list_lock] [b_state_lock]
> +	 * [j_list_lock] [b_state_lock]
>  	 */
>  	transaction_t *b_next_transaction;
>  
>  	/*
>  	 * Doubly-linked list of buffers on a transaction's data, metadata or
> -	 * forget queue. [t_list_lock] [b_state_lock]
> +	 * forget queue. [j_list_lock] [b_state_lock]
>  	 */
>  	struct journal_head *b_tnext, *b_tprev;
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

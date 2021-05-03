Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D02371E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhECRI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234113AbhECQ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C91F611CE;
        Mon,  3 May 2021 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620060483;
        bh=pqQt+ufivPLeHfDzgYO6blIaZRqsbQC3VMEA9EWcKbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HA3aXBnB3YjQaRuuC/hNpBOfQg7bHvFYdroZGq16La6nfkXDpDT6ewCPdFY2c5k/p
         RvLM5w1IDKInW5dbmiKtBAE+/rhbRDvf2SyMeKK73r8uPc3VI9aps74d8U7fbnmtle
         B6tvGcFvuKtWyJ8FoPDtAu2ZNpZwsIAzxZFeCpE0=
Date:   Mon, 3 May 2021 18:48:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <YJApQTRSEWUuR4qd@kroah.com>
References: <20210428173301.149619-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428173301.149619-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index 85663182b388..9cb2c7a112d2 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -124,11 +124,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
>  	spin_lock_bh(&pstapriv->sta_hash_lock);
>  
>  	phead = get_list_head(&pstapriv->free_sta_queue);
> -	plist = get_next(phead);
> -
> -	while (phead != plist) {
> -		psta = container_of(plist, struct sta_info, list);
> -		plist = get_next(plist);
> +	list_for_each(plist, phead) {
> +		psta = list_entry(plist, struct sta_info, list);
>  	}
>  
>  	spin_unlock_bh(&pstapriv->sta_hash_lock);


This chunk didn't apply to my tree as someone else cleaned something in
this function.

But that doesn't even really matter as this function does nothing at
all!

So I'll just leave it alone, and apply the patch without this chunk.

crazy code...

greg k-h

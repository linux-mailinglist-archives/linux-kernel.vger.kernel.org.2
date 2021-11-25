Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01645E1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357115AbhKYUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357113AbhKYUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:33:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86EC0613F1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iaFSt8plB4g2qCZtRIDKmSInpmSjFYz22dj65sciQlI=; b=cAi7ruXEDoZgqxCH7eyWDQNX+r
        m3IavACCyhGUn0jcRXwKGMD9YUNZLTYx6R22Kl3QxrbElu0OHNSmzC0tUxqZxZkGHWSJfXcl2Lefw
        K50ZmRlWa3XZVr3zgKixNrkLyTei9VlKMEqiHCwYSlsFMBIOGFZz0hRHRDubSfUmb+gxCsJeTeg82
        0QmzxCD7tesSYrBzT3Brlz+EgAcrcFYosF6iwWI0C2DoaEGZwi6KHHoK+QBgTqohHtgb0Vq3SW956
        Q6d6h7oc7zgUmTw/fiUQwjNPKVhbC4mSzY5vU4tKRpQsLxodXugLZacnh70Eu4gcah2w1XcwiN5bP
        ocS7gDjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqLMV-007hTy-OC; Thu, 25 Nov 2021 20:28:55 +0000
Date:   Thu, 25 Nov 2021 20:28:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the type of a parameter
Message-ID: <YZ/yBxJlznnraBe2@casper.infradead.org>
References: <20211125194301.19244-1-caoyixuan2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125194301.19244-1-caoyixuan2019@email.szu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 03:43:01AM +0800, Yixuan Cao wrote:
> The type of "last_migrate_reason" in struct page_owner is short.
> However, the type of "reason" in the argument list of function
> __set_page_owner_migrate_reason is int,
> which is inconsistent.

Did you try compiling this patch?

> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  mm/page_owner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 4f924957ce7a..4c23e910caf9 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -182,7 +182,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  }
>  
> -void __set_page_owner_migrate_reason(struct page *page, int reason)
> +void __set_page_owner_migrate_reason(struct page *page, short reason)
>  {
>  	struct page_ext *page_ext = lookup_page_ext(page);
>  	struct page_owner *page_owner;
> -- 
> 2.31.1
> 
> 
> 
> 

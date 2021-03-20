Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0D342D35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhCTOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhCTOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616249480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7j9C2SBGy1O/TXA3ex+LyIY8wv3F76xhWiBT6oqZo8=;
        b=XdEIR4OYfaM6rydfJBKNSmEXMNEP6KBV9RL6qenIPaVzVAcZcYvIPNTIEKApNQybNdYWs5
        tGy1LXI7ncmiGAGvcca2Ivhes4lYsscvOjsnSxtstAovDS72ZJ0Y9Lc2Z1t70VHPprf54w
        RZ/fGWYX/dVwiZMzgTndgAKN8pjLQ6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-fuedKYqCPCaSZVlEKe8ITg-1; Sat, 20 Mar 2021 10:11:16 -0400
X-MC-Unique: fuedKYqCPCaSZVlEKe8ITg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35EBF87A83A;
        Sat, 20 Mar 2021 14:11:15 +0000 (UTC)
Received: from x1-fbsd (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98EE960CCD;
        Sat, 20 Mar 2021 14:11:13 +0000 (UTC)
Date:   Sat, 20 Mar 2021 10:11:10 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, jglisse@redhat.com, shy828301@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
 putback_movable_page()
Message-ID: <YFYBIlkM+V0Nsl+5@x1-fbsd>
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320093701.12829-2-linmiaohe@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:36:57AM -0400, Miaohe Lin wrote:
> The !PageLocked() check is implicitly done in PageMovable(). Remove this
> explicit one.
>

I'd just keep the explicit assertion in place, regardless.
But if you're going to stick with this patch, please fix it because it's 
removing the wrong assertion.


> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..e4ca5ef508ea 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -146,7 +146,6 @@ void putback_movable_page(struct page *page)
>  	struct address_space *mapping;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(!PageMovable(page), page);
>  	VM_BUG_ON_PAGE(!PageIsolated(page), page);
>  
>  	mapping = page_mapping(page);
> -- 
> 2.19.1
> 
> 


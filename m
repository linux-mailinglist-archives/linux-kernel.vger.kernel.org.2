Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BDD3E17BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhHEPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbhHEPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:18:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA8C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=njZhkvm1vyJvdD0r+JCFjqmWiHQO4/apHfiulTdyXJI=; b=PRcDxoejEV9jYOj6oe78EgM76L
        mAUuIEsgbKHv8HqWpnZmclwDlhhw8HtvbgXyXlYXjgvBBmTDUpFNdb5EIEXioRGBKDyOOSnf3mpRA
        KXQ/KckJDjZ4WpxhmO5NIBXP+zgAe6uiF5pAvgCEyw5rbwj6GxBFDYASwRaFx7p6glkrHESLQ6WNq
        Mq8xhK0qHAYtQt3wDRnIrueWZWY4gbBJaKM8uTfs9v7LM/U89NP+WskNL3GcKAkP+Zshwz4+g+z5i
        1zS/C/xw3fozgR4/v2j14gq2IlYce9P6v3Q9mEOFfNB0K9pvHvppIywIe/Gjo7VBlZNb593spN3PI
        FZBeUXFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBf7n-007Cmc-3r; Thu, 05 Aug 2021 15:17:38 +0000
Date:   Thu, 5 Aug 2021 16:17:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
Message-ID: <YQwBD55FZyoY+C5D@casper.infradead.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
> We've got the expected count for anonymous page or file page by
> expected_page_refs() at the beginning of migrate_page_move_mapping(),
> thus we should move the page count validation a little forward to
> reduce duplicated code.

Please add an explanation to the changelog for why it's safe to pull
this out from under the i_pages lock.

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 239b238..5559571 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -386,11 +386,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
>  	long nr = folio_nr_pages(folio);
>  
> -	if (!mapping) {
> -		/* Anonymous page without mapping */
> -		if (folio_ref_count(folio) != expected_count)
> -			return -EAGAIN;
> +	if (folio_ref_count(folio) != expected_count)
> +		return -EAGAIN;
>  
> +	if (!mapping) {
>  		/* No turning back from here */
>  		newfolio->index = folio->index;
>  		newfolio->mapping = folio->mapping;
> @@ -404,8 +403,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	newzone = folio_zone(newfolio);
>  
>  	xas_lock_irq(&xas);
> -	if (folio_ref_count(folio) != expected_count ||
> -	    xas_load(&xas) != folio) {
> +	if (xas_load(&xas) != folio) {
>  		xas_unlock_irq(&xas);
>  		return -EAGAIN;
>  	}
> -- 
> 1.8.3.1
> 
> 

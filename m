Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28010387B55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhEROjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEROj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:39:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC4C061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CcpTl6ahcoWKTT9zvVzM5pO89ICfycVf67IsEN9gVHg=; b=cWObSjC1R2ayoD9cjWuik10Ftw
        JSaHdd4jdcbwIz7NG7TGRbBUhZzKfCSZGloSjbOkEKpwTsdW81UYLr1mno73udaCCu40bPsaQZMmw
        zB26D1D4BSh6BhqCHMNfAVZrpyazuhMrtvzSNr2yXGPT7Gfl1tovFNOeaSlCKDLnprc8dGPQ03JZh
        B4phq1acfQalXJ9KMyLbhIjZgvLUbAEZXQrVtDh6fiyMXVmCz9MAk9MBwXBFeL86mYEBOHfb+koLt
        Tzo0BZvzDzryE0j3ZQ65mmAv+CnFXiBQs9+HFvLovpB5hSrpLuzH5onLtEAQYtoV1jJzJxeUVjJZb
        eFgmfWmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lj0qI-00E3xA-KH; Tue, 18 May 2021 14:37:17 +0000
Date:   Tue, 18 May 2021 15:37:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/5] mm/swap: remove unused local variable nr_shadows
Message-ID: <YKPREjo49dP8mW2J@casper.infradead.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
 <20210518135352.3705306-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518135352.3705306-3-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 09:53:49PM +0800, Miaohe Lin wrote:
> Since commit 55c653b71e8c ("mm: stop accounting shadow entries"),
> nr_shadows is not used anymore.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +++ b/mm/swap_state.c
> @@ -114,7 +114,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  	SetPageSwapCache(page);
>  
>  	do {
> -		unsigned long nr_shadows = 0;
>  

Perhaps delete the blank line as well?


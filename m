Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC73EB67D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhHMODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:03:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhHMODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:03:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 452271FFC3;
        Fri, 13 Aug 2021 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628863354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAPgD0JM9is1QIYISxL/J70/LIGKS2gFj6IbXg8VR4Q=;
        b=vxSIu2cb0Q7xK6empan4IyTzEzmnohTONKoSMcNQ9GCzJO02Jp2fFv70tkgKzduglAR99E
        Sajyu12wss/iLoSaWvgxEbUdLr0ZfQ0ctw+VCJRWmfexYGTAmE3y/b6x0MnIO8UGOzn0R2
        m5vVNGftHjAsK2ky9kPqH87Uy01hPJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628863354;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAPgD0JM9is1QIYISxL/J70/LIGKS2gFj6IbXg8VR4Q=;
        b=uv5dnaubtajOMMcvFmnksuQ36wo5QJF65GoXHcrm2fbV0kdvjl6c6rwiiSSjHOSgIRdM6p
        iuDRXPby24v1lEBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC91137CB;
        Fri, 13 Aug 2021 14:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uxzcBnp7FmHjBwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 13 Aug 2021 14:02:34 +0000
Subject: Re: [PATCH] mm: remove redundant compound_head() calling
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        willy@infradead.org, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com, dhowells@redhat.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210811101431.83940-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <808194f6-e5d0-59e4-ffd5-2c77a907232c@suse.cz>
Date:   Fri, 13 Aug 2021 16:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811101431.83940-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 12:14 PM, Muchun Song wrote:
> There is a READ_ONCE() in the macro of compound_head(), which will
> prevent compiler from optimizing the code when there are more than
> once calling of it in a function. Remove the redundant calling of
> compound_head() from page_to_index() and page_add_file_rmap() for
> better code generation.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Seems to be compatible with folio/for-next and not made redundant by that (yet?
didn't check the branches planned for future versions), so OK. But long-term I'd
expect these optimizations to be obsoleted by the folio work.

> ---
>  include/linux/pagemap.h | 7 +++----
>  mm/rmap.c               | 6 ++++--
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 79ec90e97e94..03b9a957ef10 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -608,18 +608,17 @@ static inline struct page *read_mapping_page(struct address_space *mapping,
>   */
>  static inline pgoff_t page_to_index(struct page *page)
>  {
> -	pgoff_t pgoff;
> +	struct page *head;
>  
>  	if (likely(!PageTransTail(page)))
>  		return page->index;
>  
> +	head = compound_head(page);
>  	/*
>  	 *  We don't initialize ->index for tail pages: calculate based on
>  	 *  head page
>  	 */
> -	pgoff = compound_head(page)->index;
> -	pgoff += page - compound_head(page);
> -	return pgoff;
> +	return head->index + page - head;
>  }
>  
>  extern pgoff_t hugetlb_basepage_index(struct page *page);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 232494888628..2e216835f07c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1231,11 +1231,13 @@ void page_add_file_rmap(struct page *page, bool compound)
>  						nr_pages);
>  	} else {
>  		if (PageTransCompound(page) && page_mapping(page)) {
> +			struct page *head = compound_head(page);
> +
>  			VM_WARN_ON_ONCE(!PageLocked(page));
>  
> -			SetPageDoubleMap(compound_head(page));
> +			SetPageDoubleMap(head);
>  			if (PageMlocked(page))
> -				clear_page_mlock(compound_head(page));
> +				clear_page_mlock(head);
>  		}
>  		if (!atomic_inc_and_test(&page->_mapcount))
>  			goto out;
> 


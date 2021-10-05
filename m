Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99642210A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhJEIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:47:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44010 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:47:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E058020272;
        Tue,  5 Oct 2021 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633423559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExidNuWCqnGf0/HJrIEctui2gYVjZ4NbIpRJWFCI2Ns=;
        b=G2H3j7aIGcNz3ZWnQywfH18Mj7c4BPPgP6FRHA3/POFjoE9msPfEhr/FR0wPv0NDZqlUbr
        0cKUAH9ZcbBwP1XgtaNQg8b+mmiS/KhpYtuynnFeqFg+NevZT6qnGUEtGheCl+2tpH9BWd
        qAvh7CLwe+eHqXDjSYUthh3oBt1a0C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633423559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExidNuWCqnGf0/HJrIEctui2gYVjZ4NbIpRJWFCI2Ns=;
        b=6An5bkniBrbnJyKoLShgnPmmt3vlLrcqP1zbiVqFUIkUQWnvef8kZ+qWsBwpKrOskSI9Mw
        xRSFWPkPnSiYq7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4773C1342A;
        Tue,  5 Oct 2021 08:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RSmoDscQXGH8bAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 05 Oct 2021 08:45:59 +0000
Date:   Tue, 5 Oct 2021 10:45:57 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/5] mm/cma: add cma_pages_valid to determine if pages
 are in CMA
Message-ID: <20211005084557.GB20412@linux>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001175210.45968-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:07AM -0700, Mike Kravetz wrote:
> +bool cma_pages_valid(struct cma *cma, const struct page *pages,
> +		     unsigned long count)
> +{
> +	unsigned long pfn;
> +
> +	if (!cma || !pages)
> +		return false;
> +
> +	pfn = page_to_pfn(pages);
> +
> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * cma_release() - release allocated pages
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -539,16 +555,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  {
>  	unsigned long pfn;
>  
> -	if (!cma || !pages)
> +	if (!cma_pages_valid(cma, pages, count))
>  		return false;
>  
>  	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>  
>  	pfn = page_to_pfn(pages);
>  
> -	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> -		return false;
> -

After this patch, the timing of printing the debug statement changes as we back
off earlier.
You might want to point that out in the changelog in case someone wonders why.


-- 
Oscar Salvador
SUSE Labs

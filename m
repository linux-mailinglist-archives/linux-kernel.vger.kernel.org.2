Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA85D42393C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhJFH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:56:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJFH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:56:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 316A5224A4;
        Wed,  6 Oct 2021 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633506894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LcqWhC00ZqHExQq5oj/GC6xpMxgdSG0r21cl1T5yiHE=;
        b=FTY5HHctkRwsyin45+6jYfFNVbXp7sa+UMhBHEYqYGuoY0Z69NnrTG/6ZoJUbxCcZtcYl0
        VH40+w0PITHH8Ctk/V5nnOdjqq8g/TON73XSA/XoA+nqC7yGx7cI9XFTbaOuq1VHMGFgZU
        eSCXutz0lOTuGZuMGmTf28+IMWa2tUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633506894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LcqWhC00ZqHExQq5oj/GC6xpMxgdSG0r21cl1T5yiHE=;
        b=EabwiBHpBqPS1yaBPKzwkcxFEL3tdNqRz6qSQyRkukE1yiEhYIcAYI0U2tgOhTOtU/dj4r
        38I4VkF8rA/8anDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9230713E23;
        Wed,  6 Oct 2021 07:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id shwPIU1WXWF2GQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 06 Oct 2021 07:54:53 +0000
Date:   Wed, 6 Oct 2021 09:54:51 +0200
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
Subject: Re: [PATCH v3 3/5] hugetlb: be sure to free demoted CMA pages to CMA
Message-ID: <20211006075451.GA11341@linux>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-4-mike.kravetz@oracle.com>
 <20211005093320.GC20412@linux>
 <f1f011cc-5c5a-7c4f-5701-929918fa2dbb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f011cc-5c5a-7c4f-5701-929918fa2dbb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:57:54AM -0700, Mike Kravetz wrote:
> It is the smallest.
> 
> CMA uses a per-region bit map to track allocations.  When setting up the
> region, you specify how many pages each bit represents.  Currently,
> only gigantic pages are allocated/freed from CMA so the region is set up
> such that one bit represents a gigantic page size allocation.
> 
> With demote, a gigantic page (allocation) could be split into smaller
> size pages.  And, these smaller size pages will be freed to CMA.  So,
> since the per-region bit map needs to be set up to represent the smallest
> allocation/free size, it now needs to be set to the smallest huge page
> size which can be freed to CMA.
> 
> Unfortunately, we set up the CMA region for huge pages before we set up
> huge pages sizes (hstates).  So, technically we do not know the smallest
> huge page size as this can change via command line options and
> architecture specific code.  Therefore, at region setup time we need some
> constant value for smallest possible huge page size.  That is why
> HUGETLB_PAGE_ORDER is used.

Do you know if that is done for a reason? Setting up CMA for hugetlb before
initialiting hugetlb itself? Would not make more sense to do it the other way
around?

The way I see it is that it is a bit unfortunate that we cannot only demote
gigantic pages per se, so 1GB on x86_64 and 16G on arm64 with 64k page size.

I guess nothing to be worried about now as this is an early stage, but maybe
something to think about in the future in we case we want to allow for more
flexibility.

> I should probably add all that to the changelog for clarity?

Yes, I think it would be great to have that as a context.

> After your comment yesterday about rewriting this code for clarity,  this
> now becomes:
> 
> 		/*
> 		 * Set demote order for each hstate.  Note that
> 		 * h->demote_order is initially 0.
> 		 * - We can not demote gigantic pages if runtime freeing
> 		 *   is not supported, so skip this.
> 		 * - If CMA allocation is possible, we can not demote
> 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
> 		 */
> 		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 			continue;
> 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
> 			continue;
> 		for_each_hstate(h2) {
> 			if (h2 == h)
> 				continue;
> 			if (h2->order < h->order &&
> 			    h2->order > h->demote_order)
> 				h->demote_order = h2->order;
> 		}
> 
> Hopefully, that is more clear.

Defintiely, this looks better to me.

-- 
Oscar Salvador
SUSE Labs

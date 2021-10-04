Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6A420C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhJDNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:04:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43104 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbhJDNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:02:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 319A91FDE4;
        Mon,  4 Oct 2021 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633352462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OUdZ/nUYlMda2qgf/QTNrmYQhSZjUvD2BVvzV1p93qg=;
        b=PlAvfOCalzYQ013C27JLg5Vy+Z/vf/uiwSxm/Bu7hjNt8wwEbE5U/Zfb4Q5zNo6sYv8ILY
        C2BPI/WuFfsZ0g92iMgEb9/0NuTXgirsFWkBAwQenu8AN1XMDIFExA7ukjd7YB3pRyXBVb
        CsCEXhrrDH6uOD1RH2MPnr7KI2MyyQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633352462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OUdZ/nUYlMda2qgf/QTNrmYQhSZjUvD2BVvzV1p93qg=;
        b=j7d7WR2b8JODNDoPphHnSSXZWwz4S5Hp3n8mb1sh/dtyIw6HKEitN96ypyum4uBT9GH0X3
        OIkN4WfZ7Tn5WBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5136313CEE;
        Mon,  4 Oct 2021 13:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wPEiDw37WmGKPAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 04 Oct 2021 13:01:01 +0000
Date:   Mon, 4 Oct 2021 15:00:59 +0200
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
Subject: Re: [PATCH v3 1/5] hugetlb: add demote hugetlb page sysfs interfaces
Message-ID: <YVr7C8ek1g9hKz4C@localhost.localdomain>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001175210.45968-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:06AM -0700, Mike Kravetz wrote:
> -which function as described above for the default huge page-sized case.
> +The demote interfaces provide the ability to split a huge page into
> +smaller huge pages.  For example, the x86 architecture supports both
> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
> +2MB huge pages.  Demote interfaces are not available for the smallest
> +huge page size.  The demote interfaces are:
> +
> +demote_size
> +        is the size of demoted pages.  When a page is demoted a corresponding
> +        number of huge pages of demote_size will be created.  By default,
> +        demote_size is set to the next smaller huge page size.  If there are
> +        multiple smaller huge page sizes, demote_size can be set to any of
> +        these smaller sizes.  Only huge page sizes less then the current huge

s/then/than ?

>  static void __init hugetlb_init_hstates(void)
>  {
> -	struct hstate *h;
> +	struct hstate *h, *h2;
>  
>  	for_each_hstate(h) {
>  		if (minimum_order > huge_page_order(h))
> @@ -2995,6 +2995,23 @@ static void __init hugetlb_init_hstates(void)
>  		/* oversize hugepages were init'ed in early boot */
>  		if (!hstate_is_gigantic(h))
>  			hugetlb_hstate_alloc_pages(h);
> +
> +		/*
> +		 * Set demote order for each hstate.  Note that
> +		 * h->demote_order is initially 0.
> +		 * - We can not demote gigantic pages if runtime freeing
> +		 *   is not supported.
> +		 */
> +		if (!hstate_is_gigantic(h) ||
> +		    gigantic_page_runtime_supported()) {

Based on the comment, I think that making the condition explicit looks
better from my point of view.

if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    continue;

> +			for_each_hstate(h2) {
> +				if (h2 == h)
> +					continue;
> +				if (h2->order < h->order &&
> +				    h2->order > h->demote_order)
> +					h->demote_order = h2->order;
> +			}
> +		}
>  	}
>  	VM_BUG_ON(minimum_order == UINT_MAX);
>  }
> @@ -3235,9 +3252,29 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	return 0;
>  }
>  

-- 
Oscar Salvador
SUSE L3

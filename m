Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13E35DFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhDMNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhDMNYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:24:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618320274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgVgfP+J7DIBhEv0CRZ/1Mun/+0vSfjv/jkjrg7B9aA=;
        b=ZLCIQLgVhVDJuQBBuZxQrHH+/v2GCz5xa0StiXPdClg0F1j3mfMKNxZgEeou9w05tQ/8ir
        P9urlNZamiktMw5QXM+wyypiIMoFfiK49b9l8PdHpC5/dHK5nIkfkCgZdpB9p7VyVlZeMO
        QuKljz5eF9nkwTdan8pjiYs9GNnGvnA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A46CEAE89;
        Tue, 13 Apr 2021 13:24:34 +0000 (UTC)
Date:   Tue, 13 Apr 2021 15:24:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Message-ID: <YHWbkNqLsNht6who@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413104747.12177-5-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 12:47:44, Oscar Salvador wrote:
[...]
> +static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> +{
> +	__prep_new_huge_page(page);
>  	spin_lock_irq(&hugetlb_lock);
> -	h->nr_huge_pages++;
> -	h->nr_huge_pages_node[nid]++;
> +	__prep_account_new_huge_page(h, nid);
>  	spin_unlock_irq(&hugetlb_lock);
>  }

Any reason to decouple the locking from the accounting?
>  
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs

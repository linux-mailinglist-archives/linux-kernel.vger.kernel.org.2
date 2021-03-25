Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47487348D48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCYJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:45:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhCYJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:45:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616665520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oedc/H3NO/+XIDe2SVuW1rBJVHajjrgbUCS7N70jjOk=;
        b=O4nlFbP307bh6WYdedGymTNc9qAjh88PvhssLPuABMHN6+0xJe7+5mdZE8Lz52VR2z7Oed
        Duy5dFNEjgw364TbeEtRCO2m7YdcAUB6wNbM5/Nke7P/a4f8Qh5L0JMtogCdZSLoG3zLkB
        XqC3YvjpsXJbXtOCLp5YX4lAeg/FpNg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCE42AC16;
        Thu, 25 Mar 2021 09:45:19 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:45:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:28, Mike Kravetz wrote:
[...]
>  phys_addr_t cma_get_base(const struct cma *cma)
>  {
>  	return PFN_PHYS(cma->base_pfn);
> @@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
>  	for (i = 0; i < cma_area_count; i++)
>  		cma_activate_area(&cma_areas[i]);
>  
> +	cma_release_wq = create_workqueue("cma_release");

Considering the workqueue is used to free up memory it should likely be
WQ_MEM_RECLAIM to prevent from long stalls when WQs are overloaded.

I cannot judge the CMA parts from a very quick glance this looks
reasonably.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D241676F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhIWVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243291AbhIWVZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:25:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FD0F60F6D;
        Thu, 23 Sep 2021 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632432266;
        bh=KnyKutFqoAJwR5PxeXhTE9a7a66eM57gSt+VwjBbwkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zCkdcbEgoqvuk+qfIW2/B5tKC4A4ZfwOYErSaEF9rzypQUPOQpRg7Ue5j622RyQJR
         FMFy5fQKfRE026MnISTuLuke+H2hgWeBNTj5D4p0s7NsF84WNQEAVrc0Yg6tr1fnGP
         +7Bp7GfdveYJ8oDHqLCILzej44+gALcnlIc4Eymw=
Date:   Thu, 23 Sep 2021 14:24:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs
 interfaces
Message-Id: <20210923142426.8930bd1cfcabc782a2152c18@linux-foundation.org>
In-Reply-To: <20210923175347.10727-2-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
        <20210923175347.10727-2-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 10:53:44 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Two new sysfs files are added to demote hugtlb pages.  These files are
> both per-hugetlb page size and per node.  Files are:
>   demote_size - The size in Kb that pages are demoted to. (read-write)
>   demote - The number of huge pages to demote. (write-only)
> 
> By default, demote_size is the next smallest huge page size.  Valid huge
> page sizes less than huge page size may be written to this file.  When
> huge pages are demoted, they are demoted to this size.
> 
> Writing a value to demote will result in an attempt to demote that
> number of hugetlb pages to an appropriate number of demote_size pages.
> 
> NOTE: Demote interfaces are only provided for huge page sizes if there
> is a smaller target demote huge page size.  For example, on x86 1GB huge
> pages will have demote interfaces.  2MB huge pages will not have demote
> interfaces.
> 
> This patch does not provide full demote functionality.  It only provides
> the sysfs interfaces.
> 
> It also provides documentation for the new interfaces.
> 
> ...
>
> +static ssize_t demote_store(struct kobject *kobj,
> +	       struct kobj_attribute *attr, const char *buf, size_t len)
> +{
> +	unsigned long nr_demote;
> +	unsigned long nr_available;
> +	nodemask_t nodes_allowed, *n_mask;
> +	struct hstate *h;
> +	int err;
> +	int nid;
> +
> +	err = kstrtoul(buf, 10, &nr_demote);
> +	if (err)
> +		return err;
> +	h = kobj_to_hstate(kobj, &nid);
> +
> +	/* Synchronize with other sysfs operations modifying huge pages */
> +	mutex_lock(&h->resize_lock);
> +
> +	spin_lock_irq(&hugetlb_lock);
> +	if (nid != NUMA_NO_NODE) {
> +		nr_available = h->free_huge_pages_node[nid];
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
> +	} else {
> +		nr_available = h->free_huge_pages;
> +		n_mask = &node_states[N_MEMORY];
> +	}
> +	nr_available -= h->resv_huge_pages;
> +	if (nr_available <= 0)
> +		goto out;
> +	nr_demote = min(nr_available, nr_demote);
> +
> +	while (nr_demote) {
> +		if (!demote_pool_huge_page(h, n_mask))
> +			break;
> +
> +		/*
> +		 * We may have dropped the lock in the routines to
> +		 * demote/free a page.  Recompute nr_demote as counts could
> +		 * have changed and we want to make sure we do not demote
> +		 * a reserved huge page.
> +		 */

This comment doesn't become true until patch #4, and is a bit confusing
in patch #1.  Also, saying "the lock" is far less helpful than saying
"hugetlb_lock"!


> +		nr_demote--;
> +		if (nid != NUMA_NO_NODE)
> +			nr_available = h->free_huge_pages_node[nid];
> +		else
> +			nr_available = h->free_huge_pages;
> +		nr_available -= h->resv_huge_pages;
> +		if (nr_available <= 0)
> +			nr_demote = 0;
> +		else
> +			nr_demote = min(nr_available, nr_demote);
> +	}
> +
> +out:
> +	spin_unlock_irq(&hugetlb_lock);

How long can we spend with IRQs disabled here (after patch #4!)?

> +	mutex_unlock(&h->resize_lock);
> +
> +	return len;
> +}
> +HSTATE_ATTR_WO(demote);
> +


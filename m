Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38B439045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJYH0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:26:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52776 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhJYH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:26:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85D2E21709;
        Mon, 25 Oct 2021 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635146664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLIElNgWls0m10MMnxTbJ7+jlz26AIDr6YPYX4k5c9k=;
        b=fEXGKlkVBpaYKisUwoF3zfejibRCigYixOXzlyRQznC3mEedTlquKSxOkSm5VSxYFySeod
        OEMftDc+XFucVXkv/YJDkGZx9524EF0QyDkAu9UsLST07cL5uJ1ZdDgs+nwxHLG3ptNusy
        kmUUJV7JEa9Q4bnzCqmBHoFxipCaAJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635146664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLIElNgWls0m10MMnxTbJ7+jlz26AIDr6YPYX4k5c9k=;
        b=2YoaYmLZFjw2y508RUgR4cT5SDxeObt+gisR1KW33W6Hm3GOi2SxVwjVkxQ+gk0UiTWTRP
        pv3wuldWwJvWa/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5E131342A;
        Mon, 25 Oct 2021 07:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LcV/MadbdmGFCAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 25 Oct 2021 07:24:23 +0000
Date:   Mon, 25 Oct 2021 09:24:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces
Message-ID: <20211025072421.GB6338@linux>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-2-mike.kravetz@oracle.com>
 <YV/4ZFCvoGRn2rtr@localhost.localdomain>
 <47e53389-638a-1af1-e94f-b3c7e5e7459e@oracle.com>
 <20211018073552.GA11960@linux>
 <0530e4ef-2492-5186-f919-5db68edea654@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0530e4ef-2492-5186-f919-5db68edea654@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:58:42AM -0700, Mike Kravetz wrote:
> From f9c401323fee234667787a118c74d93aa185fcf6 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 22 Oct 2021 11:40:57 -0700
> Subject: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces
> 
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
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
 
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst |  30 +++-
>  include/linux/hugetlb.h                      |   1 +
>  mm/hugetlb.c                                 | 155 ++++++++++++++++++-
>  3 files changed, 183 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144e44..bb90de3885d1 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -234,8 +234,12 @@ will exist, of the form::
>  
>  	hugepages-${size}kB
>  
> -Inside each of these directories, the same set of files will exist::
> +Inside each of these directories, the set of files contained in ``/proc``
> +will exist.  In addition, two additional interfaces for demoting huge
> +pages may exist::
>  
> +        demote
> +        demote_size
>  	nr_hugepages
>  	nr_hugepages_mempolicy
>  	nr_overcommit_hugepages
> @@ -243,7 +247,29 @@ Inside each of these directories, the same set of files will exist::
>  	resv_hugepages
>  	surplus_hugepages
>  
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
> +        these smaller sizes.  Only huge page sizes less than the current huge
> +        pages size are allowed.
> +
> +demote
> +        is used to demote a number of huge pages.  A user with root privileges
> +        can write to this file.  It may not be possible to demote the
> +        requested number of huge pages.  To determine how many pages were
> +        actually demoted, compare the value of nr_hugepages before and after
> +        writing to the demote interface.  demote is a write only interface.
> +
> +The interfaces which are the same as in ``/proc`` (all except demote and
> +demote_size) function as described above for the default huge page-sized case.
>  
>  .. _mem_policy_and_hp_alloc:
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..f2c3979efd69 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -596,6 +596,7 @@ struct hstate {
>  	int next_nid_to_alloc;
>  	int next_nid_to_free;
>  	unsigned int order;
> +	unsigned int demote_order;
>  	unsigned long mask;
>  	unsigned long max_huge_pages;
>  	unsigned long nr_huge_pages;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95dc7b83381f..d2262ad4b3ed 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  static void __init hugetlb_init_hstates(void)
>  {
> -	struct hstate *h;
> +	struct hstate *h, *h2;
>  
>  	for_each_hstate(h) {
>  		if (minimum_order > huge_page_order(h))
> @@ -2995,6 +2995,22 @@ static void __init hugetlb_init_hstates(void)
>  		/* oversize hugepages were init'ed in early boot */
>  		if (!hstate_is_gigantic(h))
>  			hugetlb_hstate_alloc_pages(h);
> +
> +		/*
> +		 * Set demote order for each hstate.  Note that
> +		 * h->demote_order is initially 0.
> +		 * - We can not demote gigantic pages if runtime freeing
> +		 *   is not supported, so skip this.
> +		 */
> +		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +			continue;
> +		for_each_hstate(h2) {
> +			if (h2 == h)
> +				continue;
> +			if (h2->order < h->order &&
> +			    h2->order > h->demote_order)
> +				h->demote_order = h2->order;
> +		}
>  	}
>  	VM_BUG_ON(minimum_order == UINT_MAX);
>  }
> @@ -3235,9 +3251,31 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	return 0;
>  }
>  
> +static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> +	__must_hold(&hugetlb_lock)
> +{
> +	int rc = 0;
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	/* We should never get here if no demote order */
> +	if (!h->demote_order) {
> +		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
> +		return -EINVAL;		/* internal error */
> +	}
> +
> +	/*
> +	 * TODO - demote fucntionality will be added in subsequent patch
> +	 */
> +	return rc;
> +}
> +
>  #define HSTATE_ATTR_RO(_name) \
>  	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  
> +#define HSTATE_ATTR_WO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
> +
>  #define HSTATE_ATTR(_name) \
>  	static struct kobj_attribute _name##_attr = \
>  		__ATTR(_name, 0644, _name##_show, _name##_store)
> @@ -3433,6 +3471,105 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
>  }
>  HSTATE_ATTR_RO(surplus_hugepages);
>  
> +static ssize_t demote_store(struct kobject *kobj,
> +	       struct kobj_attribute *attr, const char *buf, size_t len)
> +{
> +	unsigned long nr_demote;
> +	unsigned long nr_available;
> +	nodemask_t nodes_allowed, *n_mask;
> +	struct hstate *h;
> +	int err = 0;
> +	int nid;
> +
> +	err = kstrtoul(buf, 10, &nr_demote);
> +	if (err)
> +		return err;
> +	h = kobj_to_hstate(kobj, &nid);
> +
> +	if (nid != NUMA_NO_NODE) {
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
> +	} else {
> +		n_mask = &node_states[N_MEMORY];
> +	}
> +
> +	/* Synchronize with other sysfs operations modifying huge pages */
> +	mutex_lock(&h->resize_lock);
> +	spin_lock_irq(&hugetlb_lock);
> +
> +	while (nr_demote) {
> +		/*
> +		 * Check for available pages to demote each time thorough the
> +		 * loop as demote_pool_huge_page will drop hugetlb_lock.
> +		 *
> +		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
> +		 * but will when full demote functionality is added in a later
> +		 * patch.
> +		 */
> +		if (nid != NUMA_NO_NODE)
> +			nr_available = h->free_huge_pages_node[nid];
> +		else
> +			nr_available = h->free_huge_pages;
> +		nr_available -= h->resv_huge_pages;
> +		if (!nr_available)
> +			break;
> +
> +		err = demote_pool_huge_page(h, n_mask);
> +		if (err)
> +			break;
> +
> +		nr_demote--;
> +	}
> +
> +	spin_unlock_irq(&hugetlb_lock);
> +	mutex_unlock(&h->resize_lock);
> +
> +	if (err)
> +		return err;
> +	return len;
> +}
> +HSTATE_ATTR_WO(demote);
> +
> +static ssize_t demote_size_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	int nid;
> +	struct hstate *h = kobj_to_hstate(kobj, &nid);
> +	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
> +
> +	return sysfs_emit(buf, "%lukB\n", demote_size);
> +}
> +
> +static ssize_t demote_size_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct hstate *h, *demote_hstate;
> +	unsigned long demote_size;
> +	unsigned int demote_order;
> +	int nid;
> +
> +	demote_size = (unsigned long)memparse(buf, NULL);
> +
> +	demote_hstate = size_to_hstate(demote_size);
> +	if (!demote_hstate)
> +		return -EINVAL;
> +	demote_order = demote_hstate->order;
> +
> +	/* demote order must be smaller than hstate order */
> +	h = kobj_to_hstate(kobj, &nid);
> +	if (demote_order >= h->order)
> +		return -EINVAL;
> +
> +	/* resize_lock synchronizes access to demote size and writes */
> +	mutex_lock(&h->resize_lock);
> +	h->demote_order = demote_order;
> +	mutex_unlock(&h->resize_lock);
> +
> +	return count;
> +}
> +HSTATE_ATTR(demote_size);
> +
>  static struct attribute *hstate_attrs[] = {
>  	&nr_hugepages_attr.attr,
>  	&nr_overcommit_hugepages_attr.attr,
> @@ -3449,6 +3586,16 @@ static const struct attribute_group hstate_attr_group = {
>  	.attrs = hstate_attrs,
>  };
>  
> +static struct attribute *hstate_demote_attrs[] = {
> +	&demote_size_attr.attr,
> +	&demote_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group hstate_demote_attr_group = {
> +	.attrs = hstate_demote_attrs,
> +};
> +
>  static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>  				    struct kobject **hstate_kobjs,
>  				    const struct attribute_group *hstate_attr_group)
> @@ -3466,6 +3613,12 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>  		hstate_kobjs[hi] = NULL;
>  	}
>  
> +	if (h->demote_order) {
> +		if (sysfs_create_group(hstate_kobjs[hi],
> +					&hstate_demote_attr_group))
> +			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
> +	}
> +
>  	return retval;
>  }
>  
> -- 
> 2.31.1
> 

-- 
Oscar Salvador
SUSE Labs

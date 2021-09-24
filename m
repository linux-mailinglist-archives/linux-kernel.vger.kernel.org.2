Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17414416EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbhIXJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245078AbhIXJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632475738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dewN/gQJEYK/c39ekpHoZM0DT5BTWPCy8XW+k6sgY3Q=;
        b=A/CDDJmlKEv+oBzmi9Hwjuc2sXwLlnMwX1kI0pZ3h2FhMImEGfAeGrIUdXfleSkjOcCtli
        KHFd+/f3+wH0gL1HpSfcahrlM4QkxqQPwVtsKYuuWW5Dv9+crZXYp4fflxgNfDpdSOSgg5
        ZMo8E8+ck3PQBDvcLjSmxPaW/deNbfA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-RyS90kmOP7SBK3kNeq-ifw-1; Fri, 24 Sep 2021 05:28:57 -0400
X-MC-Unique: RyS90kmOP7SBK3kNeq-ifw-1
Received: by mail-wr1-f69.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso7546752wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dewN/gQJEYK/c39ekpHoZM0DT5BTWPCy8XW+k6sgY3Q=;
        b=O1WbQc4fvLcm0sw9nS6Z/yQFzIVBVlmGWd6YnjrnHWCvcW5AFv0ksUXfkA1FPSa4u4
         gn5val6Kf543IQJ7va2RqqHUw6ygtl7lEMOSP15n+uzXjDhV26W5PI8TL3VS3IfU+QYN
         +VYA/9egT7s/ghKFB6U407skcRsVQxY0NsZKOFrY4E1m+82bE4I7gZ0pUJ+/vEU8Gr52
         Nx0UUQwgWoACjrqQUUJpCSN7AAuJhVpdPCPz7+irpfdgESOiuzBQgUuOPMPvnk7d9/8D
         eMthIRfLGAVtHGfXlLWkUNEoeT8SLdbI21xx5/lh0s6qKjjDXMNAEyv3XKac+qukTdWP
         O1RQ==
X-Gm-Message-State: AOAM531Om2FCE5RG2rA2tdRVSgGOJ14bHmjcR9rtmJxyKuZ9k3Rdewyu
        1kHexy8NLyg5X16+g8TiaPZseNSTWAMcBpJ1SnSkr3FivPQPdppyBdm0pK4oyj7QmYAaYlWYI5A
        FNTEzDCQW7FYtilJxjjMOMOE3
X-Received: by 2002:adf:f18a:: with SMTP id h10mr10340807wro.42.1632475736188;
        Fri, 24 Sep 2021 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3hItjVEh67XQyuIrQrYkPz7zRbOE56mwf9j6KZF9k4qKQrxOVrDbYt5ArC/jvLrEHlCVlvA==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr10340784wro.42.1632475735886;
        Fri, 24 Sep 2021 02:28:55 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id f1sm7937737wrc.66.2021.09.24.02.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:28:55 -0700 (PDT)
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-2-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
Message-ID: <4fcf5b61-8c01-0fa9-7541-afa755a81039@redhat.com>
Date:   Fri, 24 Sep 2021 11:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923175347.10727-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.21 19:53, Mike Kravetz wrote:
> Two new sysfs files are added to demote hugtlb pages.  These files are
> both per-hugetlb page size and per node.  Files are:
>    demote_size - The size in Kb that pages are demoted to. (read-write)
>    demote - The number of huge pages to demote. (write-only)
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
> ---
>   Documentation/admin-guide/mm/hugetlbpage.rst |  30 +++-
>   include/linux/hugetlb.h                      |   1 +
>   mm/hugetlb.c                                 | 155 ++++++++++++++++++-
>   3 files changed, 183 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144e44..0e123a347e1e 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -234,8 +234,12 @@ will exist, of the form::
>   
>   	hugepages-${size}kB
>   
> -Inside each of these directories, the same set of files will exist::
> +Inside each of these directories, the set of files contained in ``/proc``
> +will exist.  In addition, two additional interfaces for demoting huge
> +pages may exist::
>   
> +        demote
> +        demote_size
>   	nr_hugepages
>   	nr_hugepages_mempolicy
>   	nr_overcommit_hugepages
> @@ -243,7 +247,29 @@ Inside each of these directories, the same set of files will exist::
>   	resv_hugepages
>   	surplus_hugepages
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
> +        these smaller sizes.  Only huge page sizes less then the current huge
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
>   .. _mem_policy_and_hp_alloc:
>   
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..f2c3979efd69 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -596,6 +596,7 @@ struct hstate {
>   	int next_nid_to_alloc;
>   	int next_nid_to_free;
>   	unsigned int order;
> +	unsigned int demote_order;
>   	unsigned long mask;
>   	unsigned long max_huge_pages;
>   	unsigned long nr_huge_pages;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6378c1066459..c76ee0bd6374 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   
>   static void __init hugetlb_init_hstates(void)
>   {
> -	struct hstate *h;
> +	struct hstate *h, *h2;
>   
>   	for_each_hstate(h) {
>   		if (minimum_order > huge_page_order(h))
> @@ -2995,6 +2995,17 @@ static void __init hugetlb_init_hstates(void)
>   		/* oversize hugepages were init'ed in early boot */
>   		if (!hstate_is_gigantic(h))
>   			hugetlb_hstate_alloc_pages(h);
> +
> +		/*
> +		 * Set demote order for each hstate.  Note that
> +		 * h->demote_order is initially 0.
> +		 */
> +		for_each_hstate(h2) {
> +			if (h2 == h)
> +				continue;
> +			if (h2->order < h->order && h2->order > h->demote_order)
> +				h->demote_order = h2->order;
> +		}
>   	}
>   	VM_BUG_ON(minimum_order == UINT_MAX);
>   }
> @@ -3235,9 +3246,29 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>   	return 0;
>   }
>   
> +static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> +	__must_hold(&hugetlb_lock)
> +{
> +	int rc = 0;
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	/* We should never get here if no demote order */
> +	if (!h->demote_order)
> +		return rc;
> +
> +	/*
> +	 * TODO - demote fucntionality will be added in subsequent patch
> +	 */
> +	return rc;
> +}
> +
>   #define HSTATE_ATTR_RO(_name) \
>   	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   
> +#define HSTATE_ATTR_WO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
> +
>   #define HSTATE_ATTR(_name) \
>   	static struct kobj_attribute _name##_attr = \
>   		__ATTR(_name, 0644, _name##_show, _name##_store)
> @@ -3433,6 +3464,112 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
>   }
>   HSTATE_ATTR_RO(surplus_hugepages);
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
>

Wonder if you could compress that quite a bit:


...
spin_lock_irq(&hugetlb_lock);

if (nid != NUMA_NO_NODE) {
	init_nodemask_of_node(&nodes_allowed, nid);
	n_mask = &nodes_allowed;
} else {
	n_mask = &node_states[N_MEMORY];
}

while (nr_demote) {
	/*
	 * Update after each iteration because we might have temporarily
	 * dropped the lock and our counters changes.
	 */
	if (nid != NUMA_NO_NODE)
		nr_available = h->free_huge_pages_node[nid];
	else
		nr_available = h->free_huge_pages;
	nr_available -= h->resv_huge_pages;
	if (nr_available <= 0)
		break;
	if (!demote_pool_huge_page(h, n_mask))
		break;
	nr_demote--;
};
spin_unlock_irq(&hugetlb_lock);

Not sure if that "nr_demote = min(nr_available, nr_demote);" logic is 
really required. Once nr_available hits <= 0 we'll just stop denoting.

-- 
Thanks,

David / dhildenb


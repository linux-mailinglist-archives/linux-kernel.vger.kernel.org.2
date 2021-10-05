Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649BF4220A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhJEIZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:25:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJEIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:25:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CBA2223F3;
        Tue,  5 Oct 2021 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633422239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSvxM5C6EzXCJb+jzr0CptvMNBt5k5JXIfSsVkx5rks=;
        b=TSzDzbp6C7l2AyGK2ULc0m6HRsYSrZRuP1Tkmvope3p52tIIEhPcJJA6Lx3E4ZbLL/x1Z1
        K5PbI1qm41/m33jVtWSty7pkG7gCT8fM7WBR++Wp3hbCByyVORArlVXMWKMtt1TGlY0AJB
        iLmPwrsIdDMCpCgMcdieiNZMmP7K094=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633422239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSvxM5C6EzXCJb+jzr0CptvMNBt5k5JXIfSsVkx5rks=;
        b=bsVPEyzGga2BRGr9qDifD94JaCdHXocXLT2bkXbsx61oGeAu9rxBcBzBZFYhhf+JKj00mb
        W6+zd1mbYnmLYiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5605B13A78;
        Tue,  5 Oct 2021 08:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xVieFJ8LXGEIYwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 05 Oct 2021 08:23:59 +0000
MIME-Version: 1.0
Date:   Tue, 05 Oct 2021 10:23:59 +0200
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
In-Reply-To: <20211001175210.45968-2-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-2-mike.kravetz@oracle.com>
User-Agent: Roundcube Webmail
Message-ID: <04e66e73b17c367d3f4b2b40e0cd7e17@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-01 19:52, Mike Kravetz wrote:
> +static int demote_pool_huge_page(struct hstate *h, nodemask_t 
> *nodes_allowed)
> +	__must_hold(&hugetlb_lock)
> +{
> +	int rc = 0;
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	/* We should never get here if no demote order */
> +	if (!h->demote_order)
> +		return rc;

Probably add a warning here? If we should never reach this but we do, 
then
something got screwed along the way and we might want to know.

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
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
> +	} else {
> +		n_mask = &node_states[N_MEMORY];
> +	}

Cannot the n_mask dance be outside the locks? That does not need to be 
protected, right?

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
> +		if (!demote_pool_huge_page(h, n_mask))
> +			break;

Is it possible that when demote_pool_huge_page() drops the lock,
h->resv_huge_pages change? Or that can only happen under h->resize_lock?

> +
> +		nr_demote--;
> +	}
> +
> +	spin_unlock_irq(&hugetlb_lock);
> +	mutex_unlock(&h->resize_lock);
> +
> +	return len;
> +}
> +HSTATE_ATTR_WO(demote);
> +
> +static ssize_t demote_size_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct hstate *h;
> +	unsigned long demote_size;
> +	int nid;
> +
> +	h = kobj_to_hstate(kobj, &nid);
> +	demote_size = h->demote_order;

This has already been pointed out.

> +
> +	return sysfs_emit(buf, "%lukB\n",
> +			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
> +}
> +
> +static ssize_t demote_size_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct hstate *h, *t_hstate;
> +	unsigned long demote_size;
> +	unsigned int demote_order;
> +	int nid;

This is just a nit-pick, but what is t_hstate? demote_hstate might be 
more descriptive.

> +
> +	demote_size = (unsigned long)memparse(buf, NULL);
> +
> +	t_hstate = size_to_hstate(demote_size);
> +	if (!t_hstate)
> +		return -EINVAL;
> +	demote_order = t_hstate->order;
> +
> +	/* demote order must be smaller hstate order */

"must be smaller than"

-- 
Oscar Salvador
SUSE Labs

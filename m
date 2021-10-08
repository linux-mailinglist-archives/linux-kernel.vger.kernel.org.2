Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B007142656E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhJHHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:53:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJHHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:52:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE90521D6C;
        Fri,  8 Oct 2021 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633679462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOrO/y2fMgV1Ja1dD+8lPp0L19uK5f6z18Da2kjk2yQ=;
        b=imGUG8SqVGc7Dz6yptaCglkipl90+lZ1xYMYRBBrROVm0qU0I0o0Gs8Dj6plkiUWaEQQG+
        HA4sstusX3KtXMOoJqx08gr6qmnFUJD9Z5X0oopHveCOoJzPZuEMEQ3fFJ/BQ6c3QJKs0W
        2O8Z4iicadz+oX4yBpbSdv/FLPOcik0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633679462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOrO/y2fMgV1Ja1dD+8lPp0L19uK5f6z18Da2kjk2yQ=;
        b=UZ0Qkix4kWei1UbY0PlKmtrfZD+5sasCBp8MvgZsEl+5LlvbCZlL1vog0FyNaXnOejAcVm
        ENUPWpQavue8NJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2911813D36;
        Fri,  8 Oct 2021 07:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TJJ+Bmb4X2FFVAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 08 Oct 2021 07:51:02 +0000
Date:   Fri, 8 Oct 2021 09:51:00 +0200
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
Message-ID: <YV/4ZFCvoGRn2rtr@localhost.localdomain>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007181918.136982-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:19:14AM -0700, Mike Kravetz wrote:
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
> +	/* Synchronize with other sysfs operations modifying huge pages */
> +	mutex_lock(&h->resize_lock);
> +
> +	if (nid != NUMA_NO_NODE) {
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
> +	} else {
> +		n_mask = &node_states[N_MEMORY];
> +	}

Why this needs to be protected by the resize_lock? I do not understand
what are we really protecting here and from what.

Besides that, I did not spot anything wrong.

-- 
Oscar Salvador
SUSE Labs

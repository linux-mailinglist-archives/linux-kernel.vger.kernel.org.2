Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A464D431179
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJRHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:38:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhJRHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:38:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 164FF219B5;
        Mon, 18 Oct 2021 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634542556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8AdCq04FqHxZQpu0wW2BfZ1BcVn5cU9ZAer2RqlbyU=;
        b=u2TIUP/Mdjy3STk91DJsStl8q1CoRWwSY5eeKZK0tecdBKiQyPyma/s10xulK7M6uUKb+y
        OmDL9rjJdlzrobGy2RAQPND1u/jt8l4joj0osg+uvA2JQ7F+cDXueIAjSJv+93cEnpBqUS
        kIwq3GJVc/g9hZrwUyvRQNvLcEUMWKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634542556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8AdCq04FqHxZQpu0wW2BfZ1BcVn5cU9ZAer2RqlbyU=;
        b=rfrbtomo9lq+oBn53trNDIVT6TJn1ZYkDmgs94WkvTb5FZPdBhzYkDi8HbtURx/iUzfoAl
        3VzD429p2IwDnMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF3B213B44;
        Mon, 18 Oct 2021 07:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aEvpNtojbWFCEgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 18 Oct 2021 07:35:54 +0000
Date:   Mon, 18 Oct 2021 09:35:53 +0200
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
Message-ID: <20211018073552.GA11960@linux>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-2-mike.kravetz@oracle.com>
 <YV/4ZFCvoGRn2rtr@localhost.localdomain>
 <47e53389-638a-1af1-e94f-b3c7e5e7459e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e53389-638a-1af1-e94f-b3c7e5e7459e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 01:24:28PM -0700, Mike Kravetz wrote:
> In general, the resize_lock prevents unexpected consequences when
> multiple users are modifying the number of pages in a pool concurrently
> from the proc/sysfs interfaces.  The mutex is acquired here because we
> are modifying (decreasing) the pool size.

Yes, I got that. My question was wrt. n_mask initialization:

 +	if (nid != NUMA_NO_NODE) {
 +		init_nodemask_of_node(&nodes_allowed, nid);
 +		n_mask = &nodes_allowed;
 +	} else {
 +		n_mask = &node_states[N_MEMORY];
 +	}

AFAICS, this does not need to be protected.

with that addressed:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

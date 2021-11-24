Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5088A45CA81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbhKXRE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:04:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56912 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349375AbhKXREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:04:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C5F7D2193C;
        Wed, 24 Nov 2021 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637773273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pi9kgl0xy1sxQMBvOe4+mX1dWxn5PR49pVyg42HfGkc=;
        b=BIAlknL0T251E6QrfMtJNeYqwtMmU2/+gXgnS1DmJDHVIpsv/D2uBlFrD3zhoC4i8gey9X
        /HXHcoULfBD9bsVIlQGpr+rlSiLmBCZXrl05fUIWSrpJQMHndKfQdlN35Omg7P2ZSofDda
        FL+AZgTywdmLXFS99xnWZonzejiov+c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A948A3B81;
        Wed, 24 Nov 2021 17:01:13 +0000 (UTC)
Date:   Wed, 24 Nov 2021 18:01:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [memcg, kmem]  58056f7750:  hackbench.throughput 10.3%
 improvement
Message-ID: <YZ5v2LZlpzHieq/+@dhcp22.suse.cz>
References: <20211124083435.GB18309@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124083435.GB18309@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-11-21 16:34:35, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 10.3% improvement of hackbench.throughput due to commit:
> 
> 
> commit: 58056f77502f3567b760c9a8fc8d2e9081515b2d ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I am really surprised to see an improvement from this patch. I do not
expect your benchmarking would be using kmem limit. The above patch
hasn't really removed the page counter out of the picture so there
shouldn't be any real reason for performance improvement. I strongly
suspect this is just some benchmark artifact or unreliable evaluation.
-- 
Michal Hocko
SUSE Labs

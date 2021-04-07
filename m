Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA598356831
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbhDGJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:40:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345816AbhDGJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:39:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A56FAF9E;
        Wed,  7 Apr 2021 09:38:47 +0000 (UTC)
Date:   Wed, 7 Apr 2021 11:38:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 7/8] hugetlb: make free_huge_page irq safe
Message-ID: <20210407093844.GB11066@linux>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-8-mike.kravetz@oracle.com>
 <20210407091237.GC10058@linux>
 <YG18Xtk3GVa+NY+B@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG18Xtk3GVa+NY+B@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:33:18AM +0200, Michal Hocko wrote:
> Yes. spin_unlock_irq will enable interrupts unconditionally which is
> certainly not what we want if the path is called with IRQ disabled by
> the caller.

I see, thanks for confirming.

-- 
Oscar Salvador
SUSE L3

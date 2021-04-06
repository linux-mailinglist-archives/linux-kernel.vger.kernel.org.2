Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCF355ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhDFR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:57:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhDFR5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:57:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DECA4B230;
        Tue,  6 Apr 2021 17:57:45 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 06 Apr 2021 19:57:41 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
In-Reply-To: <b684d7bc-4c59-0beb-3af7-a75e76e77a87@oracle.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
 <YGwwO0galuKQsD0J@dhcp22.suse.cz>
 <b684d7bc-4c59-0beb-3af7-a75e76e77a87@oracle.com>
User-Agent: Roundcube Webmail
Message-ID: <cc941b98368dba12334b9948eb89b3b3@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-06 18:49, Mike Kravetz wrote:
> 
> Andrew, can we make this happen?  It would require removing Oscar's
> series until it can be modified to work on top of this.
> There is only one small issue with this series as it originally went
> into mmotm.  There is a missing conversion of spin_lock to 
> spin_lock_irq
> in patch 7.  In addition, there are some suggested changes from Oscar 
> to
> this patch.  I do not think they are necessary, but I could make those
> as well.  Let me know what I can do to help make this happen.

I agree that it might not be necesary to make such changes, but I still 
would like to see an explanation on the points I raised(excluding the 
list_del() as you already proved that is not necesary), just to be sure 
I am not missing anything.


-- 
Oscar Salvador
SUSE L3

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D28339ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCMPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhCMPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:10:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29501C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 07:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2c246of4H/FX570UuJ3LPDfwjAVtlnkICmfbQ/jdFGo=; b=r2hnSlFRjuxycEmqtRHxY85ZYZ
        fjIOXexcUZr1OI1Mj1JA5mHfqrjYePWZ6zX8UNDI26IE1ev+A+VpsyOQtLpdS7IS4GtopGtT11BOG
        Zqr0MMiSHHrb4kqjKuEVGHKBoxOFtM3eQPuu4Nf/H/nN2YB4Sc+IZwSkduY6BrqyG1uKh+7cYbs8n
        UvYWHm6ubpjnw36Nxq+KwwXfsDL8S4Oq1NmalTpr3jMTUTC2eVHpYjinhiy/g9h7jjP5pWMVZgJp1
        j2Zd2xHBuTOdITb9nP3u/lrl0RvinTemdZXtIOflVIzSFAOKQdX2u9u1ao0MD7c8sgTxKTrop8/C5
        9/qo0RYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lL5tG-00E8iX-BJ; Sat, 13 Mar 2021 15:09:27 +0000
Date:   Sat, 13 Mar 2021 15:09:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 01/14] include/linux/memcontrol.h: do not warn in
 page_memcg_rcu() if !CONFIG_MEMCG
Message-ID: <20210313150918.GH2577561@casper.infradead.org>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313075747.3781593-2-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:57:34AM -0700, Yu Zhao wrote:
> We want to make sure the rcu lock is held while using
> page_memcg_rcu(). But having a WARN_ON_ONCE() in page_memcg_rcu() when
> !CONFIG_MEMCG is superfluous because of the following legit use case:
> 
>   memcg = lock_page_memcg(page1)
>     (rcu_read_lock() if CONFIG_MEMCG=y)
> 
>   do something to page1
> 
>   if (page_memcg_rcu(page2) == memcg)
>     do something to page2 too as it cannot be migrated away from the
>     memcg either.
> 
>   unlock_page_memcg(page1)
>     (rcu_read_unlock() if CONFIG_MEMCG=y)
> 
> This patch removes the WARN_ON_ONCE() from page_memcg_rcu() for the
> !CONFIG_MEMCG case.

I think this is wrong.  Usually we try to have the same locking
environment no matter what the CONFIG options are, like with
kmap_atomic().  I think lock_page_memcg() should disable RCU even if
CONFIG_MEMCG=n.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD532A9AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581241AbhCBSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:50854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448880AbhCBPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:43:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614699738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+v3JZB+TwhS342xdPvs/fR2wMWd636mTWFjewLkIUI=;
        b=mUUs7UU1AEU05j8mIPP2kTnHWvzCUUEnbJjR31FiubuqAp09labYpicraJ/+uBmPIxDI1a
        Ol2/VPk6YOjf3VXvfvjbxZBDWf48Qk939nbWOJ521kwmgFHZLwqmNUn4dH3iADkwt9d83d
        1R1kuc0Z7VXNWoeIdshSOq5Y9L1bvIM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70575AE84;
        Tue,  2 Mar 2021 15:42:18 +0000 (UTC)
Date:   Tue, 2 Mar 2021 16:42:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Dingtianhong <dingtianhong@huawei.com>,
        Chenweilong <chenweilong@huawei.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Message-ID: <YD5cwFdfocudINWU@dhcp22.suse.cz>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <733264DE-1845-4615-8573-481E63895397@nvidia.com>
 <aab0bc059f3b4ffcb7acbac1724bcaa2@huawei.com>
 <1E25514A-202B-48E6-97F2-1E02B0980A96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E25514A-202B-48E6-97F2-1E02B0980A96@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 10:37:13, Zi Yan wrote:
[...]
> I have a question on copy_page_memcg above. By reading __memcg_kmem_charge_page
> and __memcg_kmem_uncharge_page, it seems to me that every single page requires
> a css_get(&memcg->css) at charge time and a css_put(&memcg->css) at uncharge time.
> But your copy_page_memcg does not do css_get for split subpages. Will it cause
> memcg->css underflow when subpages are uncharged?

yes, well spotted. I have completely missed that. This will also discard
my comment on testing the memcg.


-- 
Michal Hocko
SUSE Labs

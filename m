Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24DA354FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbhDFJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhDFJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:21:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TqTPRJB6pZK08YcdPYvz3/pZzL7+uFHBrxcaKm3Xi1A=; b=MrCz+oMav654oV72hg2MNg8+yU
        gT5QdzdWqliNIecjvZaK4E+bNAdcrX+vCVxCWzhnJ3D3yD7v5zrDD2/MpJTwg9DMnlV+mTCkA2qCz
        aONRXc99DtkQ2qmxqMzp0X75zhdYceBqf0t37s9wegIN5MUyKRLAhiEhVKv4gMCjSaLKqw+yAZBiA
        JPpslvFu9852P59/Nvv34Sof3BO8+5CnbJiazNer7u+5RXOm5q8OfvjpxM6JAXDgblBFC0xailfV4
        w8U5rb29d+ObCG5VPvfPxVhnz2ZCSyQSKL1lLqjeJf5ZD8pVzu2/TsnZXURmj3uUQFykcp1Gt4gXH
        xcl8u+VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lThqJ-00CZLg-7f; Tue, 06 Apr 2021 09:18:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFECE30377D;
        Tue,  6 Apr 2021 11:17:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB95C2BAE8C25; Tue,  6 Apr 2021 11:17:48 +0200 (CEST)
Date:   Tue, 6 Apr 2021 11:17:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
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
Subject: Re: [PATCH v4 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YGwnPCPaq1xKh/88@hirez.programming.kicks-ass.net>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:36PM -0700, Mike Kravetz wrote:
> The lock doesn't protect any sleepable operation so it can be changed to
> a (irq aware) spin lock. The bitmap processing should be quite fast in
> typical case but if cma sizes grow to TB then we will likely need to
> replace the lock by a more optimized bitmap implementation.

Or an rb-tree that stores ranges, which should also be much cheaper
storage wise, for those sizes.

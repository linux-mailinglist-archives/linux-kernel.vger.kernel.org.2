Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF903DED4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhHCMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhHCMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:02:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FACC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqSHKnZTWGmS5kpvDXOu7rtMWWiRcadlbYWKyvYr8uE=; b=AByIIbSWvwGMZvxM4zF6gD7Inx
        jFfSI9m+8WJwHEiJftOedg2iujxIBsRKVVoGpDcsrr0NOGYSrbhkvXBNfCinaPC6vpHr6WKCHdLwe
        5ewP37RIvvFlFjWRIVxUD1/2o8ZjKGGiHzasgOe/UUxuoasZAg2QNj+QwOd3OZZX3lnAYXHIwWfyI
        57l/JRA/gHSRLcY0AMWI/Pr43vtimbuy1GQ7WcZ4EHs337Oe2RlvWXlPOTRXdinSvudvbgLwVFgBO
        pqIOlsdSwyIXo2NNYvrtSXkKz1Lkhz4S+c77e5BtgTq6Jh9QRslIHH71Qv6Dv3P+FvukFeoyqWqiN
        8Y7k0f6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAt6b-004c1q-UL; Tue, 03 Aug 2021 12:01:20 +0000
Date:   Tue, 3 Aug 2021 13:01:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
Message-ID: <YQkwBdpWTPjv4xIx@casper.infradead.org>
References: <20210723080000.93953-1-ying.huang@intel.com>
 <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <YPs6cQo7iG1JcOn8@casper.infradead.org>
 <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:14:38PM +0800, Huang, Ying wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
> > time believing this, or any of the other races can really happen.
> 
> I think the race is only theoretical too.  Firstly, swapoff is a rare
> operations in practice; secondly, the race window is really small.

So do something to provoke it.  Widen the window.  Put an msleep(1000)
between *pagep = NULL and the call to get_swap_device().  That's assuming
that the swapon/swapoff loop that I proposed doesn't work.  Did you
try it?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E232B6EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351632AbhCCKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838206AbhCBXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:06:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB9C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:56:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j8so373993qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+fMIB41xOYEqnsla9E5/yzrzusPJDUgvLmNk6+uq+k=;
        b=wxHlRMSwda//NqymsO5OXpIykQpggXV0HzX2Z6Mj+UrNCrHIV9ZpuUTq39SWQu/RmE
         ePa3mhqvpgUovYvkwVKGO/PZ+c09yTDqlkDPjCE1pOxv5K3aUay03tI6oVfK4INReIZs
         htsXUoHOvZnttwIzH2BESW+GWwxWe1DaB48Lq+0+lcLBK2x9sqT85w7BsouuilnB7j8L
         4D61l58hazf+lQ0guT2J2CYPNYCFBUzrAXn6+7PvtxH4LKWxMTEktH+ohR7XeS1HCX4y
         zuVCTtQ5b9LO1wjdTo+CH0ULf+UuEW9qvxZoiQgm/WFNK2nCIBG98JEYudiizIt6PHCo
         DQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+fMIB41xOYEqnsla9E5/yzrzusPJDUgvLmNk6+uq+k=;
        b=JhWo0WITtWO4Efa3RE6CH7KKTK4ITS2QfvyHXZ+xdy+mRbhzku7lBOPzRSiKziswc0
         mM/VtiiANF9eFqU6NQwO29ydeRrI8YEAa/14wSp127mm5Vwp2syzmy2hN3r4HPK/L/V+
         hc1pedNQAoE79QfWyChGCVrQRr79uQ54FPvxwl2EyCXoA19bHaPTBrIhj52zIX4ShgDx
         tSOL2jpDg37uONJOkmGWOencrv9KzLr2WaKLquNLJdla510VYquTaCHjSofZughA5Sac
         U+K28TVKHMhXxrna1txW83AN4hhMakfZ2KcrLkazIFzssX4GgxR/Fr2QB/2BPjGxJfkR
         p0kw==
X-Gm-Message-State: AOAM531+8IV+Ywi26ScqmXmmOsjT9tZ38yD3stzFUTapfmUPsHuQwjwE
        /eVoBx9wYWAeY2UBUdyZeY+dAg==
X-Google-Smtp-Source: ABdhPJyySw5FvKxT+K6Xzl6j7+fumtlgslEBMMjP4DsfvWLAxDhGnOkn1n5GsarcuW2+wjWOa8zrWQ==
X-Received: by 2002:ac8:5752:: with SMTP id 18mr1588115qtx.385.1614725769215;
        Tue, 02 Mar 2021 14:56:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9de8])
        by smtp.gmail.com with ESMTPSA id j20sm16287943qtl.36.2021.03.02.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:56:08 -0800 (PST)
Date:   Tue, 2 Mar 2021 17:56:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com, Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Message-ID: <YD7Ch/8QebzmneCR@cmpxchg.org>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
 <alpine.LSU.2.11.2103021157160.8450@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103021157160.8450@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:24:41PM -0800, Hugh Dickins wrote:
> On Tue, 2 Mar 2021, Michal Hocko wrote:
> > [Cc Johannes for awareness and fixup Nick's email]
> > 
> > On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
> > > When split page, the memory cgroup info recorded in first page is
> > > not copied to tail pages. In this case, when the tail pages are
> > > freed, the uncharge operation is not performed. As a result, the
> > > usage of this memcg keeps increasing, and the OOM may occur.
> > > 
> > > So, the copying of first page's memory cgroup info to tail pages
> > > is needed when split page.
> > 
> > I was not aware that alloc_pages_exact is used for accounted allocations
> > but git grep told me otherwise so this is not a theoretical one. Both
> > users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
> > used in dma allocator but I got lost in indirection so I have no idea
> > whether there are any users there.
> 
> Yes, it's a bit worrying that such a low-level thing as split_page()
> can now get caught up in memcg accounting, but I suppose that's okay.
> 
> I feel rather strongly that whichever way it is done, THP splitting
> and split_page() should use the same interface to memcg.
> 
> And a look at mem_cgroup_split_huge_fixup() suggests that nowadays
> there need to be css_get()s too - or better, a css_get_many().
> 
> Its #ifdef CONFIG_TRANSPARENT_HUGEPAGE should be removed, rename
> it mem_cgroup_split_page_fixup(), and take order from caller.

+1

There is already a split_page_owner() in both these places as well
which does a similar thing. Mabye we can match that by calling it
split_page_memcg() and having it take a nr of pages?

> Though I've never much liked that separate pass: would it be
> better page by page, like this copy_page_memcg() does?  Though
> mem_cgroup_disabled() and css_getting make that less appealing.

Agreed on both counts. mem_cgroup_disabled() is a jump label and would
be okay, IMO, but the refcounting - though it is (usually) per-cpu -
adds at least two branches and rcu read locking.

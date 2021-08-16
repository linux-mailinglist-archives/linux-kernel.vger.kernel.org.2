Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CB3ED8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHPO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:29:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DBC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WxJvdZx1S/GUBWkdMxiXeG3/WqogteDc2hsw7fqpOWQ=; b=aqgR5bsgQqTgxb7+KuMJOs76Tg
        n1HfBZZQxxcqM3mbaODNG0xMl6XO0UFaVW3P2ve1vwQhp3aGqHUZgLb7vhyHKnSMlz5wAsqn17phe
        7JexrjksIgpA/y2P0Dlg3Wa3/P1QM4X9g/StN1kPntEl7i20inCbne+EwIux4M5z/PhGVnGUkGqWr
        4Fns42xKv5l8ynPyoM6f3F0keF2/hDhbYenI6Wd0uGr+P9D++vbrWtzDwHLFNCeFYPqwogeSBStlY
        qUJ/WUNKb17HUHOycD7aUnh5iW1sZNAdQ2j0pd85CH3JyEvo6Yi39kTkcK2QCrCziAKJoEKexZi27
        iOb1I5WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFdal-001Trs-Bq; Mon, 16 Aug 2021 14:28:09 +0000
Date:   Mon, 16 Aug 2021 15:27:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <YRp169xvwB3j0rpD@casper.infradead.org>
References: <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 04:10:28PM +0200, David Hildenbrand wrote:
> > > > Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
> > > > still have customers using that generation of CPUs.  2MB pages perform
> > > > better than 1GB pages on the previous generation of hardware, and I
> > > > haven't seen numbers for the next generation yet.
> > > 
> > > I read that somewhere else before, yet we have heavy 1 GiB page users,
> > > especially in the context of VMs and DPDK.
> > 
> > I wonder if those users actually benchmarked.  Or whether the memory
> > savings worked out so well for them that the loss of TLB performance
> > didn't matter.
> 
> These applications are extremely performance sensitive (i.e., RT workloads),

"real time does not mean real fast".  it means predictable latency.

> > > I will rephrase my previous statement "hugetlbfs just doesn't raise these
> > > problems because we are special casing it all over the place already". For
> > > example, not allowing to swap such pages. Disallowing MADV_DONTNEED. Special
> > > hugetlbfs locking.
> > 
> > Sure, that's why I want to drag this feature out of "oh this is a
> > hugetlb special case" and into "this is something Linux supports".
> 
> I would have understood the move to optimize SHMEM internally - similar to
> how we seem to optimize hugetlbfs SHMEM right now internally. (although
> sharing page tables for shmem can still be quite tricky)
> 
> I did not follow why we have to play games with MAP_PRIVATE, and having
> private anonymous pages shared between processes that don't COW, introducing
> new syscalls etc.

It's not about SHMEM, it's about file-backed pages on regular
filesystems.  I don't want to have XFS, ext4 and btrfs all with their
own implementations of ARCH_WANT_HUGE_PMD_SHARE.

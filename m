Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AD3ED449
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhHPMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhHPMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:48:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bYq/RlC0v6fhXkriJhOA5FB18MNbZK+nNft2JpmIjus=; b=Y2Zhk1IHVOkWh9NnpfC0ISuW5/
        M0jdQhL8RnDw0UUxSX6Fs7mqN2zpfMGbaBMZNFHohfaOBozVVF42/fX9ztpM1wjP3q1LVDG1waAkY
        urC4/xfB47ZHbbgqkMwL9f2M7LIaLNnZQCQy5zldDcS5LFcWkO2oCYcg3gUIBu9OpP8zhtRAIDGM9
        4o5hlig3wtT65q4DI/H239cmXwfXiehARu85+ypLOrvzCaB355FjjUqyudZVMn+2Ko7gHtBoSw/DR
        vf2+ltvQsv4iIDVmIK1fcZiSYFXWtFlSn19f+pyQFlyvS3grtV7cqaGBUArYN4z+HUgsVVX02tAJR
        jMhD7lgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFc0U-001M88-Ca; Mon, 16 Aug 2021 12:46:27 +0000
Date:   Mon, 16 Aug 2021 13:46:22 +0100
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
Message-ID: <YRpeHnP7QDNJRA8Y@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:20:43PM +0200, David Hildenbrand wrote:
> On 16.08.21 14:07, Matthew Wilcox wrote:
> > On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
> > > > Mappings within this address range behave as if they were shared
> > > > between threads, so a write to a MAP_PRIVATE mapping will create a
> > > > page which is shared between all the sharers. The first process that
> > > > declares an address range mshare'd can continue to map objects in the
> > > > shared area. All other processes that want mshare'd access to this
> > > > memory area can do so by calling mshare(). After this call, the
> > > > address range given by mshare becomes a shared range in its address
> > > > space. Anonymous mappings will be shared and not COWed.
> > > 
> > > Did I understand correctly that you want to share actual page tables between
> > > processes and consequently different MMs? That sounds like a very bad idea.
> > 
> > That is the entire point.  Consider a machine with 10,000 instances
> > of an application running (process model, not thread model).  If each
> > application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
> > tables per process or 40GB of RAM for the whole machine.
> 
> What speaks against 1 GB pages then?

Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
still have customers using that generation of CPUs.  2MB pages perform
better than 1GB pages on the previous generation of hardware, and I
haven't seen numbers for the next generation yet.

> > There's a reason hugetlbfs was enhanced to allow this page table sharing.
> > I'm not a fan of the implementation as it gets some locks upside down,
> > so this is an attempt to generalise the concept beyond hugetlbfs.
> 
> Who do we account the page tables to? What are MADV_DONTNEED semantics? Who
> cleans up the page tables? What happens during munmap? How does the rmap
> even work? How to we actually synchronize page table walkers?
> 
> See how hugetlbfs just doesn't raise these problems because we are sharing
> pages and not page tables?

No, really, hugetlbfs shares page tables already.  You just didn't
notice that yet.

> > Think of it like partial threading.  You get to share some parts, but not
> > all, of your address space with your fellow processes.  Obviously you
> > don't want to expose this to random other processes, only to other
> > instances of yourself being run as the same user.
> 
> Sounds like a nice way to over-complicate MM to optimize for some special
> use cases. I know, I'm probably wrong. :)

It's really not as bad as you seem to think it is.

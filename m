Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7383EDAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhHPQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:17:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YguTfFom6rn+j6nmlHG2OKvNvZ6Byw2cwNgw3ARdK2k=; b=Vj0ALVI+sLctiA1QZwhqdtT95t
        yO0jY03JRMYYK8ciIMIddB6YZFOaVLCRkh/WnFel9+Ht+UhLnsWEh11ryxhRMczP1SjtLnj7aDsv/
        thJHJGLTW9ujfk92LmQe/WpwKxJQ+md6Xathh0GJM2xm07yzXh8KIa1r59wu4OOHngt+V0FqlaDa2
        efgoc8FkHyg3PYUNBLU7XgA/QrEiiwA6fQaCzJaczYkShzZ167ruf8LihwbWKkHPlGpbZsrOVELgq
        /zz+O4uv/EzLW5UT9Qa/xq3Q93bWKL3AIq6BO8/27vfZ2mx7fjg2af3PNRrN6s2W8d0JUkaf4BekS
        nKIG1q+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFfGx-001ZQe-AL; Mon, 16 Aug 2021 16:15:47 +0000
Date:   Mon, 16 Aug 2021 17:15:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <YRqPJ6c8OQpD6HD5@casper.infradead.org>
References: <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
 <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
 <YRp4+EmohNoxzv2x@casper.infradead.org>
 <e6a31927-8f93-22af-2d5a-9d80578e9317@redhat.com>
 <YRqLc2W1P77tiSqj@casper.infradead.org>
 <25d15c74-40e2-8ec3-5232-ab945f653580@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d15c74-40e2-8ec3-5232-ab945f653580@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:06:47AM -0600, Khalid Aziz wrote:
> On 8/16/21 9:59 AM, Matthew Wilcox wrote:
> > On Mon, Aug 16, 2021 at 05:01:44PM +0200, David Hildenbrand wrote:
> > > On 16.08.21 16:40, Matthew Wilcox wrote:
> > > > On Mon, Aug 16, 2021 at 04:33:09PM +0200, David Hildenbrand wrote:
> > > > > > > I did not follow why we have to play games with MAP_PRIVATE, and having
> > > > > > > private anonymous pages shared between processes that don't COW, introducing
> > > > > > > new syscalls etc.
> > > > > > 
> > > > > > It's not about SHMEM, it's about file-backed pages on regular
> > > > > > filesystems.  I don't want to have XFS, ext4 and btrfs all with their
> > > > > > own implementations of ARCH_WANT_HUGE_PMD_SHARE.
> > > > > 
> > > > > Let me ask this way: why do we have to play such games with MAP_PRIVATE?
> > > > 
> > > > : Mappings within this address range behave as if they were shared
> > > > : between threads, so a write to a MAP_PRIVATE mapping will create a
> > > > : page which is shared between all the sharers.
> > > > 
> > > > If so, that's a misunderstanding, because there are no games being played.
> > > > What Khalid's saying there is that because the page tables are already
> > > > shared for that range of address space, the COW of a MAP_PRIVATE will
> > > > create a new page, but that page will be shared between all the sharers.
> > > > The second write to a MAP_PRIVATE page (by any of the sharers) will not
> > > > create a COW situation.  Just like if all the sharers were threads of
> > > > the same process.
> > > > 
> > > 
> > > It actually seems to be just like I understood it. We'll have multiple
> > > processes share anonymous pages writable, even though they are not using
> > > shared memory.
> > > 
> > > IMHO, sharing page tables to optimize for something kernel-internal (page
> > > table consumption) should be completely transparent to user space. Just like
> > > ARCH_WANT_HUGE_PMD_SHARE currently is unless I am missing something
> > > important.
> > > 
> > > The VM_MAYSHARE check in want_pmd_share()->vma_shareable() makes me assume
> > > that we really only optimize for MAP_SHARED right now, never for
> > > MAP_PRIVATE.
> > 
> > It's definitely *not* about being transparent to userspace.  It's about
> > giving userspace new functionality where multiple processes can choose
> > to share a portion of their address space with each other.  What any
> > process changes in that range changes, every sharing process sees.
> > mmap(), munmap(), mprotect(), mremap(), everything.
> > 
> 
> Exactly and to further elaborate, once a process calls mshare() to declare
> its intent to share PTEs for a range of address and another process accepts
> that sharing by calling mshare() itself, the two (or more) processes have
> agreed to share PTEs for that entire address range. A MAP_PRIVATE mapping in
> this address range goes against the original intent of sharing and what we
> are saying is the original intent of sharing takes precedence in case of
> this conflict.

I don't know that it's against the original intent ... I think
MAP_PRIVATE in this context means "Private to this process and every
process sharing this chunk of address space".  So a store doesn't go
through to the page cache, as it would with MAP_SHARED, but it is
visible to the other processes sharing these page tables.

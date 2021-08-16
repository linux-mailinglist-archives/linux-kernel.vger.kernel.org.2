Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9A3ED917
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhHPOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhHPOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:43:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38CC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEkk9bTRSPeIztpf1WOtGTbt+rB7VbtYlTiQl5in/5o=; b=GN4Fvc2ClJf2hxkpESl7npbmyY
        7UDRJDgS9s6lwS74oxsT2qgbCmZXrAUTPn1G61FqkgE4dW8DPc3gwE0UWVJRJpEVIrPuMa+LJYKUc
        3DCXx4TUysvoLi/Eg/KuVwjCPO+kJDZFPbLd4nQqbH4gj/vdp5ULf3l2gV6x9PZrRqupSSyWt5QUg
        cUTXuKaPQD4/oJHEK+0mpbzevDfxhcrAWJgN3QxqNjO5mLG4jDHs9vL9LU7tpQPT6DNWpu5s9Si+3
        kWBFaCER/CYTWba7I59U0s5ELs2gVWCAsOzSOCqpT9kl+/SEhYwxN14GJTjsdt0mzaCeILN7F/l0K
        SU25MxsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFdnM-001UOc-NM; Mon, 16 Aug 2021 14:41:02 +0000
Date:   Mon, 16 Aug 2021 15:40:56 +0100
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
Message-ID: <YRp4+EmohNoxzv2x@casper.infradead.org>
References: <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
 <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 04:33:09PM +0200, David Hildenbrand wrote:
> > > I did not follow why we have to play games with MAP_PRIVATE, and having
> > > private anonymous pages shared between processes that don't COW, introducing
> > > new syscalls etc.
> > 
> > It's not about SHMEM, it's about file-backed pages on regular
> > filesystems.  I don't want to have XFS, ext4 and btrfs all with their
> > own implementations of ARCH_WANT_HUGE_PMD_SHARE.
> 
> Let me ask this way: why do we have to play such games with MAP_PRIVATE?

Are you referring to this?

: Mappings within this address range behave as if they were shared
: between threads, so a write to a MAP_PRIVATE mapping will create a
: page which is shared between all the sharers.

If so, that's a misunderstanding, because there are no games being played.
What Khalid's saying there is that because the page tables are already
shared for that range of address space, the COW of a MAP_PRIVATE will
create a new page, but that page will be shared between all the sharers.
The second write to a MAP_PRIVATE page (by any of the sharers) will not
create a COW situation.  Just like if all the sharers were threads of
the same process.

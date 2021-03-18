Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F647340D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhCRSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCRSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:34:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8068C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KXYTVMpTCpHxbvDipYxwPha668ZbAx4YoTpVIgPYRcA=; b=Q2vFmO8H4ovmD7vhruivJtgPDx
        eAq1XvnV020YmxrlQbc2OXD+XuZVn15Qx+T+mwVLEyUNNjAdu/G8yt0oiEMaosFDVOqyQ4fX/UrBJ
        nUsePqBp/MCgg4Emib9/Tz7gJSy/ludVE0TPQhyOvYOaGq8BzQE2I0NY/OLZoJJ8Mj8EyDikqDiKd
        beurY5CwP51LuUtGPvOUld08F9Q4Hpi6WeDd9rioRbHs9LLLN4CB8cGN/LE3ehQna4tUn+0tKZQJW
        cyjrhqbE96iz1ywtqoxLBy9UdLRy/hMuGVNCO8ltbitBLtrQ29GLLJhZFm6Jk4vS5ppLcbghaDDBQ
        faWXtfPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMxSw-003M68-Fa; Thu, 18 Mar 2021 18:33:52 +0000
Date:   Thu, 18 Mar 2021 18:33:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jue Wang <juew@google.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Greg Thelen <gthelen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Message-ID: <20210318183350.GT3420@casper.infradead.org>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
 <alpine.LSU.2.11.2103102214170.7159@eggly.anvils>
 <20210311151446.GA28650@hori.linux.bs1.fc.nec.co.jp>
 <CAPcxDJ6D5OS+XRYbqpr-7bhYCySX=jdPZdZvQL1ecSrQoDEieg@mail.gmail.com>
 <alpine.LSU.2.11.2103111312310.7859@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103111312310.7859@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 02:00:40PM -0800, Hugh Dickins wrote:
> On Thu, 11 Mar 2021, Jue Wang wrote:
> > In our experiment with SHMEM THPs, later accesses resulted in a zero
> > page allocated instead of a SIGBUS with BUS_MCEERR_AR reported by the
> > page fault handler. That part might be an opportunity to prevent some
> > silent data corruption just in case.
> 
> Thanks for filling in more detail, Jue: I understand better now.
> 
> Maybe mm/shmem.c is wrong to be using generic_error_remove_page(),
> the function which punches a hole on memory-failure.
> 
> That works well for filesystems backed by storage (at least when the
> page had not been modified), because it does not (I think) actually
> punch a hole in the stored object; and the next touch at that offset of
> the file will allocate a new cache page to be filled from good storage.
> 
> But in the case of shmem (if we ignore the less likely swap cache case)
> there is no storage to read back good data from, so the next touch just
> fills a new cache page with zeroes (as you report above).
> 
> I don't know enough of the philosophy of memory-failure to say, but
> I can see there's an argument for leaving the bad page in cache, to
> give SIGBUS or EFAULT or EIO (whether by observation of PageHWPoison,
> or by another MCE) to whoever accesses it - until the file or that
> part of it is deleted (then that page never returned to use again).

I think you have it right here.  If the page hasn't been modified since
being read in from swap, it's perfectly fine to discard it (because the
data can be read back from swap if accessed again).  But if it has been
modified, the user has lost data and must be made aware of this.

It seems to me that other filesystems also get this wrong.  If the page
is dirty (eg for ext2/ext4/xfs), we'll silently throw away the user's
data and reload it from storage.  That's spelled "silent data corruption".

So I think this is part of the solution here:

+++ b/mm/truncate.c
@@ -236,6 +236,8 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
         */
        if (!S_ISREG(mapping->host->i_mode))
                return -EIO;
+       if (PageDirty(page))
+               return -EBUSY;
        return truncate_inode_page(mapping, page);
 }
 EXPORT_SYMBOL(generic_error_remove_page);

Things I don't know ...

 - Does shmem mark pages dirty in the right circumstances for this to work?
 - How does memory-failure cope with an -EBUSY return from
   ->error_remove_page() today?  It seems to treat all errors the same
   and return MF_FAILED, but I don't know whether that's going to do
   the right thing.
 - Do we correctly decline to evict a HWPoison page from the page cache
   until the page is truncated (hole punched, whatever).

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FADA42DA99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJNNjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:39:01 -0400
Received: from out2.migadu.com ([188.165.223.204]:39326 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNNi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:38:59 -0400
Date:   Thu, 14 Oct 2021 22:36:44 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634218614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQEUoO1u0vnESEeOSyCqC/9jXyzKonfBs4bm0m0IrIU=;
        b=kkMPpY6BessB7KtmtM82BpZwLoSFMJHb4d5Vxg9ykIxJEbcNVvMayrbUscmNT88kVFVoqa
        ar3+THmLsUNjOC3yzA/eKX9OwCYnq6cKp5sxUQ1yAtxrPRokrZxrav8d2Hem/riwKWlK38
        BUVD/mphWSgkvEpqevkLpEIv31AqRVY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <20211014133644.GA2023135@u2004>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <YWZJIKsn6Sry5P6k@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWZJIKsn6Sry5P6k@t490s>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49:04AM +0800, Peter Xu wrote:
> Hi, Naoya,
> 
> On Mon, Oct 04, 2021 at 08:50:01PM +0900, Naoya Horiguchi wrote:
> > +static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> > +{
> > +	struct page *p = pfn_to_page(swp_offset(entry));
> > +
> > +	WARN_ON(!PageHWPoison(p));
> > +	return p;
> > +}
> 
> This is more a pure question..
> 
> I'm wondering whether that WARN_ON() could trigger.
> 
> IOW, what if we poison an anonymous page and then unpoison it?  

Thanks for the good question, this could trigger WARN for unpoisoned pages.
The impact is limited because the caller of unpoison should know that that
happens in testing workload, but maybe there's no good reason to prevent
from it. So I'll drop this WARN_ON().

> Will there be a
> hwpoison swap entry leftover in the ptes that it used to map?  

Yes it will, unpoison never affects exisiting hwpoison swap entries.

> Will it crash
> the program when the page is accessed?

Reading hwpoison_entry_to_page() via pagemap interface should not crash
because it just reads the page's metadata.
The process with the hwpoison swap entry still receives SIGBUS when doing
page fault (irrespective of doing unpoison or not) on the error address.

> 
> I had a feeling that when handling the page fault in do_swap_page before we
> SIGBUS the program, we should double-check the PageHWPoison on the pfn page,
> but I could be missing something..

The double-checking seems to allow processes to detect that the hwpoison page
is unpoisoned, some test programs could benefit from it. But maybe it could
be done independent of this patch.

Personally, I only use unpoison in cleanup phase of each test case,
and each test case newly starts test processes, so reusing error pages
with unpoison can be avoided.

Thanks,
Naoya Horiguchi

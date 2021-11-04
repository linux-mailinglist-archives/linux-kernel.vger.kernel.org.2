Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAABE445C01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhKDWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232002AbhKDWJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0196C60EB4;
        Thu,  4 Nov 2021 22:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1636063640;
        bh=hiW21M8IbjMnysrLz02OTr1uCPLSmAnYYpV34I+FcwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DKcWVOCeT6uvpUrM3DSraHq727l4tf7ibOBqBj+QXlnFIa286EcEgf3FKCgbEkWyt
         xjmRfoDNT5GVuUvOGjgc0HoBd9AIlXaAyD7tGqMmhIgKggmdNV2K5GYkcVtqg5ebZ8
         6ri0/fHb4E2Xdv+89HNyn19OVN9i1sWX9oO/WB0s=
Date:   Thu, 4 Nov 2021 15:07:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+jIOebtOS5nw==?=) 
        <naoya.horiguchi@nec.com>, "mhocko@suse.com" <mhocko@suse.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "cgoldswo@codeaurora.org" <cgoldswo@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: make HWPoisoned dirty swapcache
 pages unmovable
Message-Id: <20211104150717.d235501b802868d578639422@linux-foundation.org>
In-Reply-To: <de9e587e-fcc4-11e0-19a0-22a1bbafa4b6@huawei.com>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
        <20210821094246.10149-4-linmiaohe@huawei.com>
        <20210823082646.GB1452382@hori.linux.bs1.fc.nec.co.jp>
        <de9e587e-fcc4-11e0-19a0-22a1bbafa4b6@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 17:14:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2021/8/23 16:26, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Sat, Aug 21, 2021 at 05:42:46PM +0800, Miaohe Lin wrote:
> >> HWPoisoned dirty swapcache pages are kept for killing owner processes.
> >> We should not offline these pages or do_swap_page() would access the
> >> offline pages and lead to bad ending.
> >>
> > 
> > Thank you for the report.  I'm not yet sure of the whole picture of this
> > issue.  do_swap_page() is expected to return with fault VM_FAULT_HWPOISON
> > when called via the access to the error page, so I wonder why this doesn't
> > work for your situation.  And what is the "bad ending" in the description?
> > 
> 
> IMO we might hotremove the page while SwapCache still have ref to it. Thus the page
> struct would be accessed after offlined. The page struct should be invalid in this case
> and this would make do_swap_page fragile. Or am I miss something?
> 
> > I feel that aborting memory hotremove due to a hwpoisoned dirty swapcache
> > might be too hard, so I'd like to find another solution if we have.
> 
> If there is a better way, we can just drop this one.
> 
> Many thanks for your review and reply! :)
> 
> > # You may separate this patch from former two to make them merged to
> > # mainline soon.
>
> ...
>
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -1664,6 +1664,12 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
> >>  		 */
> >>  		if (PageOffline(page) && page_count(page))
> >>  			return -EBUSY;
> >> +		/*
> >> +		 * HWPoisoned dirty swapcache pages are definitely unmovable
> >> +		 * because they are kept for killing owner processes.
> >> +		 */
> >> +		if (PageHWPoison(page) && PageSwapCache(page))
> >> +			return -EBUSY;
> 

I'll drop this.  Please resend something if you still believe that
changes are desirable.  

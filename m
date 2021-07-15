Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C693C9ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbhGOIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:38:53 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:58495 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhGOIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:38:52 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 168B41C5267
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 09:35:59 +0100 (IST)
Received: (qmail 14109 invoked from network); 15 Jul 2021 08:35:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jul 2021 08:35:58 -0000
Date:   Thu, 15 Jul 2021 09:35:57 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: avoid hard lockups in __alloc_pages_bulk()
Message-ID: <20210715083557.GP3809@techsingularity.net>
References: <20210710112929.232268-1-qiang.zhang@windriver.com>
 <20210710114613.0db3ac139a7b3102a6ca3ad4@linux-foundation.org>
 <YOoMq0Bl6M/LV6mJ@casper.infradead.org>
 <BL1PR11MB54785E7EA2BFBDAA393F15BBFF179@BL1PR11MB5478.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <BL1PR11MB54785E7EA2BFBDAA393F15BBFF179@BL1PR11MB5478.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 10:57:53PM +0000, Zhang, Qiang wrote:
> ________________________________
> ??????: Matthew Wilcox <willy@infradead.org>
> ????????: ??????, ???? 11, 2021 05:10
> ??????: Andrew Morton
> ????: Zhang, Qiang; mgorman@techsingularity.net; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> ????: Re: [PATCH] mm/page_alloc: avoid hard lockups in __alloc_pages_bulk()
> 
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Sat, Jul 10, 2021 at 11:46:13AM -0700, Andrew Morton wrote:
> > On Sat, 10 Jul 2021 19:29:29 +0800 qiang.zhang@windriver.com wrote:
> >
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > The __alloc_pages_bulk() mainly used for batch allocation of
> > > order-0 pages, in the case of holding pagesets.lock, if too
> > > many pages are required, maybe trigger hard lockup watchdog.
> >
> > Ouch.  Has this been observed in testing?  If so, can you please share
> > the kernel debug output from that event?
> 
> >This should be fixed in the caller by asking for fewer pages.
> >The NFS and vmalloc cases have already been fixed for this.
> 
> The NFS and vmalloc cases haven  been fixed??
> I don??t see if there is any information about that?
> 

AFAIK, NFS simply doesn't ask for a large enough number of pages to be
of concern. For vmalloc, it's somewhat theoritical that it can happen
for anything other than a stress test but this exists
https://lore.kernel.org/r/20210705170537.43060-1-urezki@gmail.com

I had no objection to the patch but didn't feel strongly enough to say
anything about it either given that it was triggered artifically.

-- 
Mel Gorman
SUSE Labs

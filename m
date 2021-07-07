Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66593BE240
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGGE5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGGE5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:57:03 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5390C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:54:22 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:54:12 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625633660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39kI7Yc9OgSpz5lPE3O2Efw5i4i4OxelZLRem/Qx8qU=;
        b=J2a+wKEWxNM6SM7qAg3p5DdwoxsE7Lj8ahppGZHexf7Lx0SlTp4upCDdgztewFVHCaJGSY
        2jAA6cbPgV7nr/Bl5BavqTVfshr52/lQWg63ZTC+OLXYclARtKi7wyiaFkntJWAU/EllxB
        timwrwdcT8jku1UFWdbD1LNReK3+T3I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Dan Williams <dan.j.williams@intel.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.xiang@huawei.com" <rui.xiang@huawei.com>,
        HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>, naoya.horiguchi@nec.com
Subject: Re: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6
Message-ID: <20210707045412.GA809950@u2004>
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
 <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
 <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
 <CAPcyv4h5a5AYscsyC40_5bc6j1kmjMFWJ_0MFAGEx1EPS9Tmrw@mail.gmail.com>
 <20210628070601.GB418318@u2004>
 <10142860-06b2-df68-c283-64560f31fb44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10142860-06b2-df68-c283-64560f31fb44@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:36:36AM +0200, David Hildenbrand wrote:
> > Sounds nice to me, so here's a patch. Could you review this?
> > 
> 
> Hi,
> 
> sorry for the late reply, I was on vacation. Please send it as a proper
> stand-alone patch next time, such that it
> 
> 1. won't get silently ignored by reviewers/maintainers within a thread
> 2. Can easily get picked up/tested

Sorry, I'll send in a separate thread next time.

> 
> Some minor comments below.
> 
> > Thanks,
> > Naoya Horiguchi
> > ---
> >  From a146c9f12ae8985c8985a5861330f7528cd14fe8 Mon Sep 17 00:00:00 2001
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Date: Mon, 28 Jun 2021 15:50:37 +0900
> > Subject: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6
> > 
> > Hagio-san reported that crash utility can see bit 4 in section_mem_map
> > (SECTION_TAINT_ZONE_DEVICE) to be set, even if we do not use any
> > ZONE_DEVICE ilke pmem or HMM.  This problem could break crash-related
> 
> s/ilke/like/
> 
> > toolsets and/or other memory analysis tools.
> > 
> 
> I'd rephrase this to "Having SECTION_TAINT_ZONE_DEVICE set for wrong
> sections forces pfn_to_online_page() through the slow path, but doesn't
> actually break the kernel. However, it can break crash-related toolsets."
>
> However, I am not sure why it actually breaks crash? crash would have to
> implement the same slow-path check and would have to double-check the
> sub-section present map. Then, it should just work like pfn_to_online_page()
> and not have a real issue. What am I missing?

Because a kdump generation tool (makedumpfile in my mind) uses this field
to calculate the physical address to read.  So wrong bits mean wrong address,
so kdump generation can fail.  We already avoid this by fixing makedumpfile not
to check lower 5 bits, so it's not critial for us.

> > The root cause is that SECTION_NID_SHIFT is incorrectly set to 3,
> > while we use lower 5 bits for SECTION_* flags.  So bit 3 and 4 can be
> > overlapped by sub-field for early NID, and bit 4 is unexpectedly set
> > on (for example) NUMA node id is 2 or 3.
> > 
> > To fix it, set SECTION_NID_SHIFT to 6 which is the minimum number of
> > available bits of section flag field.
> > 
> > [1]: https://github.com/crash-utility/crash/commit/0b5435e10161345cf713ed447a155a611a1b408b
> 
> [1] is never referenced

I dropped this.

> 
> > 
> > Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> > Cc: stable@vger.kernel.org # v5.12+
> 
> ^ I am not really convinced that this is a stable fix. It forces something
> through the slow path, but the kernel itself is not broken, no?

No, it's not broken, but just suboptimal.
So I drop the CC to stable.

> > Reported-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> >   include/linux/mmzone.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index fcb535560028..d6aa2a196aeb 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1357,6 +1357,7 @@ extern size_t mem_section_usage_size(void);
> >    *      worst combination is powerpc with 256k pages,
> >    *      which results in PFN_SECTION_SHIFT equal 6.
> >    * To sum it up, at least 6 bits are available.
> > + * SECTION_NID_SHIFT is set to 6 based on this fact.
> 
> I'd drop that comment or rephrase to ("once this changes, don't forget to
> adjust SECTION_NID_SHIFT")

OK, I drop the comment.

> >    */
> >   #define SECTION_MARKED_PRESENT		(1UL<<0)
> >   #define SECTION_HAS_MEM_MAP		(1UL<<1)
> > @@ -1365,7 +1366,7 @@ extern size_t mem_section_usage_size(void);
> >   #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> >   #define SECTION_MAP_LAST_BIT		(1UL<<5)
> >   #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> > -#define SECTION_NID_SHIFT		3
> > +#define SECTION_NID_SHIFT		6
> >   static inline struct page *__section_mem_map_addr(struct mem_section *section)
> >   {
> > 
> 
> Change itself looks correct to me.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you, I'll post the update soon.

- Naoya Horiguchi

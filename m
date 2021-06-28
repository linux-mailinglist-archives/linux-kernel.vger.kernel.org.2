Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D403B5970
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhF1HIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhF1HIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:08:35 -0400
Received: from out1.migadu.com (unknown [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:06:10 -0700 (PDT)
Date:   Mon, 28 Jun 2021 16:06:01 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1624863967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4QpEwFNgTOsvfq5H10EY+RsTvs2eWzJPtK6eybdANE=;
        b=PL3IikYsbIx11cpWF7Pus6qiir/lkVPehj93Ace2/2CpZi96HoH6kz63R5cA4x2jGURIx7
        IhxcnF0iBT7CPnzcThaRfFKsnHcUciuVqq4S+srH/tmA3cyQJ85fo3LPGjN0WxpfTfVO66
        Otu37WZkHX8cAAR2wUQdhgkaoj7akNU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.xiang@huawei.com" <rui.xiang@huawei.com>,
        HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>
Subject: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6
Message-ID: <20210628070601.GB418318@u2004>
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
 <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
 <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
 <CAPcyv4h5a5AYscsyC40_5bc6j1kmjMFWJ_0MFAGEx1EPS9Tmrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4h5a5AYscsyC40_5bc6j1kmjMFWJ_0MFAGEx1EPS9Tmrw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 02:23:05PM -0700, Dan Williams wrote:
> On Wed, Jun 23, 2021 at 4:10 PM HORIGUCHI NAOYA(堀口　直也)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 11:05:17AM +0200, David Hildenbrand wrote:
> > > On 27.04.21 10:30, Wang Wensheng wrote:
> > > > The section_mem_map member of struct mem_section stores some flags and
> > > > the address of struct page array of the mem_section.
> > > >
> > > > Additionally the node id of the mem_section is stored during early boot,
> > > > where the struct page array has not been allocated. In other words, the
> > > > higher bits of section_mem_map are used for two purpose, and the node id
> > > > should be clear properly after the early boot.
> > > >
> > > > Currently the node id field is overlapped with the flag field and cannot
> > > > be clear properly. That overlapped bits would then be treated as
> > > > mem_section flags and may lead to unexpected side effects.
> > > >
> > > > Define SECTION_NID_SHIFT using order_base_2 to ensure that the node id
> > > > field always locates after flags field. That's why the overlap occurs -
> > > > forgetting to increase SECTION_NID_SHIFT when adding new mem_section
> > > > flag.
> > > >
> > > > Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag")
> > > > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> > > > ---
> > > >   include/linux/mmzone.h | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > index 47946ce..b01694d 100644
> > > > --- a/include/linux/mmzone.h
> > > > +++ b/include/linux/mmzone.h
> > > > @@ -1325,7 +1325,7 @@ extern size_t mem_section_usage_size(void);
> > > >   #define SECTION_TAINT_ZONE_DEVICE (1UL<<4)
> > > >   #define SECTION_MAP_LAST_BIT              (1UL<<5)
> > > >   #define SECTION_MAP_MASK          (~(SECTION_MAP_LAST_BIT-1))
> > > > -#define SECTION_NID_SHIFT          3
> > > > +#define SECTION_NID_SHIFT          order_base_2(SECTION_MAP_LAST_BIT)
> > > >   static inline struct page *__section_mem_map_addr(struct mem_section *section)
> > > >   {
> > > >
> > >
> > > Well, all sections around during boot that have an early NID are early ...
> > > so it's not an issue with SECTION_IS_EARLY, no? I mean, it's ugly, but not
> > > broken.
> > >
> > > But it's an issue with SECTION_TAINT_ZONE_DEVICE, AFAIKT.
> > > sparse_init_one_section() would leave the bit set if the nid happens to have
> > > that bit set (e.g., node 2,3). It's semi-broken then, because we force all
> > > pfn_to_online_page() through the slow path.
> > >
> > >
> > > That whole section flag setting code is fragile.
> >
> > Hi Wensheng, David,
> >
> > This patch seems not accepted or updated yet, so what's going on?
> >
> > We recently saw the exact issue on testing crash utilities with latest
> > kernels on 4 NUMA node system.  SECTION_TAINT_ZONE_DEVICE seems to be
> > set wrongly, and makedumpfile could fail due to this. So we need a fix.
> >
> > I thought of another approach like below before finding this thread,
> > so if you are fine, I'd like to submit a patch with this. And if you
> > like going with order_base_2() approach, I'm glad to ack this patch.
> >
> >   --- a/include/linux/mmzone.h
> >   +++ b/include/linux/mmzone.h
> >   @@ -1358,14 +1358,15 @@ extern size_t mem_section_usage_size(void);
> >     *      which results in PFN_SECTION_SHIFT equal 6.
> >     * To sum it up, at least 6 bits are available.
> >     */
> >   +#define SECTION_MAP_LAST_SHIFT         5
> >    #define SECTION_MARKED_PRESENT         (1UL<<0)
> >    #define SECTION_HAS_MEM_MAP            (1UL<<1)
> >    #define SECTION_IS_ONLINE              (1UL<<2)
> >    #define SECTION_IS_EARLY               (1UL<<3)
> >    #define SECTION_TAINT_ZONE_DEVICE      (1UL<<4)
> >   -#define SECTION_MAP_LAST_BIT           (1UL<<5)
> >   +#define SECTION_MAP_LAST_BIT           (1UL<<SECTION_MAP_LAST_SHIFT)
> >    #define SECTION_MAP_MASK               (~(SECTION_MAP_LAST_BIT-1))
> >   -#define SECTION_NID_SHIFT              3
> >   +#define SECTION_NID_SHIFT              SECTION_MAP_LAST_SHIFT
> 
> Rather than make it dynamic, why not just make it 6 directly since
> that matches the comment about the maximum number of flags available.

Sounds nice to me, so here's a patch. Could you review this?

Thanks,
Naoya Horiguchi
---
From a146c9f12ae8985c8985a5861330f7528cd14fe8 Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Mon, 28 Jun 2021 15:50:37 +0900
Subject: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6

Hagio-san reported that crash utility can see bit 4 in section_mem_map
(SECTION_TAINT_ZONE_DEVICE) to be set, even if we do not use any
ZONE_DEVICE ilke pmem or HMM.  This problem could break crash-related
toolsets and/or other memory analysis tools.

The root cause is that SECTION_NID_SHIFT is incorrectly set to 3,
while we use lower 5 bits for SECTION_* flags.  So bit 3 and 4 can be
overlapped by sub-field for early NID, and bit 4 is unexpectedly set
on (for example) NUMA node id is 2 or 3.

To fix it, set SECTION_NID_SHIFT to 6 which is the minimum number of
available bits of section flag field.

[1]: https://github.com/crash-utility/crash/commit/0b5435e10161345cf713ed447a155a611a1b408b

Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
Cc: stable@vger.kernel.org # v5.12+
Reported-by: Kazuhito Hagio <k-hagio-ab@nec.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mmzone.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..d6aa2a196aeb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1357,6 +1357,7 @@ extern size_t mem_section_usage_size(void);
  *      worst combination is powerpc with 256k pages,
  *      which results in PFN_SECTION_SHIFT equal 6.
  * To sum it up, at least 6 bits are available.
+ * SECTION_NID_SHIFT is set to 6 based on this fact.
  */
 #define SECTION_MARKED_PRESENT		(1UL<<0)
 #define SECTION_HAS_MEM_MAP		(1UL<<1)
@@ -1365,7 +1366,7 @@ extern size_t mem_section_usage_size(void);
 #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
 #define SECTION_MAP_LAST_BIT		(1UL<<5)
 #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT		3
+#define SECTION_NID_SHIFT		6
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD75E375BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhEFTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhEFTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:36:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3981C061574;
        Thu,  6 May 2021 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Gmd9WE9Bu2QYLvWpqKR/yYem0cFXFiMf/zwpkj95U8=; b=crQvOxVhfA0rYm1ruAKJBNw0xC
        xsM1t+SsJ5U1dOvsLom1VliGQksmvwhkFYj4n7ocfHyofPKeGYBDJFe7TYnq2YqoCPZFOp9Hi5yST
        4FH25flkLwf/Lwe/+RCpeR/nmAkbyaM0SvaT/6ZA3du1X0I7kf4FyjORRo8wpB+6q2guCZ8DJU5gv
        abGYH78vgb/2DeTmQHYosKU2fazelARvJeX7jelqa1FilgXL4Ovy+pzWnv0m0qQ94W3S3HRu/HDqu
        DvLeYnQ9jgK+5VudN9eKZp/TM9hNoGEyJpw9FhDDQ01zRQCnF9I0oCHm83eSPFGW7r3nw8/YpGdhl
        9IBGKFNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lejha-0028sz-5z; Thu, 06 May 2021 19:30:34 +0000
Date:   Thu, 6 May 2021 20:30:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
Message-ID: <20210506193026.GE388843@casper.infradead.org>
References: <20210506152623.178731-1-zi.yan@sent.com>
 <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
 <9D7FD316-988E-4B11-AC1C-64FF790BA79E@nvidia.com>
 <3a51f564-f3d1-c21f-93b5-1b91639523ec@redhat.com>
 <16962E62-7D1E-4E06-B832-EC91F54CC359@nvidia.com>
 <f3a2152c-685b-2141-3e33-b2bcab8b6010@redhat.com>
 <3A6D54CF-76F4-4401-A434-84BEB813A65A@nvidia.com>
 <0e850dcb-c69a-188b-7ab9-09e6644af3ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e850dcb-c69a-188b-7ab9-09e6644af3ab@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 09:10:52PM +0200, David Hildenbrand wrote:
> I have to admit that I am not really a friend of that. I still think our
> target goal should be to have gigantic THP *in addition to* ordinary THP.
> Use gigantic THP where enabled and possible, and just use ordinary THP
> everywhere else. Having one pageblock granularity is a real limitation IMHO
> and requires us to hack the system to support it to some degree.

You're thinking too small with only two THP sizes ;-)  I'm aiming to
support arbitrary power-of-two memory allocations.  I think there's a
fruitful discussion to be had about how that works for anonymous memory --
with page cache, we have readahead to tell us when our predictions of use
are actually fulfilled.  It doesn't tell us what percentage of the pages
allocated were actually used, but it's a hint.  It's a big lift to go from
2MB all the way to 1GB ... if you can look back to see that the previous
1GB was basically fully populated, then maybe jump up from allocating
2MB folios to allocating a 1GB folio, but wow, that's a big step.

This goal really does mean that we want to allocate from the page
allocator, and so we do want to grow MAX_ORDER.  I suppose we could
do somethig ugly like

	if (order <= MAX_ORDER)
		alloc_page()
	else
		alloc_really_big_page()

but that feels like unnecessary hardship to place on the user.

I know that for the initial implementation, we're going to rely on hints
from the user to use 1GB pages, but it'd be nice to not do that.

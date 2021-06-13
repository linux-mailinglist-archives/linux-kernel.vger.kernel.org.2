Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178E03A5AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhFMXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFMXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:22:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A45C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:20:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 515974B7;
        Sun, 13 Jun 2021 23:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 515974B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623626434; bh=ESIB7mDCsxO9P93y6K/GIxpR76DreOsbf5raY6NloCY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GLN+14weQ0ImY4oU4yobcboXI2O07h6szMfoEoKk7W6WcA4/yDMrYUsV5B17QIALG
         SOxkuGVErCzvxau/2ik1dWrXtoz713Yb5nxDc8/PTKenCKOTMZBMqZmmcFJPRE83/h
         4RXqb0FvJpFgvspmAphu7u6h+FAV6mkIW3ePB5P0nEEfFXqYO0j59YwxuQSlC0shMI
         S++4+eMjHFZ0AL622CQRO+n4T1sGmgfwUl2qX3APReFqNLdv0/DAndxVpwNb2cqQiX
         JxpZSPnycoPZNdOmQZtao833FmbN88ab02L5Rxm24FcDAWcQoXCX87k59mrCMgOSlP
         CDjzD53r7pc6g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
In-Reply-To: <20210609075752.4596-1-david@redhat.com>
References: <20210609075752.4596-1-david@redhat.com>
Date:   Sun, 13 Jun 2021 17:20:33 -0600
Message-ID: <87y2bd9wse.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> This is v3 of the memory hot(un)plug admin-guide overhaul.
>
> v2 -> v3:
> - Added ACKs and RBs (thanks!)
> - s/aarch64/arm64/
> - Refine error handling when onlining/offlining
> - s/memory hotplug/memory offlining/ in the vmemmap optimization section
>   for huge pages

So this set doesn't apply to docs-next, even when I correct for the fact
that you didn't make the patch from the top-level kernel directory.
What tree is this against?

Thanks,

jon

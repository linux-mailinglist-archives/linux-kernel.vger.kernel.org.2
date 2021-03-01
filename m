Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D46327B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhCAKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:10:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:36886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhCAKIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:08:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D747AAAC5;
        Mon,  1 Mar 2021 10:07:40 +0000 (UTC)
Date:   Mon, 1 Mar 2021 11:07:38 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 6/7] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210301100737.GB32425@linux>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-7-osalvador@suse.de>
 <dc044ae2-efce-0639-87de-3a3167c07a06@redhat.com>
 <20210226120451.GA3661@localhost.localdomain>
 <de1e2213-7dea-da52-607b-d4d718a3e04e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1e2213-7dea-da52-607b-d4d718a3e04e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:45:07AM +0100, David Hildenbrand wrote:
> Take your config and set
> 	X86_5LEVEL=n
> (because it enforces SPARSEMEM_VMEMMAP)
> and
> 	SPARSEMEM_VMEMMAP=n
> 
> When compiling, you'll end up with a config like
> 	CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> 	# CONFIG_SPARSEMEM_VMEMMAP is not set

I see

> 
> Yet, with your patch you would get
> 
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> And it would not get fenced off in the code, right?
> 
> 
> I think you either have to check (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)) in
> addition in your code, or enforce it differently. Like
> 
> 
> config MHP_MEMMAP_ON_MEMORY
> 	depends on SPARSEMEM_VMEMMAP && ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> 	bool
> 
> 
> Then you can simplify the arch Kconfig settings, removing the sparesemem
> dependency there.

Yes, will do it this way.

Thanks!

-- 
Oscar Salvador
SUSE L3

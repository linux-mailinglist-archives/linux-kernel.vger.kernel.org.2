Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A2326247
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:51364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZMFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:05:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87B88AB8C;
        Fri, 26 Feb 2021 12:04:54 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:04:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 6/7] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210226120451.GA3661@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-7-osalvador@suse.de>
 <dc044ae2-efce-0639-87de-3a3167c07a06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc044ae2-efce-0639-87de-3a3167c07a06@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:29:07PM +0100, David Hildenbrand wrote:
> On 09.02.21 14:38, Oscar Salvador wrote:
> > Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >   arch/x86/Kconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 72663de8b04c..81046b7adb10 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2440,6 +2440,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
> >   	def_bool y
> >   	depends on MEMORY_HOTPLUG
> > +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> > +	def_bool y
> > +	depends on X86_64 && MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
> 
> It depends on SPARSEMEM_VMEMMAP, no?
> 
> I think we could have
> 
> SPARSEMEM_VMEMMAP_ENABLE=y
> and
> SPARSEMEM_VMEMMAP=n
> 
> on manually tuned configs.

I do not think this can happen:

from mm/Kconfig:

config SPARSEMEM_VMEMMAP_ENABLE
        bool

config SPARSEMEM_VMEMMAP
        bool "Sparse Memory virtual memmap"
        depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
        default y
        help
          SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
          pfn_to_page and page_to_pfn operations.  This is the most
          efficient option when sufficient kernel resources are available

and from arch/x86/Kconfig:

config ARCH_SPARSEMEM_ENABLE
        def_bool y
        depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
        select SPARSEMEM_STATIC if X86_32
        select SPARSEMEM_VMEMMAP_ENABLE if X86_64


So, if I read this correctly, for SPARSEMEM_VMEMMAP to be true,
SPARSEMEM_VMEMMAP_ENABLE needs to be true as well.

Am I missing something?

-- 
Oscar Salvador
SUSE L3

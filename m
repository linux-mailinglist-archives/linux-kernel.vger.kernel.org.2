Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1420D3304F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 23:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhCGWPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 17:15:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:38782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhCGWOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 17:14:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E9CCACBF;
        Sun,  7 Mar 2021 22:14:49 +0000 (UTC)
Date:   Sun, 7 Mar 2021 23:14:46 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <YEVQVmsDIL4g4p1W@localhost.localdomain>
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-5-osalvador@suse.de>
 <a1df6c58-dab6-3eea-fbd9-3b25c887fc73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1df6c58-dab6-3eea-fbd9-3b25c887fc73@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:32:07PM +0100, David Hildenbrand wrote:
> On 04.03.21 11:00, Oscar Salvador wrote:
> > Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >   arch/x86/Kconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2792879d398e..6d716d8bce1e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2433,6 +2433,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
> >   	def_bool y
> >   	depends on MEMORY_HOTPLUG
> > +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> > +	def_bool y
> > +	depends on X86_64 && MEMORY_HOTPLUG
> 
> Was wondering if the MEMORY_HOTPLUG would also best be part of the generic
> MHP_MEMMAP_ON_MEMORY.

Yes, I think it suits best in the generic Kconfig.

Something like this on top of patch#1:

diff --git a/mm/Kconfig b/mm/Kconfig
index de3a7b5ed216..febf805000f8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -185,7 +185,8 @@ config MEMORY_HOTREMOVE

 config MHP_MEMMAP_ON_MEMORY
        def_bool y
-       depends on SPARSEMEM_VMEMMAP && ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+       depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
+       depends on ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE

And then this patch would be:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..9f0211df1746 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,6 +2433,9 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
        def_bool y
        depends on MEMORY_HOTPLUG
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+       def_bool y

because MEMORY_HOTPLUG already depends on 64 bits.

And the same would go for the arm64 one.

Better?


-- 
Oscar Salvador
SUSE L3

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8AB326256
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:10:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:60272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:10:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E171AB8C;
        Fri, 26 Feb 2021 12:10:13 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:10:11 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 7/7] arm64/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210226121011.GD3661@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-8-osalvador@suse.de>
 <126fa740-c163-1463-ff48-dbec4ad17ed7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <126fa740-c163-1463-ff48-dbec4ad17ed7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:29:23PM +0100, David Hildenbrand wrote:
> On 09.02.21 14:38, Oscar Salvador wrote:
> > Enable arm64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >   arch/arm64/Kconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 87fd02a7a62f..d4fb29779cd4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -309,6 +309,10 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
> >   config ARCH_ENABLE_MEMORY_HOTREMOVE
> >   	def_bool y
> > +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> > +	def_bool y
> > +	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
> > +
> 
> Same comment as for x86-64 variant.

From arm64/Kconfig:

config ARCH_SPARSEMEM_ENABLE
        def_bool y
        select SPARSEMEM_VMEMMAP_ENABLE

config ARCH_SPARSEMEM_DEFAULT
        def_bool ARCH_SPARSEMEM_ENABLE

config ARCH_SELECT_MEMORY_MODEL
        def_bool ARCH_SPARSEMEM_ENABLE

config ARCH_FLATMEM_ENABLE
        def_bool !NUMA

It seems SPARSEMEM_VMEMMAP_ENABLE is ticked by default unless we are on
a !NUMA system. So make it dependent on SPARSEMEM_VMEMMAP_ENABLE seems
the right thing to do?


-- 
Oscar Salvador
SUSE L3

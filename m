Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCE335C5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhDLMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:00:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238448AbhDLMAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AAEEAE5C;
        Mon, 12 Apr 2021 11:59:55 +0000 (UTC)
Date:   Mon, 12 Apr 2021 13:59:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 4/6] mm: Drop redundant
 ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
Message-ID: <20210412115952.GC27818@linux>
References: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
 <1617259448-22529-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617259448-22529-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:14:06PM +0530, Anshuman Khandual wrote:
> ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION configs have duplicate definitions on
> platforms that subscribe them. Drop these reduntant definitions and instead
> just select them appropriately.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> (arm64)
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Hi Anshuman, 

X86 needs fixing, see below:

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 503d8b2e8676..10702ef1eb57 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -60,8 +60,10 @@ config X86
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_32BIT_OFF_T			if X86_32
>  	select ARCH_CLOCKSOURCE_INIT
> +	select ARCH_ENABLE_HUGEPAGE_MIGRATION if x86_64 && HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
> +	select ARCH_ENABLE_THP_MIGRATION if x86_64 && TRANSPARENT_HUGEPAGE

you need s/x86_64/X86_64/, otherwise we are left with no migration :-)

-- 
Oscar Salvador
SUSE L3

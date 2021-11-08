Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33D447E22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhKHKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238603AbhKHKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:40:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED09260F5A;
        Mon,  8 Nov 2021 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636367880;
        bh=ijWSRQIO9EYSaAAcrmHQs27lL73yStLZwUAjDP06ONE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEgUWKUuiwBSxr5SN+e90t9wxjNLoRpSeuAeSCGVUqNQvApROPBkA+bM5+9VnRUGs
         fHhN8nBHqVSwnCX/Hid0ko7BB+vhS9rOoxxuuGDn5wTPcY3JZiB8eMnSq7c7Y4AHU2
         FDw1109kPoKnW4zJxM3vNjVHOVpvcgeV1/U55IN55ZUOpbcEsJtJY/BRKyoVrQi2U8
         e97QiWU3Rtw5J1vFFSjz/uGvFr0+tl7mz++UKbYHrWwMDjWIkh3zR4TBxeYkav0/e8
         4u5ODSHrnsXTi4trINLQvdwaOqXv8KvFHGx/zuB93oGUVR6teyWRQ2QXnCwXCHTNZW
         nnMJD1NWdvgwQ==
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Bob Picco <bob.picco@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: pgtable: make __pte_to_phys/__phys_to_pte_val inline functions
Date:   Mon,  8 Nov 2021 10:37:49 +0000
Message-Id: <163636595480.15222.10658604372252056385.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211105075414.2553155-1-arnd@kernel.org>
References: <20211105075414.2553155-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 08:54:03 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about undefined behavior the vmalloc code when building
> with CONFIG_ARM64_PA_BITS_52, when the 'idx++' in the argument to
> __phys_to_pte_val() is evaluated twice:
> 
> mm/vmalloc.c: In function 'vmap_pfn_apply':
> mm/vmalloc.c:2800:58: error: operation on 'data->idx' may be undefined [-Werror=sequence-point]
>  2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>       |                                                 ~~~~~~~~~^~
> arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
>    25 | #define __pte(x)        ((pte_t) { (x) } )
>       |                                     ^
> arch/arm64/include/asm/pgtable.h:80:15: note: in expansion of macro '__phys_to_pte_val'
>    80 |         __pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>       |               ^~~~~~~~~~~~~~~~~
> mm/vmalloc.c:2800:30: note: in expansion of macro 'pfn_pte'
>  2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>       |                              ^~~~~~~
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: pgtable: make __pte_to_phys/__phys_to_pte_val inline functions
      https://git.kernel.org/arm64/c/c7c386fbc202

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

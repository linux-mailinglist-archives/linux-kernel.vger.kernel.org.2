Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF445432C97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 06:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhJSEXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 00:23:46 -0400
Received: from foss.arm.com ([217.140.110.172]:44238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSEXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:23:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26C7BD6E;
        Mon, 18 Oct 2021 21:21:33 -0700 (PDT)
Received: from [10.163.74.241] (unknown [10.163.74.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22853F70D;
        Mon, 18 Oct 2021 21:21:30 -0700 (PDT)
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211013054756.12177-1-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c8fe322b-51e1-1250-8b8c-b711c929f634@arm.com>
Date:   Tue, 19 Oct 2021 09:51:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211013054756.12177-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 11:17 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Vladimir Zapolskiy reports:
> 
> commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> invokes a kernel panic while running kmemleak on OF platforms with nomaped
> regions:
> 
>   Unable to handle kernel paging request at virtual address fff000021e00000
>   [...]
>     scan_block+0x64/0x170
>     scan_gray_list+0xe8/0x17c
>     kmemleak_scan+0x270/0x514
>     kmemleak_write+0x34c/0x4ac
> 
> Indeed, NOMAP regions don't have linear map entries so an attempt to scan
> these areas would fault.
> 
> Prevent such faults by excluding NOMAP regions from kmemleak.
> 
> Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>  mm/memblock.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 184dcd2e5d99..5c3503c98b2f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -936,7 +936,12 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +
> +	if (!ret)
> +		kmemleak_free_part_phys(base, size);
> +
> +	return ret;
>  }
>  
>  /**
> 
> base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

A small nit though.

Just wondering. Should not the comment for memblock_mark_nomap() be
updated (or add a comment in the function) to explain the reason to
call kmemleak_free_part_phys(), to emphasize that a scan would fail
for such memory ranges due to lack of linear mapping ?

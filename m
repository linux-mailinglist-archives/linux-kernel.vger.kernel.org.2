Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672644310E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJRGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:54:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhJRGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79547106F;
        Sun, 17 Oct 2021 23:52:17 -0700 (PDT)
Received: from [10.163.74.6] (unknown [10.163.74.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB0D3F70D;
        Sun, 17 Oct 2021 23:52:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm/memory_failure: constify static mm_walk_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
 <20211014075042.17174-3-rikard.falkeborn@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7cd5c685-834f-46ce-969d-7dfc2d1368a8@arm.com>
Date:   Mon, 18 Oct 2021 12:22:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014075042.17174-3-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/21 1:20 PM, Rikard Falkeborn wrote:
> The only usage of hwp_walk_ops is to pass its address to
> walk_page_range() which takes a pointer to const mm_walk_ops as
> argument. Make it const to allow the compiler to put it in read-only
> memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 92eeb317adf4..8d5faf347ed1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -674,7 +674,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  #define hwpoison_hugetlb_range	NULL
>  #endif
>  
> -static struct mm_walk_ops hwp_walk_ops = {
> +static const struct mm_walk_ops hwp_walk_ops = {
>  	.pmd_entry = hwpoison_pte_range,
>  	.hugetlb_entry = hwpoison_hugetlb_range,
>  };
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

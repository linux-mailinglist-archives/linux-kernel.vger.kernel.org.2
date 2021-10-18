Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736194310D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJRGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:51:53 -0400
Received: from foss.arm.com ([217.140.110.172]:32992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJRGvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:51:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F60106F;
        Sun, 17 Oct 2021 23:49:39 -0700 (PDT)
Received: from [10.163.74.6] (unknown [10.163.74.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77CE23F70D;
        Sun, 17 Oct 2021 23:49:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm/damon/vaddr: constify static mm_walk_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
 <20211014075042.17174-2-rikard.falkeborn@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cef6d514-9532-732f-ad5c-b6cc01426fe5@arm.com>
Date:   Mon, 18 Oct 2021 12:19:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014075042.17174-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/21 1:20 PM, Rikard Falkeborn wrote:
> The only usage of these structs is to pass their addresses to
> walk_page_range(), which takes a pointer to const mm_walk_ops as
> argument. Make them const to allow the compiler to put them in
> read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  mm/damon/vaddr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 953c145b4f08..65d4f115fa66 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -476,7 +476,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> -static struct mm_walk_ops damon_mkold_ops = {
> +static const struct mm_walk_ops damon_mkold_ops = {
>  	.pmd_entry = damon_mkold_pmd_entry,
>  };
>  
> @@ -572,7 +572,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> -static struct mm_walk_ops damon_young_ops = {
> +static const struct mm_walk_ops damon_young_ops = {
>  	.pmd_entry = damon_young_pmd_entry,
>  };
>  
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

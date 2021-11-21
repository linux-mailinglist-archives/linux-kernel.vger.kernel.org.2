Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D12458324
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhKULga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 06:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhKULg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 06:36:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB4060E54;
        Sun, 21 Nov 2021 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637494405;
        bh=KrGsgGWqIO6v3E/xqeEmfERGvuO3FfTILF7qve6WynI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=dKDtF8VivmaNaHPETPTODghem0k7WHA2JK+YeXOdbWz/6NGdMnleGaOpu3jRnbIT0
         VjlYuW5e51SbnJutzFTbKcRVOt/1rmjL/gQteoZ6kozv1OhUfb5hkvQxSsKcF7g5K6
         wMlgb0vXR7g8L9ca856lIAcEFmLXBALEux7FIcUuca4Db/8VTNWiiBfPhHdNcnXN2h
         9xrVsi2dZy8mIVQhLrBu663Xd29RdciexGjamr1CkBcf9qqGE3zHnofYpVQgKm2fQi
         FojbzsZKQC2jq7+QPmXKroYTupxy34rrgOTXIaaoISxo9Fip7Xi5x95WvQcJsG+eHa
         PMvUvsMj56aBw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon: move damon_rand definition into damon.h
Date:   Sun, 21 Nov 2021 11:33:12 +0000
Message-Id: <20211121113312.3942-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6a4a7e53c2ab99028d431e7dc5e3d7635adb8522.1637429074.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,


On Sun, 21 Nov 2021 01:27:54 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> damon_rand() is called in three files:damon/core.c, damon/
> paddr.c, damon/vaddr.c, i think there is no need to redefine
> this twice, So move it to damon.h will be a good choice.

Good finding.  Could you please append '()' after 'damon_rand' in the title
(s/damon_rand definition/damon_rand() definition)?

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

After doing that, you could add

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h   | 4 ++++
>  mm/damon/core.c         | 4 ----
>  mm/damon/prmtv-common.h | 4 ----
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 8a73e825e0d5..8706b17a9acf 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -11,12 +11,16 @@
>  #include <linux/mutex.h>
>  #include <linux/time64.h>
>  #include <linux/types.h>
> +#include <linux/random.h>
>  
>  /* Minimal region size.  Every damon_region is aligned by this. */
>  #define DAMON_MIN_REGION	PAGE_SIZE
>  /* Max priority score for DAMON-based operation schemes */
>  #define DAMOS_MAX_SCORE		(99)
>  
> +/* Get a random number in [l, r) */
> +#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> +
>  /**
>   * struct damon_addr_range - Represents an address region of [@start, @end).
>   * @start:	Start address of the region (inclusive).
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4d2c3a0c7c8a..bdec32ef78c0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -11,7 +11,6 @@
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/mm.h>
> -#include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> @@ -23,9 +22,6 @@
>  #define DAMON_MIN_REGION 1
>  #endif
>  
> -/* Get a random number in [l, r) */
> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> -
>  static DEFINE_MUTEX(damon_lock);
>  static int nr_running_ctxs;
>  
> diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
> index 61f27037603e..e790cb5f8fe0 100644
> --- a/mm/damon/prmtv-common.h
> +++ b/mm/damon/prmtv-common.h
> @@ -6,10 +6,6 @@
>   */
>  
>  #include <linux/damon.h>
> -#include <linux/random.h>
> -
> -/* Get a random number in [l, r) */
> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
>  
>  struct page *damon_get_page(unsigned long pfn);
>  
> -- 
> 2.31.0
> 
> 

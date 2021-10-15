Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACEF42FCB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhJOUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233148AbhJOUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F322761151;
        Fri, 15 Oct 2021 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634328037;
        bh=7V/+1FW4XJaY4Tukrc6cjuQq0Lv0qT3qHWJvILfbP8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tqe6f2Zi5ekP1KVx7FMNoH7GFR2U4AgdYRjpf3rZuEm4kQNWYzvQF0A0m1Mlay9jC
         ANkaEsNGpddWaZG3ccXGMm+XI+vwIfnBHWjdf8+RQnrbq6m2xOwJfK35WK5UuFR4pm
         C8DjIm073AXHW7eZJ2T6Fou7k1V1C0MlziFEReU4=
Date:   Fri, 15 Oct 2021 13:00:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-Id: <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
In-Reply-To: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 14:15:29 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Sibling thread of the same process could refault the reclaimed pages
> in the same time, which would be typical in None global reclaim and
> introduce thrashing.

"None" -> "node", I assume?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  				sc->memcg_low_skipped = 1;
>  				continue;
>  			}
> +			/*
> +			 * Don't bother current when its memcg is below low
> +			 */

The comment explains what the code is doing, but the code itself
already does this.  Please can we have a comment that explains *why*
the code is doing this?


> +			if (get_mem_cgroup_from_mm(current->mm) == memcg)
> +				continue;
>  			memcg_memory_event(memcg, MEMCG_LOW);
>  		}


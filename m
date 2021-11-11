Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865644D3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhKKJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhKKJ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:27:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90CC761267;
        Thu, 11 Nov 2021 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636622683;
        bh=W1x0ssHgAn4wHCs14v8ZVBBVxbqa2b9C3CY3UVtS1Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Hq0SnEJjZLEqEUNzARMJOFeklPhUhzYouxWv5LWZb2uyzGzV929v3svuWe1dx8mz4
         YYhlJCBNSiYvBf5OrInXoK+oFpJhPG+kSMI+8h3BZFcYvKL9P+k/kwPe1IfqxZ7bvJ
         fdaHj+258EydEPILbsN2BxxfszG5+T4Pq2GVb5lH1ptncdKJkRt1w7N5WH0huAFkZL
         Djzizx4ewUqHSFpKbO2YaQZ4t6/Pz4iHDp5WX4L4/HRtB1BcdxWUG5FJWEtMDfHSRj
         +w//ziwV0eBuWEk7b/rKUercnXkqpJaXMm/tBQE0ojmw8dxApNmwAd6lZ7vc6qpnFV
         R8JvJmM2mmfNQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] mm/damon: Do some small changes
Date:   Thu, 11 Nov 2021 09:24:40 +0000
Message-Id: <20211111092440.11576-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1636610337.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin,

On Thu, 11 Nov 2021 14:07:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> These four patches are mainly to do some small changes.
> 
> V1 -> V2
> 	Add reviewed by SeongJae Park
> 	Add two new patches
> V1:
> https://lore.kernel.org/linux-mm/cover.1636546262.git.xhao@linux.alibaba.com/
> 
> 
> Xin Hao (4):
>   mm/damon: Unified access_check function naming rules
>   mm/damon: Add 'age' of region tracepoint support
>   mm/damon/core: Using function abs() instead of diff_of()
>   mm/damon: Remove some no need func definitions in damon.h file

Overall, all patches looks good to me, though I asked[1] a trivial change in
the commit message of the second patch.

Also, I found one interesting thing.  It seems you are wrapping body of the
commit messages at <75 columns[2]?  That's obviously neither a problem, nor
even trivial nit.  But... I'd prefer the messages look more consistent with
others.

[1] https://lore.kernel.org/linux-mm/20211111082034.13323-1-sj@kernel.org/
[2] https://docs.kernel.org/process/submitting-patches.html?highlight=75#the-canonical-patch-format


Thanks,
SJ

> 
>  include/linux/damon.h        | 25 ++-----------------------
>  include/trace/events/damon.h |  7 +++++--
>  mm/damon/core.c              |  6 ++----
>  mm/damon/vaddr.c             |  8 ++++----
>  4 files changed, 13 insertions(+), 33 deletions(-)
> 
> --
> 2.31.0

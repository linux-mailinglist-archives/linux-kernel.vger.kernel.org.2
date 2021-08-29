Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF33FAA74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhH2Jat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhH2Jas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CEA160C51;
        Sun, 29 Aug 2021 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630229396;
        bh=UxZL4W6qGDlr0ioRS9G59aeJGyhhQ/D/YpRN4g/VwXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1zAteKQLFZqfChd33F+XzeOOHyHl0gnhYXw/XkT58wAiNLEWFkWI4LIDyM381Myg
         2CevjM6T49rkCT+Jc52pWWhXPx8Tbap4Ce/kVaP46qB6qzNw8dC9nujI7GO8MC5n5n
         oA+oqiaVHik75McLjDlhBPSULJ0nvNrM7FcVpcLOgAzRQ9BQCnFwatYF1KMLrwZr78
         5gzNULJYNVvvdFPtkdinvLBfaUj1TUC8huPoB+LUCMtE4pU8QbgfuRp83OTaea+bye
         6OHzZnD/5DcFU+szByA3LNsWWYLqxy9p4/uPGxP9sOAmH0KXtKHmgTYxoMI/VVsF5x
         h74GO09Zqm2ZA==
Date:   Sun, 29 Aug 2021 18:29:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mattwu@163.com
Subject: Re: [PATCH 0/2] *** kretprobe scalability improvement ***
Message-Id: <20210829182953.1a05f40bdc5c82ff3a997d69@kernel.org>
In-Reply-To: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
References: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun,  8 Aug 2021 02:54:15 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> kretprobe is using freelist to manage return instances, but freelist as
> a LIFO queue based on singly linked list, scales badly and thus lowers
> throughput of kretprobed routines, especially for high parallelization.
> Here's a typical result (XEON 8260: 2 sockets/48 cores/96 threads):
> 
>       1X       2X       4X       6X       8X      12X     16X
> 10880312 18121228 23214783 13155457 11190217 10991228 9623992
>      24X      32X      48X      64X      96X     128X    192X
>  8484455  8376786  6766684  5698349  4113405  4528009 4081401
> 
> This patch implements a scalabe, lock-less and numa-aware object pool
> and as a result improves kretprobe to achieve near-linear scalability.
> Tests of kretprobe throughput show the biggest gain as 181.5x of the
> original freelist. Tge extreme tests of raw queue throughput can be up
> to 282.8 of gain. The comparison results are the followings:
> 
>                   1X         2X         4X         8X        16X
> freelist:  237911411  163596418   33048459   15506757   10640043
> objpool:   234799081  294086132  585290693 1164205947 2334923746
>                  24X        32X        48X        64X        96X
> freelist:    9025299    7965531    6800225    5507639    4284752
> objpool:  3508905695 1106760339 1101385147 1221763856 1211654038
> 
> The object pool is a percpu-extended version of original freelist,
> with compact memory footprints and balanced performance results for
> 3 test caess: nonblockable retrieval (most kertprobe cases), bulk
> retrieval in a row (multiple-threaded blockable kretprobe), huge
> misses (preallocated objects much less than required).

Sorry, I missed this series.
I'm OK for the code, but please combine these 2 patches into 1 because
those are not bisectable.

Thank you,

> 
> wuqiang (2):
>   scalable lock-less object pool implementation
>   kretprobe: manage instances with scalable object pool
> 
>  include/linux/freelist.h | 521 ++++++++++++++++++++++++++++++++++++---
>  include/linux/kprobes.h  |   2 +-
>  kernel/kprobes.c         |  83 ++++---
>  3 files changed, 536 insertions(+), 70 deletions(-)
> 
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

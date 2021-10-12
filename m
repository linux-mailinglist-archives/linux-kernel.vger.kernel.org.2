Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A89429E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhJLHNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhJLHNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:13:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D3F961078;
        Tue, 12 Oct 2021 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634022682;
        bh=qD7SONrCv4oiHwGk10dQtz0fdhOVBKUUsBL/etLiZb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=hdnrQmFf6/9HbBaYnMBNbTgWgQuJmo52lH2FT9VuxHVRt6FO4bz3dn0jlR/oUfWF/
         gNP4vrzLKYDAH6c7Csg6nZaXHga9GQPz29/H/u9tjDa0Ayo9Ic+4SEckYr3AQFU//9
         xDAyQ18km4BFPlFRFDMnJrP0qqdg4bgejhD8L2nNqjUpBeYeWm5xC5zIZNF233936O
         r3zIFfsSxDHltK2mZADsGadIpKMdrGtMQdl1nV8sq41xL2Bm3ONtbWnu7oW6Fw3+mS
         vYBWzDfRi/gEWsZuuomE3J6ctZIecPKw8vpHzlIXGRWYmgobiEIJVVG0sbGh+TdAgT
         2/otWTLAchRQg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/dbgfs: add region_stat interface
Date:   Tue, 12 Oct 2021 07:11:19 +0000
Message-Id: <20211012071119.32320-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012054948.90381-1-xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin, thank you for this patch!

On Tue, 12 Oct 2021 13:49:48 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Using damon-dbgfs has brought great convenience to user-mode
> operation damon, but sometimes if i want to be able to view
> the division of task regions, nr_access values etc,but i found
> that it is impossible to view directly through the dbgfs interface,
> so there i add a interface "region_stat", it displays like this.
> 
>  # cat region_stat
>  last_aggregation=120.87s
>  target_id=5148
>  nr_regions=10
>  400000-258c000(34352 KiB): 1
>  258c000-4719000(34356 KiB): 0
>  4719000-abbf000(103064 KiB): 0
>  abbf000-c4d4000(25684 KiB): 11
>  c4d4000-ff5c000(59936 KiB): 15
>  ff5c000-152f9000(85620 KiB): 20
>  152f9000-1599e000(6804 KiB): 10
>  1599e000-19573000(61268 KiB): 0
>  19573000-1f92c000(102116 KiB): 0
>  1f92c000-22a4c000(50304 KiB): 0

I think similar information could also be collected via the 'damon_aggregated'
tracepoint[1], which is merged in the mainline, or 'DAMOS_STAT'[2], which is
merged in -mm.  The recording feature[3] could also be used, though it would
take some time before it is merged in the mainline.  Have you considered using
those but found some problem?

[1] https://git.kernel.org/torvalds/c/2fcb93629ad8
[2] https://lore.kernel.org/linux-mm/20211001125604.29660-6-sj@kernel.org/
[3] https://lore.kernel.org/linux-mm/20211008094509.16179-1-sj@kernel.org/


Thanks,
SJ

[...]

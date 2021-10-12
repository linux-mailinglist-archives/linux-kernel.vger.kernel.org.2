Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713D442A144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJLJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235817AbhJLJjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4154660F92;
        Tue, 12 Oct 2021 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634031451;
        bh=R0SmQ7S/jRl0PK0hlJ5/R750VuqmT/FeDVno38hWDr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=mzfCcpVr8ALhVHoZHgieujKeAdV8tmt7NBQGrjgmA2ROwdKxQFfT3Ob98rwChUpQ6
         E8nSFfPCYteYGrh7NtHRnhJEwQxknS0aujyJaMuDxemmJeonhN1d/OtEHmaRsySFty
         q4v0DqOtNxUKfmSdv5F+JUx1eywsK7+4giQiX6abGn6vgYqE6vSuHdeQLd6w3Qx28L
         KqJ1BlWlh1DfEoY02cX/4+VOwk0oOhSnwDEdw479bMmesw981ubORAL/iHR1SzrLRR
         sPSJoEgJ8TlNHyCELfCdO9SOJrfoFQd+uLF/rEI/EtprWutRyEPd+dUoymHB8GA/o6
         yzOJJXso1BvGA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, sjpark@amazon.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/dbgfs: add region_stat interface
Date:   Tue, 12 Oct 2021 09:37:26 +0000
Message-Id: <20211012093726.33014-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <7ab062d3-f087-78ef-4630-471bb6d16275@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 15:57:17 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> 
> 在 2021/10/12 下午3:11, SeongJae Park 写道:
> > Hello Xin, thank you for this patch!
> >
> > On Tue, 12 Oct 2021 13:49:48 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> Using damon-dbgfs has brought great convenience to user-mode
> >> operation damon, but sometimes if i want to be able to view
> >> the division of task regions, nr_access values etc,but i found
> >> that it is impossible to view directly through the dbgfs interface,
> >> so there i add a interface "region_stat", it displays like this.
> >>
> >>   # cat region_stat
> >>   last_aggregation=120.87s
> >>   target_id=5148
> >>   nr_regions=10
> >>   400000-258c000(34352 KiB): 1
> >>   258c000-4719000(34356 KiB): 0
> >>   4719000-abbf000(103064 KiB): 0
> >>   abbf000-c4d4000(25684 KiB): 11
> >>   c4d4000-ff5c000(59936 KiB): 15
> >>   ff5c000-152f9000(85620 KiB): 20
> >>   152f9000-1599e000(6804 KiB): 10
> >>   1599e000-19573000(61268 KiB): 0
> >>   19573000-1f92c000(102116 KiB): 0
> >>   1f92c000-22a4c000(50304 KiB): 0
> > I think similar information could also be collected via the 'damon_aggregated'
> > tracepoint[1], which is merged in the mainline, or 'DAMOS_STAT'[2], which is
> > merged in -mm.  The recording feature[3] could also be used, though it would
> > take some time before it is merged in the mainline.  Have you considered using
> > those but found some problem?
> 
> Yes, i know we can use damon_aggregated tracepoint, but i think, add a 
> "region_stat" will be more
> 
> convenient and intuitive, especially when we use damon-dbgfs interface.

Thanks for the answer.

For more conveniend and intuitive interfaces, I recommend DAMON user-sapce
tool[1] rather than the debugfs interface.  You can also implement your own
user-space tool on top of the debugfs interface.  For example, the reference
implementation[1] implements 'record' feature on top of the tracepoint.  The
feature can provide below information, which is quite similar to what you want.
For more information on this, please refer to the document[2].

    # damo record $(pidof $workload)
    # damo report raw
    base_time_absolute: 8 m 59.809 s

    monitoring_start:                0 ns
    monitoring_end:            104.599 ms
    monitoring_duration:       104.599 ms
    target_id: 18446623438842320000
    nr_regions: 3
    563ebaa00000-563ebc99e000(  31.617 MiB):        1
    7f938d7e1000-7f938ddfc000(   6.105 MiB):        0
    7fff66b0a000-7fff66bb2000( 672.000 KiB):        0

    monitoring_start:          104.599 ms
    monitoring_end:            208.590 ms
    monitoring_duration:       103.991 ms
    target_id: 18446623438842320000
    nr_regions: 4
    563ebaa00000-563ebc99e000(  31.617 MiB):        1
    7f938d7e1000-7f938d9b5000(   1.828 MiB):        0
    7f938d9b5000-7f938ddfc000(   4.277 MiB):        0
    7fff66b0a000-7fff66bb2000( 672.000 KiB):        5

If this is still not so useful for you, could you please elaborate more on your
detailed requirements and use cases?

[1] https://github.com/awslabs/damo
[2] https://github.com/awslabs/damo/blob/next/USAGE.md#raw


Thanks,
SJ

> 
> >
> > [1] https://git.kernel.org/torvalds/c/2fcb93629ad8
> > [2] https://lore.kernel.org/linux-mm/20211001125604.29660-6-sj@kernel.org/
> > [3] https://lore.kernel.org/linux-mm/20211008094509.16179-1-sj@kernel.org/
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
> 
> -- 
> Best Regards!
> Xin Hao

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5B3EBC47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhHMS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbhHMS4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7214D6024A;
        Fri, 13 Aug 2021 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628880967;
        bh=3uaHgmEvZhNDKI0rrRHd0Jlbqr0chISUgb3mTBGDw1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbgdhBpClZ7Hi6JQOA6pxuTrCl62aWCa4E3l1zxlnqsyM4lbCXFQJZpVtGxallJU3
         qKyHb52zny5w2E8YGgSQ3k8HUxOPpyqGBkzeAiPmLPdD8Df0su/iWWNdZig7RbF4p6
         d0NzEsgM+Si5sX9ZEtPibMCBS9t8yuYW5z0nQBeTRZmBfyU98Ag0ocQkMgl447Moe+
         oxiijqJo5TobAwmX2uZw2CtkEBKVm8r77ZKsqQtHuWEWNm9Tooe5+ZDvVt3Og0mxy6
         MWCQgDoNZgDnPOYmanRhv2q1tf9bvoENra5qWdPIIPN/fkp9mHIVVAPa8XHNGotdsE
         JgL9uA9NfJTgA==
Date:   Fri, 13 Aug 2021 11:56:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce periodic iostat io latency
 traces
Message-ID: <YRbARsMfs2O2fz2s@google.com>
References: <20210803225542.3487172-1-daeho43@gmail.com>
 <2a79c1c5-366b-92d9-4025-dbda660b1178@kernel.org>
 <YRWKKQe0bcgjKIIA@google.com>
 <b1a7b8a6-89dc-9076-2388-ced59aa8c47c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a7b8a6-89dc-9076-2388-ced59aa8c47c@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13, Chao Yu wrote:
> On 2021/8/13 4:52, Jaegeuk Kim wrote:
> > On 08/11, Chao Yu wrote:
> > > Hi Daeho,
> > > 
> > > On 2021/8/4 6:55, Daeho Jeong wrote:
> > > > From: Daeho Jeong <daehojeong@google.com>
> > > > 
> > > > Whenever we notice some sluggish issues on our machines, we are always
> > > > curious about how well all types of I/O in the f2fs filesystem are
> > > > handled. But, it's hard to get this kind of real data. First of all,
> > > > we need to reproduce the issue while turning on the profiling tool like
> > > > blktrace, but the issue doesn't happen again easily. Second, with the
> > > > intervention of any tools, the overall timing of the issue will be
> > > > slightly changed and it sometimes makes us hard to figure it out.
> > > > 
> > > > So, I added F2FS_IOSTAT_IO_LATENCY config option to support printing out
> > > > IO latency statistics tracepoint events which are minimal things to
> > > > understand filesystem's I/O related behaviors. With "iostat_enable" sysfs
> > > > node on, we can get this statistics info in a periodic way and it
> > > > would cause the least overhead.
> > > > 
> > > > [samples]
> > > >    f2fs_ckpt-254:1-507     [003] ....  2842.439683: f2fs_iostat_latency:
> > > > dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> > > > rd_data [136/1/801], rd_node [136/1/1704], rd_meta [4/2/4],
> > > > wr_sync_data [164/16/3331], wr_sync_node [152/3/648],
> > > > wr_sync_meta [160/2/4243], wr_async_data [24/13/15],
> > > > wr_async_node [0/0/0], wr_async_meta [0/0/0]
> > > > 
> > > >    f2fs_ckpt-254:1-507     [002] ....  2845.450514: f2fs_iostat_latency:
> > > > dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> > > > rd_data [60/3/456], rd_node [60/3/1258], rd_meta [0/0/1],
> > > > wr_sync_data [120/12/2285], wr_sync_node [88/5/428],
> > > > wr_sync_meta [52/6/2990], wr_async_data [4/1/3],
> > > > wr_async_node [0/0/0], wr_async_meta [0/0/0]
> > > > 
> > > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > > 
> > > > ---
> > > > v2: clean up with wrappers and fix a build breakage reported by
> > > >       kernel test robot <lkp@intel.com>
> > > > ---
> > > >    fs/f2fs/Kconfig             |   9 +++
> > > 
> > > I try to apply this patch in my local dev branch, but it failed due to
> > > conflicting with below commit, it needs to rebase this patch to last dev
> > > branch.
> > 
> > I applied this in dev branch. Could you please check?
> 
> Yeah, I see.
> 
> > > > +config F2FS_IOSTAT_IO_LATENCY
> > > > +	bool "F2FS IO statistics IO latency information"
> > > > +	depends on F2FS_FS
> > > > +	default n
> > > > +	help
> > > > +	  Support printing out periodic IO latency statistics tracepoint
> > > > +	  events. With this, you have to turn on "iostat_enable" sysfs
> > > > +	  node to print this out.
> > > 
> > > This functionality looks independent, how about introuducing iostat.h
> > > and iostat.c (not sure, maybe trace.[hc])to include newly added structure
> > > and functions for dispersive codes cleanup.
> 
> Thoughts? this also can avoid using CONFIG_F2FS_IOSTAT_IO_LATENCY in many places.

It seems there's somewhat dependency with iostat which is done by default.
How about adding this by default as well in the existing iostat, and then
covering all together by F2FS_IOSTAT?

> 
> Thanks,

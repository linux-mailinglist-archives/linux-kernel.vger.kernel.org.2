Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15FA3F362C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhHTVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhHTVx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9875661166;
        Fri, 20 Aug 2021 21:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629496369;
        bh=e7ifXtKt2aWf1y2xE7mHpd35Fe0gLKD3FzNWdBEnQpE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iMSKHmPLIpFcrWMroqjdSqTwWskuliZl06qP2VZTaoN3ZpWasuLdE7Lh+FY+3fteV
         RcW+cmoIyV+xXcauyJe3IQ0SPxvgs71jIevhfssJawv7vbZ7LTTl3z51s/tOBOL+rf
         V145OPRFH4DviXV7ra+aTU0ElOw2DiywEDhYB5xne4kWblP529L6Jpyc0LAzVAOR9h
         XMqIIOVLNPncXsmXMTUyPdVD8noT/gb1N4qoLHzCwoQ3nB27FBbgB8A0All+nqLO3C
         L1FkPUQbieLqdlvIlXa9y/b8FMKwcJPcrj7csscZhSUEJdQn4lsRpQhyQjYk/inFbq
         RsiQd5m8NpChA==
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce periodic iostat io
 latency traces
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210820035229.216975-1-daeho43@gmail.com>
 <20210820035229.216975-2-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <71203c35-4a9d-c43f-c74c-16a90bb5ff71@kernel.org>
Date:   Sat, 21 Aug 2021 05:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820035229.216975-2-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/20 11:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Whenever we notice some sluggish issues on our machines, we are always
> curious about how well all types of I/O in the f2fs filesystem are
> handled. But, it's hard to get this kind of real data. First of all,
> we need to reproduce the issue while turning on the profiling tool like
> blktrace, but the issue doesn't happen again easily. Second, with the
> intervention of any tools, the overall timing of the issue will be
> slightly changed and it sometimes makes us hard to figure it out.
> 
> So, I added the feature printing out IO latency statistics tracepoint
> events, which are minimal things to understand filesystem's I/O related
> behaviors, into F2FS_IOSTAT kernel config. With "iostat_enable" sysfs
> node on, we can get this statistics info in a periodic way and it
> would cause the least overhead.
> 
> [samples]
>   f2fs_ckpt-254:1-507     [003] ....  2842.439683: f2fs_iostat_latency:
> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> rd_data [136/1/801], rd_node [136/1/1704], rd_meta [4/2/4],
> wr_sync_data [164/16/3331], wr_sync_node [152/3/648],
> wr_sync_meta [160/2/4243], wr_async_data [24/13/15],
> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> 
>   f2fs_ckpt-254:1-507     [002] ....  2845.450514: f2fs_iostat_latency:
> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> rd_data [60/3/456], rd_node [60/3/1258], rd_meta [0/0/1],
> wr_sync_data [120/12/2285], wr_sync_node [88/5/428],
> wr_sync_meta [52/6/2990], wr_async_data [4/1/3],
> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> 
> ---
> v4: separate the previous patch into two patches
> v3: moved other I/O statistics related features into a separate file
>      with the same kernel config option for better maintenance.
> v2: clean up with wrappers and fix a build breakage reported by
>      kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

It needs to move Signed-off-by tag to the front of change log section,
otherwise it will be missed during applying.

Thanks,

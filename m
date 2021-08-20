Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81B3F3738
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhHTXQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhHTXQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:16:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D71561165;
        Fri, 20 Aug 2021 23:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629501378;
        bh=gND2D7ZmLJGqxBQEiaqUQVfu0fJGInr/zCwmlW7GWkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKezb+LrZllD3p0QDSwLHv8XtHhksmhz1hYnqCZcuCRRI7vHZE1K+v0KpI2NDoifu
         MrMYvI6k1dUeSF6ZlArPzmZdHGyMGiQteiTUVhZjwc1L7ZH54WVfW7xM2csKj7xev4
         /h7Oath5HxOCb7l5o3Nu9hrDDgjURiNdHT1hmm2TV5cGLvoCbyZ8COYECIJZPWTOkW
         bp/Trc9zHZvHen1JzVdSN2/a4v7lxVs5qI7FF2kkwNT+PX4z0XcCtZwDMEx12lwvd1
         SiCsytxOMO0CuZgPye2en5D0lJC0KOlHkUV09JUxf4jWFo4D1A/l+E4ic8yHM56URC
         5BnghgNnraWOQ==
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce periodic iostat io latency
 traces
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210820222909.342198-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <501b84ea-b06e-7bcd-9aac-1422cfb6bae6@kernel.org>
Date:   Sat, 21 Aug 2021 07:16:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820222909.342198-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/21 6:29, Daeho Jeong wrote:
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
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

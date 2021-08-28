Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6380F3FA28D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhH1AoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 20:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhH1AoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 20:44:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEF8860F14;
        Sat, 28 Aug 2021 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630111392;
        bh=jah1aaOllz3Ob5t19NZqX7ZjZZ2lH5n+1dapisCauwQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GJbKp4uSX/c1BFHuIEAXUZUN78tl/voUlAWWTZpgdsdcmu9+G7WKBORjJyQeVTXJl
         gGHmAUl7D1oFkAM+XI49Mf09mZX9fnJUOB+UUBpfJ9NF6SI0tbzHXMjw6UyW7vcoTS
         dk6vxdpV0arO/4o6p86qx+WDbf7jrd+WDvgGBAgVz/3eGzZpmvJGFfQo8AGeB28SxS
         g5shRAJjfioCS24ASPANj1dhEn4qfBvHcn6NbsjsFKsg1DJS8VIPIAFF5T3Y2VdKjD
         geOVLxVlj3nu/RVtB1XoskYu92u6Ze4Z0KAEMUljFPVSRdX/ND3YNUuZuemLNCw1yo
         TrUYHe9Ka861A==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210825185747.1627497-1-daeho43@gmail.com>
 <1f1e6d38-6bd1-17ea-b8ca-a45d1244728f@kernel.org>
 <CACOAw_yhgo1_wrejKskSm=Rsw27ogx=TS_A=z=-NGLcecA-gYA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <335d5bb5-7055-c934-33df-a03885382034@kernel.org>
Date:   Sat, 28 Aug 2021 08:43:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_yhgo1_wrejKskSm=Rsw27ogx=TS_A=z=-NGLcecA-gYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/27 23:22, Daeho Jeong wrote:
>> I'd like to add a fixed chunk/hole fragmentation mode in addition, then
>> userspace can control the fragmented chunk/hole with fixed size.
>>
>> How do you think of renaming "fragment:block" to "fragment:rand_block", and
>> then I can add "fragment:fixed_block" option and its logic in addition?
>>
> 
> The reason I added the randomness on these values is the segment
> selection in SSR mode.
> If all the segments have the same free block counts, f2fs will
> allocate a new segment sequentially in SSR.

I'm fine with this, since test program can customize different fragment
degree on segments by setting different chunk/hole size.

> This was what I didn't want. Plus, in the real world, the size of hole
> and chunk will be different in different segments.
> 
> But, if you think we need this "fragment:fixed_block" mode, I am happy
> to have it. :)

Thanks a lot. :)

As you said it needs to be aligned to real world fragmentation, I notice that:
with this way, we can't simulate similar fragment in FTL, due to its page
mapping architecture, all fragmented data/node in filesystem will be written
sequentially into its blocks.

In order to simulate fragment in FTL, we need to:
- write data (chunk size) with dummy pages (hole size) to devices
- issue discards on those holes

I guess fragmenting device (erase blocks) at the same time wouldn't be
original intention of this patch, right?

Thanks,

> 
>> Do we need to consider multiple thread scenario? in such case,
>> .fragment_remained_chunk may update randomly.
>>
>> In addition, multiple log headers share one .fragment_remained_chunk,
>> it may cause unexpected result, it means there may be continuous holes
>> or chunks in locality due to swithing between different log headers.
>>
>> Thanks,
>>
> 
> Oh, I overlooked that point. I am going to add the variable for each
> segment as you said before.
> 
> Thanks,
> 

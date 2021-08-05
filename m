Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9793E0CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhHEDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhHEDPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A420F610A0;
        Thu,  5 Aug 2021 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628133299;
        bh=5cm8AXwBgyiHBMqWiIPN+HOr+oCVs4hexDU07cDPJKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bC9DZgtuvKOCo1hfq3Tm65pNNhMnlGTlHbBBM3zC6FHGXMVuS/jOLX7Yo0BBy4bLQ
         lHUCBSxWb5HuQyHNGUVp7iFTWYFyXjT3o912hXnubu+YVzZujEInJNvGOfaX12cWx1
         LO/UjuSpcROQWm/IeN25ldBkPsDEYyb7eL3l3rL9PAocMq8XuFgCi/sz9k0sjh4EQY
         UBZ7fio6jtcLRj5YDzwIYi1FzpbcGrE8OFNDUWwkPxlgeGvA8QOzx8YWCsk3rCvWiN
         RFhlZbw3ci2avSZSIyWLk5RPrLp7LuD4wlqxMHWTKnvVN4gtASQ3JXoKiquy66XDKm
         jvbYXoSqILQjQ==
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com> <YQsmfm3ibU6bhvZr@google.com>
 <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
 <YQtSrIx0/sAipDs4@google.com>
 <62eb8902-90fa-4b1a-55ce-a178643baf90@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8f8a2aad-a201-01d2-eb31-06289421d6ec@kernel.org>
Date:   Thu, 5 Aug 2021 11:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <62eb8902-90fa-4b1a-55ce-a178643baf90@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/5 11:04, Chao Yu wrote:
> On 2021/8/5 10:53, Jaegeuk Kim wrote:
>> On 08/05, Chao Yu wrote:
>>> Jaegeuk,
>>>
>>> On 2021/8/5 7:45, Jaegeuk Kim wrote:
>>>> Chao,
>>>>
>>>> How about this?
>>>> https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
>>>
>>> Looks more clean, thanks,
>>>
>>>>
>>>> I'm digging one bug in __insert_extent_tree w/ the patch tho.
>>>
>>> Shouldn't we initialize @ei in f2fs_update_extent_tree_range(), otherwise,
>>> __try_merge_extent_node(&ei) -> __is_extent_mergeable() will do the check
>>> w/ uninitialized c_len of @ei.
>>
>> Fixed some bugs, but still getting another data corruption.

You mean data readed indexed by extent cache is inconsistent with the on-disk one,
right?

Thanks,

>>
>> https://github.com/jaegeuk/f2fs/commit/c5d97919c55b467392407b60c1a7b1e3e81721ff
> 
> Let me rebase to your code, and do some tests.
> 
> Thanks
> 
>>
>>>
>>>>> On 08/04, Chao Yu wrote:
>>>>>> +	if (from_dnode)
>>>>>> +		goto skip_reading_dnode;
>>>
>>> Wrong condition here, thanks for fixing.
>>>
>>> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

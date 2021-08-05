Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685AB3E0CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhHEDEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhHEDEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD0D661004;
        Thu,  5 Aug 2021 03:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628132664;
        bh=DoFtBqW8UB6ruKlkRSAEkUmYvCdD/NWqyxtofjx/IEo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cvv2hzAVc/Y0Ko9wOqWwQ6eDKKp8phmjSGUKkGAUixj6TLKLpEbP/5Xou52GPQ52v
         4OsGSN8N0tCQ2O7TpNpgOi998eUE0In9YgHtsMMSir0V8m8f/AAsPReP3ko5XI9rYN
         Y8kuw6pFcUknud+XlcEcUBiWfOBwWZ37i5YL2FOfboPgLnb62DsH3eeNzWQ3i3g6gP
         94XL/XW94+p13ZFM0n8f0mUcqZ49qYODEqJpAF/SXnuaIZyOhvM2XWyYKF/vInrUJP
         tTLPyGcOzCOWGozvvnhEwJqC6DvqOTxYYAJfGc4jY8hAP0u+GeBeVCJoWHypOoynWa
         v5gkfyyrZ3Sug==
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com> <YQsmfm3ibU6bhvZr@google.com>
 <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
 <YQtSrIx0/sAipDs4@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <62eb8902-90fa-4b1a-55ce-a178643baf90@kernel.org>
Date:   Thu, 5 Aug 2021 11:04:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQtSrIx0/sAipDs4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/5 10:53, Jaegeuk Kim wrote:
> On 08/05, Chao Yu wrote:
>> Jaegeuk,
>>
>> On 2021/8/5 7:45, Jaegeuk Kim wrote:
>>> Chao,
>>>
>>> How about this?
>>> https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
>>
>> Looks more clean, thanks,
>>
>>>
>>> I'm digging one bug in __insert_extent_tree w/ the patch tho.
>>
>> Shouldn't we initialize @ei in f2fs_update_extent_tree_range(), otherwise,
>> __try_merge_extent_node(&ei) -> __is_extent_mergeable() will do the check
>> w/ uninitialized c_len of @ei.
> 
> Fixed some bugs, but still getting another data corruption.
> 
> https://github.com/jaegeuk/f2fs/commit/c5d97919c55b467392407b60c1a7b1e3e81721ff

Let me rebase to your code, and do some tests.

Thanks

> 
>>
>>>> On 08/04, Chao Yu wrote:
>>>>> +	if (from_dnode)
>>>>> +		goto skip_reading_dnode;
>>
>> Wrong condition here, thanks for fixing.
>>
>> Thanks,

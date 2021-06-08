Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBD39EA80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFHADT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:03:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 901F060FE9;
        Tue,  8 Jun 2021 00:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623110487;
        bh=Uqzz4vK6Dqa6fvMe03GrzcwVa585uYCfslJFoH1K9kU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ng6oleFIsLvrfs6YfQwha8/CA53vnsqyv5y92/jB7azYlLenvSU838go/DQ+BJkgE
         sz/i9qP+2Mpk7xOvehf9l00UNhVTMjAPnJty261JpM10jnNpeZGKNf9mzV6ouEdEhH
         M4ZmENCrIuGEPUXdzenQV2noqp4KPhShxLTZgh14AjFRAF6KjxVpjxcYQD7uYK+dnN
         w3UCYbCzbfHTD50tmxchk/9OedysaP+rMKC+SO1oDz5cmRWuMU5Xtds98H92eG2+hv
         V2wuNC5ignYxbfceNyNK2QibDfMOwkeRPmu90lgUejvPL5cmj2eYF7sctCkT6SzgFb
         8eyrkIE/t061g==
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce cf_name_slab cache
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210607232715.3669-1-chao@kernel.org>
 <YL6wHViJbCKVGx4K@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <60da30ab-cfec-2b97-554a-88706430ca18@kernel.org>
Date:   Tue, 8 Jun 2021 08:01:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL6wHViJbCKVGx4K@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/8 7:47, Eric Biggers wrote:
> On Tue, Jun 08, 2021 at 07:27:15AM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Add a slab cache: "f2fs_casefold_name_entry" for memory allocation
>> of casefold name.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/dir.c      | 16 ++++++++++------
>>   fs/f2fs/recovery.c |  6 +++++-
>>   fs/f2fs/super.c    | 24 ++++++++++++++++++++++++
>>   3 files changed, 39 insertions(+), 7 deletions(-)
> 
> Looks good, but "f2fs_casefolded_name" would be a better name for this cache.
> 
> "f2fs_casefold_name_entry" makes it sounds like it contains some bookkeeping
> information and not the actual casefolded filenames.

Better, done.

> 
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 96dcc4aca639..ee400562157d 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -16,6 +16,10 @@
>>   #include "xattr.h"
>>   #include <trace/events/f2fs.h>
>>   
>> +#ifdef CONFIG_UNICODE
>> +extern struct kmem_cache *cf_name_slab;
>> +#endif
> 
> Also this variable needs to be prefixed with "f2fs_".  Otherwise this will cause
> a build error if/when ext4 adds the same thing.

Correct, fixed in v2.

Thanks for the suggestion.

Thanks,

> 
> - Eric
> 

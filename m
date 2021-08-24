Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231D3F6C49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHXXg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234775AbhHXXgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:36:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842C261101;
        Tue, 24 Aug 2021 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629848135;
        bh=TmmmCy3ttRTPrwcFEXqnLiJzYlTQBbSyZZokMksdh6k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xa5ffoXsFfxhlL30GG+vlyO9U4ExCvHxDy3AoC5wlWqluFeDCgQHKS36MWFQ56jXT
         BuuB1dJ0va2BlhoHRFV6WCYVGLi4ti6P3ct0fK6nkmJVUgteaC1dxWbZCBU3Ve1AAb
         URsvWYx9ZRP5DK6KL76/uxZ1F6TKIKf3r8WppEZE4H3PAD/vH/Y7nSnii/cEVRvKtW
         aQ3tCjlsW4Srh4+JD3slxikZUXhuD0bDPXQTQuYYxt3QlpSOnGZVsnnz2NrogkCISD
         BBtkT1JUx2VZMtw+CMukdigpldZvGfQ/W5yXg1U6qZtbYtbV2MLVxTFi33/fC30uSN
         YQtL/bPT6T2oQ==
Subject: Re: [PATCH] f2fs: fix wrong option name printed by parse_options()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210824011948.15408-1-chao@kernel.org>
 <YSUr1GS0M7weoRTt@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2520fdb0-835f-2664-198b-386416464e0d@kernel.org>
Date:   Wed, 25 Aug 2021 07:35:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSUr1GS0M7weoRTt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/25 1:26, Jaegeuk Kim wrote:
> On 08/24, Chao Yu wrote:
>> It prints below kernel message during mounting w/ checkpoint=disable
>> option:
>>
>> "F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"
>>
>> Fix typo "checkpoint=merge" w/ "checkpoint_merge"
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 49e153fd8183..88c66e46bd5c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1289,6 +1289,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
>> +			test_opt(sbi, MERGE_CHECKPOINT)) {
>> +		f2fs_err(sbi, "checkpoint_merge cannot be used with checkpoint=disable\n");
>> +		return -EINVAL;
> 
> What about disabling MERGE_CHECKPOINT autmatically?

checkpoint_merge was introduced separately rather than adding a new "merge"
parameter in mount option "checkpoint=%s", so they are compatible.

Please ignore this patch...

Thanks,

> 
>> +	}
>> +
>>   	/* Not pass down write hints if the number of active logs is lesser
>>   	 * than NR_CURSEG_PERSIST_TYPE.
>>   	 */
>> -- 
>> 2.32.0

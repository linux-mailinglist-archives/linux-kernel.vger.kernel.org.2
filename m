Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58E43BF83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhJ0CWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhJ0CWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD785610A0;
        Wed, 27 Oct 2021 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635301197;
        bh=6OnS/9NlrXeuVcDWbkkNkhf9wUozNfxWCF5JnO+Sd0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJ5SrEFBopmQPRVZEr3mltDxlkZ7M6MKGEIfehRJYjf+JTh91b0vtQSqksfnqRyrp
         XlEoR/hKvcbv4VqIL9Ltzc1U7xAXjQB8pqhRcYZLNTdkQtfDILoTcEk87KvGrDvDKp
         KvtAc1I/0jhuFrynUtoHU0hzWFmgf0dQg5vvfs8Y8/dSqMtaRwGi/oXvescz9pmDDd
         ccNqCNs8JPQMVIVI0uzkpuPLMVS8o+uUzenZ36B3Vy/Ur1NeYD7vVnvF+ObT+b3BlM
         kUsDUs7b8WkcHpvamq2dOpbw6otbbmKX8Sm8F0PXPgxnf8w6QKxEouQiXIotZtC7z4
         LE3rErfe3gGfg==
Message-ID: <4897a06a-9f9e-27ce-91d3-58721bee42ac@kernel.org>
Date:   Wed, 27 Oct 2021 10:19:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] f2fs: fix incorrect return value in
 f2fs_sanity_check_ckpt()
Content-Language: en-US
To:     jaegeuk@kernel.org, Pavel Machek <pavel@denx.de>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210922152705.720071-1-chao@kernel.org>
 <20210924095021.GA16651@duo.ucw.cz>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20210924095021.GA16651@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Missed to apply this patch?

Thanks,

On 2021/9/24 17:50, Pavel Machek wrote:
> Hi!
> 
>> This code looks quite confused: part of function returns 1 on
>> corruption, part returns -errno. The problem is not stable-specific.
>>
>> [1] https://lkml.org/lkml/2021/9/19/207
>>
>> Let's fix to make 'insane cp_payload case' to return 1 rater than
>> EFSCORRUPTED, so that return value can be kept consistent for all
>> error cases, it can avoid confusion of code logic.
>>
>> Fixes: 65ddf6564843 ("f2fs: fix to do sanity check for sb/cp fields correctly")
>> Reported-by: Pavel Machek <pavel@denx.de>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>
> 
> (This is good minimal fix, but eventually I believe the function
> should switch to 0/-errno... for consistency with rest of kernel).
> 
> Thank you,
> 								Pavel
> 								
>> +++ b/fs/f2fs/super.c
>> @@ -3487,7 +3487,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>   		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
>>   		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
>>   			  cp_payload, nat_bits_blocks);
>> -		return -EFSCORRUPTED;
>> +		return 1;
>>   	}
>>   
>>   	if (unlikely(f2fs_cp_error(sbi))) {
> 

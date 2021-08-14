Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D913EBF7E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhHNB74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236264AbhHNB7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:59:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 047AF6103A;
        Sat, 14 Aug 2021 01:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628906367;
        bh=uH60sluU04NxgCXY9p0lCQ9nqdOl1r0r3BwNc1FCRbs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QSpGivX48oH4E7RdkGy3ohWeDHBfigThPz9AiMnZRXcgJjDGkbhAcNfp4079/C/bq
         h/f3yzNT3UMm+SMZnmS/QTW9eoIdwR0fzS7UXr5s7pHVp/JsXSQE97+9jptgTwIv1W
         w9HGCpbkYtvAa449kpmaA5UtyMQMG5EQ78SNkMs0az9OokcFVrS+C+nUzvdQ3uG6nb
         SUl/zqvCH28cnT7txTCEKdBIVbisAZRQauDUEkTyeGpkNITiOB5UtVkaYjvZngTzSL
         UI7845IQA/B5u6FCOVTqf5Yzg1DThcmIg5888sIwDmy/dbyP5HPCYsowXLZkDcpGKE
         D5NrZUBe+QvYA==
Subject: Re: [PATCH v5 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <ALgAlACUD67cbvnqcwuTRaqA.3.1628879583910.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <25e44e70-eca6-5e48-fca1-844f76ea3a06@kernel.org>
Date:   Sat, 14 Aug 2021 09:59:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ALgAlACUD67cbvnqcwuTRaqA.3.1628879583910.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/14 2:33, 李扬韬 wrote:
> From: Chao Yu <chao@kernel.org>
> Date: 2021-08-13 22:44:49
> To:  Yangtao Li <frank.li@vivo.com>,jaegeuk@kernel.org
> Cc:  linux-f2fs-devel@lists.sourceforge.net,linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node>On 2021/8/13 20:32, Yangtao Li wrote:
>>> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
>>> this flag is set in too many places. For some scenes that are not very
>>> reproducible, adding stack information will help locate the problem.
>>>
>>> Let's expose all fsck stack history in procfs.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>> v5:
>>> -fix implicit declaration of function 'stack_trace_save'
>>>    fs/f2fs/f2fs.h  | 34 +++++++++++++++++++++++++++++++++-
>>>    fs/f2fs/sysfs.c | 26 ++++++++++++++++++++++++++
>>>    2 files changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 67faa43cc141..cbd06dea3c6a 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -24,6 +24,8 @@
>>>    #include <linux/quotaops.h>
>>>    #include <linux/part_stat.h>
>>>    #include <crypto/hash.h>
>>> +#include <linux/stackdepot.h>
>>> +#include <linux/stacktrace.h>
>>>    
>>>    #include <linux/fscrypt.h>
>>>    #include <linux/fsverity.h>
>>> @@ -119,6 +121,8 @@ typedef u32 nid_t;
>>>    
>>>    #define COMPRESS_EXT_NUM		16
>>>    
>>> +#define FSCK_STACK_DEPTH 64
>>> +
>>>    struct f2fs_mount_info {
>>>    	unsigned int opt;
>>>    	int write_io_size_bits;		/* Write IO size bits */
>>> @@ -1786,6 +1790,8 @@ struct f2fs_sb_info {
>>>    	unsigned int compress_watermark;	/* cache page watermark */
>>>    	atomic_t compress_page_hit;		/* cache hit count */
>>>    #endif
>>> +	depot_stack_handle_t *fsck_stack;
>>> +	unsigned int fsck_count;
>>>    };
>>>    
>>>    struct f2fs_private_dio {
>>> @@ -1997,9 +2003,35 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>>>    	return test_bit(type, &sbi->s_flag);
>>>    }
>>>    
>>> -static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>>> +static void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>>>    {
>>>    	set_bit(type, &sbi->s_flag);
>>> +
>>> +	if (unlikely(type ==  SBI_NEED_FSCK)) {
>>
>> Hmm... I don't know what to say...
> 
> Sorry, maybe there is a problem with my vim configuration.
> The strange thing is that checkpatch.pl didn't check it out.
> 
>>
>>> +		unsigned long entries[FSCK_STACK_DEPTH];
>>> +		depot_stack_handle_t stack, *new;
>>> +		unsigned int nr_entries;
>>> +		int i;
>>> +
>>> +		nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>>> +		nr_entries = filter_irq_stacks(entries, nr_entries);
>>> +		stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
>>> +		if (!stack)
>>> +			return;
>>> +
>>> +		/* Try to find an existing entry for this backtrace */
>>> +		for (i = 0; i < sbi->fsck_count; i++)
>>> +			if (sbi->fsck_stack[i] == stack)
>>
>> stack need to be released here?
> 
> We can't remove stack from depot, as we store them contiguously one after
> another in a contiguous memory allocation.
> 
> Or we can limit the recorded stack number.
> 
> $ grep -nr "SBI_NEED_FSCK" fs/f2fs/ --include=*.c --include=*.h | wc -l
> 53
> $ grep -nr "f2fs_bug_on" fs/f2fs/ --include=*.c --include=*.h | wc -l
> 135

I didn't look into details of stack_depot_save(), two stack handles from below
call paths will be the same?

- move_data_block
  - f2fs_wait_on_page_writeback
   - f2fs_bug_on

- ra_data_block
  - f2fs_wait_on_page_writeback
   - f2fs_bug_on

If they have different stack handles, combination number of
set_sbi_flag(NEED_FSCK)/f2fs_bug_on and their callers will be far more than two
hundred.

Thanks,

> 
> Since we only have two hundred possible settings here, considering that
> the same stack will not be recorded, and the probability of occurrence will
> not be high, so it is acceptable not to release?
> 
> If this is the case, the subsequent allocation does not need to be released.
> 
> Thx,
> Yangtao
> 

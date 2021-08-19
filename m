Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58B3F14CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhHSIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhHSIFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:05:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4993261139;
        Thu, 19 Aug 2021 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629360258;
        bh=pu0ysrGHipCPaIG2y6nk/FcaajGch8ROclwW+cPMTlA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=klGfKQuG0JWx1ts+OWEOYXOrkS6Oe4DTXllQVs/cju6eJFL2fyy6Fp62FPdulqY3n
         xeKZPojvYrTbdEnqulkazrp+C3ISDA7ArsSrTK0Tkl3Ueg1E1HAbevJaJhotw0eBS8
         vuXVfQ9WdVqb+mkK+26sw4mVsGVefWKfrp4BeRC1qzK8BE8MxOTKSr/9D8h1tz3tcI
         Hkiir9eZuPAZGoVPi+EtixJdfIF5Nhv9/6Yxe04DQr8ikAZs/rVmtzywdsnd348yu3
         hfBZ3Asgt4xTr8VNnUFyiNbePbkYFbYOR/ecmb8lXdJYftJwIxVhstgt8fD1Pj0zwl
         iKh8d/pMqKeYA==
Subject: Re: [PATCH v6] f2fs: introduce /sys/fs/f2fs/<disk>/fsck_stack node
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <AEYAigA8D7ZftrI0MRYeIqoY.3.1629098634558.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <492e1c4e-f39c-0460-0459-9c84aeaf407f@kernel.org>
Date:   Thu, 19 Aug 2021 16:04:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AEYAigA8D7ZftrI0MRYeIqoY.3.1629098634558.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 15:23, 李扬韬 wrote:
>>> HI Chao,
>>>>> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
>>>>> this flag is set in too many places. For some scenes that are not very
>>>>> reproducible, adding stack information will help locate the problem.
>>>>>
>>>>> Let's record all fsck stack history, I added F2FS_FSCK_STACK_TRACE
>>>>> configuration options and sysfs nodes. After opening the configuration
>>>>> options and enabling the node, it will start recording. The recorded
>>>>> stack information will not be clear, and we can get information form
>>>>> kernel log.
>>>>>
>>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>>> ---
>>>>>    Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++
>>>>>    fs/f2fs/Kconfig                         | 10 ++++++
>>>>>    fs/f2fs/f2fs.h                          | 45 +++++++++++++++++++++++++
>>>>>    fs/f2fs/sysfs.c                         | 27 +++++++++++++++
>>>>>    4 files changed, 89 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> index ef4b9218ae1e..047c398093cf 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> @@ -493,3 +493,10 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
>>>>>    Description:	When ATGC is on, it controls age threshold to bypass GCing young
>>>>>    		candidates whose age is not beyond the threshold, by default it was
>>>>>    		initialized as 604800 seconds (equals to 7 days).
>>>>> +
>>>>> +What:		/sys/fs/f2fs/<disk>/fsck_stack
>>>>> +Date:		August 2021
>>>>> +Contact:	"Yangtao Li" <frank.li@vivo.com>
>>>>> +Description:	Controls to enable/disable fsck stack trace, you can get stack
>>>>> +		information from kernel log. Note that the recorded stack information
>>>>> +		will not be cleared.
>>>>
>>>> Again, please don't add this into sysfs.
>>
>>Oh, I missed to check the details...
>>
>>> 
>>> I added this node, part of the idea is to trigger the export of stack information.
>>> There is no information transmitted through sysfs here, but the record of the stack is switched on and off.
>>> If don't export this information through procfs and sysfs, is there a more appropriate way?
>>
>>Well, I doubt why we should export stack info via proc/sysfs node or
>>sysfs switch.
>>
>>Those info will always be needed to troubleshoot issues no matter in
>>user or eng version of Android, can we just print them directly into
>>kernel message... what I concern is we may lost the bug scene due to
>>no one can help to trigger dmesg printing via sysfs.
>>
>>Jaegeuk, thoughts?
>>
>>> 
>>>>
>>>>> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
>>>>> index 7669de7b49ce..f451e567e4a8 100644
>>>>> --- a/fs/f2fs/Kconfig
>>>>> +++ b/fs/f2fs/Kconfig
>>>>> @@ -135,3 +135,13 @@ config F2FS_FS_LZORLE
>>>>>    	default y
>>>>>    	help
>>>>>    	  Support LZO-RLE compress algorithm, if unsure, say Y.
>>>>> +
>>>>> +config F2FS_FSCK_STACK_TRACE
>>>>
>>>> I don't think we need another config to wrap this functionality, may be we
>>>> can use F2FS_CHECK_FS instead.
>>> 
>>> OK.
>>> 
>>>>
>>>>> +	bool "F2FS fsck stack information record"
>>>>> +	depends on F2FS_FS
>>>>> +	depends on STACKDEPOT
>>>>> +	default y
>>>>> +	help
>>>>> +	 Support printing out fsck stack history. With this, you have to
>>>>> +	 turn on "fsck_stack" sysfs node. Then you can get information
>>>>> +	 from kernel log.
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index ee8eb33e2c25..b2d1d1a5a3fc 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -24,6 +24,8 @@
>>>>>    #include <linux/quotaops.h>
>>>>>    #include <linux/part_stat.h>
>>>>>    #include <crypto/hash.h>
>>>>> +#include <linux/stackdepot.h>
>>>>> +#include <linux/stacktrace.h>
>>>>>    
>>>>>    #include <linux/fscrypt.h>
>>>>>    #include <linux/fsverity.h>
>>>>> @@ -117,6 +119,8 @@ typedef u32 nid_t;
>>>>>    
>>>>>    #define COMPRESS_EXT_NUM		16
>>>>>    
>>>>> +#define FSCK_STACK_DEPTH		64
>>>>
>>>> 16?
>>> 
>>> OK.
>>> 
>>>>
>>>>> +
>>>>>    struct f2fs_mount_info {
>>>>>    	unsigned int opt;
>>>>>    	int write_io_size_bits;		/* Write IO size bits */
>>>>> @@ -1748,6 +1752,11 @@ struct f2fs_sb_info {
>>>>>    	unsigned int compress_watermark;	/* cache page watermark */
>>>>>    	atomic_t compress_page_hit;		/* cache hit count */
>>>>>    #endif
>>>>> +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
>>>>> +	depot_stack_handle_t *fsck_stack_history;
>>>>> +	unsigned int fsck_count;
>>>>> +	bool fsck_stack;
>>>>
>>>> IMO, all bug_on()s are corner cases, and catching those stacks won't cost
>>>> much, so we can just use CONFIG_XXX to enable/disable this feature.
>>> 
>>> F2FS_CHECK_FS ？
>>> 
>>>>
>>>>> +#endif
>>>>>    };
>>>>>    
>>>>>    struct f2fs_private_dio {
>>>>> @@ -1954,6 +1963,38 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
>>>>>    	return sbi->node_inode->i_mapping;
>>>>>    }
>>>>>    
>>>>> +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
>>>>> +static void fsck_stack_trace(struct f2fs_sb_info *sbi)
>>>>> +{
>>>>> +	unsigned long entries[FSCK_STACK_DEPTH];
>>>>> +	depot_stack_handle_t stack, *new;
>>>>> +	unsigned int nr_entries;
>>>>> +	int i;
>>>>> +
>>>>> +	if (!sbi->fsck_stack)
>>>>> +		return;
>>>>> +
>>>>> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>>>>> +	nr_entries = filter_irq_stacks(entries, nr_entries);
>>>>> +	stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
>>>>> +	if (!stack)
>>>>> +		return;
>>>>> +
>>>>> +	/* Try to find an existing entry for this backtrace */
>>>>> +	for (i = 0; i < sbi->fsck_count; i++)
>>>>> +		if (sbi->fsck_stack_history[i] == stack)
>>>>> +			return;
>>>>> +
>>>>> +	new = krealloc(sbi->fsck_stack_history, (sbi->fsck_count + 1) *
>>>>> +		       sizeof(*sbi->fsck_stack_history), GFP_KERNEL);
>>>>> +	if (!new)
>>>>> +		return;
>>>>> +
>>>>> +	sbi->fsck_stack_history = new;
>>>>> +	sbi->fsck_stack_history[sbi->fsck_count++] = stack;
>>>>
>>>> It will case memory leak after f2fs module exits.
>>> 
>>> So let's enable this feature when f2fs is not a module and enable F2FS_CHECK_FS.
>>
>>I mean it needs to free .fsck_stack_history during umount().
>  >
> 
> So this is a double-edged sword, and the person who uses it must be aware of this issue.
> The release seems unrealistic under the current circumstances. This is also the reason

You mean the handles allocated from stack_depot_save() should not be released, right?

> why I add a switch, instead of enabling it by default after opening the configuration.

Well, I still didn't get why we can not release the memory allocated by krealloc().

Thanks,

> 
> Yangtao
> 
> 

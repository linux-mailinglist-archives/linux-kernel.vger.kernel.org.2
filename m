Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638E63EB6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbhHMOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhHMOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB4460C41;
        Fri, 13 Aug 2021 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865892;
        bh=5leq8kE0+YWfDReXgUKHmWcBXZjTix6mSjdCruwc/hc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uHncfYNkIPFZjqoEC32dZD04Xq/OzMmnsZodq3Jc3s2/1snq+f0Zq1aBPLfez2hQ2
         5UJDATDVjVriYqvmefBCbfMY4A9E6qe7NEXp8nlkoGFYrhzAUxaBvMCnnuEq670Djo
         iaLwvXEcmSkVIcrTxNGNA8m/L3r3GD7AlNSOSmVg6/Pf61tXuYZ6FiOPMWcUMWeMwo
         MkEt06nEneAVwNM5vZksjScIuhAWMA1Ycgq6fi41oHQjkNVtk2R/QqxTowBH9sCk6k
         6QwWwm3BQXNVHvXkWw+1XfZ+/pEYUjVowV+fhHqr86XImv2jZ2Id6uXOCOLcZTrzdm
         uUO5D0fQLfV3Q==
Subject: Re: [PATCH v5 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210813123221.185591-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0cc57cc5-33b1-cc00-58a4-fce8de22aa35@kernel.org>
Date:   Fri, 13 Aug 2021 22:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813123221.185591-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 20:32, Yangtao Li wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
> this flag is set in too many places. For some scenes that are not very
> reproducible, adding stack information will help locate the problem.
> 
> Let's expose all fsck stack history in procfs.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v5:
> -fix implicit declaration of function 'stack_trace_save'
>   fs/f2fs/f2fs.h  | 34 +++++++++++++++++++++++++++++++++-
>   fs/f2fs/sysfs.c | 26 ++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 67faa43cc141..cbd06dea3c6a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -24,6 +24,8 @@
>   #include <linux/quotaops.h>
>   #include <linux/part_stat.h>
>   #include <crypto/hash.h>
> +#include <linux/stackdepot.h>
> +#include <linux/stacktrace.h>
>   
>   #include <linux/fscrypt.h>
>   #include <linux/fsverity.h>
> @@ -119,6 +121,8 @@ typedef u32 nid_t;
>   
>   #define COMPRESS_EXT_NUM		16
>   
> +#define FSCK_STACK_DEPTH 64
> +
>   struct f2fs_mount_info {
>   	unsigned int opt;
>   	int write_io_size_bits;		/* Write IO size bits */
> @@ -1786,6 +1790,8 @@ struct f2fs_sb_info {
>   	unsigned int compress_watermark;	/* cache page watermark */
>   	atomic_t compress_page_hit;		/* cache hit count */
>   #endif
> +	depot_stack_handle_t *fsck_stack;
> +	unsigned int fsck_count;
>   };
>   
>   struct f2fs_private_dio {
> @@ -1997,9 +2003,35 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>   	return test_bit(type, &sbi->s_flag);
>   }
>   
> -static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
> +static void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>   {
>   	set_bit(type, &sbi->s_flag);
> +
> +	if (unlikely(type ==  SBI_NEED_FSCK)) {

Hmm... I don't know what to say...

> +		unsigned long entries[FSCK_STACK_DEPTH];
> +		depot_stack_handle_t stack, *new;
> +		unsigned int nr_entries;
> +		int i;
> +
> +		nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> +		nr_entries = filter_irq_stacks(entries, nr_entries);
> +		stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
> +		if (!stack)
> +			return;
> +
> +		/* Try to find an existing entry for this backtrace */
> +		for (i = 0; i < sbi->fsck_count; i++)
> +			if (sbi->fsck_stack[i] == stack)

stack need to be released here?

> +				return;
> +
> +		new = krealloc(sbi->fsck_stack, (sbi->fsck_count + 1) *
> +			       sizeof(*sbi->fsck_stack), GFP_KERNEL);
> +		if (!new)

Ditto?

> +			return;
> +
> +		sbi->fsck_stack = new;

Need to be released somewhere.

> +		sbi->fsck_stack[sbi->fsck_count++] = stack;

Need to be released somewhere.

> +	}
>   }
>   
>   static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0954761341d7..c134bbb99c7b 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1171,6 +1171,29 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
>   	return 0;
>   }
>   
> +static int __maybe_unused fsck_stack_seq_show(struct seq_file *seq,
> +						void *offset)
> +{
> +	struct super_block *sb = seq->private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +	unsigned int i, j;
> +
> +	for (i = 0; i < sbi->fsck_count; i++) {
> +		nr_entries = stack_depot_fetch(sbi->fsck_stack[i], &entries);
> +		if (!entries)
> +			return 0;
> +
> +		for (j = 0; j < nr_entries; j++)
> +			seq_printf(seq, "%pS\n", (void *)entries[j]);
> +
> +		seq_putc(seq, '\n');
> +	}
> +
> +	return 0;
> +}
> +
>   static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
>   						void *offset)
>   {
> @@ -1261,6 +1284,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>   				iostat_info_seq_show, sb);
>   		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
>   				victim_bits_seq_show, sb);
> +		proc_create_single_data("fsck_stack", S_IRUGO, sbi->s_proc,
> +				fsck_stack_seq_show, sb);
>   	}
>   	return 0;
>   put_feature_list_kobj:
> @@ -1282,6 +1307,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>   		remove_proc_entry("segment_info", sbi->s_proc);
>   		remove_proc_entry("segment_bits", sbi->s_proc);
>   		remove_proc_entry("victim_bits", sbi->s_proc);
> +		remove_proc_entry("fsck_stack", sbi->s_proc);
>   		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>   	}
>   
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07F3EE0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhHQA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232995AbhHQA2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:28:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C36760F55;
        Tue, 17 Aug 2021 00:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160057;
        bh=JAyjnFSiVYPluKRbzgYs1WrwR65TQsHZgz7pFKAhH9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szi2GdEolnaOQo9jSGh1cxvC4y9mRj+tBO4Q+L6m9pohIP7BlRkzN6W3FH+IaPVS4
         0kAf49PqrI2vAFVfTibz/Dak86zdCcQwu5cRt84nlVfbylpOTbWhhYMF2t5Yy3vSPV
         UNMwfZSzxplB1xynRQ63kDBZVMlPIQ6m+XuhFBN84JWlOycLyastH5FBmm9vDXesM6
         75y/ifrf25DuDEWUso/Cj4c7PgUCQRsAed6rijj4wI2EDQWgDrZXN4a7T4GAEAm3MU
         5vez6v3ZNlJMpjyqcl6yeJkwFIggovYz+zrRJrI2usz+7F8vRE8cRCNFhJrsb5h15h
         vxZu2B9TF+Ovw==
Date:   Mon, 16 Aug 2021 17:27:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] f2fs: introduce /sys/fs/f2fs/<disk>/fsck_stack node
Message-ID: <YRsCd2ZfzB43oAE3@google.com>
References: <AJAAagAPD-VfBUmHLD9YN4pD.3.1629086526174.Hmail.frank.li@vivo.com>
 <2692c9c0-bb9f-0dd2-f0ca-6abb89e34c47@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2692c9c0-bb9f-0dd2-f0ca-6abb89e34c47@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Chao Yu wrote:
> On 2021/8/16 12:02, 李扬韬 wrote:
> > HI Chao,
> > > > SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
> > > > this flag is set in too many places. For some scenes that are not very
> > > > reproducible, adding stack information will help locate the problem.
> > > > 
> > > > Let's record all fsck stack history, I added F2FS_FSCK_STACK_TRACE
> > > > configuration options and sysfs nodes. After opening the configuration
> > > > options and enabling the node, it will start recording. The recorded
> > > > stack information will not be clear, and we can get information form
> > > > kernel log.
> > > > 
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > ---
> > > >    Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++
> > > >    fs/f2fs/Kconfig                         | 10 ++++++
> > > >    fs/f2fs/f2fs.h                          | 45 +++++++++++++++++++++++++
> > > >    fs/f2fs/sysfs.c                         | 27 +++++++++++++++
> > > >    4 files changed, 89 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > index ef4b9218ae1e..047c398093cf 100644
> > > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > @@ -493,3 +493,10 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
> > > >    Description:	When ATGC is on, it controls age threshold to bypass GCing young
> > > >    		candidates whose age is not beyond the threshold, by default it was
> > > >    		initialized as 604800 seconds (equals to 7 days).
> > > > +
> > > > +What:		/sys/fs/f2fs/<disk>/fsck_stack
> > > > +Date:		August 2021
> > > > +Contact:	"Yangtao Li" <frank.li@vivo.com>
> > > > +Description:	Controls to enable/disable fsck stack trace, you can get stack
> > > > +		information from kernel log. Note that the recorded stack information
> > > > +		will not be cleared.
> > > 
> > > Again, please don't add this into sysfs.
> 
> Oh, I missed to check the details...
> 
> > 
> > I added this node, part of the idea is to trigger the export of stack information.
> > There is no information transmitted through sysfs here, but the record of the stack is switched on and off.
> > If don't export this information through procfs and sysfs, is there a more appropriate way?
> 
> Well, I doubt why we should export stack info via proc/sysfs node or
> sysfs switch.
> 
> Those info will always be needed to troubleshoot issues no matter in
> user or eng version of Android, can we just print them directly into
> kernel message... what I concern is we may lost the bug scene due to
> no one can help to trigger dmesg printing via sysfs.
> 
> Jaegeuk, thoughts?

I thought that it'd be good to have an error history in debufs. For example,
we can have a set of reasons defined as enum and put the error counts per
SBI_NEED_FSCK along with error number like ENOMEM, EIO, and so on. The goal
would be to understand whether we're getting SBI_NEED_FSCK which triggers
fsck in practical.

> 
> > 
> > > 
> > > > diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> > > > index 7669de7b49ce..f451e567e4a8 100644
> > > > --- a/fs/f2fs/Kconfig
> > > > +++ b/fs/f2fs/Kconfig
> > > > @@ -135,3 +135,13 @@ config F2FS_FS_LZORLE
> > > >    	default y
> > > >    	help
> > > >    	  Support LZO-RLE compress algorithm, if unsure, say Y.
> > > > +
> > > > +config F2FS_FSCK_STACK_TRACE
> > > 
> > > I don't think we need another config to wrap this functionality, may be we
> > > can use F2FS_CHECK_FS instead.
> > 
> > OK.
> > 
> > > 
> > > > +	bool "F2FS fsck stack information record"
> > > > +	depends on F2FS_FS
> > > > +	depends on STACKDEPOT
> > > > +	default y
> > > > +	help
> > > > +	 Support printing out fsck stack history. With this, you have to
> > > > +	 turn on "fsck_stack" sysfs node. Then you can get information
> > > > +	 from kernel log.
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index ee8eb33e2c25..b2d1d1a5a3fc 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -24,6 +24,8 @@
> > > >    #include <linux/quotaops.h>
> > > >    #include <linux/part_stat.h>
> > > >    #include <crypto/hash.h>
> > > > +#include <linux/stackdepot.h>
> > > > +#include <linux/stacktrace.h>
> > > >    #include <linux/fscrypt.h>
> > > >    #include <linux/fsverity.h>
> > > > @@ -117,6 +119,8 @@ typedef u32 nid_t;
> > > >    #define COMPRESS_EXT_NUM		16
> > > > +#define FSCK_STACK_DEPTH		64
> > > 
> > > 16?
> > 
> > OK.
> > 
> > > 
> > > > +
> > > >    struct f2fs_mount_info {
> > > >    	unsigned int opt;
> > > >    	int write_io_size_bits;		/* Write IO size bits */
> > > > @@ -1748,6 +1752,11 @@ struct f2fs_sb_info {
> > > >    	unsigned int compress_watermark;	/* cache page watermark */
> > > >    	atomic_t compress_page_hit;		/* cache hit count */
> > > >    #endif
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +	depot_stack_handle_t *fsck_stack_history;
> > > > +	unsigned int fsck_count;
> > > > +	bool fsck_stack;
> > > 
> > > IMO, all bug_on()s are corner cases, and catching those stacks won't cost
> > > much, so we can just use CONFIG_XXX to enable/disable this feature.
> > 
> > F2FS_CHECK_FS ？
> > 
> > > 
> > > > +#endif
> > > >    };
> > > >    struct f2fs_private_dio {
> > > > @@ -1954,6 +1963,38 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
> > > >    	return sbi->node_inode->i_mapping;
> > > >    }
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +static void fsck_stack_trace(struct f2fs_sb_info *sbi)
> > > > +{
> > > > +	unsigned long entries[FSCK_STACK_DEPTH];
> > > > +	depot_stack_handle_t stack, *new;
> > > > +	unsigned int nr_entries;
> > > > +	int i;
> > > > +
> > > > +	if (!sbi->fsck_stack)
> > > > +		return;
> > > > +
> > > > +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> > > > +	nr_entries = filter_irq_stacks(entries, nr_entries);
> > > > +	stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
> > > > +	if (!stack)
> > > > +		return;
> > > > +
> > > > +	/* Try to find an existing entry for this backtrace */
> > > > +	for (i = 0; i < sbi->fsck_count; i++)
> > > > +		if (sbi->fsck_stack_history[i] == stack)
> > > > +			return;
> > > > +
> > > > +	new = krealloc(sbi->fsck_stack_history, (sbi->fsck_count + 1) *
> > > > +		       sizeof(*sbi->fsck_stack_history), GFP_KERNEL);
> > > > +	if (!new)
> > > > +		return;
> > > > +
> > > > +	sbi->fsck_stack_history = new;
> > > > +	sbi->fsck_stack_history[sbi->fsck_count++] = stack;
> > > 
> > > It will case memory leak after f2fs module exits.
> > 
> > So let's enable this feature when f2fs is not a module and enable F2FS_CHECK_FS.
> 
> I mean it needs to free .fsck_stack_history during umount().
> 
> Thanks,
> 
> > 
> > > 
> > > > +}
> > > > +#endif
> > > > +
> > > >    static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
> > > >    {
> > > >    	return test_bit(type, &sbi->s_flag);
> > > > @@ -1962,6 +2003,10 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
> > > >    static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
> > > >    {
> > > >    	set_bit(type, &sbi->s_flag);
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +	if (unlikely(type == SBI_NEED_FSCK))
> > > > +		fsck_stack_trace(sbi);
> > > > +#endif
> > > >    }
> > > >    static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
> > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > index 204de4c2c818..4e786bb797e7 100644
> > > > --- a/fs/f2fs/sysfs.c
> > > > +++ b/fs/f2fs/sysfs.c
> > > > @@ -306,6 +306,26 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> > > >    	if (!strcmp(a->attr.name, "compr_new_inode"))
> > > >    		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
> > > >    #endif
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +	if (!strcmp(a->attr.name, "fsck_stack")) {
> > > > +		unsigned long *entries;
> > > > +		unsigned int nr_entries;
> > > > +		unsigned int i;
> > > > +		int count;
> > > > +
> > > > +		count = sysfs_emit(buf, "%u\n", sbi->fsck_stack);
> > > > +		if (!sbi->fsck_stack)
> > > > +			return count;
> > > > +
> > > > +		for (i = 0; i < sbi->fsck_count; i++) {
> > > > +			nr_entries = stack_depot_fetch(sbi->fsck_stack_history[i], &entries);
> > > > +			if (!entries)
> > > > +				return count;
> > > > +			stack_trace_print(entries, nr_entries, 0);
> > > > +		}
> > > > +		return count;
> > > > +	}
> > > > +#endif
> > > >    	ui = (unsigned int *)(ptr + a->offset);
> > > > @@ -740,6 +760,10 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
> > > >    F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
> > > >    F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fsck_stack, fsck_stack);
> > > > +#endif
> > > > +
> > > >    #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> > > >    static struct attribute *f2fs_attrs[] = {
> > > >    	ATTR_LIST(gc_urgent_sleep_time),
> > > > @@ -812,6 +836,9 @@ static struct attribute *f2fs_attrs[] = {
> > > >    	ATTR_LIST(atgc_candidate_count),
> > > >    	ATTR_LIST(atgc_age_weight),
> > > >    	ATTR_LIST(atgc_age_threshold),
> > > > +#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
> > > > +	ATTR_LIST(fsck_stack),
> > > > +#endif
> > > >    	NULL,
> > > >    };
> > > >    ATTRIBUTE_GROUPS(f2fs);
> > > > 
> > 
> > Thx,
> > Yangtao
> > 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB213ECCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhHPCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHPCg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:36:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 720FA613CF;
        Mon, 16 Aug 2021 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629081358;
        bh=7b/38QWZKPFkBnPmu04d0vL64YFvCb5U/RY8d2wJBA8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ltxI8YMXIYrWtCErzqMKnycZH6LV8gxiMC2xOFXIrxEjz2TBL965WEoRNUM2lj3TD
         4xHf/hsM2/vwTh9eCS0CuT5pV3UQfSpj9XMGo7U8AkTNDHIIzVMLquZAJfNvqCs5Il
         7SxwPiy5HSIvooNcVQ0yWo+3/39Q88A9ooTzE2o5z4FXvBMp4rzpqq1q4Xrc8qhPhR
         n5YVAdXY0M25/Ba96DardFEbQM6alx+tuk0+02NXvw4CIBStJtM7TQjZCIqK79Zl5E
         M2vfVmS58l5sz98D1ed15hvXd6Yd5JMPdmI2XFKXV8gr9YLa/gbjZppKKgCpY4xcTf
         UBw4zF8FQEoww==
Subject: Re: [PATCH 1/2] f2fs: add sysfs nodes to get discard information
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210814175840.115938-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <01c884b3-1250-3585-c417-5afb7b4930f0@kernel.org>
Date:   Mon, 16 Aug 2021 10:35:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814175840.115938-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/15 1:58, Yangtao Li wrote:
> I've added new sysfs nodes to show discard stat since mount, which
> will help us analyze whether the performance problem is related to
> discard.
> 
> issued_discard  - Shows the number of issued discard
> queued_discard  - Shows the number of cached discard cmd count
> discard_cmd_cnt - Shows the number of cached discard cmd count
> undiscard_blks  - Shows the number of undiscard blocks

We have exported them in debugfs, can you use that?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 20 +++++++++++
>   fs/f2fs/sysfs.c                         | 44 +++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index ef4b9218ae1e..32df6d16d74f 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -493,3 +493,23 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
>   Description:	When ATGC is on, it controls age threshold to bypass GCing young
>   		candidates whose age is not beyond the threshold, by default it was
>   		initialized as 604800 seconds (equals to 7 days).
> +
> +What:		/sys/fs/f2fs/<disk>/issued_discard
> +Date:		August 2021
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Shows the number of issued discard.
> +
> +What:		/sys/fs/f2fs/<disk>/queued_discard
> +Date:		August 2021
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Shows the number of queued discard.
> +
> +What:		/sys/fs/f2fs/<disk>/discard_cmd_cnt
> +Date:		August 2021
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Shows the number of cached discard cmd count.
> +
> +What:		/sys/fs/f2fs/<disk>/undiscard_blks
> +Date:		August 2021
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Shows the number of undiscard blocks.
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 6642246206bd..b7d6c1adc7f8 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -248,6 +248,42 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
>   			(unsigned long long)MAIN_BLKADDR(sbi));
>   }
>   
> +static ssize_t issued_discard_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
> +
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			(unsigned long long)atomic_read(&dcc_info->issued_discard));
> +}
> +
> +static ssize_t queued_discard_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
> +
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			(unsigned long long)atomic_read(&dcc_info->queued_discard));
> +}
> +
> +static ssize_t discard_cmd_cnt_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
> +
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			(unsigned long long)atomic_read(&dcc_info->discard_cmd_cnt));
> +}
> +
> +static ssize_t undiscard_blks_show(struct f2fs_attr *a,
> +				struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
> +
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			(unsigned long long)dcc_info->undiscard_blks);
> +}
> +
>   static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>   			struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -690,6 +726,10 @@ F2FS_GENERAL_RO_ATTR(unusable);
>   F2FS_GENERAL_RO_ATTR(encoding);
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
> +F2FS_GENERAL_RO_ATTR(issued_discard);
> +F2FS_GENERAL_RO_ATTR(queued_discard);
> +F2FS_GENERAL_RO_ATTR(discard_cmd_cnt);
> +F2FS_GENERAL_RO_ATTR(undiscard_blks);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -750,6 +790,10 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(gc_urgent),
>   	ATTR_LIST(reclaim_segments),
>   	ATTR_LIST(main_blkaddr),
> +	ATTR_LIST(issued_discard),
> +	ATTR_LIST(queued_discard),
> +	ATTR_LIST(discard_cmd_cnt),
> +	ATTR_LIST(undiscard_blks),
>   	ATTR_LIST(max_small_discards),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(batched_trim_sections),
> 

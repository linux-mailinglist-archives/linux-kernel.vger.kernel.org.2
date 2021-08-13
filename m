Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6B3EB68D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbhHMOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235276AbhHMOKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B574E60F14;
        Fri, 13 Aug 2021 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628863796;
        bh=PQZD4Nu7ZxDfBD002JLy8YbK0Jz4MmIKBcujAim5Td0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y7BACqmQkexVmUFI7dEnBlXk9hjQUU5aqF4P+/7zFS9oxGV6ZhRv3WeRjrB9RNdM6
         z85iPv1jSocmdqbAOmd+RUhDs+Ms3Rcg5ETNnabkCfKdMR+kviBN04wzIlBUhKPdAy
         p6tRf5uyE8kpP3TJeOeTUINoxGui5ST0FqHEIexONzHMA0CHCgK1jYjyAjTM3FnVTT
         xub+OyveTtPowrsGaD1J1KsvLuCpsQiUye2N9Kv22OooeZijfLA6UAnOZgq2+e8h7d
         OOdX2Y82jkhRDH8sPYYhWXbUpdKMg4auLgv8In3I2iCGFgp90QQcGpSeLV+HuYyAYf
         eNudOn9YVbhSA==
Subject: Re: [PATCH] f2fs: convert /sys/fs/f2fs/<disk>/stat/sb_status to use
 string
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210813140119.130321-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <78fcfb53-66ec-b383-8477-3f25ee13f962@kernel.org>
Date:   Fri, 13 Aug 2021 22:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813140119.130321-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 22:01, Yangtao Li wrote:
> Do not use numbers but strings to improve readability when flag is set.

This breaks output rule of sysfs entry, see below link:

https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg19001.html

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> This patch is based on [v2] f2fs: improve sbi status info in debugfs/f2fs/status
> 
>   Documentation/ABI/testing/sysfs-fs-f2fs | 34 ++++++++++++-------------
>   fs/f2fs/debug.c                         | 19 +-------------
>   fs/f2fs/f2fs.h                          |  1 +
>   fs/f2fs/sysfs.c                         | 26 ++++++++++++++++++-
>   4 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 73211f77d11e..b07eb1e27c97 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -410,23 +410,23 @@ Date:		December 2020
>   Contact:	"Chao Yu" <yuchao0@huawei.com>
>   Description:	Show status of f2fs superblock in real time.
>   
> -		====== ===================== =================================
> -		value  sb status macro       description
> -		0x1    SBI_IS_DIRTY          dirty flag for checkpoint
> -		0x2    SBI_IS_CLOSE          specify unmounting
> -		0x4    SBI_NEED_FSCK         need fsck.f2fs to fix
> -		0x8    SBI_POR_DOING         recovery is doing or not
> -		0x10   SBI_NEED_SB_WRITE     need to recover superblock
> -		0x20   SBI_NEED_CP           need to checkpoint
> -		0x40   SBI_IS_SHUTDOWN       shutdown by ioctl
> -		0x80   SBI_IS_RECOVERED      recovered orphan/data
> -		0x100  SBI_CP_DISABLED       CP was disabled last mount
> -		0x200  SBI_CP_DISABLED_QUICK CP was disabled quickly
> -		0x400  SBI_QUOTA_NEED_FLUSH  need to flush quota info in CP
> -		0x800  SBI_QUOTA_SKIP_FLUSH  skip flushing quota in current CP
> -		0x1000 SBI_QUOTA_NEED_REPAIR quota file may be corrupted
> -		0x2000 SBI_IS_RESIZEFS       resizefs is in process
> -		====== ===================== =================================
> +		=====================	=================================
> +		sb status		description
> +		fs_dirty		dirty flag for checkpoint
> +		closing			specify unmounting
> +		need_fsck		need fsck.f2fs to fix
> +		recovering		recovery is doing or not
> +		sb_dirty		need to recover superblock
> +		need_cp			need to checkpoint
> +		shutdown		shutdown by ioctl
> +		recovered		recovered orphan/data
> +		cp_disabled		CP was disabled last mount
> +		cp_disabled_quick	CP was disabled quickly
> +		quota_need_flush	need to flush quota info in CP
> +		quota_skip_flush	skip flushing quota in current CP
> +		quota_need_repair	quota file may be corrupted
> +		resizefs		resizefs is in process
> +		=====================	=================================
>   
>   What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
>   Date:		January 2021
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index d8c09346545d..298bf41a13b6 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -323,23 +323,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>   #endif
>   }
>   
> -static char *s_flag[] = {
> -	[SBI_IS_DIRTY]		= " fs_dirty",
> -	[SBI_IS_CLOSE]		= " closing",
> -	[SBI_NEED_FSCK]		= " need_fsck",
> -	[SBI_POR_DOING]		= " recovering",
> -	[SBI_NEED_SB_WRITE]	= " sb_dirty",
> -	[SBI_NEED_CP]		= " need_cp",
> -	[SBI_IS_SHUTDOWN]	= " shutdown",
> -	[SBI_IS_RECOVERED]	= " recovered",
> -	[SBI_CP_DISABLED]	= " cp_disabled",
> -	[SBI_CP_DISABLED_QUICK]	= " cp_disabled_quick",
> -	[SBI_QUOTA_NEED_FLUSH]	= " quota_need_flush",
> -	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
> -	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
> -	[SBI_IS_RESIZEFS]	= " resizefs",
> -};
> -
>   static int stat_show(struct seq_file *s, void *v)
>   {
>   	struct f2fs_stat_info *si;
> @@ -357,7 +340,7 @@ static int stat_show(struct seq_file *s, void *v)
>   		if (si->sbi->s_flag) {
>   			seq_puts(s, "[SBI:");
>   			for_each_set_bit(j, &si->sbi->s_flag, 32)
> -				seq_puts(s, s_flag[j]);
> +				seq_printf(s, " %s", s_flag[j]);
>   			seq_puts(s, "]\n");
>   		}
>   		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 67faa43cc141..772dd3352c64 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1257,6 +1257,7 @@ enum {
>   	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>   	SBI_IS_RESIZEFS,			/* resizefs is in process */
>   };
> +extern char *s_flag[];
>   
>   enum {
>   	CP_TIME,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0954761341d7..e6f87e3d8f2e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -111,10 +111,34 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>   				sbi->sectors_written_start) >> 1)));
>   }
>   
> +char *s_flag[] = {
> +	[SBI_IS_DIRTY]		= "fs_dirty",
> +	[SBI_IS_CLOSE]		= "closing",
> +	[SBI_NEED_FSCK]		= "need_fsck",
> +	[SBI_POR_DOING]		= "recovering",
> +	[SBI_NEED_SB_WRITE]	= "sb_dirty",
> +	[SBI_NEED_CP]		= "need_cp",
> +	[SBI_IS_SHUTDOWN]	= "shutdown",
> +	[SBI_IS_RECOVERED]	= "recovered",
> +	[SBI_CP_DISABLED]	= "cp_disabled",
> +	[SBI_CP_DISABLED_QUICK]	= "cp_disabled_quick",
> +	[SBI_QUOTA_NEED_FLUSH]	= "quota_need_flush",
> +	[SBI_QUOTA_SKIP_FLUSH]	= "quota_skip_flush",
> +	[SBI_QUOTA_NEED_REPAIR]	= "quota_need_repair",
> +	[SBI_IS_RESIZEFS]	= "resizefs",
> +};
> +
>   static ssize_t sb_status_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> -	return sprintf(buf, "%lx\n", sbi->s_flag);
> +	int len = 0, i = 0;
> +
> +	for_each_set_bit(i, &sbi->s_flag, 32)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				 len ? ", " : "", s_flag[i]);
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +
> +	return len;
>   }
>   
>   static ssize_t features_show(struct f2fs_attr *a,
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4C3F29FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhHTKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhHTKQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:16:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAB9961106;
        Fri, 20 Aug 2021 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629454548;
        bh=CBrORSLHaWU8FbMU4GyCeZ7OKQ4Gi+xXP5M2F5cMJBA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oGq6jA8ZvTR/6qHrzuvBW/jjqy/T85Jh0XyrcY8Z2DVRkuixp/c1UCv6DyejIOw9j
         gdoxZAf4491gutFClmZhlStKun0T04dHyfSWEvWfNEbLje5T9PYyLa4yVSmzvvuv+/
         OaLyz9z/QJeP39Q1J/2+Y4JLEQsZdakpx83pZxWfmu14HvwpSP7l4kc/pFJ9XMt/5w
         avIp5Gf5eMJj7YIYP4oS/ikVoq4/8MvYpr3L2mqLDEORAlwXBc477yzAESnTN+ON6R
         8SlwbevPGkNXC6tL8WqTJ331bznwgIVjKWFrqfkCvZWyO5zYKVOvMXyxYoILPU8Ufq
         uSv5og8HQS6Fg==
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: change fiemap print out format
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210808215234.1939266-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5cce41d6-d59a-0596-6d14-e313aa91c78b@kernel.org>
Date:   Fri, 20 Aug 2021 18:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210808215234.1939266-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/9 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Given fiemap way to print out extents in the kernel, we can correctly
> print the layout of each file in a unit of extent, not block. So, I
> changed fiemap print out way like below.
> 
> Fiemap: offset = 0 len = 60
> 	logical addr.    physical addr.   length           flags
> 0	0000000000000000 00000020032df000 0000000000004000 00001008
> 1	0000000000004000 00000020032e0000 0000000000004000 00001008
> 2	0000000000008000 00000020032e1000 0000000000004000 00001008
> 3	000000000000c000 00000020032e2000 0000000000004000 00001008
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++---------------
>   1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 42dbd60..0d2948e 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -731,11 +731,11 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
>   #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
>   static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
>   {
> -	unsigned count, i;
> -	int fd;
> -	__u64 phy_addr;
> -	struct fiemap *fm = xmalloc(sizeof(struct fiemap) +
> -			sizeof(struct fiemap_extent));
> +	unsigned int i;
> +	int fd, extents_mem_size;
> +	u64 start, length;
> +	u32 mapped_extents;
> +	struct fiemap *fm = xmalloc(sizeof(struct fiemap));
>   
>   	if (argc != 4) {
>   		fputs("Excess arguments\n\n", stderr);
> @@ -743,26 +743,41 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
>   		exit(1);
>   	}
>   
> -	fm->fm_start = atoi(argv[1]) * F2FS_BLKSIZE;
> -	fm->fm_length = F2FS_BLKSIZE;
> -	fm->fm_extent_count = 1;
> -	count = atoi(argv[2]);
> +	memset(fm, 0, sizeof(struct fiemap));
> +	start = atoi(argv[1]) * F2FS_BLKSIZE;
> +	length = atoi(argv[2]) * F2FS_BLKSIZE;
> +	fm->fm_start = start;
> +	fm->fm_length = length;
>   
>   	fd = xopen(argv[3], O_RDONLY | O_LARGEFILE, 0);
>   
> -	printf("Fiemap: offset = %08"PRIx64" len = %d\n",
> -				(u64)fm->fm_start / F2FS_BLKSIZE, count);
> -	for (i = 0; i < count; i++) {
> -		if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> -			die_errno("FIEMAP failed");
> +	printf("Fiemap: offset = %"PRIu64" len = %"PRIu64"\n",
> +				start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);
> +	if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> +		die_errno("FIEMAP failed");
> +
> +	mapped_extents = fm->fm_mapped_extents;
> +	extents_mem_size = sizeof(struct fiemap_extent) * mapped_extents;
> +	free(fm);
> +	fm = xmalloc(sizeof(struct fiemap) + extents_mem_size);
>   
> -		phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
> -		printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
> +	memset(fm, 0, sizeof(struct fiemap));
> +	memset(fm->fm_extents, 0, extents_mem_size);

Is that equals to memset(fm, 0, sizeof(struct fiemap) + extents_mem_size);?

> +	fm->fm_start = start;
> +	fm->fm_length = length;
> +	fm->fm_extent_count = mapped_extents;
>   
> -		if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
> -			break;
> +	if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> +		die_errno("FIEMAP failed");
>   
> -		fm->fm_start += F2FS_BLKSIZE;
> +	printf("\t%-17s%-17s%-17s%s\n", "logical addr.", "physical addr.", "length", "flags");
> +	for (i = 0; i < fm->fm_mapped_extents; i++) {
> +		printf("%d\t%.16llx %.16llx %.16llx %.8x\n", i,
> +		    fm->fm_extents[i].fe_logical, fm->fm_extents[i].fe_physical,
> +		    fm->fm_extents[i].fe_length, fm->fm_extents[i].fe_flags);
> +
> +		if (fm->fm_extents[i].fe_flags & FIEMAP_EXTENT_LAST)
> +			break;
>   	}
>   	printf("\n");
>   	free(fm);
> 

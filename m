Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F1453B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhKPVBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:01:23 -0500
Received: from p3plsmtp03-03-2.prod.phx3.secureserver.net ([72.167.218.215]:60619
        "EHLO p3plwbeout03-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhKPVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:01:22 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 16:01:22 EST
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id n5PXmMZq31yg2n5PYmXtlW; Tue, 16 Nov 2021 13:50:36 -0700
X-CMAE-Analysis: v=2.4 cv=brGJuGWi c=1 sm=1 tr=0 ts=6194199c
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=i0EeH86SAAAA:8
 a=FXvPX3liAAAA:8 a=3-y2XQbapDSkYxSPjksA:9 a=QEXdDO2ut3YA:10
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  n5PXmMZq31yg2
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp04.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1mn5PW-0004Ff-Lh; Tue, 16 Nov 2021 20:50:35 +0000
Message-ID: <89e27e25-ec2b-337e-4bf0-705912eea62d@squashfs.org.uk>
Date:   Tue, 16 Nov 2021 20:50:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] squashfs: provides backing_dev_info in order to disable
 read-ahead
To:     Zheng Liang <zhengliang6@huawei.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
References: <20211116113141.1391026-1-zhengliang6@huawei.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20211116113141.1391026-1-zhengliang6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfHAMQ3K2ZJnRc6bekDYq4nmHF7Al3chg+TA8CgLGRla1NaJdm7idHn9gSXJYZBaQVhV4P6b0WMyZs2sPVkBsqIuV1EsvD2nc5P7+fR6M5Y1B4AEf5sTh
 TELwZactmmi86cuKdx2jjoP0+iTsXm3enxXM+NT2pooP0dnu1uswE4PLrwAjvrvJ/mwfk5dEMUmG9FfjcDLqEuamNkCf4d+dHgg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 11:31, Zheng Liang wrote:
> the commit c1f6925e1091("mm: put readahead pages in cache earlier")
> causes the read performance of squashfs to deteriorate.Through testing,
> we find that the performance will be back by closing the readahead of
> squashfs. So we want to learn the way of ubifs, provides backing_dev_info
> and disable read-ahead.
> 
> --------------------------------------------------------------------
> We tested the following data by fio.
> squashfs image blocksize=128K
> test command:
> fio --name basic --bs=? --filename="/mnt/test_file" --rw=? --iodepth=1 --ioengine=psync --runtime=200 --time_based
> 
> turn on squashfs readahead in 5.10 kernel
> bs(k)      read/randread           MB/s
> 4            randread              271
> 128          randread              231
> 1024         randread              246
> 4            read                  310
> 128          read                  245
> 1024         read                  247
> 
> turn off squashfs readahead in 5.10 kernel
> bs(k)      read/randread           MB/s
> 4            randread              293
> 128          randread              330
> 1024         randread              363
> 4            read                  338
> 128          read                  360
> 1024         read                  365
> 
> turn on squashfs readahead and revert the
> commit c1f6925e1091("mm: put readahead
> pages in cache earlier") in 5.10 kernel
> bs(k)      read/randread           MB/s
> 4           randread               289
> 128         randread               306
> 1024        randread               335
> 4           read                   337
> 128         read                   336
> 1024        read                   338
> 
> Signed-off-by: Zheng Liang <zhengliang6@huawei.com>

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Looks good to me.

Phillip
--
Squashfs maintainer.

> ---
>   fs/squashfs/super.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index bb44ff4c5cc6..7a4c865fc8e6 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -29,6 +29,7 @@
>   #include <linux/module.h>
>   #include <linux/magic.h>
>   #include <linux/xattr.h>
> +#include <linux/backing-dev.h>
>   
>   #include "squashfs_fs.h"
>   #include "squashfs_fs_sb.h"
> @@ -112,6 +113,24 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
>   	return decompressor;
>   }
>   
> +static int squashfs_bdi_init(struct super_block *sb)
> +{
> +	int err;
> +	unsigned int major = MAJOR(sb->s_dev);
> +	unsigned int minor = MINOR(sb->s_dev);
> +
> +	bdi_put(sb->s_bdi);
> +	sb->s_bdi = &noop_backing_dev_info;
> +
> +	err = super_setup_bdi_name(sb, "squashfs_%u_%u", major, minor);
> +	if (err)
> +		return err;
> +
> +	sb->s_bdi->ra_pages = 0;
> +	sb->s_bdi->io_pages = 0;
> +
> +	return 0;
> +}
>   
>   static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
> @@ -127,6 +146,20 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	TRACE("Entered squashfs_fill_superblock\n");
>   
> +	/*
> +	 * squashfs provides 'backing_dev_info' in order to disable read-ahead. For
> +	 * squashfs, I/O is not deferred, it is done immediately in readpage,
> +	 * which means the user would always have to wait their own I/O. So the effect
> +	 * of readahead is very weak for squashfs. squashfs_bdi_init will set
> +	 * sb->s_bdi->ra_pages and sb->s_bdi->io_pages to 0 and close readahead for
> +	 * squashfs.
> +	 */
> +	err = squashfs_bdi_init(sb);
> +	if (err) {
> +		errorf(fc, "squashfs init bdi failed");
> +		return err;
> +	}
> +
>   	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
>   	if (sb->s_fs_info == NULL) {
>   		ERROR("Failed to allocate squashfs_sb_info\n");
> 


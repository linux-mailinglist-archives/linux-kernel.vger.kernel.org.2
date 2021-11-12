Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17744E194
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 06:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhKLFj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 00:39:28 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33198 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhKLFj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:39:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uw8mH23_1636695393;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uw8mH23_1636695393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Nov 2021 13:36:35 +0800
Date:   Fri, 12 Nov 2021 13:36:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        guoweichao@oppo.com, guanyuwei@oppo.com, yh@oppo.com,
        zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] erofs: add sysfs interface
Message-ID: <YY39YZcn/a6F0PMh@B-P7TQMD6M-0146.local>
References: <20211112023003.10712-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112023003.10712-1-huangjianan@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Fri, Nov 12, 2021 at 10:30:02AM +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
> since v4:
> - Resend in a clean chain.
> 
> since v3:
> - Add description of sysfs in erofs documentation.
> 
> since v2:
> - Check whether t in erofs_attr_store is illegal.
> - Print raw value for bool entry.
> 
> since v1:
> - Add sysfs API documentation.
> - Use sysfs_emit over snprintf.
> 
>  Documentation/ABI/testing/sysfs-fs-erofs |   7 +
>  Documentation/filesystems/erofs.rst      |   8 +
>  fs/erofs/Makefile                        |   2 +-
>  fs/erofs/internal.h                      |  10 +
>  fs/erofs/super.c                         |  12 ++
>  fs/erofs/sysfs.c                         | 240 +++++++++++++++++++++++
>  6 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
>  create mode 100644 fs/erofs/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> new file mode 100644
> index 000000000000..86d0d0234473
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -0,0 +1,7 @@
> +What:		/sys/fs/erofs/features/
> +Date:		November 2021
> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> +Description:	Shows all enabled kernel features.
> +		Supported features:
> +		lz4_0padding, compr_cfgs, big_pcluster, device_table,
> +		sb_chksum.

Please help submit a patch renaming lz4_0padding to 0padding globally
since LZMA and later algorithms also need that...

Also, lack of chunked_file and compr_head2 as well?

Thanks,
Gao Xiang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89771374D48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhEFCKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:10:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17466 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFCKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:10:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbH510mBPzkWpY;
        Thu,  6 May 2021 10:06:45 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 6 May 2021
 10:09:18 +0800
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
To:     <daejun7.park@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
Date:   Thu, 6 May 2021 10:09:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/29 14:20, Daejun Park wrote:
> In file defragmentation by ioctl, all data blocks in the file are
> re-written out-of-place. File defragmentation implies user will not update
> and mostly read the file. So before the defragmentation, we set file
> temperature as cold for better block allocation.

I don't think all fragmented files are cold, e.g. db file.

We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
"system.advise" -v value) to indicate this file is a hot/cold file, so my
suggestion is after file defragmentation, if you think this file is cold, and
use setxattr() to set it as cold.

Thanks,

> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index d697c8900fa7..dcac965a05fe 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>   	map.m_len = pg_end - pg_start;
>   	total = 0;
>   
> +	if (!file_is_cold(inode))
> +		file_set_cold(inode);
> +
>   	while (map.m_lblk < pg_end) {
>   		pgoff_t idx;
>   		int cnt = 0;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C314032A1E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836420AbhCBHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:02:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13828 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835859AbhCBGMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:12:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DqRY56MKpz7sDF;
        Tue,  2 Mar 2021 14:09:29 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 2 Mar 2021
 14:11:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
Date:   Tue, 2 Mar 2021 14:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210302054233.3886681-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/2 13:42, Jaegeuk Kim wrote:
> This is useful when checking conditions during checkpoint=disable in Android.

This sysfs entry is readonly, how about putting this at
/sys/fs/f2fs/<disk>/stat/?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/sysfs.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index e38a7f6921dd..254b6fa17406 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
>   			(unsigned long long)(free_segments(sbi)));
>   }
>   
> +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(overprovision_segments(sbi)));
> +}
> +
>   static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
>   F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
>   F2FS_GENERAL_RO_ATTR(dirty_segments);
>   F2FS_GENERAL_RO_ATTR(free_segments);
> +F2FS_GENERAL_RO_ATTR(ovp_segments);

Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?

Thanks,

>   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>   F2FS_GENERAL_RO_ATTR(features);
>   F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> 

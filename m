Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64733085EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhA2Ggm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:36:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11908 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhA2Ggg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:36:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRncz3RJYzjDr1;
        Fri, 29 Jan 2021 14:34:43 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 Jan
 2021 14:35:41 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid inconsistent quota data
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210128090256.73910-1-yuchao0@huawei.com>
Message-ID: <62062195-b551-c5c7-7165-228e59852904@huawei.com>
Date:   Fri, 29 Jan 2021 14:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210128090256.73910-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/28 17:02, Chao Yu wrote:
> From: Yi Chen <chenyi77@huawei.com>
> 
> Occasionally, quota data may be corrupted detected by fsck:
> 
> Info: checkpoint state = 45 :  crc compacted_summary unmount
> [QUOTA WARNING] Usage inconsistent for ID 0:actual (1543036928, 762) != expected (1543032832, 762)
> [ASSERT] (fsck_chk_quota_files:1986)  --> Quota file is missing or invalid quota file content found.
> [QUOTA WARNING] Usage inconsistent for ID 0:actual (1352478720, 344) != expected (1352474624, 344)
> [ASSERT] (fsck_chk_quota_files:1986)  --> Quota file is missing or invalid quota file content found.
> 
> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Ok..]
> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> [FSCK] valid_block_count matching with CP             [Ok..] [0xdf299]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x2b01]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x2b01]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x2665]
> [FSCK] free segment_count matched with CP             [Ok..] [0xcb04]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Fail]
> 
> The root cause is:
> If we open file w/ readonly flag, disk quota info won't be initialized
> for this file, however, following mmap() will force to convert inline
> inode via f2fs_convert_inline_inode(), which may increase block usage
> for this inode w/o updating quota data, it causes inconsistent disk quota
> info.
> 
> The issue will happen in following stack:
> open(file, O_RDONLY)
> mmap(file)
> - f2fs_convert_inline_inode
>   - f2fs_convert_inline_page
>    - f2fs_reserve_block
>     - f2fs_reserve_new_block
>      - f2fs_reserve_new_blocks
>       - f2fs_i_blocks_write
>        - dquot_claim_block
> inode->i_blocks increase, but the dqb_curspace keep the size for the dquots
> is NULL.
> 
> To fix this issue, let's call dquot_initialize() anyway in both
> f2fs_truncate() and f2fs_convert_inline_inode() functions to avoid potential
> inconsistent quota data issue.
> 
> Fixes: 0abd675e97e6 ("f2fs: support plain user/group quota")
> Signed-off-by: Daiyue Zhang <zhangdaiyue1@huawei.com>
> Signed-off-by: Dehe Gu <gudehe@huawei.com>
> Signed-off-by: Junchao Jiang <jiangjunchao1@huawei.com>
> Signed-off-by: Ge Qiu <qiuge@huawei.com>
> Signed-off-by: Yi Chen <chenyi77@huawei.com>

[Chao Yu: clean up commit message a bit]
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

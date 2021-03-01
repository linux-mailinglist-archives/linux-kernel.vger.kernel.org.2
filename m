Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889273275FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 03:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhCACB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 21:01:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13098 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhCACB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 21:01:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dpk3C65zWz16Dpp;
        Mon,  1 Mar 2021 09:59:35 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 1 Mar 2021
 10:01:13 +0800
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix last_lblock check in
 check_swap_activate_fast
To:     Huang Jianan <huangjianan@oppo.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <zhangshiming@oppo.com>
References: <20210227120231.136559-1-huangjianan@oppo.com>
 <20210227120231.136559-2-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aa06822f-89eb-19ca-674b-929273bd3717@huawei.com>
Date:   Mon, 1 Mar 2021 10:01:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210227120231.136559-2-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/27 20:02, Huang Jianan via Linux-f2fs-devel wrote:
> Because page_no < sis->max guarantees that the while loop break out
> normally, the wrong check contidion here doesn't cause a problem.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/f2fs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a1498a1a345c..4dbc1cafc55d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3804,7 +3804,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
>   	last_lblock = bytes_to_blks(inode, i_size_read(inode));
>   	len = i_size_read(inode);
>   
> -	while (cur_lblock <= last_lblock && cur_lblock < sis->max) {
> +	while (cur_lblock + 1 <= last_lblock && cur_lblock < sis->max) {

while (cur_lblock < last_lblock && cur_lblock < sis->max) {

It's nitpick, if necessary, I guess Jaegeuk could help to change this
while merging.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   		struct f2fs_map_blocks map;
>   		pgoff_t next_pgofs;
>   
> 

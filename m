Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1007533AB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCOGNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:13:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13534 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCOGMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:12:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzQy95K4KzNn2k;
        Mon, 15 Mar 2021 14:10:25 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 15 Mar
 2021 14:12:45 +0800
Subject: Re: [PATCH] f2fs: fix the discard thread sleep timeout under high
 utilization
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1615784186-2693-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <49be0c70-4fe4-6acd-b508-08621f0623c0@huawei.com>
Date:   Mon, 15 Mar 2021 14:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1615784186-2693-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sahitya,

On 2021/3/15 12:56, Sahitya Tummala wrote:
> When f2fs is heavily utilized over 80%, the current discard policy
> sets the max sleep timeout of discard thread as 50ms
> (DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
> no pending discard commands to be issued. This results into
> unnecessary frequent and periodic wake ups of the discard thread.
> This patch adds check for pending  discard commands in addition
> to heavy utilization condition to prevent those wake ups.

Could this commit fix your issue?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=43f8c47ea7d59c7b2270835f1d7c4618a1ea27b6

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>   fs/f2fs/segment.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index dced46c..df30220 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1112,6 +1112,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   				struct discard_policy *dpolicy,
>   				int discard_type, unsigned int granularity)
>   {
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
>   	/* common policy */
>   	dpolicy->type = discard_type;
>   	dpolicy->sync = true;
> @@ -1129,7 +1131,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   		dpolicy->io_aware = true;
>   		dpolicy->sync = false;
>   		dpolicy->ordered = true;
> -		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> +		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL &&
> +				atomic_read(&dcc->discard_cmd_cnt)) {
>   			dpolicy->granularity = 1;
>   			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
>   		}
> 

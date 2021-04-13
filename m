Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219A235D5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbhDMDXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:23:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16452 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhDMDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:23:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FK9qZ37N7ztVdX;
        Tue, 13 Apr 2021 11:21:14 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 13 Apr
 2021 11:23:25 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid touching checkpointed
 data in get_victim()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210324031828.67133-1-yuchao0@huawei.com>
 <YFvQGxLbpmDjxEzR@google.com>
 <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
 <66e0a225-7f52-a33e-ccd6-e7bfa1067ed1@kernel.org>
 <YHUJFElliMOWMbWN@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1954fdd1-8e2a-123c-6a92-ab2ba0dad958@huawei.com>
Date:   Tue, 13 Apr 2021 11:23:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YHUJFElliMOWMbWN@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 10:59, Jaegeuk Kim wrote:
> @@ -2701,7 +2689,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type, bool flush)
> 
>   	reset_curseg(sbi, type, 1);
>   	curseg->alloc_type = SSR;
> -	__next_free_blkoff(sbi, curseg, 0);
> +	__next_free_blkoff(sbi, curseg->segno, 0);

Forgot to assign curseg->next_blkoff here, I checked generic/083, it passed,
let me run all testcases.

Thanks,

> 
>   	sum_page = f2fs_get_sum_page(sbi, new_segno);
>   	if (IS_ERR(sum_page)) {

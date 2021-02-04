Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80530EAE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhBDD0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:26:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12019 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBDD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:26:16 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWP6N0m9rzjHm9;
        Thu,  4 Feb 2021 11:24:12 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 4 Feb 2021
 11:25:26 +0800
Subject: Re: [PATCH v4] f2fs: compress: add compress_inode to cache compressed
 blockst
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210202080056.51658-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
Date:   Thu, 4 Feb 2021 11:25:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210202080056.51658-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

On 2021/2/2 16:00, Chao Yu wrote:
> -	for (i = 0; i < dic->nr_cpages; i++) {
> +	for (i = 0; i < cc->nr_cpages; i++) {
>   		struct page *page = dic->cpages[i];

por_fsstress still hang in this line?

Thanks,

>   		block_t blkaddr;
>   		struct bio_post_read_ctx *ctx;
> @@ -2201,6 +2207,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>   		blkaddr = data_blkaddr(dn.inode, dn.node_page,
>   						dn.ofs_in_node + i + 1);
>   
> +		f2fs_wait_on_block_writeback(inode, blkaddr);
> +
> +		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
> +			if (atomic_dec_and_test(&dic->remaining_pages))
> +				f2fs_decompress_cluster(dic);
> +			continue;
> +		}
> +

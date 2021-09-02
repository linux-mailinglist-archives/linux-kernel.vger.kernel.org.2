Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1977E3FF825
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhIBX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243538AbhIBX6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAC9861053;
        Thu,  2 Sep 2021 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630627059;
        bh=99fHBy+T4K/mLQGDUtNtGh+nM1zfP3QWsKjosICZFrE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eqU0fedD54QHOyuaINSODjXbVG0NaNgqeOg3QZxtWr6oqLPlevyqizlfn0GJg4GoU
         O0E2kRc8DEvnzwUM+x8sq+KMY2XNMmLmyNJS0B45Hm/6IZ05QU7ijl+NqPeZY2JrSu
         fidkF6W1XwEJfO8wJ5s2P8KvKFaeY6/lhgPdEFHagSatrY1RLsfezF/MIUTFGRTEJv
         ZDk658AZDCqNCLgfM3bysTBBjF3VcTZ0XLGg1ZIcouWlS2sPh67pVCfdpgiMZdyxMs
         B1Z8WGprIt4gD9Wy06heBB9e4MXM+qSerl/HRySDst+99dsPgpQqlQdZPD10V/+Z6v
         Lip+UhPCQtD/g==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
Date:   Fri, 3 Sep 2021 07:57:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902172404.3517626-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/3 1:24, Daeho Jeong wrote:
> @@ -2630,6 +2631,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>   	unsigned short seg_type = curseg->seg_type;
>   
>   	sanity_check_seg_type(sbi, seg_type);
> +	if (f2fs_need_rand_seg(sbi))
> +		return prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);

	if (f2fs_need_seq_seg(sbi))
		return 0;

static inline bool f2fs_need_seq_seg(struct f2fs_sb_info *sbi)
{
	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK;
}

> @@ -2707,12 +2715,29 @@ static int __next_free_blkoff(struct f2fs_sb_info *sbi,
>   static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
>   				struct curseg_info *seg)
>   {
> -	if (seg->alloc_type == SSR)
> +	if (seg->alloc_type == SSR) {
>   		seg->next_blkoff =
>   			__next_free_blkoff(sbi, seg->segno,
>   						seg->next_blkoff + 1);
> -	else
> +	} else {
>   		seg->next_blkoff++;
> +		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK) {
> +			if (--seg->fragment_remained_chunk <= 0) {
> +				seg->fragment_remained_chunk =
> +				   sbi->fragment_chunk_size;
> +				seg->next_blkoff +=
> +				   sbi->fragment_hole_size;

One more concern... we'd better to save fragment_remained_hole as well
as fragment_remained_chunk,  otherwise, if fragment_chunk_size +
fragment_hole_size > 512, fragment hole will be truncated to 512 -
fragment_chunk_size due to we won't create hole with enough size as
seg->next_blkoff has crossed end of current segment.

Thanks,

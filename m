Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FEF36A50D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhDYGVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 02:21:24 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47968 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhDYGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 02:21:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UWeubQZ_1619331642;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UWeubQZ_1619331642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 14:20:42 +0800
Subject: Re: [PATCH] ocfs2: Remove repeated uptodate check for buffer
To:     Wan Jiabing <wanjiabing@vivo.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, akpm <akpm@linux-foundation.org>
Cc:     kael_w@yeah.net
References: <20210425025702.13628-1-wanjiabing@vivo.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <d48872a7-753d-9c6e-c69b-4ea4c5c8efaa@linux.alibaba.com>
Date:   Sun, 25 Apr 2021 14:20:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210425025702.13628-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/21 10:57 AM, Wan Jiabing wrote:
> In commit 60f91826ca62 ("buffer: Avoid setting buffer bits that are
> already set"), function set_buffer_##name was added a test_bit() to
> check buffer, which is the same as function buffer_##name.
> The !buffer_uptodate(bh) here is a repeated check. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/aops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index ad20403b383f..bd039fdbb27e 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -634,8 +634,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
>  		}
>  
>  		if (PageUptodate(page)) {
> -			if (!buffer_uptodate(bh))
> -				set_buffer_uptodate(bh);
> +			set_buffer_uptodate(bh);
>  		} else if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
>  			   !buffer_new(bh) &&
>  			   ocfs2_should_read_blk(inode, page, block_start) &&
> 

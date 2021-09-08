Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C560B40383B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348905AbhIHKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:52:56 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:33544 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347300AbhIHKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:52:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UngnLi9_1631098292;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UngnLi9_1631098292)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 18:51:33 +0800
Subject: Re: [PATCH v2] ocfs2: Fix handle refcount leak in two exception
 handling paths
To:     Chenyuan Mi <cymi20@fudan.edu.cn>, akpm <akpm@linux-foundation.org>
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
Date:   Wed, 8 Sep 2021 18:51:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908102055.10168-1-cymi20@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/21 6:20 PM, Chenyuan Mi wrote:
> The reference counting issue happens in two exception handling paths
> of ocfs2_replay_truncate_records(). When executing these two exception
> handling paths, the function forgets to decrease the refcount of handle
> increased by ocfs2_start_trans(), causing a refcount leak.
> 
> Fix this issue by using ocfs2_commit_trans() to decrease the refcount
> of handle in two handling paths.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index f1cc8258d34a..b05fde7edc3a 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -5940,6 +5940,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>  		status = ocfs2_journal_access_di(handle, INODE_CACHE(tl_inode), tl_bh,
>  						 OCFS2_JOURNAL_ACCESS_WRITE);
>  		if (status < 0) {
> +			ocfs2_commit_trans(osb, handle);
>  			mlog_errno(status);
>  			goto bail;
>  		}
> @@ -5964,6 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>  						     data_alloc_bh, start_blk,
>  						     num_clusters);
>  			if (status < 0) {
> +				ocfs2_commit_trans(osb, handle);
>  				mlog_errno(status);
>  				goto bail;
>  			}
> 

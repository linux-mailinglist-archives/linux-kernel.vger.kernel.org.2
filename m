Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B5403690
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhIHJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:06:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57654 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234820AbhIHJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:06:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UngJA3E_1631091909;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UngJA3E_1631091909)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 17:05:10 +0800
Subject: Re: [PATCH] ocfs2: Fix handle refcount leak in two exception handling
 paths
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20210908062603.6723-1-cymi20@fudan.edu.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <636c032f-b0ee-8b1f-998d-bed2869297a0@linux.alibaba.com>
Date:   Wed, 8 Sep 2021 17:05:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908062603.6723-1-cymi20@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyuan,
Thanks for reporting this bug.
But the fix looks incorrect. It will commit transaction once more in
normal case.
The simplest way is calling ocfs2_commit_trans() in each of the error
handling path before goto bail.

if (status < 0) {
	ocfs2_commit_trans(osb, handle);
	mlog_errno(status);
	goto bail;
}

Thanks,
Joseph

On 9/8/21 2:26 PM, Chenyuan Mi wrote:
> The reference counting issue happens in two exception handling 
> paths of ocfs2_replay_truncate_records(). When executing these 
> two exception handling paths, the function forgets to decrease 
> the refcount of handle increased by ocfs2_start_trans(), causing 
> a refcount leak.
> 
> Fix this issue by using ocfs2_commit_trans() to decrease the 
> refcount of handle in two handling paths.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> 
> ---
>  fs/ocfs2/alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index f1cc8258d34a..b87960cdda0d 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -5941,7 +5941,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>  						 OCFS2_JOURNAL_ACCESS_WRITE);
>  		if (status < 0) {
>  			mlog_errno(status);
> -			goto bail;
> +			goto bail_commit;
>  		}
>  
>  		tl->tl_used = cpu_to_le16(i);
> @@ -5965,7 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>  						     num_clusters);
>  			if (status < 0) {
>  				mlog_errno(status);
> -				goto bail;
> +				goto bail_commit;
>  			}
>  		}
>  
> @@ -5975,6 +5975,8 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>  
>  	osb->truncated_clusters = 0;
>  
> +bail_commit:
> +	ocfs2_commit_trans(osb, handle);
>  bail:
>  	return status;
>  }
> 

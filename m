Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB880377A07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 04:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEJCLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 22:11:12 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33810 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhEJCLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 22:11:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UYHoRqe_1620612605;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UYHoRqe_1620612605)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 May 2021 10:10:06 +0800
Subject: Re: [PATCH] ocfs2: Reomve err less than zero check
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mark@fasheh.com
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <1620470481-31597-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <222b3da3-c2f0-aa03-96de-35facb27a169@linux.alibaba.com>
Date:   Mon, 10 May 2021 10:10:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620470481-31597-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/21 6:41 PM, Jiapeng Chong wrote:
> The check for err < 0 is always false because err is an enum and can
> never be less than zero.
> 
Precisely speaking, it is because enum dlm_status starts from 0.
So could you please update commit log and send v2?

Thanks,
Joseph

> Clean up the following coccicheck warning:
> 
> fs/ocfs2/dlm/dlmdebug.c:222 dlm_errname() warn: unsigned 'err' is never
> less than zero.
> 
> fs/ocfs2/dlm/dlmdebug.c:214 dlm_errmsg() warn: unsigned 'err' is never
> less than zero.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/ocfs2/dlm/dlmdebug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
> index d442cf5..817914d 100644
> --- a/fs/ocfs2/dlm/dlmdebug.c
> +++ b/fs/ocfs2/dlm/dlmdebug.c
> @@ -211,7 +211,7 @@ void dlm_print_one_lock(struct dlm_lock *lockid)
>  
>  const char *dlm_errmsg(enum dlm_status err)
>  {
> -	if (err >= DLM_MAXSTATS || err < 0)
> +	if (err >= DLM_MAXSTATS)
>  		return dlm_errmsgs[DLM_MAXSTATS];
>  	return dlm_errmsgs[err];
>  }
> @@ -219,7 +219,7 @@ const char *dlm_errmsg(enum dlm_status err)
>  
>  const char *dlm_errname(enum dlm_status err)
>  {
> -	if (err >= DLM_MAXSTATS || err < 0)
> +	if (err >= DLM_MAXSTATS)
>  		return dlm_errnames[DLM_MAXSTATS];
>  	return dlm_errnames[err];
>  }
> 

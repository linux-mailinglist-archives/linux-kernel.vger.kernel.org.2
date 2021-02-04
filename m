Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C330EBC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBDFNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:13:34 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60421 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhBDFNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:13:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNpakAn_1612415537;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UNpakAn_1612415537)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 13:12:17 +0800
Subject: Re: [PATCH] ocfs2: Remove unneeded return variable
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        "mark@fasheh.com >> Mark Fasheh" <mark@fasheh.com>
References: <1612408323-23579-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <cea953c5-79e7-8bd3-13ca-8ee4f25ff03f@linux.alibaba.com>
Date:   Thu, 4 Feb 2021 13:12:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612408323-23579-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK.
This was discussed before, please refer:
https://oss.oracle.com/pipermail/ocfs2-devel/2020-April/014969.html

Thanks,
Joseph

On 2/4/21 11:12 AM, Yang Li wrote:
> This patch removes unneeded return variables, using only
> '0' instead.
> It fixes the following warning detected by coccinelle:
> ./fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags".
> Return "0" on line 84
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/ocfs2/stack_o2cb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
> index dbf8b57..2da9633 100644
> --- a/fs/ocfs2/stack_o2cb.c
> +++ b/fs/ocfs2/stack_o2cb.c
> @@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
>  	}
>  static int flags_to_o2dlm(u32 flags)
>  {
> -	int o2dlm_flags = 0;
> -
>  	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
>  	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
>  	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
> @@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
>  	/* map_flag() should have cleared every flag passed in */
>  	BUG_ON(flags != 0);
>  
> -	return o2dlm_flags;
> +	return 0;
>  }
>  #undef map_flag
>  
> 

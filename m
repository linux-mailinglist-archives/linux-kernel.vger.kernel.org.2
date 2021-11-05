Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077D3445DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhKEB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:57:38 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53880 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhKEB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:57:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uv5DzfM_1636077294;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Uv5DzfM_1636077294)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Nov 2021 09:54:55 +0800
Subject: Re: [PATCH] ocfs2:Use BUG_ON instead of if condition followed by BUG.
To:     cgel.zte@gmail.com, mark@fasheh.com,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211105014424.75372-1-zhang.mingyu@zte.com.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <58841188-72eb-bde9-12f7-4a3c7ff3e4c4@linux.alibaba.com>
Date:   Fri, 5 Nov 2021 09:54:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211105014424.75372-1-zhang.mingyu@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/21 9:44 AM, cgel.zte@gmail.com wrote:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/journal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index dbf9b9e97d74..1887a2708709 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1669,8 +1669,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  	status = jbd2_journal_load(journal);
>  	if (status < 0) {
>  		mlog_errno(status);
> -		if (!igrab(inode))
> -			BUG();
> +		BUG_ON(!igrab(inode));
>  		jbd2_journal_destroy(journal);
>  		goto done;
>  	}
> @@ -1699,8 +1698,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  	if (status < 0)
>  		mlog_errno(status);
>  
> -	if (!igrab(inode))
> -		BUG();
> +	BUG_ON(!igrab(inode));
>  
>  	jbd2_journal_destroy(journal);
>  
> 

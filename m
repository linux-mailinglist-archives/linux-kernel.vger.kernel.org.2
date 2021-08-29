Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B93FABF7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhH2NY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 09:24:56 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55372 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235439AbhH2NYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 09:24:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UmS9Nax_1630243433;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UmS9Nax_1630243433)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 Aug 2021 21:23:54 +0800
Subject: Re: [PATCH linux-next] ocfs2: fix bugon.cocci warnings
To:     CGEL <cgel.zte@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        akpm <akpm@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210828010432.11100-1-deng.changcheng@zte.com.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <2800786e-dba1-c1fe-158d-92bee8f06acf@linux.alibaba.com>
Date:   Sun, 29 Aug 2021 21:23:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828010432.11100-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/21 9:04 AM, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use BUG_ON instead of if condition followed by BUG.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

BTW, could you send out a series to clean all in ocfs2?

> ---
>  fs/ocfs2/journal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 4f15750..2305aa5 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -974,8 +974,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
>  		goto done;
>  
>  	/* need to inc inode use count - jbd2_journal_destroy will iput. */
> -	if (!igrab(inode))
> -		BUG();
> +	BUG_ON(!igrab(inode));
>  
>  	num_running_trans = atomic_read(&(osb->journal->j_num_trans));
>  	trace_ocfs2_journal_shutdown(num_running_trans);
> @@ -1656,8 +1655,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  	status = jbd2_journal_load(journal);
>  	if (status < 0) {
>  		mlog_errno(status);
> -		if (!igrab(inode))
> -			BUG();
> +		BUG_ON(!igrab(inode));
>  		jbd2_journal_destroy(journal);
>  		goto done;
>  	}
> @@ -1686,8 +1684,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
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

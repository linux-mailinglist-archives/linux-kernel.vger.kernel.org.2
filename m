Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0D35F2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhDNLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:45:45 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41705 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233595AbhDNLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:45:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UVY-JZg_1618400680;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UVY-JZg_1618400680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 19:44:40 +0800
Subject: Re: [PATCH] ocfs2/dlm: remove unused function
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mark@fasheh.com,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <1618382761-5784-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <d5e3ba19-abac-891d-9e88-6d3a0cef931b@linux.alibaba.com>
Date:   Wed, 14 Apr 2021 19:44:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1618382761-5784-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/21 2:46 PM, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> fs/ocfs2/dlm/dlmrecovery.c:129:20: warning: unused function
> 'dlm_reset_recovery' [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Seems after commit ded2cf71419b ("ocfs2: dlm: fix recovery hung"),
dlm_reset_recovery() no longer has any user.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlm/dlmrecovery.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
> index 4b566e8..afc5173 100644
> --- a/fs/ocfs2/dlm/dlmrecovery.c
> +++ b/fs/ocfs2/dlm/dlmrecovery.c
> @@ -126,13 +126,6 @@ static inline void __dlm_reset_recovery(struct dlm_ctxt *dlm)
>  	dlm_set_reco_master(dlm, O2NM_INVALID_NODE_NUM);
>  }
>  
> -static inline void dlm_reset_recovery(struct dlm_ctxt *dlm)
> -{
> -	spin_lock(&dlm->spinlock);
> -	__dlm_reset_recovery(dlm);
> -	spin_unlock(&dlm->spinlock);
> -}
> -
>  /* Worker function used during recovery. */
>  void dlm_dispatch_work(struct work_struct *work)
>  {
> 

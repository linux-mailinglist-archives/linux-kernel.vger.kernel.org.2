Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A73473F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhCXIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:50:20 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36491 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233778AbhCXItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:49:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UT9xP8q_1616575783;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UT9xP8q_1616575783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Mar 2021 16:49:44 +0800
Subject: Re: [PATCH ] ocfs2: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, akpm <akpm@linux-foundation.org>
Cc:     rdunlap@infradead.org
References: <20210324072931.5056-1-unixbhaskar@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <6b861fe6-855f-28e0-84d8-b2ec968ffc21@linux.alibaba.com>
Date:   Wed, 24 Mar 2021 16:49:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324072931.5056-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/21 3:29 PM, Bhaskar Chowdhury wrote:
> 
> s/cluter/cluster/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/stackglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index a191094694c6..8d33ebc6b6fc 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -731,7 +731,7 @@ static void __exit ocfs2_stack_glue_exit(void)
>  }
> 
>  MODULE_AUTHOR("Oracle");
> -MODULE_DESCRIPTION("ocfs2 cluter stack glue layer");
> +MODULE_DESCRIPTION("ocfs2 cluster stack glue layer");
>  MODULE_LICENSE("GPL");
>  module_init(ocfs2_stack_glue_init);
>  module_exit(ocfs2_stack_glue_exit);
> --
> 2.30.1
> 

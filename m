Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9433E8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCQFPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCQFPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:15:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=no2cjjiGTSqw+GfdD5S3LIUDOLpLpclElmBCYQUTnBo=; b=ZwDCDVDeTIcqLOEH/1wO0k6Z9o
        1+rtcqdJEGHEIe7iaSGbG25pBWQeHDHiPwCDc6aMpGiA3HhY6k12Qc0Ux8S+aWNIrO9sZvLIsPD7Y
        LmsWf7YJAgRoxEPtiGtCt0cYnkO+D5fOucUibrlCQxYe+Tki2mKV/hTMC8pFE813JTEqFmgM2uc+6
        VM0iC/HXpa30ayo0OQHFOk/LY0xuwhiSffQMrAzj7LBYyIj4DwWV3LKS1pDqpZkwpk1ZdmOh6tziS
        pelVgkm9+1VXXvvbPz+DY6o9Y+kMkkgPKwNhyqlVH4QGrDmtCXKw5m8goZ8PSwfynx1tyr+2JdxwT
        OGmKnQpA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMOWw-001bUt-4K; Wed, 17 Mar 2021 05:15:38 +0000
Subject: Re: [PATCH] mm: Typo fix in the file util.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317033439.3429411-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc9294dc-a68f-363f-03ec-b5626275a3e9@infradead.org>
Date:   Tue, 16 Mar 2021 22:15:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317033439.3429411-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 8:34 PM, Bhaskar Chowdhury wrote:
> 
> 
> s/condtion/condition/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 54870226cea6..f85da35b50eb 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -775,7 +775,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>  	 * The deviation of sync_overcommit_as could be big with loose policy
>  	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
>  	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
> -	 * with the strict "NEVER", and to avoid possible race condtion (even
> +	 * with the strict "NEVER", and to avoid possible race condition (even
>  	 * though user usually won't too frequently do the switching to policy
>  	 * OVERCOMMIT_NEVER), the switch is done in the following order:
>  	 *	1. changing the batch
> --


-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE64343715
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVDDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCVDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:02:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=PvE96ntsEZmCkQyTvzYblPmwgkpkwSuUISXQXJ8/0WE=; b=gzrjPqdcfDBFHkNhzP7aP0R7zp
        dl0EJjbKcybjcXnM8df5PjIq0KyotWvgGf7vBPg3hvxgJG+g+V0PCWziq6+r1+WB4FEFxLwl+F80X
        J+W9WXVaVz3rgHzGGjlK1UBx17R3bDeU1QpBH8juwPlpcRk99Dkc5jPdJne6mcB/dDEwOwq7/qba+
        HHd32Viq+AoFTUvySeLGchOHBLcPd267kqeUG2sXYR3oGAGSosIzRpLOLAanfw+1GN/cIsxIzbZ0f
        fo4Nh9VNllK8EOBh6Xhp1FpuGcO4NkS13yRo9KK1pfifLscnvv6e/b+HduTptiHxba9ICn6bjmxz2
        3NyrjYVw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOAq5-00AjuL-NN; Mon, 22 Mar 2021 03:02:47 +0000
Subject: Re: [PATCH] cxl: Fix couple of spellings
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210322023307.168754-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <132af432-56a3-5435-06cd-25c8427f654b@infradead.org>
Date:   Sun, 21 Mar 2021 20:02:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322023307.168754-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 7:33 PM, Bhaskar Chowdhury wrote:
> 
> s/filesytem/filesystem/
> s/symantics/semantics/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/misc/cxl/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index fb2eff69e449..e627b4056623 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -52,7 +52,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
>  		 * can always access it when dereferenced from IDR. For the same
>  		 * reason, the segment table is only destroyed after the context is
>  		 * removed from the IDR.  Access to this in the IOCTL is protected by
> -		 * Linux filesytem symantics (can't IOCTL until open is complete).
> +		 * Linux filesystem semantics (can't IOCTL until open is complete).
>  		 */
>  		i = cxl_alloc_sst(ctx);
>  		if (i)
> --


-- 
~Randy


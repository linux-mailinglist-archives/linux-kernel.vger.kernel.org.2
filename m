Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE393D3A26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhGWLoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGWLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:44:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53840C061575;
        Fri, 23 Jul 2021 05:24:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso1861286ota.4;
        Fri, 23 Jul 2021 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2Symr9KuFJEPAV72a+i75cWNYGzF1LQQeEf4EUxAZo=;
        b=V8YEP+xfPM0EKJb1BLXAfsAsZheHK7HN/Cfm2yulIZ5muRp3FaXSKrFCv2xb/KPfJp
         xv04yZtC2E56XsFXN3Qex1GGNzltTxoAY+eNMJ9F95n2wU1DW3CWn4/q/H21rK3q0QL4
         7biClPtQTrkCe+dHfY+x6cfSomeGINeJIsdfT2g0bBgGSGcF5ICCm7Zl+hySWjLB+K2b
         krOgWuknqTwmtn4k0Ku3PkdFpAmfBBiOO82gX/gZVd2eicVjnVrecTNEuYWKkTjKr9aS
         hi95PBxcxRLAubbURXU3Nw+jqxmVdMuYQWVQx+eAnFWHOg21HD8pFVGJN4dDbRl8APTo
         PV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=t2Symr9KuFJEPAV72a+i75cWNYGzF1LQQeEf4EUxAZo=;
        b=qohJgatLrNOplY/dKe/eNBN/VI7LxVCVPNgGs2tK0BIDljz6aRtSp+CLH6KWgLCSkK
         xlg7EaHSpk0SmyIAl9m1m3VY1wiJ/m1mIFBSLHuyrSI90eBtrrLW2+vnz57q03qbyicC
         s0jbfTifFFy7xA6dRK1MFwD+fW0evCj9FhWkXB3QDiFrzwQwd1cEv8S0HIRbTUtb4BNb
         hK7d1KMjMdIvmcKOHAT8WXRcc1EQj6O4sCxzIq1MviCzH97JyriwvzmxytFCHLpxpCaf
         zXCKZKYasQkxOFL1gEi2GjNapXheCxOWzqhNNJ+Bf3zTAaI1ALbLdCnI+H2edZpZkgQk
         SiLg==
X-Gm-Message-State: AOAM53228Rqa5wbcVWxhlTbz5QSdzLqRz9bpDkE0aYBycdcWudZLRsvP
        xFgovVU6R8rUuLc2Syedeg==
X-Google-Smtp-Source: ABdhPJy8gHqpZvxm7eEtoQaPmkDy1f7x/bbkHq1veXt4C0r+zuxodWrO9SmmDcZKiXpO/pwvCKEGSA==
X-Received: by 2002:a9d:4813:: with SMTP id c19mr2923124otf.208.1627043084573;
        Fri, 23 Jul 2021 05:24:44 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id c26sm2984518otu.38.2021.07.23.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:24:43 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2d56:5547:21b6:aeca])
        by serve.minyard.net (Postfix) with ESMTPSA id BDF3818005A;
        Fri, 23 Jul 2021 12:24:41 +0000 (UTC)
Date:   Fri, 23 Jul 2021 07:24:40 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Quan Nguyen <quan@os.amperecomputing.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: ssif_bmc: Return -EFAULT if copy_from_user() fails
Message-ID: <20210723122440.GM3406@minyard.net>
Reply-To: minyard@acm.org
References: <20210723084459.GA21470@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723084459.GA21470@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:44:59AM +0300, Dan Carpenter wrote:
> The copy_from_user() function returns the number of bytes remaining to
> be copied but we should return -EFAULT here.

Yep, this is in my queue.

Thanks,

-corey

> 
> Fixes: 007888f365c9 ("ipmi: ssif_bmc: Add SSIF BMC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/char/ipmi/ssif_bmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index b15c05622e72..ce8cd8364a3f 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -85,9 +85,8 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
>  	if (count > sizeof(struct ssif_msg))
>  		return -EINVAL;
>  
> -	ret = copy_from_user(&msg, buf, count);
> -	if (ret)
> -		return ret;
> +	if (copy_from_user(&msg, buf, count))
> +		return -EFAULT;
>  
>  	if (!msg.len || count < ssif_msg_len(&msg))
>  		return -EINVAL;
> -- 
> 2.20.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3245A30B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhKWMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhKWMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:48:25 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC16C061574;
        Tue, 23 Nov 2021 04:45:17 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m192so17234480qke.2;
        Tue, 23 Nov 2021 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pj5pRezhhNkyiaStdHERODlX0WAKuYd0htVQrRQ/a9E=;
        b=bwslQKsHykLwNeFyH6OrDRROoo+i6rJx+M3TgFUyqHOkVrmNwRM9MDsb9ECnMaIx2W
         mI+cmFZD9vUTiGcgxu4kYu7LXySu1iDm/gzFgC5VTXKjeVDxER13plbNpFWi3xrWUAQP
         80Xw4ZpYHRImQymTC2XC2KP4AftK/OQoTo49vU8xmOBOVukERvGbi3/fKpn9g0taGn5n
         sqdCmdxAvSYfR+EAJ2UJfH26lzFrFkooE+l4QVCqwQMnlBY/rP+Rx+IgPro5vPCiPlFG
         Ef1d2oALiKlz0akGZME7gERGfp96FjAH5RmvOJpRM2j3D5AellHTbcWQSqQvQHibJjjp
         ShYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=pj5pRezhhNkyiaStdHERODlX0WAKuYd0htVQrRQ/a9E=;
        b=rIzmbr1Rx7F8CEPWEWQ8FqQbokXZPAVE1xbb4KH7CSIibVce633SO3UmkR51MjCEhH
         mkg04r/FFjW2XrfK44kf1haox1kaoHslWI+YY2ZuW8ywwkqIrnVq1ArUK17P7/yTHJGf
         SgF0xJ01bCuh0zIMpSqpwmhfyYHwNfqoPx0Uo9jTkRNff9YV/RGANsdJYxxjsef95qA8
         lfDH2qXvicbiYR6wgeYa7p42VmEnZckNOeS5TXDiSdJ7nM6eQXDM+CALcUzzwHx5PQDh
         BkYmvy8TyyB6geK6U4hGSROQIo3WfLY7k94K+nrwbqeq9ayq8B6KLKynSfQQJpgiNi2B
         zOTw==
X-Gm-Message-State: AOAM530l/iY6JIH1BDxh9Kb0utjyu/wgXazPOn+ogUnwtumattxAJycT
        O/24/MTXfeyJucTEtneacg==
X-Google-Smtp-Source: ABdhPJy+c6Ab9P7urxQO20LuHJLgrItcL/xdDnpqrruO2jxZKRJAwbt2rUjnx//m0XoH9S28ZYFwZA==
X-Received: by 2002:a05:620a:3193:: with SMTP id bi19mr4353490qkb.521.1637671516482;
        Tue, 23 Nov 2021 04:45:16 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id bk25sm5988852qkb.13.2021.11.23.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:45:16 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:30e0:13f:84cd:1650])
        by serve.minyard.net (Postfix) with ESMTPSA id 3E85B1800BA;
        Tue, 23 Nov 2021 12:45:15 +0000 (UTC)
Date:   Tue, 23 Nov 2021 06:45:14 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ipmi: msghandler: Make symbol 'remove_work_wq'
 static
Message-ID: <20211123124514.GT15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211123083618.2366808-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123083618.2366808-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 08:36:18AM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/char/ipmi/ipmi_msghandler.c:194:25: warning:
>  symbol 'remove_work_wq' was not declared. Should it be static?
> 
> This symbol is not used outside of ipmi_msghandler.c, so
> marks it static.

Thanks, I should have noticed this.

-corey

> 
> Fixes: 1d49eb91e86e ("ipmi: Move remove_work to dedicated workqueue")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 1ade72bfae0f..a2ec0171363a 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -191,7 +191,7 @@ struct ipmi_user {
>  	struct work_struct remove_work;
>  };
>  
> -struct workqueue_struct *remove_work_wq;
> +static struct workqueue_struct *remove_work_wq;
>  
>  static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
>  	__acquires(user->release_barrier)
> 

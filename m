Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80740109C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhIEPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 11:37:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF8C061575;
        Sun,  5 Sep 2021 08:35:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w4so6824344ljh.13;
        Sun, 05 Sep 2021 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cITEr3eddlLeZ9kM0AgouAgtRcaj2tOTljG3ru0dFVk=;
        b=YvT6EUl+6q/tevvH91tqDHe0BY2TlIpFiqapTRBIHV3z8tn9j5pf0SPvO1sG1b2sxf
         iaezoaedL05/u2H39uGplnVmzXte564JdxvThJOqJ28P4557Y5E857esx4e65FERp5JF
         eoCWDaxEQdZv52Ts3Zenr9UKED98uSJ0MXYqmSf7bsHRN1m2lteZiyvH8dNklAFjlljR
         dYmTQHRA1QwD/jFkADWcuOq3/5tXsjfwYHjyWdAtpRRbDTYhTKc9E4ZZtTHPiB7yRR5j
         eMmQSZMbfUsX/9Ji9iOnc3PQQihz+s+6hLCnpiE+vP2TwmnMAt/C+Ejop/YMEECuhcKj
         ECyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cITEr3eddlLeZ9kM0AgouAgtRcaj2tOTljG3ru0dFVk=;
        b=Y0ePE1UquQzJlUqqC/kwyA75LA+SdHmyD5uAWPXQzkT/5KJZhafwrW+uK2blO9Zew4
         PcprKSlUeZyQe/+vs3/sIvYRP4Wsr+4VJ/TWigN37KFBXDQNUWMK9iDy/RT9MjKaeut2
         a1o0T/996PuF/bFIcW65hQ/51OR0wAdcHLHSnIdvC6UUf2As4imBT685WW2qTx0VQOwB
         jyA5wGm38qB7HaJb4Jx+T3ERyriF72M5iWQsJmPHEzZyMxCoAv+HFICxPYExFu6rjPZa
         9OzIlQCsDQMJEJ/PzWKjT7nY5mRHICCEOylWa45Na4iDmS97TY2EU5lDSlB8vK3bmG7T
         gOKQ==
X-Gm-Message-State: AOAM532Io3/Wd8/uyZ8aEhd+e/ZlsqjWoRHXRRwTzavGPSdML3FaFaHh
        BCH1JNCmTCQGD7TLMnD75fQ=
X-Google-Smtp-Source: ABdhPJyCf0n/bQHL8GFb1eHjvQyZ6xpoQk9kEMnUbR8RzaSGvc+SIQ9GwDXBROucDrGWXnT0qV6f1A==
X-Received: by 2002:a2e:a908:: with SMTP id j8mr6880398ljq.77.1630856155629;
        Sun, 05 Sep 2021 08:35:55 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id d24sm669456ljj.8.2021.09.05.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:35:55 -0700 (PDT)
Date:   Sun, 5 Sep 2021 18:35:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: ntb_pingpong: remove redundant initialization of
 variables msg_data and spad_data
Message-ID: <20210905153553.nmmgv7w3t3oeqtca@mobilestation>
References: <20210609112128.184667-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609112128.184667-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 12:21:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variables msg_data and spad_data are being initialized with values
> that are never read, they are being updated later on. The initializations
> are redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wow, missed this in my emails log. Thanks for the cleanup.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 2164e8492772..8aeca7914050 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -187,7 +187,7 @@ static void pp_ping(struct pp_ctx *pp)
>  
>  static void pp_pong(struct pp_ctx *pp)
>  {
> -	u32 msg_data = -1, spad_data = -1;
> +	u32 msg_data, spad_data;
>  	int pidx = 0;
>  
>  	/* Read pong data */
> -- 
> 2.31.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20210609112128.184667-1-colin.king%40canonical.com.

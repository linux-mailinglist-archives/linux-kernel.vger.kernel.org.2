Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352E422CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhJEPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhJEPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:42:25 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEF0C061749;
        Tue,  5 Oct 2021 08:40:35 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e19-20020a4a7353000000b002b5a2c0d2b8so6543595oof.3;
        Tue, 05 Oct 2021 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QktpwidiajSgJvIim8VKPelrfPrxs7aTCcg3SgMOnQ=;
        b=LrJydlGqf2IRWbCkEuUKMLD9qxKoltfdqfE4dgB/X732p4nit+b4w157mj+ialGptg
         cCCdKSMuHXHBWYskXuKDs9Uut4xCe7CFE5Z8FvgY3u6wNIClzHkn3vf6I0bz71EhoOGh
         PHcHmP1CMQMhSg6xVG2vxqqzjc5scRnD1m1ic4xtkXtecYecJuULGD6qWue4CLgqdXbU
         JWpupOpwyflNReq2Ac622+QH1Whqi9kncjtlRCRSzCifgymWQujIF4b3EfKFN9k0nwlx
         JPtmDkMHVKIvzkWcTAnAO7jAgUTZTO1IppGOtkAaGopor6lP+8zVyRYxfrgdqeEL/UK4
         dlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=5QktpwidiajSgJvIim8VKPelrfPrxs7aTCcg3SgMOnQ=;
        b=UCwNxUXJIjmb/0ik6kc7P3+2z2xZ24KwzdvZCrD8fjXXJea79RemrgOQzi6ZQkPa7h
         R/+em0PBdHdzqKOMOysnjvL0Y1JDrn1ib/QWhcnnHcYSGY/KApO/dS3SdAToTRb4k0HK
         77YBtKAjeoslVtJsqs7CzPFxNCU+z1o8cLa0hQqKV12JRy+sgHl64yp31teglb/mn9uC
         YggYGw4x4ojNDHVINbxFDGCkF9871/SFKeHRyegbI8w538G2eUAWT6mlW4el6WsR5BPE
         yb9AycGt/9qZyuQPkTtya8pLjgnG5qOGxvVjLps/q6Cj2cCinxV6qyx9+EGc+OHGILaH
         buBQ==
X-Gm-Message-State: AOAM533w47oTKH3RUDgQydBaqnXuYkNKO1ypRCKjRwiDRDfRfbwm/uUW
        4gtiwr9+TKy9lm8yWGMRQ2503wlbag==
X-Google-Smtp-Source: ABdhPJzHlCKXoqun8+eMsIBoGBDZwo9BLOIQP/FgDYKi9BIHYuRSRjpt7qabwEBqbV9m6/FNDHKXCg==
X-Received: by 2002:a4a:e292:: with SMTP id k18mr13915115oot.80.1633448434304;
        Tue, 05 Oct 2021 08:40:34 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e2sm3428597ooh.40.2021.10.05.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:40:33 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPSA id F22D2180053;
        Tue,  5 Oct 2021 15:40:32 +0000 (UTC)
Date:   Tue, 5 Oct 2021 10:40:31 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Colin King <colin.king@canonical.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH][next] ipmi: ipmb: Fix off-by-one
 size check on rcvlen
Message-ID: <20211005154031.GD5381@minyard.net>
Reply-To: minyard@acm.org
References: <20211005151611.305383-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005151611.305383-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:16:11PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an off-by-one bounds check on the rcvlen causing a potential
> out of bounds write on iidev->rcvmsg. Fix this by using the >= operator
> on the bounds check rather than the > operator.

Got it, thanks.

-corey

> 
> Addresses-Coverity: ("Out-of-bounds write")
> Fixes: 0ba0c3c5d1c1 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/ipmi/ipmi_ipmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index b10a1fd9c563..77ebec4ed28e 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -192,7 +192,7 @@ static int ipmi_ipmb_slave_cb(struct i2c_client *client,
>  		break;
>  
>  	case I2C_SLAVE_WRITE_RECEIVED:
> -		if (iidev->rcvlen > sizeof(iidev->rcvmsg))
> +		if (iidev->rcvlen >= sizeof(iidev->rcvmsg))
>  			iidev->overrun = true;
>  		else
>  			iidev->rcvmsg[iidev->rcvlen++] = *val;
> -- 
> 2.32.0
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer

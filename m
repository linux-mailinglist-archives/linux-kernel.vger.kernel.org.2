Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065D334A93A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCZOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:06:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CDFC0613AA;
        Fri, 26 Mar 2021 07:06:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h13so6450766eds.5;
        Fri, 26 Mar 2021 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAUeEBvNOlRZeFn3QKTykt9MHuUQpjA5Y+tnrO+kfKQ=;
        b=U3KqtzLbFEZfuPQqGOTS+dccIk7ZnAnc5e1QRbttk93YJd8TuGQqM03aD0d2Urh19u
         Ia5O286+r52F2H3fF8iQ3ydyaFKbPN/JmzllzMuyyFX6lblgCic5Io1gZqN5HEWWuo7h
         VxtN61prve1090JGLCQzWEN/eOwlipoKdFeLmpz3H0aYpmazyeQfKAKlUtyVl/T7S9/f
         aFYjScxMLxdsSdXGH+7AfsFMK2uCCvXZ9S2pSc0Z1yMbfupbclpeq4AjG3V73Etc3ZDk
         gtTOFgfee0FSi4IAzcp1Gyi58OIukA3Znw3z2OT8feV9/P33uosZZ9iQX8WO+xmWD7DE
         NUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAUeEBvNOlRZeFn3QKTykt9MHuUQpjA5Y+tnrO+kfKQ=;
        b=Cwra7tYiMvElaTJGYY11FbkpSKZLio+N9ai49XDVNMLKjJE8fb3eZfzi0noNezquH4
         8Iby/dlIqlfOatqWQPn75G/Hz0+FhaZ9lyEx2YE/thZAbvaqLxmksV5wwcla48Y83lHm
         9hWzwPs7s6r8S0Yvhz161dsn9gLvWLlYrGjXfz7F9YEXmRLrE3f8UxO+zJzMC7y0fvqA
         kBA2U7zwfdcyetb+CQ7cqAs12E+sy27kPi4AgLF3IFGH7MPfUG12oEvEj4KPkB7C2JIP
         czEKbBGrS9bv91we0zNlH2c3WBgBg7KGJFjYcBL/pIMaEzP3t6DHKk/U5XaHx7l+EvPA
         q4ag==
X-Gm-Message-State: AOAM532aYeVR8Fjoekr/cr444kq3Sopw13xw2TbNQaO1yn1a8VmDV0kg
        J+iWJFQCXLJyO1zKAbpQenSFbNoRn3SK+g==
X-Google-Smtp-Source: ABdhPJwF/EPr6RMn1+mfNp+lhbo3BHgzp7LyW4Qp3TiJJKlD91udGcaItnBA1syzMo33ZgnwokvcEw==
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr15100004edc.143.1616767570246;
        Fri, 26 Mar 2021 07:06:10 -0700 (PDT)
Received: from [10.20.0.9] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id gq25sm3936362ejb.85.2021.03.26.07.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 07:06:09 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: clean up a variable in
 surface_dtx_read()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YF3TgCcpcCYl3a//@mwanda>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <e614021b-62aa-c879-c324-fc1dc1eec73e@gmail.com>
Date:   Fri, 26 Mar 2021 15:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YF3TgCcpcCYl3a//@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 1:28 PM, Dan Carpenter wrote:
> The "&client->ddev->lock" and "&ddev->lock" are the same thing.  Let's
> use "&ddev->lock" consistently.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface_dtx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
> index 1fedacf74050..63ce587e79e3 100644
> --- a/drivers/platform/surface/surface_dtx.c
> +++ b/drivers/platform/surface/surface_dtx.c
> @@ -487,7 +487,7 @@ static ssize_t surface_dtx_read(struct file *file, char __user *buf, size_t coun
>   			if (status < 0)
>   				return status;
>   
> -			if (down_read_killable(&client->ddev->lock))
> +			if (down_read_killable(&ddev->lock))
>   				return -ERESTARTSYS;
>   
>   			/* Need to check that we're not shut down again. */
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2395E45FF00
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355075AbhK0OHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355196AbhK0OFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:05:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210FC06175C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 06:02:30 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 207so24414226ljf.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6Jp+Jmv9nQ4RwfE9Lv1G0z4T1+sN4K5Hm7FU2O6G3Po=;
        b=xLQAvi6VXf7U8l/yJVeP9gcvtkRIkIrjt64YcaNqsZaWkPQJhDq5Tqs7qufpRGEXwT
         UeYhciNhFatnRhRVAsGgtSCCR/zwi9OQkRqaytIqViWhcaPCZZIsx3JdJf1p14HhRGmI
         sINB1KdVGY1YSYStn5yRvJlEA9Tr33TU3K3/vHdsljmbu4ALNxeKRJ770XcPuOonS+2O
         bXyFj51bwXK8i4iOojBQutk8mG1TQUrKNPMFQEE5jbqVOTD0H2FYX0hJWMvEStV47a/M
         2n5pjMbkvpBrd1uoNrrN5dFe+servml7aDZvDxoPT6C1EBPaPncchphhYs1BgIZyF1mP
         vTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Jp+Jmv9nQ4RwfE9Lv1G0z4T1+sN4K5Hm7FU2O6G3Po=;
        b=5sdlQjfBdgnprDIET1seSf+IcsfgneNzG7tMGHZBCxefCKCuid5N0F7V96RjJrkLYS
         XpDQ6dzRLxFcSSfKm7A2DF6oEHzxXh7bASQZWQMI3FzcObIx+DDAly9IJOwJ0qqxTvkF
         kKl0Q5v93PloDJCKLycsB00Ja6OX8ig4EKvJ9Ep41nmoCm4Ad7aMqmwOTLogpTPy2qks
         H0aLJAYoDd+c7krx3eoewZ9GJbaOEvAVRtRc3z+y3wszS8fKTJpG6GAuj5twU5Bo8HDV
         Cw820g88m398zdybJOiJHhQPuF79FrDXTGdXjy5t9WBtDpafggNPsK14fN6mxN8bD0AG
         tWsA==
X-Gm-Message-State: AOAM530/aiWmYxJ24iMYblJo02kP9vdi5XZLS5MZXS7oxjb5DpO89/cK
        4Pa3LdjyVqBUACkd2nGx6PLksA==
X-Google-Smtp-Source: ABdhPJyz24J5I1/otOJx9sQYPb9FUXaXuNX7Nh3JjWdXmTizPpwpJ5pmEAEZW14aF8rvZNyADHq7hg==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr36136932ljk.508.1638021747974;
        Sat, 27 Nov 2021 06:02:27 -0800 (PST)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id t4sm849568lfe.220.2021.11.27.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:02:27 -0800 (PST)
Date:   Sat, 27 Nov 2021 15:02:26 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: max96712: Constify static v4l2_subdev_ops
Message-ID: <YaI6csuWQFTU7moc@oden.dyn.berto.se>
References: <20211127094945.27985-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211127094945.27985-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej Rikard,

Tack för din patch, ser bra ut.

On 2021-11-27 10:49:44 +0100, Rikard Falkeborn wrote:
> The only usage of max96712_subdev_ops is to pass its address to
> v4l2_i2c_subdev_init() which takes a pointer to const struct
> v4l2_subdev_ops as argument. Make it const to allow the compiler to put
> it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/staging/media/max96712/max96712.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/media/max96712/max96712.c
> index 847e2ffd4f53..9bc72d9a858b 100644
> --- a/drivers/staging/media/max96712/max96712.c
> +++ b/drivers/staging/media/max96712/max96712.c
> @@ -250,7 +250,7 @@ static const struct v4l2_subdev_pad_ops max96712_pad_ops = {
>  	.set_fmt = max96712_get_pad_format,
>  };
>  
> -static struct v4l2_subdev_ops max96712_subdev_ops = {
> +static const struct v4l2_subdev_ops max96712_subdev_ops = {
>  	.video = &max96712_video_ops,
>  	.pad = &max96712_pad_ops,
>  };
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund

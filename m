Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4413997C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCByt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCBys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:54:48 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA2C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 18:52:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q6so2462505qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fmfr4z1WLWuoXatp4jFBsEgXay95FG/JmcWVrfnjUA=;
        b=c0WkxRnn6Huh03RMuqwNK1laL++oNVz2ynQ6L/8lMi7oUm8LhUSMKLBbv3g0FxgYhI
         quWdQa/iueHMnmoN4L9fCPmQuRTyBLSHNz5jWy85pw622EW0+kUN45tGfEfHzfgfHu6p
         iUPsGEuCm8E09+HhMV9CYcBSh8JDgVG8I/3H8BPJXUzJ6a/s6SkXT4uJI/f1966QsYHh
         ljy+qjN6khJpssqihRQsO62RHaOiY8tchFvPBmJY6l4DUSJeVtTVfJxx2hhAByMrptWh
         0qdthO4GcitT/4lpLtIyWukQB+ltHx71JAv0h77ChuCDfA6AL0HSXew3zC6g5iX4XQ0c
         8j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7fmfr4z1WLWuoXatp4jFBsEgXay95FG/JmcWVrfnjUA=;
        b=M4QASo8qGqF11C+n/YOvkQsYQ5Z1rgnV+ty3UwLiS67GzrT0O9l3sizrZT+5OTFucB
         sGoIhYo8bTi71h6WDaO+PIv7d3vkrzJPv2eqcff5Irxm823jO1oYqD1+78/Oao1pMjFF
         2SqEpdilm98mePJ7W1JsrGlkEhRmgQ1c++ZAo+gRSXyQt6mbvvSPOEC+nsRAt/o5PLAG
         l3LZ+a0N9yCkjGUCGjAwECjJ2Tv0wVngo9RJFrnR8mrGs00/mwizznfHxv0YTN4aeh9q
         yRJv0ZplDEqsCldFqTlueNTqyUfQn0UKzBsgLH6B6/yJlQ4mkR4IydOSL8mSIez8lGNP
         ZD2Q==
X-Gm-Message-State: AOAM531gJsXbrV/sAlEAkk9e9EkUj7chfluxuAkIWEWgLzkQ9kp8WtIx
        +V5h+S3vcsDXM7xK8R747dA=
X-Google-Smtp-Source: ABdhPJxH9utFBbwsPt/vgTlJ7Pi8GXKQ7mYDs4pvcIBQALN46RCbYWNpFZPD0V6PlktTEQQwvNUbRQ==
X-Received: by 2002:a0c:e185:: with SMTP id p5mr3487013qvl.17.1622685169026;
        Wed, 02 Jun 2021 18:52:49 -0700 (PDT)
Received: from localhost.localdomain ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id a10sm906587qtg.40.2021.06.02.18.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:52:48 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Wed, 2 Jun 2021 21:52:46 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     pjones@redhat.com, konrad@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ibft: Remove unneeded semicolon
Message-ID: <YLg17kKDiWEl7CF4@localhost.localdomain>
References: <20210601142132.4132319-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601142132.4132319-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:21:32PM +0800, Zheng Yongjun wrote:
> Remove unneeded semicolon.

Heya,

Please bear with me - but this semicolon does not seem to be hurting
anyone so not sure what bug this patch is trying to fix?

I would prefer to leave the code as is (with all its warts) unless
there are bugs or features to be added.

Thank you.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/firmware/iscsi_ibft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 7127a04bca19..d46da640f484 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -802,7 +802,7 @@ static void ibft_unregister(void)
>  		ibft_kobj = boot_kobj->data;
>  		if (ibft_kobj->hdr && ibft_kobj->hdr->id == id_nic)
>  			sysfs_remove_link(&boot_kobj->kobj, "device");
> -	};
> +	}
>  }
>  
>  static void ibft_cleanup(void)
> -- 
> 2.25.1
> 

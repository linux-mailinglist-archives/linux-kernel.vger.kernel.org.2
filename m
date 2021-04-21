Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F236719D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbhDURoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbhDURoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:44:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9277AC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:43:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b17so30592285pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iop9sruWWZSxGtHmNYX36Jd0eJEk72OqG23A/bctcgg=;
        b=KERT70S61Qltkgi1Aa1Wpfd5hkz2A2hEM601DubpZKrbIW2mF3Izu2wlKbW3nSQcqC
         mx1W6dd58gQrZCCPglM5531BdBO/Trlm1EVn3bJnYEmxIxZ8+OlfF6RonRRs6ZiLvrJ/
         ay+za8z/TJI75zmDPw/UsI63VAuWYIwDU7YuOAcPuSK9M6Xxmgl+U7ENmIMhO04ct2EM
         w75kSMJJgJpxbjiuORyewwe6Cy8n6Z+zyOBzbKneWzX9fM5FqIxicILNgLXcReJdbVqL
         vsUHWmBFaGFGVBWrb5VMJFARqqI8SjLOkrqf3RQDaoeJrx/fJ6uqsZLEOQLqtjEfc9Xg
         t7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iop9sruWWZSxGtHmNYX36Jd0eJEk72OqG23A/bctcgg=;
        b=n+XGqwOEOL4heSje+fBHCNSjdAK0X/GIHvm/mLz8xrAo1SdkXKi0COfvGdVDVdFrln
         wT3Hf0Qv2Y61KyISAT9sezCCZ+KIMq6OQz8GaHWh1QeMiHQL19EzCm5bX0EJIfgpbusA
         KuOfevlwjGJI+tQaqoLUF8aN9hR6FZLSXQL/l44QJpCKAbIJ3IjQzifXx8k2nDcMHDtW
         DmLHPb9yA1Halr599JlzS45a+iRKB9cr0saJ/ZmpmakjhJ72NLIH5Nkw9ieRyWWdfK7j
         jXSSViikSrIjxMMzQFNamG23FrFh+JilN5HM+HidANCXtU0KQLvrfhwBm4lHoxprFk4c
         dGjA==
X-Gm-Message-State: AOAM531lWu/uw8BIstRfO5oU7GJYIIANLFRoF8wrIwDOkbpY/buBDi2O
        dIZPf6mDE0HitmPuCqgzY5xdFA==
X-Google-Smtp-Source: ABdhPJymxLvOl4ALgewRCvw1sM7e3ewI+dY0lHkB+zghwJ+H6qoPqYG6aYn6nlN5eAJGlKIR3wNDdw==
X-Received: by 2002:a65:5089:: with SMTP id r9mr22949281pgp.38.1619027012152;
        Wed, 21 Apr 2021 10:43:32 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r3sm59810pgn.82.2021.04.21.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:43:31 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:43:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 4/7] rpmsg: char: Introduce
 __rpmsg_chrdev_create_eptdev function
Message-ID: <20210421174329.GB1223348@xps15>
References: <20210413134458.17912-1-arnaud.pouliquen@foss.st.com>
 <20210413134458.17912-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413134458.17912-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:44:55PM +0200, Arnaud Pouliquen wrote:
> Introduce the __rpmsg_chrdev_create_eptdev internal function that returns
> the rpmsg_eptdev context structure.
> 
> This patch prepares the introduction of a rpmsg channel device for the
> char device. The rpmsg device will need a reference to the context.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> ---
> update from V1
> - fix __rpmsg_chrdev_create_eptdev function header indentation.
> 
> ---
>  drivers/rpmsg/rpmsg_char.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 21ef9d9eccd7..a64249d83172 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -323,8 +323,9 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>  	kfree(eptdev);
>  }
>  
> -int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> -			       struct rpmsg_channel_info chinfo, struct class *rpmsg_class)
> +static struct rpmsg_eptdev *
> +__rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> +			     struct rpmsg_channel_info chinfo, struct class *rpmsg_class)
>  {
>  	struct rpmsg_eptdev *eptdev;
>  	struct device *dev;
> @@ -332,7 +333,7 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
>  
>  	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
>  	if (!eptdev)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	dev = &eptdev->dev;
>  	eptdev->rpdev = rpdev;
> @@ -376,7 +377,7 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
>  		put_device(dev);
>  	}
>  
> -	return ret;
> +	return eptdev;
>  
>  free_ept_ida:
>  	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> @@ -386,7 +387,19 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
>  	put_device(dev);
>  	kfree(eptdev);
>  
> -	return ret;
> +	return ERR_PTR(ret);
> +}
> +
> +int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> +			       struct rpmsg_channel_info chinfo,  struct class *rpmsg_class)
> +{
> +	struct rpmsg_eptdev *eptdev;
> +
> +	eptdev = __rpmsg_chrdev_create_eptdev(rpdev, parent, chinfo, rpmsg_class);
> +	if (IS_ERR(eptdev))
> +		return PTR_ERR(eptdev);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_create_eptdev);
>  
> -- 
> 2.17.1
> 

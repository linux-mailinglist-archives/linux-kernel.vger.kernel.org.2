Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F139A3671AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbhDURqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhDURqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:46:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C99C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:45:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j7so21175687pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ut0gNS/Z6SzxBjiicfpi9MImfRo7ew13zfAdk9Vprd0=;
        b=SIrL+Q3r6VEewwGL+joTXOtRbF53efIh5RVPV8yMSyabLzrFjaxGAjqqqrg3lb1SMs
         /G48ay45D3FQ9m5BLbIQrNjWIHKSaiBgbHW7qqDnr+Y03/3MsGupk6+vUv1k9wjfYRc4
         VAO1llTS5UE+3vR29D0e/0EIsuXJJFG/QFMh7XN4u1N9NQralqu/Zuqb7vG/ana1shj1
         GO22AiQpWvql2SgiHZfgI7zlW3+mHN8AVJ0sO8fPmk3OJiihTN2PsPNgrLtOT/Mrsyrm
         V4V27lwOt4Pl4ItPi+el5Tf1lMdMvnX85wFEiDNDlD09VKSn2YoY+HfhWgQtc+AP3oMh
         Gqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ut0gNS/Z6SzxBjiicfpi9MImfRo7ew13zfAdk9Vprd0=;
        b=TlbZHB5r4T7kef+4YGCckRHzr7as6nqNKvVabYAcFMNxXtrEqY95kGor9kVOEOKD0j
         PZIwLh7+Mnu+62MJJkMJTKrKFDz1jYssH9a8HgtGMhIT1VCuiVCYWIxjnEg+CnfoyzKO
         QSE586CY3xqUWi9LEAiJp9EUSDX5oZ7FkNqbSAfAjogdEEn1wYr05urKq2GW8jqDEcVo
         sg3phBDwD+Qb42U0sxllZXpsrEdZjSD02yLmlE8ygXvrJWKAa1VxfdQAaC5hdUwwSlJT
         crI/fCxw3hkYWTDd1GfcBxyeiwu791yqD7TAoRxYJxX0HuyX8SaEXRa4LLgNjbGpPO1Y
         kMQg==
X-Gm-Message-State: AOAM531Nc8pv9DRz6TozhGI7qSTkHrL6A5oBJ7oENNuwEKwJcSN8UnB4
        xHR8UI4EfKWwtnbAyWz+3fUMMw==
X-Google-Smtp-Source: ABdhPJxInlfZIuUPh9liALM1C3FPVm/IvfkXHVriMoop8sdWsZjss+z371kiQlb5L7yDOTWbDg5cqA==
X-Received: by 2002:a62:ee09:0:b029:247:56aa:dfa6 with SMTP id e9-20020a62ee090000b029024756aadfa6mr31068474pfi.69.1619027139169;
        Wed, 21 Apr 2021 10:45:39 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id gc15sm2654845pjb.2.2021.04.21.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:45:38 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:45:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 4/7] rpmsg: char: Introduce
 __rpmsg_chrdev_create_eptdev function
Message-ID: <20210421174537.GC1223348@xps15>
References: <20210413134458.17912-1-arnaud.pouliquen@foss.st.com>
 <20210413134458.17912-5-arnaud.pouliquen@foss.st.com>
 <20210421174329.GB1223348@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421174329.GB1223348@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:43:29AM -0600, Mathieu Poirier wrote:
> On Tue, Apr 13, 2021 at 03:44:55PM +0200, Arnaud Pouliquen wrote:
> > Introduce the __rpmsg_chrdev_create_eptdev internal function that returns
> > the rpmsg_eptdev context structure.
> > 
> > This patch prepares the introduction of a rpmsg channel device for the
> > char device. The rpmsg device will need a reference to the context.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > 
> > ---
> > update from V1
> > - fix __rpmsg_chrdev_create_eptdev function header indentation.
> > 
> > ---
> >  drivers/rpmsg/rpmsg_char.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>

Please excuse the brain-bug here - this RB was destined to patch 3/7.  I am not sure
about this patch yet (see comment in 5/7).
 
> > 
> > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > index 21ef9d9eccd7..a64249d83172 100644
> > --- a/drivers/rpmsg/rpmsg_char.c
> > +++ b/drivers/rpmsg/rpmsg_char.c
> > @@ -323,8 +323,9 @@ static void rpmsg_eptdev_release_device(struct device *dev)
> >  	kfree(eptdev);
> >  }
> >  
> > -int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> > -			       struct rpmsg_channel_info chinfo, struct class *rpmsg_class)
> > +static struct rpmsg_eptdev *
> > +__rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> > +			     struct rpmsg_channel_info chinfo, struct class *rpmsg_class)
> >  {
> >  	struct rpmsg_eptdev *eptdev;
> >  	struct device *dev;
> > @@ -332,7 +333,7 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
> >  
> >  	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
> >  	if (!eptdev)
> > -		return -ENOMEM;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	dev = &eptdev->dev;
> >  	eptdev->rpdev = rpdev;
> > @@ -376,7 +377,7 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
> >  		put_device(dev);
> >  	}
> >  
> > -	return ret;
> > +	return eptdev;
> >  
> >  free_ept_ida:
> >  	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> > @@ -386,7 +387,19 @@ int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent
> >  	put_device(dev);
> >  	kfree(eptdev);
> >  
> > -	return ret;
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +int rpmsg_chrdev_create_eptdev(struct rpmsg_device *rpdev, struct device *parent,
> > +			       struct rpmsg_channel_info chinfo,  struct class *rpmsg_class)
> > +{
> > +	struct rpmsg_eptdev *eptdev;
> > +
> > +	eptdev = __rpmsg_chrdev_create_eptdev(rpdev, parent, chinfo, rpmsg_class);
> > +	if (IS_ERR(eptdev))
> > +		return PTR_ERR(eptdev);
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL(rpmsg_chrdev_create_eptdev);
> >  
> > -- 
> > 2.17.1
> > 

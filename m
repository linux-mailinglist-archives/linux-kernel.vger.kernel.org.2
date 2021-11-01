Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D553441F57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhKAReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhKAReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:34:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF3C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:31:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so16507742pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NtXayfTUJqN0+HnL18EFdYPTjw8r+9ANxCl9WnYlDq8=;
        b=Voisx85ftQ9ebXLfKeWT0X2TDAchK9ZJ5g6bI2MkUr27Rms+2MCI5wdkc9NM+aI3L7
         PIod2Fxk6BGbz/JSbHuIpVOuAAa1wkx6btD6dNUf00nU/Ucfk22S0T/fndYSvrOEnsIS
         wlvk6doBhqvOEuuQoukZ44SDZSoatTrTma/IeW+Ju3/3ktTACSFVZgx//Eezf8Xmh2Nx
         dOhk8v3NSeFo/pOfqDUyCSgd4nwiIAGmKMqkUpXeFnOTyhjRw8nczRX0g9Vo8hQI8+o1
         +P6UY/TJo2rBYhNeoEJpDx5xSDSViK5elD12VITHXChm7D5an8+tjbTqDjUWHtDMmfZ9
         Uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NtXayfTUJqN0+HnL18EFdYPTjw8r+9ANxCl9WnYlDq8=;
        b=ppG5KOOoWPEmIPhtVUqZbrZAswXQSEBaWtCqST5gnP3j7ypyNEapC2su2HS1pB0MnG
         i+crf4A4GEMk7AGr805/ojuskhmd7gXkqsBeVbGr8+RyiWcgkwsXYXHk09QEiCxX3E6J
         uSCuPvTefuLmETrxy41/PDGiqAMclt2beeSe1VOd8xIQqLz97C6Z20yTrM9Wc1DpDV9v
         +fl+bbw2y158AKLefRnmUWzpadWoPAhlYaW4dQixrOrTRIkhLeoCtBnGba7PIaR1Gekb
         e2WYwIRk0ZvzUh8uoXkvSFZjJUGVXEEEST8GVsFmn+YXma9/fVyrwWcDB81XSVeG9jG3
         cNhQ==
X-Gm-Message-State: AOAM5333wYyVmObQwBzdKc5PNH+nL2sHbDLU7MzE8KiIUTYSpA5yiOYq
        0+NW/kPI7jY+xh4XLnmzcKR6kw1Y99s=
X-Google-Smtp-Source: ABdhPJxcYS501VmNX6gHmkSUboOHq80KnozPWaDUu/SJ7HdJd6F2DxV0pqHKuSXV2xOvQuTdkccByg==
X-Received: by 2002:a17:902:bd94:b0:13f:f96c:aa22 with SMTP id q20-20020a170902bd9400b0013ff96caa22mr26544710pls.43.1635787908362;
        Mon, 01 Nov 2021 10:31:48 -0700 (PDT)
Received: from ojas ([122.161.50.72])
        by smtp.gmail.com with ESMTPSA id ls14sm77889pjb.49.2021.11.01.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 10:31:48 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:01:21 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: vchiq: Replace global state with per device
 state
Message-ID: <20211101172843.GA17771@ojas>
References: <cover.1635764115.git.ojaswin98@gmail.com>
 <5b51970f601c4bf5165fc70174085a809b3c0316.1635764115.git.ojaswin98@gmail.com>
 <84300618-98c8-0f44-e5a5-8d7fd6c853b0@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84300618-98c8-0f44-e5a5-8d7fd6c853b0@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:19:17PM +0100, Stefan Wahren wrote:
> Hi Ojaswin,
> 
> Am 01.11.21 um 12:09 schrieb Ojaswin Mujoo:
> > Currently, the driver has a global g_state variable which is initialised
> > during probe and directly used all over the driver code. However, this
> > prevents the driver to support multiple VideoCore VPUs at the same time.
> >
> > Replace this global state with a per device state which is initialised
> > and allocated during probing.
> >
> > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> ...
> >  
> >  /*
> > @@ -1763,6 +1795,7 @@ static int vchiq_probe(struct platform_device *pdev)
> >  	struct device_node *fw_node;
> >  	const struct of_device_id *of_id;
> >  	struct vchiq_drvdata *drvdata;
> > +	struct vchiq_device *vchiq_dev;
> >  	int err;
> >  
> >  	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
> > @@ -1784,7 +1817,18 @@ static int vchiq_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, drvdata);
> >  
> > -	err = vchiq_platform_init(pdev, &g_state);
> > +	vchiq_dev = kzalloc(sizeof(struct vchiq_device), GFP_KERNEL);
> > +	vchiq_dev->state = kzalloc(sizeof(struct vchiq_state), GFP_KERNEL);
> > +	vchiq_dev->vchiq_pdev = *pdev;
> > +
> > +	g_state = vchiq_dev->state;
> > +
> 
> just a quick idea: how about storing the global state within vchiq_drvdata?
> 
> So there is no need to reinvent somekind of vchiq device which is the
> "same" as the platform device. After that you are able to access the
> private driver data via platform_get_drvdata().
Hi Stefan, 

Thank for looking into this. I agree that the vchiq_device is just a
sorta extension of the pdev. However, regarding using the drvdata, I had
some questions.

So I understand the purpose of this patch is to make sure our driver is
able to support multiple devices, that is it can work with say, an SoC
with 2 VideoCore VPUs. In this case, we would need to maintain 2 states
for each VPU instead of a global state, however if we use something like
the following:

 	drvdata = (struct vchiq_drvdata *)of_id->data;
  drvdata->state = kzalloc(sizeof(struct vchiq_state), GFP_KERNEL);
	platform_set_drvdata(pdev, drvdata);
		
Correct me if I'm wrong but I think the assignment to drvdata in line 1
above will return a pointer to the same structure. In which case, the
line 2 will always overwrite the older state that is present. 
That's why I was initialising a separate object (vchiq_device) everytime
the probe was called so that each device can have their own device
specific structs. 

Please let me know if my understanding of drvdata is wrong here.
> 
> Best regards
> 

Thank you!
Ojaswin

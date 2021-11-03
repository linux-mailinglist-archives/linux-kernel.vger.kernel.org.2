Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE4444663
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhKCRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhKCRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:00:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E6C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:57:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d12so1212672oij.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3VstZY1jHT+RNp6OmveWhgRjsLMcP2Rwk0s7VGvurVM=;
        b=kjvSR4JBDQiOkTxb8ZZsbaf3MmZLFVQQEFbPemMVa+/J29n3x4Fsa7nAh1aNk74Op+
         XuRT0M4rlZSLPJn3a7NWuUo18rryNo4CaO/pfcmpVFcRGDbqO6bYBTT939gR3YgpER+u
         GzbWWbLd++6D2vNDTVdTMfT7H8rVBhE9ZnguRSqQVuq52w2SQwTJOrAj2f4nFt/yw/DX
         5yTJgjNNJrkRrhPJEbLzJtnhNAg1OAcRCqdlhxM06ZN7LjYhzk/rWwkGxPb5/S8sjrmm
         38ZYC0STfVsqiHAQLn7kpiaAQ5QYKdClIXznzdTYI3i2qexmZCv46iYNBqKd/3ett3jQ
         tEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VstZY1jHT+RNp6OmveWhgRjsLMcP2Rwk0s7VGvurVM=;
        b=eyXqH661E3g6KdFRzSXZ1YBl1YXT4wDVrgCFeNVd75x2naWYJUQJdRuE4QZNtkN8jW
         7IqlgQaiF3nJwWNgbuYutYrM95CTuBZzd9ZZrPARjRJL2M5BtT6XjOW9bSLV179TfqFQ
         q6IlG5kZLL/bDjik5afRLsSsIVSgB7pwPc2WpciGyHRQbS/o6ZGWaI6QCHq3333dh4yx
         qAiT0DAmcMzjtQmOgkiQEemWy1Ky+HXm6oildocM4ZRXA2hrXil8zd1+JuvV8LBr/49q
         w8668J/JqFunUk7YBXeeyC7tcXqfDqPsEvYVhN8QL72DrVynVknpXu+utDrmwoHUK9SW
         NLyA==
X-Gm-Message-State: AOAM531Y8wMgN+BnPXIr+BOtKFHeBqU72xsM3mmktoMLj+A4cBHYJRo6
        B93gVmtVdWEbZeQoxgvfZzrKN4Re9lO2Cg==
X-Google-Smtp-Source: ABdhPJzVy48wbNpxKNKM93NqqIW8zUJgznRb+0LUQ1sKQKTMxw9rWw4ugYXLUEU38HZoTb3fdi0CUQ==
X-Received: by 2002:a54:4e8f:: with SMTP id c15mr11441741oiy.113.1635958675587;
        Wed, 03 Nov 2021 09:57:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k26sm683551otp.42.2021.11.03.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:57:54 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:57:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v6 06/10] rpmsg: Introduce rpmsg_create_default_ept
 function
Message-ID: <YYK/jiHIUh8RBvTo@builder.lan>
References: <20211022125426.2579-1-arnaud.pouliquen@foss.st.com>
 <20211022125426.2579-7-arnaud.pouliquen@foss.st.com>
 <YYAlzvXns4Ejxa6S@builder.lan>
 <d1352a00-bc6d-91ae-b902-622c75448e3a@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1352a00-bc6d-91ae-b902-622c75448e3a@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Nov 11:56 CDT 2021, Arnaud POULIQUEN wrote:

> 
> 
> On 11/1/21 6:37 PM, Bjorn Andersson wrote:
> > On Fri 22 Oct 07:54 CDT 2021, Arnaud Pouliquen wrote:
> > 
> >> By providing a callback in the rpmsg_driver structure, the rpmsg devices
> >> can be probed with a default endpoint created.
> >>
> >> In this case, it is not possible to associated to this endpoint private data
> >> that could allow the driver to retrieve the context.
> >>
> >> This helper function allows rpmsg drivers to create a default endpoint
> >> on runtime with an associated private context.
> >>
> >> For example, a driver might create a context structure on the probe and
> >> want to provide that context as private data for the default rpmsg
> >> callback.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Tested-by: Julien Massot <julien.massot@iot.bzh>
> >> ---
> >>  drivers/rpmsg/rpmsg_core.c | 51 ++++++++++++++++++++++++++++++++++++++
> >>  include/linux/rpmsg.h      | 13 ++++++++++
> >>  2 files changed, 64 insertions(+)
> >>
> >> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> >> index 53162038254d..92557c49d460 100644
> >> --- a/drivers/rpmsg/rpmsg_core.c
> >> +++ b/drivers/rpmsg/rpmsg_core.c
> >> @@ -132,6 +132,57 @@ void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
> >>  }
> >>  EXPORT_SYMBOL(rpmsg_destroy_ept);
> >>  
> >> +/**
> >> + * rpmsg_create_default_ept() - create a default rpmsg_endpoint for a rpmsg device
> >> + * @rpdev: rpmsg channel device
> >> + * @cb: rx callback handler
> >> + * @priv: private data for the driver's use
> >> + * @chinfo: channel_info with the local rpmsg address to bind with @cb
> >> + *
> >> + * On register_rpmsg_driver if no callback is provided in the rpmsg_driver structure,
> >> + * no endpoint is created when the device is probed by the rpmsg bus.
> >> + *
> >> + * This function returns a pointer to the default endpoint if already created or creates
> >> + * an endpoint and assign it as the default endpoint of the rpmsg device.
> > 
> > But if the driver didn't specify a callback, when would this ever
> > happen?
> 
> Not sure to understand your point here...
> Do you mean that something is missing in description such as:
>  * On register_rpmsg_driver if no callback is provided in the rpmsg_driver
>  * structure, no endpoint is created when the device is probed by the rpmsg bus.
>  * The rpmsg driver can call rpmsg_create_default_ept during or after its
>  * probing to register a default endpoint with an associated callback and @priv
>  * context.
> 

I was referring specifically to the case of rpmsg_create_default_ept()
being called on a rpmsg_device that already has a rpdev->ept.

Afaict this would either be because the driver did specify a callback or
because the driver didn't but has already called
rpmsg_create_default_ept().

Both cases sounds like invalid usage.

> > 
> >> + *
> >> + * Drivers should provide their @rpdev channel (so the new endpoint would belong
> >> + * to the same remote processor their channel belongs to), an rx callback
> >> + * function, an optional private data (which is provided back when the
> >> + * rx callback is invoked), and an address they want to bind with the
> >> + * callback. If @addr is RPMSG_ADDR_ANY, then rpmsg_create_ept will
> >> + * dynamically assign them an available rpmsg address (drivers should have
> >> + * a very good reason why not to always use RPMSG_ADDR_ANY here).
> >> + *
> >> + * Returns a pointer to the endpoint on success, or NULL on error.
> > 
> > Correct kerneldoc is "Return: ..."
> 
> I will update this
> 
> > 
> >> + */
> >> +struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
> >> +						rpmsg_rx_cb_t cb, void *priv,
> >> +						struct rpmsg_channel_info chinfo)
> >> +{
> >> +	struct rpmsg_endpoint *ept;
> >> +
> >> +	if (WARN_ON(!rpdev))
> >> +		return NULL;
> >> +
> >> +	/* It does not make sense to create a default endpoint without a callback. */
> >> +	if (!cb)
> >> +		return NULL;
> >> +
> >> +	if (rpdev->ept)
> >> +		return rpdev->ept;
> > 
> > How does the caller know if they should call rpmsg_destroy_ept() on the
> > returned ept or not?
> 
> This case is probably a bug. What about replacing the condition by
> if(WARN_ON(rpdev->ept))?
> 

Right, I don't think it will be possible for the client driver to do the
right thing based on this logic.

> > 
> >> +
> >> +	ept = rpdev->ops->create_ept(rpdev, cb, priv, chinfo);
> >> +	if (!ept)
> >> +		return NULL;
> >> +
> >> +	/* Assign the new endpoint as default endpoint */
> >> +	rpdev->ept = ept;
> >> +	rpdev->src = ept->addr;
> >> +
> >> +	return ept;
> >> +}
> >> +EXPORT_SYMBOL(rpmsg_create_default_ept);
> >> +
> >>  /**
> >>   * rpmsg_send() - send a message across to the remote processor
> >>   * @ept: the rpmsg endpoint
> >> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> >> index 6fe51549d931..b071ac17ff78 100644
> >> --- a/include/linux/rpmsg.h
> >> +++ b/include/linux/rpmsg.h
> >> @@ -172,6 +172,9 @@ void rpmsg_destroy_ept(struct rpmsg_endpoint *);
> >>  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *,
> >>  					rpmsg_rx_cb_t cb, void *priv,
> >>  					struct rpmsg_channel_info chinfo);
> >> +struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
> > 
> > Is there ever a case where someone outside drivers/rpmsg/ should call
> > this function?
> 
> A rpmsg service driver could call it to generate the ns announcement after
> the probe (for instance on a sysfs open).
> (Please have a look to [PATCH v6 10/10] rpmsg: core: send a ns announcement when
> a default endpoint is created)
> 

I'm still not convinced that it's correct to do NS only for primary
endpoints.

In particular looking down the path where you are instantiating services
on the Linux side; e.g. what if you want your driver to probe on some
control channel but have the actual data flow on a separate channel
(something I believe Loic talked about earlier).

How would the remote side know about that second endpoint if the NS
doesn't announce it?

Regards,
Bjorn

> Thanks,
> Arnaud
> 
> > 
> > Regards,
> > Bjorn
> > 
> >> +						rpmsg_rx_cb_t cb, void *priv,
> >> +						struct rpmsg_channel_info chinfo);
> >>  
> >>  int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
> >>  int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
> >> @@ -236,6 +239,16 @@ static inline struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev
> >>  	return NULL;
> >>  }
> >>  
> >> +static inline struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
> >> +							      rpmsg_rx_cb_t cb, void *priv,
> >> +							      struct rpmsg_channel_info chinfo)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >>  static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
> >>  {
> >>  	/* This shouldn't be possible */
> >> -- 
> >> 2.17.1
> >>

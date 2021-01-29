Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4173308248
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhA2AOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhA2AO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:14:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED8CC061353
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:13:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t25so5436277pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DvXKajRo/sxOf4IOVGOfrlqOa4H+vynjfq2cu2QEPHs=;
        b=LBgFNkuNXpSTQcIsZcvhpIfjd9FmCB1AcxB4yaQafY98EB4WohlJ+c9g91dB/lReAp
         g87T9DUvk5kmVttqkF7c8H/FU1IP3uAg1byEKeOGnW0LN7qnjjgPgI8D+/phW1b7zbTr
         MNKOKfWzCOwaKEVBI7LWsrPrze1rtdCqVZX/D6gkS4xHV/T0uwOFj1F6cKTcyPGDf9sO
         IQloDZZZHFrRv4oSY3Wdhhb0PFS6RQF8LjDbFUWuLHbGm7NTTwr1T4zWnpHTbw3VbC36
         zsLPpi7cmjccnXo0EfTzBGBxefTPt31T83MgXTvjQOTLkvc3HLZf1rR5/jSjNuVMBeuh
         ADcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvXKajRo/sxOf4IOVGOfrlqOa4H+vynjfq2cu2QEPHs=;
        b=Okix8z7l3chBmWpPj6tNwK7e5KZtRpuUA5pQVKz3aMhpF/bQa82smgaz+qAmUGPXWQ
         bLuOlzkSv1D4774/YYxmtj8VqC/cC+SCLnAfdxL/DI7/Yhde1/sWbf8g3RwyrxzgzDC1
         Dct46ytCrEkIuRVS20fgVJqDnC6oWtwtFxaReqBBz+MUyfE8f6Ok5YmRYALLS1w1psLa
         4fwzMbIvNV6deUfOwptTx1wLqByUP89zkexWEcM2FZwn5X/V9M6AT2JoRg2B36NmiXND
         Uk0dJY/GlFxpBO4J4XD635rwM0+ZBgTl6FGQ7G9D+pIlyPjAaUyXzai/eO1X5/HFDZXR
         Et0g==
X-Gm-Message-State: AOAM5338bYoWcoY88Z3mFTvyRVO/Q8YnVOrccxT9Uzc34hm5FlVTqMtJ
        uFLkfnzLekW/6NISUlAt3j+w5g==
X-Google-Smtp-Source: ABdhPJwI5XsRAklaO6w93ZOvFl74HCJjs7x8iMLj3nCgU9B/WvrEaxXRekU7t1Y/L2d1vbTjRA5/Rg==
X-Received: by 2002:a63:33c4:: with SMTP id z187mr1953619pgz.312.1611879186273;
        Thu, 28 Jan 2021 16:13:06 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n1sm5789580pjv.47.2021.01.28.16.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 16:13:05 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:13:03 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 04/16] rpmsg: ctrl: implement the ioctl function to
 create device
Message-ID: <20210129001303.GA1211489@xps15>
References: <20201222105726.16906-1-arnaud.pouliquen@foss.st.com>
 <20201222105726.16906-5-arnaud.pouliquen@foss.st.com>
 <20210121235258.GG611676@xps15>
 <1b76bf93-9647-c658-b4dd-1b10264a1189@foss.st.com>
 <20210122205934.GA866146@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122205934.GA866146@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > It seems to me that the main point to step forward is to clarify the global
> > design and features of the rpmsg-ctrl.
> > Depending on the decision taken, this series could be trashed and rewritten from
> > a blank page...To not lost to much time on the series don't hesitate to limit
> > the review to the minimum.
> > 
> 
> I doubt you will ever get clear guidelines on the whole solution.  I will get
> back to you once I am done with the SMD driver, which should be in the
> latter part of next week.
>

After looking at the rpmsg_chrdev driver, its current customers (i.e the Qcom
drivers), the rpmsg name service and considering the long term goals of this
patchset I have the following guidelines: 

1) I thought long and hard about how to split the current rpmsg_chrdev driver
between the control plane and the raw device plane and the end solution looks
much slimpler than I expected.  Exporting function rpmsg_eptdev_create() after
moving it to another file (along with other dependencies) should be all we need.
Calling rpmsg_eptdev_create() from rpmsg_ctrldev_ioctl() will automatically load
the new driver, the same way calling rpmsg_ns_register_device() from
rpmsg_probe() took care of loading the rpmsg_ns driver.

2) While keeping the control plane functionality related to
RPMSG_CREATE_EPT_IOCTL intact, introduce a new RPMSG_CREATE_DEV_IOCTL that will
allow for the instantiation of rpmsg_devices, exactly the same way a name service
announcement from a remote processor does.  I envision that code path to
eventually call rpmsg_create_channel().

3) Leave the rpmsg_channel_info structure intact and use the
rpmsg_channel_info::name to bind to a rpmsg_driver, exactly how it is currently
done for name service driver selection.  That will allow us to re-use the
current rpmsg_bus intrastructure, i.e rpmsg_bus::match(), without having to deal
with yet another bus type.  Proceeding this way gives us the opportunity to keep
the current channel name convention for other rpmch_chrdev users untouched.

4) In a prior conversation you indicated the intention of instantiating the
rpmsg_chrdev from the name service interface.  I agree with doing so but 
conjugating that with the RPMSG_CHAR kenrel define may be tricky.  I will wait
to see what you come up with.

I hope this helps.

Thanks,
Mathieu


 
> > Thanks,
> > Arnaud
> > 
> > > 
> > > Thanks,
> > > Mathieu
> > > 
> > >> +	return NULL;
> > >> +}
> > >> +
> > >>  static long rpmsg_ctrl_dev_ioctl(struct file *fp, unsigned int cmd,
> > >>  				 unsigned long arg)
> > >>  {
> > >>  	struct rpmsg_ctrl_dev *ctrldev = fp->private_data;
> > >> -
> > >> -	dev_info(&ctrldev->dev, "Control not yet implemented\n");
> > >> +	void __user *argp = (void __user *)arg;
> > >> +	struct rpmsg_channel_info chinfo;
> > >> +	struct rpmsg_endpoint_info eptinfo;
> > >> +	struct rpmsg_device *newch;
> > >> +
> > >> +	if (cmd != RPMSG_CREATE_EPT_IOCTL)
> > >> +		return -EINVAL;
> > >> +
> > >> +	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
> > >> +		return -EFAULT;
> > >> +
> > >> +	/*
> > >> +	 * In a frst step only the rpmsg_raw service is supported.
> > >> +	 * The override is foorced to RPMSG_RAW_SERVICE
> > >> +	 */
> > >> +	chinfo.driver_override = rpmsg_ctrl_get_drv_name(RPMSG_RAW_SERVICE);
> > >> +	if (!chinfo.driver_override)
> > >> +		return -ENODEV;
> > >> +
> > >> +	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
> > >> +	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
> > >> +	chinfo.src = eptinfo.src;
> > >> +	chinfo.dst = eptinfo.dst;
> > >> +
> > >> +	newch = rpmsg_create_channel(ctrldev->rpdev, &chinfo);
> > >> +	if (!newch) {
> > >> +		dev_err(&ctrldev->dev, "rpmsg_create_channel failed\n");
> > >> +		return -ENXIO;
> > >> +	}
> > >>  
> > >>  	return 0;
> > >>  };
> > >> -- 
> > >> 2.17.1
> > >>

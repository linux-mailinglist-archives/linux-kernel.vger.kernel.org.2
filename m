Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC13B31C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFXOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhFXOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:52:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:50:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s14so4087306pfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6gRbND3XlnFRjxaAFjazt4t2CTzeQHjH9Rv+KQ2khaQ=;
        b=CN5a8joLkzaqbmkYg56qrlGLFVf//X5GU2u3nXsLilDK0o9UwUxDsjPfHaiUrylnYL
         LVkpGs+tG0w3i2+pxdoBC3hn37adQF3+PUoLENdcSbAR9Sy2NPwSjiR7NXqobp7zzupJ
         d0rkicbffZnYLXFVQ/YEQqxiqeJjdZFea0XP0NstQdI29GcNnGery+czH40BXP7v68ql
         RBEmAq2C7wyp96U+HaIZANcOLxTSb2g/TPV8yQCc9npS+6q6zUq1JsEyV5lKd4+lw8I2
         LCjP0S+0XzvaKqkIIgbuxF6YNu9sgsCE142m7ziZ0wiGZOsOREpdAtUCCJIi00c1KRC/
         vB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6gRbND3XlnFRjxaAFjazt4t2CTzeQHjH9Rv+KQ2khaQ=;
        b=k7av6puEMhFHzNC2QguV3MDXWI8w9/456DKPTMpd1zirLgtwVQ5NJ5n/xU6VHemqV3
         n2q81Zy7nGYoYeNgTDJue70zEm1T00CZ50W9VorSIg1lyid+NHkYd+6J6FzZdSX4EZJv
         cupZSdjahy21U8g4juf1AuUnUTZWs8RiTSkq3+F7cumCWXm+RhB/pORHaZ7e65AeiVtE
         NIN0wqxaMZ7u5RHq4i/7slDBXEKVMmtLzNu+IOLwfR+9N/kw+/1vMjVzbtLx8n7s2KZg
         Ak09MWGD4P2+pELVoT6WBxd40fgN3yAzRRiiUHqtLRHn239RE/WRgl35TMTQYnqffCWn
         oc9g==
X-Gm-Message-State: AOAM533jO4f/AdFOToteyeeyJTRcs/7P2F+LnJj+I+SPeI/+6gN4Df9r
        PZ90FjGfI2JyS3YACxPlhqtQXz7oyBDZ
X-Google-Smtp-Source: ABdhPJxGK1UjuX/vighv2ORISjGThUrb8ytgGnsIeZ62mStFW21XjjolJzYWV54+ToUH7EwAQpqzAQ==
X-Received: by 2002:aa7:82cb:0:b029:2e6:f397:d248 with SMTP id f11-20020aa782cb0000b02902e6f397d248mr5551594pfn.52.1624546209966;
        Thu, 24 Jun 2021 07:50:09 -0700 (PDT)
Received: from workstation ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id g38sm2616315pgg.63.2021.06.24.07.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jun 2021 07:50:09 -0700 (PDT)
Date:   Thu, 24 Jun 2021 20:20:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 6/8] bus: mhi: core: Add support for processing priority
 of event ring
Message-ID: <20210624145006.GE6108@workstation>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-7-manivannan.sadhasivam@linaro.org>
 <YNSOXaWt3YX3yDQC@kroah.com>
 <20210624142453.GB6108@workstation>
 <YNSZZhGSZ0lFgS+U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSZZhGSZ0lFgS+U@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:40:38PM +0200, Greg KH wrote:
> On Thu, Jun 24, 2021 at 07:54:53PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 24, 2021 at 03:53:33PM +0200, Greg KH wrote:
> > > On Mon, Jun 21, 2021 at 09:46:14PM +0530, Manivannan Sadhasivam wrote:
> > > > From: Hemant Kumar <hemantk@codeaurora.org>
> > > > 
> > > > Event ring priorities are currently set to 1 and are unused.
> > > > Default processing priority for event rings is set to regular
> > > > tasklet. Controllers can choose to use high priority tasklet
> > > > scheduling for certain event rings critical for processing such
> > > > as ones transporting control information if they wish to avoid
> > > > system scheduling delays for those packets. In order to support
> > > > these use cases, allow controllers to set event ring priority to
> > > > high.
> > > > 
> > > > Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> > > > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Link: https://lore.kernel.org/r/1624053903-24653-2-git-send-email-bbhatt@codeaurora.org
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/bus/mhi/core/init.c | 3 +--
> > > >  drivers/bus/mhi/core/main.c | 9 +++++++--
> > > >  include/linux/mhi.h         | 2 +-
> > > >  3 files changed, 9 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> > > > index c81b377fca8f..444676034bf0 100644
> > > > --- a/drivers/bus/mhi/core/init.c
> > > > +++ b/drivers/bus/mhi/core/init.c

[...]

> > That's because, "1" was used from the beginning by the controller drivers
> > as the regular priority. And I thought of using "0" as high priority so
> > that we can leave the controller drivers unmodified.
> 
> There's no problem modifying everyone, how much work is that?
> 

I thought of minimizing the diff if we can avoid...err

> > > Shouldn't this be a boolean, or if not, an enumerated type so that
> > > people can read the code over time?
> > > 
> > 
> > Bhaumik proposed an enum but I wanted 0/1 so that the controller drivers
> > can be untouched. Also, I don't see any immediate requirement for other
> > priorities.
> > 
> > Will make it a bool then.
> 
> Rename it when you change it so that you know you catch all existing
> users.
> 

Okay. Bhaumik, can you please use the enum (as you did)?

Thanks,
Mani

> thanks,
> 
> greg k-h

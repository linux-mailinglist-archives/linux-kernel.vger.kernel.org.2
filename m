Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC263B313B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhFXO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhFXO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:27:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:24:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v13so3036669ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7v6zzISLRT7/mjVxXBDqD+HRCxTxfM4X75SVBiBJOw=;
        b=qK8PdNdlByn3qX7V+vm+XZUKw7OQ1w2eaUfw9UZ+NwdYtsJOk7tTLJd09uRgpxkpHB
         qR6go1ZwGObxHzSWBRuOeIMH2zxJypaY1ATeIbit1Ztgucla0wy+J8Y+4Fn2CzkUrnao
         VsH0YdQJsvySH4RgtwwdTlM1KnDbztcmWEGRnrj6dxu+IC+GQUhcQvJe5CC2tSJSMLqG
         GvVo0P8uNKV6WYstQ4Whf+9qhrQrJKjWqd94jcFVpqMuKJVDwvFx8PzaWDpwPruK9I96
         hchE7dqNgm6Hb4fBuTo5uNHv+OTxF/wW3ZwfcyR9dZ+K/up4UrqNlkp/9awYPNXZ2sbB
         hoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7v6zzISLRT7/mjVxXBDqD+HRCxTxfM4X75SVBiBJOw=;
        b=tf1pimkYqrkoFcG2dvkEdaEjqYZQTIaUjeaew2mQr8NK1cDqqAyDWSQpyTAJKKnlfM
         tZBX2iJnQiN8I+cLU0Ajav9QX/Iz+dKHpeMdjDMZVkyGdhjvu0X59TgBSE7Lev6Crab4
         gSjx+ih4iZ8k2VXVOU7f72SyWxC2SPDybCkDYQKTAWAHXTN/KpCPggzXT7t0J9MZcgZn
         bQYhEZsbcWNtvXYa8zr61zbZmo7ASBcDyUIP8tibeej65JpOHnd1TYJNSxlIr3sriwGX
         gyuQC9p87osk0EFbNfa3ptqRtobIXK5BL5nQI2w9YVFikLK36iICjHxVRK7gwwmARHfE
         r2Ng==
X-Gm-Message-State: AOAM530MQPossc6EtTgqYZ2b76jWYc9YsbYMYtmHiwZqcNWiFd3pde0N
        gqzdaowjhqurwnPiq6SEEz3t
X-Google-Smtp-Source: ABdhPJz2ZArOXzewLZbgfj6eFARvMM1JjkvoQ5pkMwZ4WI7/T3UW+Mmuksb5QuOpxsFKjMyu6s796Q==
X-Received: by 2002:a17:90b:3a8f:: with SMTP id om15mr5780463pjb.222.1624544697074;
        Thu, 24 Jun 2021 07:24:57 -0700 (PDT)
Received: from workstation ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id u4sm3183777pfu.27.2021.06.24.07.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jun 2021 07:24:56 -0700 (PDT)
Date:   Thu, 24 Jun 2021 19:54:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 6/8] bus: mhi: core: Add support for processing priority
 of event ring
Message-ID: <20210624142453.GB6108@workstation>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-7-manivannan.sadhasivam@linaro.org>
 <YNSOXaWt3YX3yDQC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSOXaWt3YX3yDQC@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 03:53:33PM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 09:46:14PM +0530, Manivannan Sadhasivam wrote:
> > From: Hemant Kumar <hemantk@codeaurora.org>
> > 
> > Event ring priorities are currently set to 1 and are unused.
> > Default processing priority for event rings is set to regular
> > tasklet. Controllers can choose to use high priority tasklet
> > scheduling for certain event rings critical for processing such
> > as ones transporting control information if they wish to avoid
> > system scheduling delays for those packets. In order to support
> > these use cases, allow controllers to set event ring priority to
> > high.
> > 
> > Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> > Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Link: https://lore.kernel.org/r/1624053903-24653-2-git-send-email-bbhatt@codeaurora.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/bus/mhi/core/init.c | 3 +--
> >  drivers/bus/mhi/core/main.c | 9 +++++++--
> >  include/linux/mhi.h         | 2 +-
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> > index c81b377fca8f..444676034bf0 100644
> > --- a/drivers/bus/mhi/core/init.c
> > +++ b/drivers/bus/mhi/core/init.c
> > @@ -673,8 +673,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
> >  				&mhi_cntrl->mhi_chan[mhi_event->chan];
> >  		}
> >  
> > -		/* Priority is fixed to 1 for now */
> > -		mhi_event->priority = 1;
> > +		mhi_event->priority = event_cfg->priority;
> >  
> >  		mhi_event->db_cfg.brstmode = event_cfg->mode;
> >  		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
> > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > index 8ac73f9e92a6..3775c77dec63 100644
> > --- a/drivers/bus/mhi/core/main.c
> > +++ b/drivers/bus/mhi/core/main.c
> > @@ -454,10 +454,15 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
> >  
> >  		if (mhi_dev)
> >  			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
> > -	} else {
> > -		tasklet_schedule(&mhi_event->task);
> > +
> > +		return IRQ_HANDLED;
> >  	}
> >  
> > +	if (!mhi_event->priority)
> > +		tasklet_hi_schedule(&mhi_event->task);
> > +	else
> > +		tasklet_schedule(&mhi_event->task);
> > +
> >  	return IRQ_HANDLED;
> >  }
> >  
> > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > index 86cea5256e3c..bf23c213429c 100644
> > --- a/include/linux/mhi.h
> > +++ b/include/linux/mhi.h
> > @@ -250,7 +250,7 @@ struct mhi_channel_config {
> >   * @irq_moderation_ms: Delay irq for additional events to be aggregated
> >   * @irq: IRQ associated with this ring
> >   * @channel: Dedicated channel number. U32_MAX indicates a non-dedicated ring
> > - * @priority: Priority of this ring. Use 1 for now
> > + * @priority: Processing priority of this ring. 0 is high and 1 is regular
> 
> Why is 0 high and 1 low?  Does that feel backwards?
> 

That's because, "1" was used from the beginning by the controller drivers
as the regular priority. And I thought of using "0" as high priority so
that we can leave the controller drivers unmodified.

> Shouldn't this be a boolean, or if not, an enumerated type so that
> people can read the code over time?
> 

Bhaumik proposed an enum but I wanted 0/1 so that the controller drivers
can be untouched. Also, I don't see any immediate requirement for other
priorities.

Will make it a bool then.

Thanks,
Mani

> thanks,
> 
> greg k-h

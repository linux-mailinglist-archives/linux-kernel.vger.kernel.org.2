Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCAE3839C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbhEQQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbhEQQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:27:18 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB2C0611ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:04:48 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso1528236oow.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=497j5i9PiEed0l/3m4AyWSz3JeI6UPuRLk3suVfX+FY=;
        b=UGV73mruOQI0LJ8GXx51mSQHqTN32sOoxg5qc3YVdm/rTMyr8v/f8nSSNLL1jXDwtc
         8XCJhY4+9Z4WpxTGkWh6gScNGSkGG2PXntLO7oEQH3eLN1+AdwlQPKwpvskKD0vCFlSU
         nVKSDoa2+aXZ/ukhRSmdUaXsQunXFMN+MNuZlqer/uIyyes3wd8Wp97zLzGS1e+DWJoP
         kYTSJJK0QAH+Fev9lozmlmD6FfaLDDtqpmDqza1uRtYGyUIi/7hQtc0TvyijLd6fmtIV
         k7gdtXKbuQ+MUCNfKfonxdifEF4rwIAvLmDG5w4OozJJo4D+mhFY6iHQCFGPfTWLpJvH
         46Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=497j5i9PiEed0l/3m4AyWSz3JeI6UPuRLk3suVfX+FY=;
        b=n612MNzBndzoYy9ijFHAoY0ia6B5d39BGaJ3TlfXlBySSfhReilVYTYO+zv6dFTPDl
         DbLONbYWcm6zAtWWOk+xHOp5dNc2kvznj7NIaBEy8euXXwA5do0fvCqCGGqAIX9sPy8s
         V3xG6MZlIkJvfFa9d7bRU6eqPrDL4GaZvb+g36szz2al85WymnJypsRspc61Cg9rZDJn
         IxQQ79eRjLfdLL9uw+BxfaTcQDND1PtUiQ+VkgWqoFfz325Cznxnoxqox5+bGUOaNG7D
         Uh3tb3t4DvB4KieqVHols0sKlhyER24jAAkb/382ZBE8/yPowLXGkYJKlxr6v0lr2QqR
         GT3w==
X-Gm-Message-State: AOAM5315JM+pUAfo0f+AD16nDrVYPG4jrRv5cYW6IlweNPayZkdaMkyd
        HoOCRTzHR6o41Z+ZPpFvarpXbQ==
X-Google-Smtp-Source: ABdhPJxgxVcSmpQln9qt+Rt3t/XXqzQVVr5lUHB6erbyL9OBqTYaRXCyeZEk0mpMXXW7mC6xzp97IQ==
X-Received: by 2002:a4a:d052:: with SMTP id x18mr284059oor.21.1621263888040;
        Mon, 17 May 2021 08:04:48 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f8sm3063699oos.33.2021.05.17.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:04:47 -0700 (PDT)
Date:   Mon, 17 May 2021 10:04:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix copy-paste of the container_of
Message-ID: <20210517150445.GS2484@yoga>
References: <20210516034833.621530-1-bjorn.andersson@linaro.org>
 <YKIyylBF9gxXSg/3@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKIyylBF9gxXSg/3@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 May 04:09 CDT 2021, Heikki Krogerus wrote:

> Hi,
> 
> On Sat, May 15, 2021 at 08:48:33PM -0700, Bjorn Andersson wrote:
> > Some of the boilerplate code was copy pasted from the typec_switch and
> > retained the use of the switch's container_of macros. The two structs
> > are identical in this regard, so this change doesn't cause a functional
> > change today, but could possibly cause future issues.
> > 
> > Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/usb/typec/mux.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > index 8514bec7e1b8..e4467c4c3742 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -45,7 +45,7 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
> >  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
> >  				switch_fwnode_match);
> >  
> > -	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> > +	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
> 
> That does not look correct to me?
> 

No it doesn't, you're right. I spotted the last one and it being trivial
I obviously didn't pay enough attention when just "fixing" the other two
instances of "the same".

> >  }
> >  
> >  /**
> > @@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(typec_switch_put);
> >  
> >  static void typec_switch_release(struct device *dev)
> >  {
> > -	kfree(to_typec_switch(dev));
> > +	kfree(to_typec_mux(dev));
> 
> Ditto.
> 
> >  }
> >  
> >  static const struct device_type typec_switch_dev_type = {
> > @@ -239,7 +239,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> >  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
> >  				mux_fwnode_match);
> >  
> > -	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> > +	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
> 
> That looks correct.
> 
> Either I'm missing something, or only the last change is needed.
> 

Sorry about that, I'll fix it up and repost the patch.

Regards,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6703D965B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhG1UGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhG1UGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:06:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BBC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:06:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so11816517pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOXvanqkJmFK42acZmBqNZo5yXMDDdF902WjpDqKC4A=;
        b=WnAwo5B+9Xwwuru6q9EGEhgLjvCcS6LlStfUh1WwP/Q5o3pUKz7vcGCwDWOMbHCf+y
         vwCvUj3gT/ytNsLCG8dg5cf09Qu1agFSi0hpKEXqg2yrh7+HTfbTLj0N7lTi+DwAUA+c
         wiR4zn4V2tQ14TJYRd7y2LPKBsbPk2OwmiRff/+J4AEDQGP5zEemUeX5fzPCV0DHnPEJ
         x7E6m68JxBw48tNnED7NLEn4yeWsOJrRPymcV3InL99jm6wiaqKPuC5cRewZ+ECj610+
         bTHswTQoEPjOzgkuA1cbYByHodXUmieFhfZQZTyrmxbT1QxE6ymTkLGJOmpwUyi5Rht+
         HcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOXvanqkJmFK42acZmBqNZo5yXMDDdF902WjpDqKC4A=;
        b=V4J6iOM7Z7lWn2rlFvt3SUpG/mIdBeb+OYsR085j0fQoDKxUUWkY7lwwDBui+cYtJY
         QtSGWbhDX3jJFyO6WfCdhf7Kv5C8D+bFH95rXJZuijiR9TwvllmYCvEYG1S+sLx0XllF
         81+iBqR/tFKZeVfjzGE1EpxxIizsLl0rRsQqm5kNI9ybcbHX4GDmYZls3Z/IeWIMke9/
         dYNwW/QIGy5Aziwq58m7I8njrCDzXiGpQnRqw6iPZA4y22XTgvYf+sq6bK2qpqeG2B5B
         gZa1YoUz3HXixISKyF4wPhSzsA24EXwZrxe3gVsv6Ih0AVKrTWHO7dRgMPwBalaq+eDO
         PUew==
X-Gm-Message-State: AOAM531qI5JZ9xr0d7CuWfOMMNoVqCW9FYYtTpx1b9S68KZf0vla0rA2
        pe6cUpUCzqkk7rCLZyzOgXg=
X-Google-Smtp-Source: ABdhPJxlPnIoSUgxvNTqCOCrs1RLNXp7nKQOGGNqWBmMeOHJQEVlDU7Jpe2FJKzo2NYHKr+EBZjihA==
X-Received: by 2002:a17:90a:ead4:: with SMTP id ev20mr11244312pjb.65.1627502773141;
        Wed, 28 Jul 2021 13:06:13 -0700 (PDT)
Received: from ojas ([122.161.51.5])
        by smtp.gmail.com with ESMTPSA id m11sm759503pgn.56.2021.07.28.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:06:12 -0700 (PDT)
Date:   Thu, 29 Jul 2021 01:36:07 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vchiq: Set $CONFIG_VCHIQ_CDEV to be enabled
 by default
Message-ID: <20210728200607.GB17046@ojas>
References: <cover.1627495116.git.ojaswin98@gmail.com>
 <70d91b0482e19d7551d3258ea54c970c1b996317.1627495116.git.ojaswin98@gmail.com>
 <YQGl47Wpu7+SHIW+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQGl47Wpu7+SHIW+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:45:55PM +0200, Greg KH wrote:
> On Thu, Jul 29, 2021 at 12:07:16AM +0530, Ojaswin Mujoo wrote:
> > Before this config was defined, the cdev used to be created
> > unconditionally. When an earlier commit introduced this config, the
> > default behavior was set to disabled, which might surprise some
> > unsuspecting users.  Hence, make this config default to 'Y' to be more
> > backward consistent.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> > ---
> >  drivers/staging/vc04_services/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> > index 63caa6818d37..2b70c37cdd09 100644
> > --- a/drivers/staging/vc04_services/Kconfig
> > +++ b/drivers/staging/vc04_services/Kconfig
> > @@ -23,6 +23,7 @@ if BCM2835_VCHIQ
> >  
> >  config VCHIQ_CDEV
> >  	bool "VCHIQ Character Driver"
> > +	default y
> 
> 
> default y is only if the machine will not work without this option.
> Is that the case here?  If not, then please do not have this as the
> default.
Got it Greg. 

From my testing, the Raspberry Pi does seem to boot correctly without
this although some userspace libraries might not work. 

Since the machine itself works, I guess I'll drop this patch.

Thank you!
Ojaswin
> 
> thanks,
> 
> greg k-h

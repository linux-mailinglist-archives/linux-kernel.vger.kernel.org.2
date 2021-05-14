Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01B0380C98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhENPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhENPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:13:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:12:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso1781843pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ord6fAEI5pa3vLbCAlTEL5Ixb9JiPvq2Xdqyi33y9BI=;
        b=M/sHzds9a8295wb+vFFMV/JUqeIeU+vUJS1sX4FZqx4DzvwwhQ33d1zi+htfC8NCNF
         SpnU6vs7wc0Lib+RMVXDsvOOcqPPSCIKSa8dvQ51vbMmHcRvMnf3zxMYiDNWncBSDCrC
         gDbEqu2GU6WKGM8cBv7Kb9bDoeSjggxzOjldr38mqn9u1bmnFCqdJISQT7TPkfHHSSwF
         kMBqUZkyLsyRywNb7PDwGD57V+0/SYijvWKpaPvD1VKbVyTJlPqo+19RLktqM1lVvVMs
         nHuOgsQoBW9XC+iEWpmOQuvyZ8h+PK0eGDPacAZTgNcBetPPsXCPxcZgG6+lXA7mnPcE
         3K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ord6fAEI5pa3vLbCAlTEL5Ixb9JiPvq2Xdqyi33y9BI=;
        b=WJiErm7/z9TpmJScg6TSQEV88HBURdb526pdsjI7azmlRdoq525ppluJflV0IqQLYP
         /4xBicIQ+oJFJ/BgPZATraZv9oNH/uWpkSOek+sWEkxeE8fpZFQvB4OvNNNX/MBbCTeD
         Gqxr254daMzHuxbchqlgUPTg0gsJotxX9AArJ20egNEAZjZMPXipDyXN6LgSsc31XKcC
         dc1dprcvSC8fjIx3rqSpee3A07YMAZ8zNKD8OZlUwU75PKLZGHzRwwxre4Kw/+E1yD6e
         OqKB9bQbg2pxnP8B4mnusw1L/mRIHJ0VMI2STidltBxcafAJuNsO5BB8rhfa3/Lrn6H5
         LKMw==
X-Gm-Message-State: AOAM530zaBCrAZVpbRyXx9YoKIybPEbI5PavNES0EIBqtvP+ZEVhGvk8
        KGR/DYgapeEmS9+jCp+5sVM=
X-Google-Smtp-Source: ABdhPJyWlZKIT6VersxrGK0t+xRw+CdJKziO3ciPN0f1GkGTrAmwmxwmfO9DkCNLLx05FOdUqOi9cA==
X-Received: by 2002:a17:902:e804:b029:ed:5748:9047 with SMTP id u4-20020a170902e804b02900ed57489047mr46158767plg.36.1621005142477;
        Fri, 14 May 2021 08:12:22 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id f14sm7624439pjj.53.2021.05.14.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:12:21 -0700 (PDT)
Date:   Fri, 14 May 2021 20:42:16 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ6TUAowTI75h/sl@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6Jf+Z1ReVgDt64@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 04:30:23PM +0200, Greg KH wrote:
> On Fri, May 14, 2021 at 07:53:57PM +0530, Shreyansh Chouhan wrote:
> > On Fri, May 14, 2021 at 04:05:32PM +0200, Greg KH wrote:
> > > On Fri, May 14, 2021 at 07:18:38PM +0530, Shreyansh Chouhan wrote:
> > > > On Fri, May 14, 2021 at 03:36:25PM +0200, Greg KH wrote:
> > > > > On Fri, May 14, 2021 at 07:00:39PM +0530, Shreyansh Chouhan wrote:
> > > > > > The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
> > > > > > multiline macro whose statements were not enclosed in a do while
> > > > > > loop.
> > > > > >
> > > > > > This patch adds a do while loop around the statements of the said
> > > > > > macro.
> > > > > >
> > > > > > Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/greybus/loopback.c | 10 ++++++----
> > > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > > > > > index 2471448ba42a..c88ef3e894fa 100644
> > > > > > --- a/drivers/staging/greybus/loopback.c
> > > > > > +++ b/drivers/staging/greybus/loopback.c
> > > > > > @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
> > > > > >  }									\
> > > > > >  static DEVICE_ATTR_RO(name##_avg)
> > > > > >
> > > > > > -#define gb_loopback_stats_attrs(field)				\
> > > > > > -	gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > > -	gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > > -	gb_loopback_ro_avg_attr(field)
> > > > > > +#define gb_loopback_stats_attrs(field)					\
> > > > > > +	do {								\
> > > > > > +		gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > > +		gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > > +		gb_loopback_ro_avg_attr(field);				\
> > > > > > +	} while (0)
> > > > > >
> > > > > >  #define gb_loopback_attr(field, type)					\
> > > > > >  static ssize_t field##_show(struct device *dev,				\
> > > > > > --
> > > > > > 2.31.1
> > > > > >
> > > > > >
> > > > >
> > > > > Did you test build this change?
> > > >
> > > > I built the module using make -C . M=drivers/staging/greybus to test
> > > > build it. I didn't get any errors.
> > >
> > > Really?  Can you provide the full build output for this file with your
> > > change?  I don't think you really built this file for the obvious
> > > reasons...
> >
> > I ran make -C . M=drivers/staging/greybus
> >
> > I got a three line output saying:
> > make: Entering directory '/work/linux'
> >   MODPOST drivers/staging/greybus//Module.symvers
> > make: Leaving directory '/work/linux'
> >
> > I just tried rebuilding the kernel with CONFIG_GREYBUS=m, and now I can
> > see what you are talking about. Why weren't these errors reported when I
> > ran the previous make command? Does that too check for the config
> > variables even when I specifically asked it to build a module?
>
> You were just asking it to build a subdirectory, not a specific
> individual file, and when you do that it looks at the configuration
> settings.
>

I see.

> It's always good to ensure that you actually build the files you modify
> before sending patches out.

Sorry, I googled about building a single module, and thought running
that command would have built it. Moreover, since the change was so
simple I didn't suspect anything when it got built correctly the first
time around.

I didn't look at how/where was the macro called and missed a very
obvious error. Now that I have looked at it, the only way I can think of
fixing this is changing the macro to a (inline?) function. Will
that be a desirable change?

And yes, I will definitely be more careful in the future.

>
> thanks,
>
> greg k-h

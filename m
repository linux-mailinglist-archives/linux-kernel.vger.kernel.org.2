Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE60380D44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhENPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhENPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:36:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:35:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m190so24407391pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9PHGu8ICX6Bvm2mYeN1sFRXlXnYrgx9wiY9e9NTzRA=;
        b=J47PUO/OkQ1tCchPsNPQkCRt64WXh3Kno7Kx1fXemegkRnTjjWXYMPwjful6mdjtnC
         uUjphafJqmijfpryZOdaGN6MwJjpFjCokLLT3/CyKHgI0QyMdqWUkOPO09MrJxsRdl6m
         7f9hPBmpd1fNBQttYcSLNNYZ8y0V2c32cvvnlAuI562fzxqmVgtXmLlWpCVYYK/zRU/5
         +myrKr+HmlRgPmgGoaPq7eVfrCw/gzIt90AnwOxLIiArvLELGRhjhKTbJF+EKicNl4e6
         LcchwcaBhkKzVQTY9nO9RGDMiDW6TGAckKjg9Ok2YAmfHe0bgKs3RN3DFADUks9s8AR5
         GVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9PHGu8ICX6Bvm2mYeN1sFRXlXnYrgx9wiY9e9NTzRA=;
        b=Lqbd0oym1e8VU6t/UaVVTjq7E9hykgo/47BjTSgerwJ4f69/hgGsilXIXp4tH1l9c1
         4ctE/VSVTds2zaqlAl88sfDOodZ1jkTXYJY81/t7mlzQJFz0XY2QZEfLwyH0gckq7WKd
         f6he1H6qGRW2lgo+eM+EZfG7zzGLBrKFwhmeR9lBQ9gAOevhlwT1Fwqd+uOVU3YEeQbC
         ug9ZKNJwC++R1batzus2FZ8ZJfPD8ojYwfkrNGRDHwnWDs3HXSebKfaOkwUoTSWVB9xU
         RfaFixPngBXiuQgjTuwvUq+5BKaXdUZ1l1hSUAKGjPq9Vk+m65mFX5CD45+6NbS43j4g
         nqdQ==
X-Gm-Message-State: AOAM533ljew0T2o+R0ZbAvGlkZKVXgvG3Om1gDUT/KragUw4TWOSfOV7
        c4Sg0EwPUK9tXP5ldkZ6gJtDgxYtDmy0e24Q
X-Google-Smtp-Source: ABdhPJwSW4vXEaS7uZcsalnr3Z17EqZyvHlcPX17NF5gUCEe3OElod6FIMluCdazJmbiX7N2tzWC1g==
X-Received: by 2002:a05:6a00:1384:b029:2c7:fcda:8d83 with SMTP id t4-20020a056a001384b02902c7fcda8d83mr21348365pfg.0.1621006500095;
        Fri, 14 May 2021 08:35:00 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id a190sm4057600pfb.185.2021.05.14.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:34:59 -0700 (PDT)
Date:   Fri, 14 May 2021 21:04:54 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ6YnhBYGrTJ3lhe@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
 <YJ6TUAowTI75h/sl@fedora>
 <YJ6XpUMliWQOS8MB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6XpUMliWQOS8MB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 05:30:45PM +0200, Greg KH wrote:
> On Fri, May 14, 2021 at 08:42:16PM +0530, Shreyansh Chouhan wrote:
> > On Fri, May 14, 2021 at 04:30:23PM +0200, Greg KH wrote:
> > > On Fri, May 14, 2021 at 07:53:57PM +0530, Shreyansh Chouhan wrote:
> > > > On Fri, May 14, 2021 at 04:05:32PM +0200, Greg KH wrote:
> > > > > On Fri, May 14, 2021 at 07:18:38PM +0530, Shreyansh Chouhan wrote:
> > > > > > On Fri, May 14, 2021 at 03:36:25PM +0200, Greg KH wrote:
> > > > > > > On Fri, May 14, 2021 at 07:00:39PM +0530, Shreyansh Chouhan wrote:
> > > > > > > > The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
> > > > > > > > multiline macro whose statements were not enclosed in a do while
> > > > > > > > loop.
> > > > > > > >
> > > > > > > > This patch adds a do while loop around the statements of the said
> > > > > > > > macro.
> > > > > > > >
> > > > > > > > Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/staging/greybus/loopback.c | 10 ++++++----
> > > > > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > > > > > > > index 2471448ba42a..c88ef3e894fa 100644
> > > > > > > > --- a/drivers/staging/greybus/loopback.c
> > > > > > > > +++ b/drivers/staging/greybus/loopback.c
> > > > > > > > @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
> > > > > > > >  }									\
> > > > > > > >  static DEVICE_ATTR_RO(name##_avg)
> > > > > > > >
> > > > > > > > -#define gb_loopback_stats_attrs(field)				\
> > > > > > > > -	gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > > > > -	gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > > > > -	gb_loopback_ro_avg_attr(field)
> > > > > > > > +#define gb_loopback_stats_attrs(field)					\
> > > > > > > > +	do {								\
> > > > > > > > +		gb_loopback_ro_stats_attr(field, min, u);		\
> > > > > > > > +		gb_loopback_ro_stats_attr(field, max, u);		\
> > > > > > > > +		gb_loopback_ro_avg_attr(field);				\
> > > > > > > > +	} while (0)
> > > > > > > >
> > > > > > > >  #define gb_loopback_attr(field, type)					\
> > > > > > > >  static ssize_t field##_show(struct device *dev,				\
> > > > > > > > --
> > > > > > > > 2.31.1
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Did you test build this change?
> > > > > >
> > > > > > I built the module using make -C . M=drivers/staging/greybus to test
> > > > > > build it. I didn't get any errors.
> > > > >
> > > > > Really?  Can you provide the full build output for this file with your
> > > > > change?  I don't think you really built this file for the obvious
> > > > > reasons...
> > > >
> > > > I ran make -C . M=drivers/staging/greybus
> > > >
> > > > I got a three line output saying:
> > > > make: Entering directory '/work/linux'
> > > >   MODPOST drivers/staging/greybus//Module.symvers
> > > > make: Leaving directory '/work/linux'
> > > >
> > > > I just tried rebuilding the kernel with CONFIG_GREYBUS=m, and now I can
> > > > see what you are talking about. Why weren't these errors reported when I
> > > > ran the previous make command? Does that too check for the config
> > > > variables even when I specifically asked it to build a module?
> > >
> > > You were just asking it to build a subdirectory, not a specific
> > > individual file, and when you do that it looks at the configuration
> > > settings.
> > >
> > 
> > I see.
> > 
> > > It's always good to ensure that you actually build the files you modify
> > > before sending patches out.
> > 
> > Sorry, I googled about building a single module, and thought running
> > that command would have built it. Moreover, since the change was so
> > simple I didn't suspect anything when it got built correctly the first
> > time around.
> > 
> > I didn't look at how/where was the macro called and missed a very
> > obvious error. Now that I have looked at it, the only way I can think of
> > fixing this is changing the macro to a (inline?) function. Will
> > that be a desirable change?
> 
> No, it can't be a function, the code is fine as-is, checkpatch is just a
> perl script and does not always know what needs to be done.
> 

I see. Thanks a lot for answering my queries.

Also sorry for the noise.

> thanks,
> 
> greg k-h

Regards,
Shreyansh Chouhan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470C33DA632
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhG2OVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhG2OVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:21:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F20C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:20:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m1so10554703pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1MJS4je1Oiq7mhlbgvshdM+wBGyXHC/8oJzd/GZ1Bg=;
        b=Ow6fkhcPEh5V54oLfWWwMO7N3w8hOXvUHnRCEDo6zEciRgrCaJsWFsAcGnHwmh2vzD
         FPMisuZ3FNXTf1ixYZPueZXd8SlW0Sz5U+WAicNuv3cCxFOuib10hY1RfAbe25NVplGQ
         cFbNTcFvibLllrPwkX1NyOUGsfubqOt4JDVkl6QEMBEexnkifJfcBERFxqsXLxDQlC6C
         sWvxUebaqrJx4zyMhNnHramYFQuvyDG0DUp+CZ8TnJsj2WONURIPg4QNHM4xLMgwjz4d
         aQIxu9xpzTPCVDDZQL0Apsap6Nh+R7+Z0NH4Xj2u0w2G5KRLYVz10F7gqa8OYyYtCME9
         Ig2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1MJS4je1Oiq7mhlbgvshdM+wBGyXHC/8oJzd/GZ1Bg=;
        b=cTW6uqA7U5SQoJDi92dYGYnNh0A67WrSRvpoATz264ks+BEwrXyzijdoPdScPvfy46
         RD+hRQMw281usLa3L1W+AH2a47X+wJfdpb9NNLhP/O9aFjzO8+yxkaxnQ5IqFGE+eZnK
         xEQkjfZXblNC2vDthM6pxg1wYlU6PoEZgS0v0hM746XyZqoUPAH5DhaOi0XtXKq8A0SG
         56hUa8HYJIllwsLMjdk4oxdBmMmZcPrXxCHGyjL01/RTU7yv77ccUIwCqLQwLimGse8j
         5p7g8W8t9gInYsURblJ6EbzFNpLIr3mLFYxI/YCSD6K5IJxYkrwWIFzJUcioDMTFm9sk
         vs3w==
X-Gm-Message-State: AOAM530Pz0HEUpZWFODQVaOU/HpAVKVaWUkLY5E2gtZvRVOFjYDtXUwC
        KidpNP+VXAB3Rhyyd5iZzWs=
X-Google-Smtp-Source: ABdhPJwJqoUiFy7YXuGI7xJHhZ4oqQidNFSSfrsgUMREpiAhvQS66r555cMNOfkEqZZH73MivZZI6w==
X-Received: by 2002:a17:902:a9c3:b029:12c:31c7:9b81 with SMTP id b3-20020a170902a9c3b029012c31c79b81mr4901232plr.30.1627568456660;
        Thu, 29 Jul 2021 07:20:56 -0700 (PDT)
Received: from ojas ([122.161.51.5])
        by smtp.gmail.com with ESMTPSA id p3sm4091663pgi.20.2021.07.29.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:20:56 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:50:43 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, nsaenz@kernel.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vchiq: Set $CONFIG_VCHIQ_CDEV to be enabled
 by default
Message-ID: <20210729142043.GA25192@ojas>
References: <cover.1627495116.git.ojaswin98@gmail.com>
 <70d91b0482e19d7551d3258ea54c970c1b996317.1627495116.git.ojaswin98@gmail.com>
 <YQGl47Wpu7+SHIW+@kroah.com>
 <20210728200607.GB17046@ojas>
 <ddcc0ba2-edc0-89a9-b20d-ce58b3e548fc@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcc0ba2-edc0-89a9-b20d-ce58b3e548fc@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:21:41PM +0200, Stefan Wahren wrote:
> Am 28.07.21 um 22:06 schrieb Ojaswin Mujoo:
> > On Wed, Jul 28, 2021 at 08:45:55PM +0200, Greg KH wrote:
> >> On Thu, Jul 29, 2021 at 12:07:16AM +0530, Ojaswin Mujoo wrote:
> >>> Before this config was defined, the cdev used to be created
> >>> unconditionally. When an earlier commit introduced this config, the
> >>> default behavior was set to disabled, which might surprise some
> >>> unsuspecting users.  Hence, make this config default to 'Y' to be more
> >>> backward consistent.
> >>>
> >>> Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> >>> ---
> >>>  drivers/staging/vc04_services/Kconfig | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> >>> index 63caa6818d37..2b70c37cdd09 100644
> >>> --- a/drivers/staging/vc04_services/Kconfig
> >>> +++ b/drivers/staging/vc04_services/Kconfig
> >>> @@ -23,6 +23,7 @@ if BCM2835_VCHIQ
> >>>  
> >>>  config VCHIQ_CDEV
> >>>  	bool "VCHIQ Character Driver"
> >>> +	default y
> >>
> >> default y is only if the machine will not work without this option.
> >> Is that the case here?  If not, then please do not have this as the
> >> default.
> > Got it Greg. 
> >
> > From my testing, the Raspberry Pi does seem to boot correctly without
> > this although some userspace libraries might not work. 
> >
> > Since the machine itself works, I guess I'll drop this patch.
> 
> The idea is good, but the patch needs improvement :)
> 
> Acceptable solution might be that BCM2835_VCHIQ selects VCHIQ_CDEV.
Thanks for the suggestion, Stefan. 

So on testing with select, it seems like select defines a hard reverse
dependency i.e if BCM2835_VCHIQ=y then VCHIQ_CDEV=y and it can't be set
to n.

Checking the Kconfig launguae doc, I found that we could use "imply" to
define weak reverse dependencies, such that BCM2835_VCHIQ=y auto selects
VCHIQ_CDEV=y but we can also change it back to n if required. I tested
this out and it seems to work fine. I believe we can se imply here as it
better suits the use case.

Thank you,
Ojaswin
> 
> >
> > Thank you!
> > Ojaswin
> >> thanks,
> >>
> >> greg k-h
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

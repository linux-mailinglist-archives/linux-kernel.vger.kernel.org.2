Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4841DF89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352358AbhI3QvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352228AbhI3QvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:51:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1ECC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:49:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t4so4499520plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2I7JkxI5MtVO/SyPk3TCAjamGg2Qcc2s2nk2OwgS+3M=;
        b=ngwDdmByPwIgkkXgFt4PuFRkQs+EX+S4DN8pih1MtZr0R+zQ2oYxwEhx9xLBVrV1g7
         ooSCyl3JWt1hC16qYly/ZhJFHKvMMif/udNuIgtJGabd4OXnCbaZ0+4I0ryizbkVLY/h
         5bso0MtXrSg1ZVkgO2mynN3ZPQRQP0dW0+kL2pwbtxajoGLB5cTjPpjN33Mzg/MixN3v
         tRsxOjnm+gJCuCFyaolzbaEHhlOU+WWdi7x5/GzUjoVFsYFz/KWM1iobnYnxecJuzMAi
         7QBPr5I6asPaThNLRPjDnDkwmYfMLjLOJoVj4vzFI3t4c8dTORPwU2M/Ar4lt0OMlpWF
         7wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2I7JkxI5MtVO/SyPk3TCAjamGg2Qcc2s2nk2OwgS+3M=;
        b=svOww2iVO/1NJddgHMbigpyK2K7A/wNwXP8lznAhUWOh5grqiSyRQvO+5/+iXSbkJv
         va3v043DZwUFPztwMp971VZ0+AleqJy7JCUodoXGzqvkw9OBGiGt5dx3VZRXtwEXpaqO
         c6OmsELfe1CJylbzoO0XtM95BB5bW5DaxaxraLL/iBrn8bMcCD8vzTDvKkrinXO1jRig
         qSKjQjezR3+w9UywCl9S3vYeW0cTdH5CsVivNquFJ+A/EyuFZ4myInTLSA/ndMrrYgpc
         3xCDqEbCYF/+aUuu6G+L8twhi1A5SDgou+HURI7Ujgsoch+CglAHqE4cy3Fq85cpMw44
         VvzA==
X-Gm-Message-State: AOAM530wiazRZ/yXPeAWUuJlePcwqvKfSE/oYJcmMpv7r7/U4IrRlNGV
        4Fjjf9eizb5ed14FIVo98rOlahV87o8=
X-Google-Smtp-Source: ABdhPJw9f0dIAgX81zXwy3xIgo0j+HskjqhZyObvNTVqJ5QhNKZFIf8DsBaSOscyvMaaR8VD4NnGUg==
X-Received: by 2002:a17:90b:946:: with SMTP id dw6mr7680100pjb.41.1633020557621;
        Thu, 30 Sep 2021 09:49:17 -0700 (PDT)
Received: from ojas ([122.161.49.24])
        by smtp.gmail.com with ESMTPSA id y3sm3728261pfr.140.2021.09.30.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:49:17 -0700 (PDT)
Date:   Thu, 30 Sep 2021 22:19:11 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq: Update TODO file
Message-ID: <20210930164911.GA4746@ojas>
References: <20210927181323.10931-1-ojaswin98@gmail.com>
 <YVK/9AIRQ5yzxpzb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVK/9AIRQ5yzxpzb@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:10:44AM +0200, Greg KH wrote:
> On Mon, Sep 27, 2021 at 11:43:23PM +0530, Ojaswin Mujoo wrote:
> > Remove completed tasks from TODO and add some relevant details to task
> > 14.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> > ---
> >  drivers/staging/vc04_services/interface/TODO | 43 ++++----------------
> >  1 file changed, 7 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
> > index 39810ce017cd..5a6b3fc2663a 100644
> > --- a/drivers/staging/vc04_services/interface/TODO
> > +++ b/drivers/staging/vc04_services/interface/TODO
> > @@ -16,23 +16,6 @@ some of the ones we want:
> >    to manage these buffers as dmabufs so that we can zero-copy import
> >    camera images into vc4 for rendering/display.
> >  
> > -2) Garbage-collect unused code
> > -
> > -One of the reasons this driver wasn't upstreamed previously was that
> > -there's a lot code that got built that's probably unnecessary these
> > -days.  Once we have the set of VCHI-using drivers we want in tree, we
> > -should be able to do a sweep of the code to see what's left that's
> > -unused.
> > -
> > -3) Make driver more portable
> > -
> > -Building this driver with arm/multi_v7_defconfig or arm64/defconfig
> > -leads to data corruption during the following command:
> > -
> > -  vchiq_test -f 1
> > -
> > -This should be fixed.
> > -
> >  4) Fix kernel module support
Hi Greg,
> 
> Now the numbering is out of order?
It was already out of order (No point 11). I assumed it was so that references to the
tasks nos in discussion that took place before this patch will make sense.
> 
> How about a first patch to remove the numbering and just replace it with
> a list of items that are not numbered, and then remove the tasks that
> are already done?
Sure I can do that.

Thanks for the review.
ojaswin
> 
> thanks,
> 
> greg k-h

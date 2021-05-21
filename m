Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD038C191
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhEUIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhEUIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:20:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:17:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y14so18056768wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jdABYnMZGkgeB+5iHaRfg/8FA1WJ/QjBj3/r591woE4=;
        b=GVEuqrZtG2fRv0UbDERCnhXIqsgeD+bjv+/Cmq78Bx0w8IrIyqvBFjhRtE8flRllPs
         t9ly/QUL8z+MR9OjFFyhLE12DCZsGj/xYvu7z8+EnS8/09qdleR1DH4DfbUaCP1D9fYZ
         /KLITDMo3AEurNvnzJDwNABeYPmzYlw2iVLHuc21B4rbFXI7P9lURt0T3l4P++wk2cpa
         NxIAq9FBK7iYM6LSZmvvh1yYlr0i0+S7gVvr5FA2QvL5tDn9lh8XpFtGR3ZxzFUYG3xF
         b56PtbnqgSTV+OStQnm5dAjFdddNslFXj0VIIq/Gj0A6WXKjCRkupcJZVBn6uP9spcul
         xhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jdABYnMZGkgeB+5iHaRfg/8FA1WJ/QjBj3/r591woE4=;
        b=kDqhx9+qytWy0SI64RYh6BWtzNsW6FGtCBo1DMmIIZG+P2I66gaGCr22/DRsqzQGyo
         nquTtZjAcrVRz9wO18SEuP8UZ5JXmYxh4CSLCfavAjBfbcIKYfJJYoRZ4UKn257oqHCI
         l6dSegvTTQMVpeA2gwG77O+UgtMFBbb+FC4Qjps+vL4Xmw20O4jhl67/f4p80X14MpqR
         vTK7/kZwHXRFChZK6TEfLJYwRP8V5npXG345y1KM8ObkGRTIaFPToVukLKWT/7Jm4n8y
         IwT8/MdlxKy+ugfaqfOLLvvGXcpLlB6gUg7rmPbgo2Vb3lwRUV/VMeS4sb0yzqSjU9FR
         pHIA==
X-Gm-Message-State: AOAM531LiAvVvtuPQURTWHs0/fzEOlE6t1Xo36q3HQ0hlGMzbA2R7RkD
        Frm4SS3jLVnzP6yl2j14QrVqiQ==
X-Google-Smtp-Source: ABdhPJwSTJRxhRvwqqNfLgwzZAGb7Y/OqMhJXJvLa0/rlJt289PPRhkCboovQHDRJ5lNEvdBy9hSbg==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr8180056wrt.197.1621585051546;
        Fri, 21 May 2021 01:17:31 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s83sm5265147wms.16.2021.05.21.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:17:31 -0700 (PDT)
Date:   Fri, 21 May 2021 09:17:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        paulkf@microgate.com
Subject: Re: [PATCH 05/16] char: pcmcia: synclink_cs: Fix a bunch of
 kernel-doc issues
Message-ID: <20210521081729.GC2549456@dell>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <20210520121347.3467794-6-lee.jones@linaro.org>
 <YKdqxYsVineUqqFf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKdqxYsVineUqqFf@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Greg Kroah-Hartman wrote:

> On Thu, May 20, 2021 at 01:13:36PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'dev' not described in 'hdlcdev_ioctl'
> >  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'ifr' not described in 'hdlcdev_ioctl'
> >  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'cmd' not described in 'hdlcdev_ioctl'
> >  drivers/char/pcmcia/synclink_cs.c:4068: warning: expecting prototype for called by network layer to process IOCTL call to network device(). Prototype was for hdlcdev_ioctl() instead
> >  drivers/char/pcmcia/synclink_cs.c:4173: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: paulkf@microgate.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/char/pcmcia/synclink_cs.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> > index 4a1e63911b279..b004abac61542 100644
> > --- a/drivers/char/pcmcia/synclink_cs.c
> > +++ b/drivers/char/pcmcia/synclink_cs.c
> > @@ -4054,11 +4054,12 @@ static int hdlcdev_close(struct net_device *dev)
> >  }
> >  
> >  /**
> > - * called by network layer to process IOCTL call to network device
> > + * hdlcdev_ioctl() - called by network layer to process IOCTL call
> > + *                   to network device
> >   *
> > - * dev  pointer to network device structure
> > - * ifr  pointer to network interface request structure
> > - * cmd  IOCTL command code
> > + * @dev:  pointer to network device structure
> > + * @ifr:  pointer to network interface request structure
> > + * @cmd:  IOCTL command code
> >   *
> >   * returns 0 if success, otherwise error code
> >   */
> > @@ -4165,7 +4166,8 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> >   * hdlcdev_tx_timeout() - called by network layer when transmit timeout
> >   *                        is detected
> >   *
> > - * @dev:  pointer to network device structure
> > + * @dev:      pointer to network device structure
> > + * @txqueue:  unused
> >   */
> >  static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >  {
> 
> This one did not apply to my tree :(

It's based on yesterday's -next.

I'll re-rebase any that are left.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

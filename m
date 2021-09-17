Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185E140FAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhIQPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234100AbhIQPBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C24A61152;
        Fri, 17 Sep 2021 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631890781;
        bh=rq5PzzOFrHc1KmZbpfwmO28EQTpCplOWgu2k+YD6F2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQMPxkOlrYV3w3JYoSW8GwBTyJWFb9LDCmO6dqqZuDHL7nK0Qo2H98Q+guMMC6ajn
         mJvSydvevM94/V3NTg4K8u0QQwrFjPtztMS2QWoq3zmxoGHVIrGLW3jDv365X/buKQ
         EJ0k0lZSvcn8Int5p8vXuEbAx55k2BIdwWR7/sio=
Date:   Fri, 17 Sep 2021 16:59:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Srivathsa Dara <srivathsa729.8@gmail.com>
Subject: Re: [PATCH] staging: wfx: sta: Fix 'else' coding style warning
Message-ID: <YUStWq5jGgIh0rfx@kroah.com>
References: <20210914143107.18436-1-srivathsa729.8@gmail.com>
 <3459215.8gJYjjsDaa@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3459215.8gJYjjsDaa@pc-42>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 04:33:50PM +0200, Jérôme Pouiller wrote:
> Hello Srivathsa,
> 
> Thank for your suggestion. However ...
> 
> On Tuesday 14 September 2021 16:31:06 CEST Srivathsa Dara wrote:
> > Fix 'else is not generally useful after a break or return' checkpatch
> > warning
> > 
> > Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
> > ---
> >  drivers/staging/wfx/sta.c | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> > index aceb18a1f54b..23c0425e3929 100644
> > --- a/drivers/staging/wfx/sta.c
> > +++ b/drivers/staging/wfx/sta.c
> > @@ -169,19 +169,18 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
> >                         if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
> >                                 dev_info(wvif->wdev->dev, "ignoring requested PS mode");
> >                         return -1;
> > -               } else {
> > -                       /* It is necessary to enable PS if channels
> > -                        * are different.
> > -                        */
> > -                       if (enable_ps)
> > -                               *enable_ps = true;
> > -                       if (wvif->wdev->force_ps_timeout > -1)
> > -                               return wvif->wdev->force_ps_timeout;
> > -                       else if (wfx_api_older_than(wvif->wdev, 3, 2))
> > -                               return 0;
> > -                       else
> > -                               return 30;
> >                 }
> > +               /* It is necessary to enable PS if channels
> > +                * are different.
> > +                */
> > +               if (enable_ps)
> > +                       *enable_ps = true;
> > +               if (wvif->wdev->force_ps_timeout > -1)
> > +                       return wvif->wdev->force_ps_timeout;
> > +               else if (wfx_api_older_than(wvif->wdev, 3, 2))
> > +                       return 0;
> > +               else
> > +                       return 30;
> 
> I am not a big fan of blindly applying the hints from checkpatch. With
> this patch, it seems that the code in the "if" branch is an exception
> and the rest of the code is the general case.
> 
> But, it is not true. There are two cases, and the author (me in fact)
> attended to express that that by using a "else" statement.

But that first part of the if statement returns, making the second part
not needed to be indented at all as the code flow just moves on here.

It's best not to indent if not needed, and it's not needed here as
the tools are saying.  So I've applied this.

thanks,

greg k-h


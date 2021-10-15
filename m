Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07F42FA80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbhJORth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhJORtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:49:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A5C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:47:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g25so27665742wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BK7npsUFAIp6FKMHAOrHdT/9NsQ/1+JS0jeDwR1u3YU=;
        b=1s4jH8l+/YtfwuznlhoYBXPwIBYapddXopzH4JdXmJWWljTmJrTxqf4CuFIY5nOUcU
         wik4dZ1HoOUZmZOSRS4AovDuSbh9h0N0OXq/q4S9+eUBhRmNHnkrxiAXJqzVhUXRD7t5
         cHBp7uLugfWpaWj7i0TUeTp3kkE87fqnsxB820wW3G4S6Ns30YeDiPyerXQTFas+yaGs
         WUsPVfnH2B4QfKuNHVUIIpqFZJvXd41l31kHsPqoHH/5jTKFAq4mQ0d8RZ6Z6Q3YqtSR
         AOHxd25dp40zKL7y9AeAZfPSvsgNG6mIqUtI1p1mpaiPLDzduMf6SMaM9nzPKJP0G5J0
         xhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BK7npsUFAIp6FKMHAOrHdT/9NsQ/1+JS0jeDwR1u3YU=;
        b=ivXqEx9TldZdyH5CVe6XSQqVcblUpalVQ1Xt6P/oXVkXShMDopRinAc6EWLgmRfOzz
         oaBao6HIDg5hEkDs/MnP3IuGicmmn41E8hhTVA2PtnWJAJJ9YRkNGuHFCMOOrgpeAeKE
         vjigdW2cDWja2+Xnif6K0CxwyaenF09ddq+zDWKf2yWFQ0spEZ8szL3w38mZ6OXEXCBI
         6qGxQk/s1Hg5MuT5SH8HiWSi1Guomw49oW/JRVRqFce1tzdD5JUyqi1Yx4YCU0WhmFPw
         M2GrE4kNUlWf3hyKx3gP/z1rXVpARO84yzKeA4/ll7BodokkuZGVLletpe6VoO7Eyusi
         YJcw==
X-Gm-Message-State: AOAM5303uW6ZIy/LSmbVPfafiTHL9goVJx5JldglGeOL0UONTNbqT/L+
        Xm+W/vS4L963OAhj4Wup2xg6xg==
X-Google-Smtp-Source: ABdhPJw3D/2ovofi7SdVKSgyw3JUGeq1FSg0F9N93MOkgDpgR8PSlenC68jwceDCTTzy7C2dJ1A+GA==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr16382641wrr.106.1634320048313;
        Fri, 15 Oct 2021 10:47:28 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l13sm5446539wrn.79.2021.10.15.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:47:27 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:47:26 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove MSG_88E calls from
 hal/usb_halinit.c
Message-ID: <YWm+rug27J7fGSEI@equinox>
References: <20211015000233.842-1-phil@philpotter.co.uk>
 <20211015083211.ngbgtmhkh3lh5kzj@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015083211.ngbgtmhkh3lh5kzj@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:32:11AM +0200, Martin Kaiser wrote:
> Thus wrote Phillip Potter (phil@philpotter.co.uk):
> 
> > Remove both MSG_88E calls from hal/usb_halinit.c, as these calls serve
> > no purpose other than to print the name of the function they are in
> > (_ReadAdapterInfo8188EU) on entry and on exit, with a timing of the
> > function, which is better accomplished by other means. Also remove
> > the jiffies assignment at the start of the function, as it is no
> > longer used.
> 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
> >  1 file changed, 6 deletions(-)
> 
> > diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> > index f6db5b05e6e7..abbd107ad3c1 100644
> > --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> > +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> > @@ -1073,15 +1073,9 @@ static void _ReadRFType(struct adapter *Adapter)
> 
> >  static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
> >  {
> > -	u32 start = jiffies;
> > -
> > -	MSG_88E("====> %s\n", __func__);
> > -
> >  	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
> >  	_ReadPROMContent(Adapter);
> 
> > -	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
> > -
> >  	return _SUCCESS;
> >  }
> 
> Makes sense to me. We should get rid of the prints that show only the
> function name.
> 
> Acked-by: Martin Kaiser <martin@kaiser.cx>

Dear Martin,

Many thanks for the Acked-by :-)

Regards,
Phil

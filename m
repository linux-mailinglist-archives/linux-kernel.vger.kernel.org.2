Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB33FA76C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhH1Tsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhH1Tsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:48:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:47:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f2so17971618ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PFEOUXTdeWHo2sN4esZdY6SR6YfyyU39CPfbRl+Qd6c=;
        b=fsANJW0RRNCAG7UpF9B/3bsseWnuiA4kx2isHVMKHRp6cyWMhdYSh2pBHfXELdFg2F
         VUwlQrTlc9BnQyfgD0KXJ0tgUG+aa0PvN0SrUnHccPFbNJn2Y0w/T5qUVJMgoCRAQSvB
         qxn1GAbDctX4pgmuYkkP0Ugt/YdjU+vrLRDtXIhhBthLjrotDNqJ/E+6YjIJ9LbT4GtS
         ZF+146nd6svEgsmcX738kIWegkSokFubF08fCy3sL6kKZ+SoSlI+wM4lSLWVLyGsoPj2
         wUGXC8GCZp3s1QYObtnEXhMGiehtR2rKNSsMI8WAFX89VC2YQ9wh2AJrdeE/k7VDwMaa
         K0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PFEOUXTdeWHo2sN4esZdY6SR6YfyyU39CPfbRl+Qd6c=;
        b=VtVNYbaLo4SyJUYk+i6OWD/RvW+moBmEoSOTb0825G/U22YghJRagjArIa+OLR6wVs
         9AEDMgDStBfgUHjp6tD5BmqnBiFQ0g98iBP7+mdzCfCk24F67fVTb9bgzmVgqk0nBI/o
         IpZ5rub9BBvzYuoKSk/vse1YZ3ckX9AF8VLI0ctcHc4mh3Pk/QLDsRW4sVxnEHNeVhgy
         wKGnCG4CHPKqbXFxXTOCtIc60wRGCtMn15jszJ8F+dXm0sMedLuNcJJZTxF+tNlCu5gb
         yDoEAQb/MpioxeMiTI7O7/is/8eru4KrFgmE4NbykwWKVnNZgTQofZ5u++EM2Gt+DeT6
         Pqug==
X-Gm-Message-State: AOAM530FVVO2DWWL6PXb5H7Qphz5vZSg8eFKT2OnpIk0yeljA72by8yi
        p/lmS3MVi0DTH1yia8mT19Q=
X-Google-Smtp-Source: ABdhPJzL9U7CN0DQZtSnui5dUfG88tUwIQrRYCHIWC20DwlQ527cFUnFPtC2RI28HdNNGS50KgulCQ==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr13667502lji.296.1630180057822;
        Sat, 28 Aug 2021 12:47:37 -0700 (PDT)
Received: from kari-VirtualBox (87-95-21-3.bb.dnainternet.fi. [87.95.21.3])
        by smtp.gmail.com with ESMTPSA id k3sm941166lfj.129.2021.08.28.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 12:47:37 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:47:34 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Michael Straube <straube.linux@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove null check before vfree
Message-ID: <20210828194734.7xn3tkdh2yay5yyt@kari-VirtualBox>
References: <YSp4UP1+HrhmDA3C@user>
 <1e31610a-0324-dfb7-abe5-f05d652d461d@gmail.com>
 <b098cbe9-1cc6-d97f-e1d8-df6c99b0afa0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b098cbe9-1cc6-d97f-e1d8-df6c99b0afa0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 09:30:14PM +0200, Michael Straube wrote:
> On 8/28/21 21:20, Michael Straube wrote:
> > On 8/28/21 19:54, Saurav Girepunje wrote:
> > > Remove NULL check. NULL check before freeing function is not needed.
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > >   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > > b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > > index f6dffed53a60..4726771a8403 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > > @@ -155,9 +155,7 @@ u32    _rtw_free_sta_priv(struct    sta_priv
> > > *pstapriv)
> > >           spin_unlock_bh(&pstapriv->sta_hash_lock);
> > >           /*===============================*/
> > > 
> > > -        if (pstapriv->pallocated_stainfo_buf)
> > > -            vfree(pstapriv->pallocated_stainfo_buf);
> > > -        }
> > > +        vfree(pstapriv->pallocated_stainfo_buf);
> > > 
> > >       return _SUCCESS;
> > >   }
> > > -- 
> > > 2.32.0
> > > 
> > 
> > Acked-by: Michael Straube <straube.linux@gmail.com>
> > 
> > Thanks,
> > Michael
> 
> Whoops, I missed that you removed the } that belongs to the enclosing if
> block. Probably because it is not properly indented in the original
> code.

Easy to miss because that bracket is in wrong place in first place.

Michael can you now on even build test before sending. Thanks.

> 
> Best regards,
> Michael
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948313125A0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:56:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12ABC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 07:55:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a1so14263889wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0E1VUN8G/OPIL1C7pz+2prddbYXUwAAZ8Arf/5v2Sxo=;
        b=vMIUTrFeLDoel4sVmTIRApRDmZ71M9NOPckidtV0kQbsa60TgeTCVTP8+XvKf08J6Z
         Mxh53Ju1lQdKCn4nWaZLEydKj48A5gHf5PtYCvlNrx61KQiBT3RmvhNap8ojPXulH/Tf
         DdJhmN6iTPpO2IvNA4rmklBUAXIShDF1a7hUawi5296M1mdkA9bEB5WjarZMjypG7aTU
         fg9UeG0vJcbSb1aoo79GEtPDQyhcsKxuX37k7EuMOXYudkm6O9ZiCRlyW/cQlntNPmeP
         fs/jufmlq2CigjQs8FVfdVyso5CkvKHWK5zlPzqwr3cAF7wCANsrwz3nMIQ99idM4q2q
         zilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0E1VUN8G/OPIL1C7pz+2prddbYXUwAAZ8Arf/5v2Sxo=;
        b=W1D0Bff9mLxYxS+wkF6yPtei4JuBC2iZYUa8S7+IZbutRFnPn9pWrTTDKRS91pA3wQ
         cvyaNoGoUqFWrxQTuqNboPU++0h18t8zeygt7BZI7Oh+3wg9GQbv0v6qQHAI9tvQ6vuH
         AKDKs7Xx71nPWQVwu8C+4ivrZlK36F+/hdmqD60r3QqJiWu/lSxqCv+PUWgQKcISYhEU
         Vb3++u9JUqCEerMJUPOAeNpd6E9+fVbNFqGcOEj4qiDGF3v0l+ATVMGc04efDBAGwBaL
         Cws8cDFt4xNfll2jrnZHLUyiWLL+dPgjkbS1BJH99MHwjUqn8tNAxQS5J7MPcsWyf7pD
         Mx4A==
X-Gm-Message-State: AOAM5318S4T6O6dc2aMoVTfH6JfHRy/VNTw7mlQygG4Tg1yp3PMido7/
        RBvh5NQBNTE+LgxPc2Op5dHxOg==
X-Google-Smtp-Source: ABdhPJy43Jj0B/tlzcEUCDcxCpP7sINP1pKCjAj6i62s7+2H6KawmrPgkJAyS7WePYeNO+DZOYUakw==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr15606807wrw.216.1612713354515;
        Sun, 07 Feb 2021 07:55:54 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id o12sm22696042wrx.82.2021.02.07.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:55:52 -0800 (PST)
Date:   Sun, 7 Feb 2021 15:55:50 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.sverdlin@nokia.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH v2] staging: octeon: convert all uses of strlcpy to
 strscpy in ethernet-mdio.c
Message-ID: <20210207155550.GA88784@kernelvm>
References: <20210207151320.88696-1-phil@philpotter.co.uk>
 <YCAIqrpLLBxZh+47@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAIqrpLLBxZh+47@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 04:35:06PM +0100, Greg KH wrote:
> On Sun, Feb 07, 2021 at 03:13:20PM +0000, Phillip Potter wrote:
> > Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
> > to strscpy calls. As return values were not checked for these three
> > calls before, change should be safe as functionality is equivalent.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> > 
> > v2: Modified changelog to take account of feedback from Greg KH.
> > 
> >  drivers/staging/octeon/ethernet-mdio.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
> > index b0fd083a5bf2..b3049108edc4 100644
> > --- a/drivers/staging/octeon/ethernet-mdio.c
> > +++ b/drivers/staging/octeon/ethernet-mdio.c
> > @@ -21,9 +21,9 @@
> >  static void cvm_oct_get_drvinfo(struct net_device *dev,
> >  				struct ethtool_drvinfo *info)
> >  {
> > -	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> > -	strlcpy(info->version, UTS_RELEASE, sizeof(info->version));
> > -	strlcpy(info->bus_info, "Builtin", sizeof(info->bus_info));
> > +	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> > +	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
> > +	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
> >  }
> >  
> >  static int cvm_oct_nway_reset(struct net_device *dev)
> 
> Sorry, this does not apply to my tree, someone already did this
> conversion before you :(
> 
> greg k-h

Thank you anyway, and thank you to you and Joe for your feedback, much
appreciated.

Regards,
Phil

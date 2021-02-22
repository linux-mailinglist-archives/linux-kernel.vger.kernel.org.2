Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD04321D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhBVQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:48:03 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35585 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhBVQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:47:31 -0500
Received: by mail-pg1-f171.google.com with SMTP id t25so10571772pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0AVccQ8Xy3jeqFqQ4rJqiBX9Mc9QWkAQEVWTtLe4WME=;
        b=E+cfQDRPLgcXK9ZEqbFd8afGn69+wYbguLHj1OPVS/QFHLeJwjMG9AFgnNfj3BPWH3
         eXf83u7FMLz/YWD/1JsrcS28SVp6t5cxU5SfB/KBaEk1IEH+1PDRcxET0k/pfUVtAu4Y
         o4W8gl1YvjwpZshkNOoBCScV3ONqJinupbJ5f4g98huuDzFZy91ESace0ILZbywS5mRr
         vNC3zDti6HW5OpAE6E5V/kpd1wAvP/l0LFFZpFbF9998/YjozE3j9s3N/xBILcxqFqCN
         wT2wdnC99/KKimATJj2LVMKmTGYBNQzNpwhsZ5e82RNcejDFRBLqm04P1hlF0zNq0yci
         vzqw==
X-Gm-Message-State: AOAM533rXG+TYjMlzNYK75LV58NkT2aukdUF1X897wCJJb8VFRPj5ZJJ
        mn87dpJ7KigYI4bckwMj4X2ZaYvRbtL/itCc
X-Google-Smtp-Source: ABdhPJwXMVPiYAE8E//i/iaaKfsyEfenPXBWx1Jl6C2fPLyjVywu2ttey2IORJN+jPoAyHEj3DVDSA==
X-Received: by 2002:a05:6a00:228d:b029:1ed:5a5f:527c with SMTP id f13-20020a056a00228db02901ed5a5f527cmr13846903pfe.35.1614012409720;
        Mon, 22 Feb 2021 08:46:49 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.255])
        by smtp.gmail.com with ESMTPSA id z4sm18894990pgv.73.2021.02.22.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:46:49 -0800 (PST)
Date:   Mon, 22 Feb 2021 22:16:45 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: wlan-ng/p80211 : check userspacebuf size for
 sanity
Message-ID: <YDPf9Z+eIjcBu240@karthik-strix-linux.karthek.com>
References: <YDOnoLJzHYXMZBA/@karthik-strix-linux.karthek.com>
 <20210222132132.GU2222@kadam>
 <YDO0vtJyyGSSi44n@karthik-strix-linux.karthek.com>
 <20210222135937.GV2222@kadam>
 <YDPKL47kPVyRPRcC@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDPKL47kPVyRPRcC@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 08:43:51PM +0530, karthek wrote:
> On Mon, Feb 22, 2021 at 04:59:37PM +0300, Dan Carpenter wrote:
> > I have added the Driver Devel list to the CC list.  Adding linux-kernel
> > is sort of useless.  The correct people who are interested in this patch
> > are all on the Driver Devel list.
> > 
> > On Mon, Feb 22, 2021 at 07:12:22PM +0530, karthek wrote:
> > > On Mon, Feb 22, 2021 at 04:21:33PM +0300, Dan Carpenter wrote:
> > > > On Mon, Feb 22, 2021 at 06:16:24PM +0530, karthek wrote:
> > > > > currently p80211knetdev_do_ioctl() is testing user passed
> > > > > struct ifreq for sanity by checking for presence of a magic number,
> > > > > in addition to that also check size field, preventing buffer overflow
> > > > > before passing data to p80211req_dorequest() which casts it
> > > > > to *struct p80211msg
> > > > > 
> > > > > Signed-off-by: karthek <mail@karthek.com>
> > > > > ---
> > > > > is this correct?
> > > > > is it necessary to check for size in addition to magicnum?
> > > > > did i even understand the problem correctly?
> > > > > 
> > > > >  drivers/staging/wlan-ng/p80211netdev.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > > > > index 70570e8a5..c7b78d870 100644
> > > > > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > > > > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > > > > @@ -568,7 +568,10 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> > > > >  		result = -EINVAL;
> > > > >  		goto bail;
> > > > >  	}
> > > > > -
> > > > > +	if (req->len < sizeof(struct p80211msg)) {
> > > > > +		result = -EINVAL;
> > > > > +		goto bail;
> > > > > +	}
> > > > 
> > > > Please don't send private emails.  Always CC the list.
> > > sorry
> > > > 
> > > > That's only a partial solution.  You need to check in p80211req_handlemsg()
> > > > as well and probably other places.
> > > currently p80211req_handlemsg() is only referenced in p80211req_dorequest()
> > > can we check that there instead?
> > 
> > If I have to do all the work in finding the buffer overflows, then I
> > should write my own patch.  :/
> > 
> > Anyway the p80211knetdev_do_ioctl() function calls p80211req_dorequest()
> > which calls p80211req_handlemsg(wlandev, msg); and
> > wlandev->mlmerequest(wlandev, msg);.
> > 
> > We have already discussed the p80211req_handlemsg() function.  The
> > wlandev->mlmerequest() function is always just prism2sta_mlmerequest().
> > The prism2sta_mlmerequest() calls a bunch of functions and each of those
> > functions need to have a different limit check added to prevent memory
> > corruption.
other than this ioctl call codepath other codepaths leading to those
functions doesn't seem to get that msg(struct p80211req) from userspace
so may be they dont need that checking
anyway why do you think that is necessary?
> > 
> > Homework #1: Should we get rid of the wlandev->mlmerequest() pointer
> > and just call prism2sta_mlmerequest() directly?
> yeah
> > 
> > Homework #2: Another solution is to just delete all these custom IOCTLs.
> > I don't know what they do so I don't know if they are necessary or not.
> i wish i could
> > 
> > regards,
> > dan carpenter
> > 

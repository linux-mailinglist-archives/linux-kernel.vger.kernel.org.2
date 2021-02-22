Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB703219FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhBVOQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:16:08 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:55081 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhBVNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:43:08 -0500
Received: by mail-pj1-f49.google.com with SMTP id cx11so6436717pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9K+4tfqbwg4fEjyR/ODvGC4CubFP5dP+GFejvhCOHo=;
        b=pwpC7VqNrkYKPvEkzhdHc9Dqt/meo2bQDuqT6XKSHxicbOjmINX3ISX3A9Jg0ExeCk
         wWOrwkGErSDhsOKjQVAAY+sODXV0jIy9N28zsNti7hFPAnaLmDeGL7sI0ReMaDK605Ie
         jnye3om27unpFWjzJ7XauOmsOxI6Yb9/umgsB2UHKwXey2UgIUXQZ9SEChoJMBJ5Ax6A
         mb12b6J5Dcc3d2p54BJ6PikBOvqjguS1cMpLWSGmNgWK48yyoKrfJ4sdIkOkRfqVLTHj
         0C7kHL98o2TLSlh17fuxWqYmDBON+NLQtKxmdqTNF9n+04+Cgmz8XZV3XBxc/wITBfkE
         1dAQ==
X-Gm-Message-State: AOAM5317ZtRuid15EJ+hOOkCD/6ROARQPY+TFIaACg+KVvkb0HCovfpb
        TxC1i5Xv291RROKKzz7jNj0=
X-Google-Smtp-Source: ABdhPJyMEBvSznlTgNCYKKYtm3qCDerBtNCUHdHHF0Y3nzscEm20VlU0KugR/ihHCBaG6rp1z4RTDQ==
X-Received: by 2002:a17:902:aa4b:b029:e2:bb4b:a63 with SMTP id c11-20020a170902aa4bb02900e2bb4b0a63mr22165310plr.7.1614001347344;
        Mon, 22 Feb 2021 05:42:27 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.255])
        by smtp.gmail.com with ESMTPSA id l190sm19417662pfl.205.2021.02.22.05.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 05:42:26 -0800 (PST)
Date:   Mon, 22 Feb 2021 19:12:22 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng/p80211 : check userspacebuf size for
 sanity
Message-ID: <YDO0vtJyyGSSi44n@karthik-strix-linux.karthek.com>
References: <YDOnoLJzHYXMZBA/@karthik-strix-linux.karthek.com>
 <20210222132132.GU2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222132132.GU2222@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:21:33PM +0300, Dan Carpenter wrote:
> On Mon, Feb 22, 2021 at 06:16:24PM +0530, karthek wrote:
> > currently p80211knetdev_do_ioctl() is testing user passed
> > struct ifreq for sanity by checking for presence of a magic number,
> > in addition to that also check size field, preventing buffer overflow
> > before passing data to p80211req_dorequest() which casts it
> > to *struct p80211msg
> > 
> > Signed-off-by: karthek <mail@karthek.com>
> > ---
> > is this correct?
> > is it necessary to check for size in addition to magicnum?
> > did i even understand the problem correctly?
> > 
> >  drivers/staging/wlan-ng/p80211netdev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > index 70570e8a5..c7b78d870 100644
> > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > @@ -568,7 +568,10 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> >  		result = -EINVAL;
> >  		goto bail;
> >  	}
> > -
> > +	if (req->len < sizeof(struct p80211msg)) {
> > +		result = -EINVAL;
> > +		goto bail;
> > +	}
> 
> Please don't send private emails.  Always CC the list.
sorry
> 
> That's only a partial solution.  You need to check in p80211req_handlemsg()
> as well and probably other places.
currently p80211req_handlemsg() is only referenced in p80211req_dorequest()
can we check that there instead?
> 
> regards,
> dan carpenter
> 

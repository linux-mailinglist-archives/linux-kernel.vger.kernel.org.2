Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3855321B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhBVPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:21:01 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:39074 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhBVPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:14:38 -0500
Received: by mail-pj1-f50.google.com with SMTP id d2so9262655pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sg3iIrkkDsgypdsbDNoge70vzTAFrCPegzLsFOlHOJg=;
        b=ozpRx7B/ujwWcqQAVIvFGPN45LpPGV7yK0NsuEQ8NUW5WlroKxfZo4TxxsAMTwTpBn
         /aVFhYopjSdTwPSpqVXsZZgYbTYgAwy4HpSv7DHi1/lSZtvEmU/kd1FjChojwnT6sTkT
         JQao6z3iderYG7+5mBH0OBSO6nN715oWIqkxRb9aIZ0x0Ccfc1OMwSLwtJXyIqwLctwx
         vD3G/5F92VvlLGHMxOhfmEpjTvPsHaR94SXZ5yYl6/ufv3NMp76jh7dw/oxF0DiSqPwl
         Q1RDousDct2MusAeESL+zBrhWVCoguFdob8cz+UR+My0rWdolXTHpcOVK2Q4hEByBjk2
         fSrA==
X-Gm-Message-State: AOAM532vTrzrZYkzUNp/7l3YSAuRZsVFpVMf/ynBZsD5SUU7A0uXTPgk
        uWRYfLxtGC2HlbcgLbxVzjc=
X-Google-Smtp-Source: ABdhPJzy5v7UB0lwfUGmYizhvLtXQNvKKDOnN6VOd5KsBhRU/l6ZCxbtcGYdlwbeEfpEfcKmL45Xuw==
X-Received: by 2002:a17:902:744a:b029:e3:795d:b809 with SMTP id e10-20020a170902744ab02900e3795db809mr22856518plt.7.1614006835839;
        Mon, 22 Feb 2021 07:13:55 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.255])
        by smtp.gmail.com with ESMTPSA id v4sm5460329pjo.32.2021.02.22.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:13:55 -0800 (PST)
Date:   Mon, 22 Feb 2021 20:43:51 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: wlan-ng/p80211 : check userspacebuf size for
 sanity
Message-ID: <YDPKL47kPVyRPRcC@karthik-strix-linux.karthek.com>
References: <YDOnoLJzHYXMZBA/@karthik-strix-linux.karthek.com>
 <20210222132132.GU2222@kadam>
 <YDO0vtJyyGSSi44n@karthik-strix-linux.karthek.com>
 <20210222135937.GV2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222135937.GV2222@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:59:37PM +0300, Dan Carpenter wrote:
> I have added the Driver Devel list to the CC list.  Adding linux-kernel
> is sort of useless.  The correct people who are interested in this patch
> are all on the Driver Devel list.
> 
> On Mon, Feb 22, 2021 at 07:12:22PM +0530, karthek wrote:
> > On Mon, Feb 22, 2021 at 04:21:33PM +0300, Dan Carpenter wrote:
> > > On Mon, Feb 22, 2021 at 06:16:24PM +0530, karthek wrote:
> > > > currently p80211knetdev_do_ioctl() is testing user passed
> > > > struct ifreq for sanity by checking for presence of a magic number,
> > > > in addition to that also check size field, preventing buffer overflow
> > > > before passing data to p80211req_dorequest() which casts it
> > > > to *struct p80211msg
> > > > 
> > > > Signed-off-by: karthek <mail@karthek.com>
> > > > ---
> > > > is this correct?
> > > > is it necessary to check for size in addition to magicnum?
> > > > did i even understand the problem correctly?
> > > > 
> > > >  drivers/staging/wlan-ng/p80211netdev.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > > > index 70570e8a5..c7b78d870 100644
> > > > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > > > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > > > @@ -568,7 +568,10 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> > > >  		result = -EINVAL;
> > > >  		goto bail;
> > > >  	}
> > > > -
> > > > +	if (req->len < sizeof(struct p80211msg)) {
> > > > +		result = -EINVAL;
> > > > +		goto bail;
> > > > +	}
> > > 
> > > Please don't send private emails.  Always CC the list.
> > sorry
> > > 
> > > That's only a partial solution.  You need to check in p80211req_handlemsg()
> > > as well and probably other places.
> > currently p80211req_handlemsg() is only referenced in p80211req_dorequest()
> > can we check that there instead?
> 
> If I have to do all the work in finding the buffer overflows, then I
> should write my own patch.  :/
> 
> Anyway the p80211knetdev_do_ioctl() function calls p80211req_dorequest()
> which calls p80211req_handlemsg(wlandev, msg); and
> wlandev->mlmerequest(wlandev, msg);.
> 
> We have already discussed the p80211req_handlemsg() function.  The
> wlandev->mlmerequest() function is always just prism2sta_mlmerequest().
> The prism2sta_mlmerequest() calls a bunch of functions and each of those
> functions need to have a different limit check added to prevent memory
> corruption.
> 
> Homework #1: Should we get rid of the wlandev->mlmerequest() pointer
> and just call prism2sta_mlmerequest() directly?
yeah
> 
> Homework #2: Another solution is to just delete all these custom IOCTLs.
> I don't know what they do so I don't know if they are necessary or not.
i wish i could
> 
> regards,
> dan carpenter
> 

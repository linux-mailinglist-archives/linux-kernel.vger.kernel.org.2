Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375D13241EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBXQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:16:21 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:52832 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbhBXQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:13:01 -0500
Received: by mail-pj1-f48.google.com with SMTP id kr16so1601297pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znf/l1mfnTdzj1tAFt88yp752BGUtEl4XP2IYuaKZTs=;
        b=OQMvsOKGo7UOlWrXtc3ZHfGIAdSs79leP2wTCv3rJlMYV/MS4XsrdKVozdLF2jQ7kq
         rhZRBTWAmtce8YCSJHxL3mvYl0LVCGwMl8AIume5mKQmdq1PM2z+DNEm8xSMbR2Dac06
         Akwch8pYNTFmkclrwoBRNnqArCuGUUhUPjGFwdQhF0OY+oCHeEgvEWBFcbDujVeE/FIz
         ELxfGvnE1ms6jHeLT8sOpLMANQ7KMQLt0KfYUOhfXycg79OohRVmC2jNuDYlHuTrdXWk
         w9lNIS8LAt+2I0xAo4Zn0sv6XrStsBzLGBRVeLYnmlQpJ1aeF2abWz/BPR8s8PPlkZGh
         Xq9g==
X-Gm-Message-State: AOAM533qQDSoBAgTl7/aJ1D1U2/O6n64Wceh4TfRU1/NHzKQTU52uVtp
        omGxs7BfIB7Fx5VxzalwAoE=
X-Google-Smtp-Source: ABdhPJx7IyGUAxjYTwnBqxStyxBOZONa0stTnIZV7U902QoSKg/lRFiLi65R1YP3dVCKVTuuxaEj/g==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr5083231pjw.43.1614183135770;
        Wed, 24 Feb 2021 08:12:15 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.67])
        by smtp.gmail.com with ESMTPSA id y8sm3542994pfe.36.2021.02.24.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:12:15 -0800 (PST)
Date:   Wed, 24 Feb 2021 21:42:09 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix sparse warnings
Message-ID: <YDZ62RMHotsPrF+R@karthik-strix-linux.karthek.com>
References: <cover.1613921277.git.mail@karthek.com>
 <YDZpKcXLkiueequk@karthik-strix-linux.karthek.com>
 <20210224150648.GT2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224150648.GT2087@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:06:48PM +0300, Dan Carpenter wrote:
> On Wed, Feb 24, 2021 at 08:26:41PM +0530, karthek wrote:
> > On Sun, Feb 21, 2021 at 09:00:48PM +0530, karthik alapati wrote:
> > > the following patches fixes two  byte-order issues
> > > and fixes these sparse warnings
> > > 
> > > 
> > > drivers/staging//wimax/i2400m/op-rfkill.c:89:25: warning: incorrect type in assignment (different base types)
> > > drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    expected restricted __le16 [usertype] length
> > > drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    got unsigned long
> > > .
> > > drivers/staging//wimax/i2400m/fw.c:514:27: warning: restricted __le32 degrades to integer
> > > 
> > > 
> > > karthik alapati (2):
> > >   staging: wimax/i2400m: fix byte-order issue
> > >   staging: wimax/i2400m: convert __le32 type to host byte-order
> > > 
> > >  drivers/staging/wimax/i2400m/fw.c        | 2 +-
> > >  drivers/staging/wimax/i2400m/op-rfkill.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > -- 
> > > 2.30.1
> > > 
> > ping?
> 
> The merge window is open so no one is merging these types of fixes now.
> Wait until -rc1 is out, and then give the maintainer two weeks to look
> at your patch and get back to you.
> 
> regards,
> dan carpenter
>
thanks dan, Got it.

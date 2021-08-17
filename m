Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C73EE8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhHQIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhHQIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:51:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A1C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:50:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r19so27201426eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QxsAwmTrTeB18+OyhXDgjAvk7BaTLmBXsRYKyRJCcI=;
        b=Velx31fB81eddg504YD3UoiFlJ202ncCk6DSnXWHl8jOVqQ4CBO+fx9OM+cGevTz5f
         cZLWrujKyoTh6fwYY3UgCZMmZDzPgLvQKljphZlyajZBeNy7lAmBQuPxPPV6praiQKk6
         25sslycvfQBoCrXfonPohSf/iFjgSD5ij0t2XLkvo7Ojyg+yZinI4PqVExUjEPrk2rtS
         KdFd4DFrqQionb339l6Uwommm35n3s7pTW5j6GEnZisKNY8b8q6fPxy1RgqLuyQCBNQd
         7HO8aEG1b3QHOmmZ2Wl5aHHwLP3rzfVNgvYUe6n5xJoQ60KRWWDHWcI2ZyA3iRnY2SKA
         HIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QxsAwmTrTeB18+OyhXDgjAvk7BaTLmBXsRYKyRJCcI=;
        b=oY392u7tI2PdzUrZWWk1T+J9AKcyPJIs+kHKnxxAMld+hILmzezUcvSuZmRs/eZlnV
         9Q16YuFMAfGDnlhODu8ZziXgJ4hrKNvrUK9+4YIDd4x0ybL5Ig83h/CVAnaVoF2Aj+am
         idZh49zh/mHvtaVi5iPpctFlU+69VPIOCO1ToCQeudem4aU24fTFiJr+RB29CJxCTYSN
         fWZGXuHBknoDgYBcOt5Qs8RSPQrSoRKk0au1OytGgblZt2wMWK7YYaddwbYSzmmMVZOT
         GwAEWopuVOYGnOgMsWiqoSxq1FowXUAyhEnw6nbASk20Yz2hITpZj6MV94wh5LRzK56K
         nlwQ==
X-Gm-Message-State: AOAM5302YbSGPcN2qQUsQm/2ej1XWxMBQL45vBIqFHcVe0KtLqGHm3Jj
        botjy3TVTAtKH94LAkbplYY=
X-Google-Smtp-Source: ABdhPJzqf6jFhXcFY16uzDOrtqySbrQ3vdFOoxPRCj+S+ihDNd9Kn2xk3pn2QLzi8eSC+PXSNMsURw==
X-Received: by 2002:aa7:d946:: with SMTP id l6mr2881942eds.81.1629190251496;
        Tue, 17 Aug 2021 01:50:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id m25sm703205edv.81.2021.08.17.01.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:50:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: Remove unused code
Date:   Tue, 17 Aug 2021 10:50:49 +0200
Message-ID: <2687424.dsZdMDUqJ2@localhost.localdomain>
In-Reply-To: <YRqXNyX+fY9qKh3Q@kroah.com>
References: <20210816160617.11949-1-fmdefrancesco@gmail.com> <YRqXNyX+fY9qKh3Q@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 6:49:59 PM CEST Greg Kroah-Hartman wrote:
> On Mon, Aug 16, 2021 at 06:06:14PM +0200, Fabio M. De Francesco wrote:
> > Remove unused code from the r8188eu driver.
> > 
> > Fabio M. De Francesco (3):
> >   staging: r8188eu: Remove unused nat25_handle_frame()
> >   staging: r8188eu: Remove all code depending on the NAT25_LOOKUP method
> >   staging: r8188eu: Remove no more used variable and function
> >  
> >  drivers/staging/r8188eu/core/rtw_br_ext.c    | 263 +------------------
> >  drivers/staging/r8188eu/include/recv_osdep.h |   1 -
> >  drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
> >  3 files changed, 1 insertion(+), 264 deletions(-)
> 
> Patch 2/3 did not apply, can you please rebase and resend the remaining
> 2 patches against my latest tree?

Sure. I've already sent them:

"[PATCH v2 2/3] staging: r8188eu: Remove code depending on NAT25_LOOKUP", 
https://lkml.org/lkml/2021/8/16/1082;
"[PATCH v2 3/3] staging: r8188eu: Remove no more used variable and function",
https://lkml.org/lkml/2021/8/16/1094.

Thanks,

Fabio
 
> thanks,
> 
> greg k-h





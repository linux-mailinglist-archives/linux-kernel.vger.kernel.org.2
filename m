Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF43D0A19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhGUHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhGUHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:11:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DBC061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:51:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v1so1225635edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OviwxmQXhJdo0TloNvGVegugc9cROp3g9iBnuBkT8bE=;
        b=d6tocUcKm9pxZrf2i3DUgWZhK0a7b0w7sMiUQFZ0c+0rC1c4k2WU8dN6Vfpr490v9A
         IjbVlcw/aKsjPigaK9dLLKJEyT6vy6AH/oGxKvGRaJYBOyVpNHEL/dT2Ws+rfqQuDrCT
         ApGvbR9E4lbM5dE4F+igOaOLZ/MpReJfDLbtIWjnR1Y2HRRQKkQt3/IHqDr2d4D20fhR
         yqz7Y4J22jfuwhJ/Q8j5DYdFcyX76fvs37mOunvYEGFoZApmp+tPSoi/9Qb3EJWhqIIG
         xHdLalO1v6n1ICe3EhF4/PocgD4hKqcAHnbV4jFqyH2QzrwBf4VuqtGJWlHgrj/pWPkI
         RyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OviwxmQXhJdo0TloNvGVegugc9cROp3g9iBnuBkT8bE=;
        b=kH8NZQxhpMKSA7Ch64B3zSaT+MA2GyVXXES2pu/ikiVTWlb2woZkvfQlKgz8+1xLWI
         551fYJaQQbjwCg0mbgvsVEUTzdHnPtiEjUIBWdSdlK8AFJ8LVknx9s7J53pJwxwaURJE
         xXl6xAqFKlYz0D3DmWYqRmtR1JJKJxf3esMFtuVG8z18Nj51+ZiWlLxo4XxA/SGQhnV9
         jrMX/ksxtQCFhq2C9KivGKypRZfn2KPcq/YCi9QA2BJ0n4iKAQjpE2CpNZTssrCD1I0v
         OGrV0LjrKShEAUP0kF7KBmn7X093loMValr/JrQdPdKv8VejVflswjWuPcuJDBh52dqE
         SntA==
X-Gm-Message-State: AOAM530TInqKXvB9SsyK0pr4EPQzddrWxKF4qP1tWLp9RuA4g2cTkzNX
        WRk6X+PssubzTsp7N1ql9aM=
X-Google-Smtp-Source: ABdhPJyzHMCIX7uNIYHsYLT7QeR+KYXwZDlY7DRyPamhotr/8BW1nhXIHdg9mMwK1x3OmcUYxkj0zw==
X-Received: by 2002:a05:6402:d54:: with SMTP id ec20mr48237987edb.41.1626853897163;
        Wed, 21 Jul 2021 00:51:37 -0700 (PDT)
Received: from agape.jhs ([5.171.80.208])
        by smtp.gmail.com with ESMTPSA id c28sm7979632ejc.102.2021.07.21.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:51:36 -0700 (PDT)
Date:   Wed, 21 Jul 2021 09:51:34 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <20210721075133.GB1415@agape.jhs>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <YPdUM2Gi+tPKoJII@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPdUM2Gi+tPKoJII@equinox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Phillip,

On Tue, Jul 20, 2021 at 11:54:43PM +0100, Phillip Potter wrote:
> On Tue, Jul 20, 2021 at 11:00:36AM +0200, Fabio Aiuto wrote:
> > Hi all,
> > 
> > On Mon, Jul 19, 2021 at 06:46:16PM -0500, Larry Finger wrote:
> > > On 7/19/21 5:46 PM, Phillip Potter wrote:
> > > > Move all C source files from the core subdirectory to the root
> > > > folder of the driver, and adjust Makefile accordingly. The ultmate
> > > > goal is to remove hal layer and fold its functionalty into the main
> > > > sources. At this point, the distinction between hal and core will be
> > > > meaningless, so this is the first step towards simplifying the file
> > > > layout.
> > > > 
> > > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > > ---
> > > >   drivers/staging/rtl8188eu/Makefile            | 34 +++++++++----------
> > > >   drivers/staging/rtl8188eu/{core => }/rtw_ap.c |  0
> > > >   .../staging/rtl8188eu/{core => }/rtw_cmd.c    |  0
> > > >   .../staging/rtl8188eu/{core => }/rtw_efuse.c  |  0
> > > >   .../rtl8188eu/{core => }/rtw_ieee80211.c      |  0
> > > >   .../rtl8188eu/{core => }/rtw_ioctl_set.c      |  0
> > > >   .../staging/rtl8188eu/{core => }/rtw_iol.c    |  0
> >  > 
> > > 
> > > I think this is just source churning. The current setup with include. core.
> > > hal and os_dep subdirectories are not opressive.
> > > 
> > > Larry
> > > 
> > > 
> > 
> > maybe the information we will need one day is:
> > 
> > will the core/-os_dep/-hal/-include/-directory-structure be
> > welcomed in mainline wireless subsystem, when an rtl* driver
> > will be perfectly tuned?
> > 
> > At the moment I can't see such a directory organization
> > in any of the realtek wireless driver.
> > 
> > Sure there's time for that ;),
> > 
> > Thank you,
> > 
> > fabio
> > 
> > 
> Dear Fabio,
> 
> Certainly a good start is removing this 'hal' layer so for now I'll
> focus on that as much as I can. Perhaps the path forwards will become
> clearer without it there :-) Thank you for your feedback.

Agreed

> 
> Regards,
> Phil

thank you,

fabio

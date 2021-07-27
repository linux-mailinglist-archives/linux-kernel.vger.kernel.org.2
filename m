Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE13D7775
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhG0Nsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237549AbhG0Nrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60441619F5;
        Tue, 27 Jul 2021 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627393654;
        bh=p8LnftZhZgD85kdOqArZWnpzvxx9HnLHlrz8ygUVkXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9RLsGuPNuLPwMZRXz1VRfSlOA+GkzoRlwcnCpJnJOr1fOnINoC/JWm7/r38Qd2DE
         MPTKdgSu7/Gxb6bayos7HQpGLJxTgYXmxGZpk5pZHHPUJoESETDLKRx9OaVg/lufPH
         eA/255LmZBHrTR3sOtvpcp3St0G9T5oBlKvZ63V8=
Date:   Tue, 27 Jul 2021 15:47:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH v3 0/7] staging: rtl8188eu: replace driver with better
 version
Message-ID: <YQAOdEz9GfhpCeBZ@kroah.com>
References: <20210724001055.1613840-1-phil@philpotter.co.uk>
 <YQAE1q9ZWRPHqfK5@kroah.com>
 <CAA=Fs0nwOBUoCSbwzaE7TTQab_BZcCy2SL1RJby+Hmo=URw_Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0nwOBUoCSbwzaE7TTQab_BZcCy2SL1RJby+Hmo=URw_Pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:25:34PM +0100, Phillip Potter wrote:
> On Tue, 27 Jul 2021 at 14:06, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 24, 2021 at 01:10:48AM +0100, Phillip Potter wrote:
> > > I had to break this patchset up a bit to get around the file size limits
> > > on the mailing list, and also I removed the hostapd stuff which is
> > > userspace related and therefore not required.
> > >
> > > The driver currently in staging is older and less functional than the
> > > version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> > > This series of patches therefore:
> > >
> > > (1) Removes the current driver from staging.
> > > (2) Imports the GitHub version mentioned above in its place.
> >
> > Let's do (2) first before worrying about (1), given that we can't get a
> > version of (2) that actually builds yet :)
> >
> > thanks,
> >
> > greg k-h
> 
> Dear Greg,
> 
> I'm confused - v3 patchset builds fine for me after applying in
> sequence from 1 to 7?

Why does kbuild report problems?

Anyway, please let's just add the new driver in a new directory, get it
building, and then we can remove the old one.  That way patches will
continue to work and there's no confusion when backporting patches as
the code bases are different.

thanks,

greg k-h

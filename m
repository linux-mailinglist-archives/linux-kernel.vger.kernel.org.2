Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE030C9F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhBBSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238543AbhBBSat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:30:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9C2F64F72;
        Tue,  2 Feb 2021 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612290609;
        bh=isI4qMMdTZ51+PpDN64U3sdPAoY1aBox05SjMzT2Ar4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ziof9qrrJkldISTz481eXvOZyN7aTWbQ6HaBVp6R2J5TscGNTbuWTg4WP8P3bSvBW
         RUd23O6jnC5LDzeEg0tBbeEbcCCwd1omLCDHW423fG9rC5hgcp8iubKzpgCSiFrXEl
         LzPEXs+u20Ro3dnITWo5Zg+GsVR/NR/Wqju/OBEw=
Date:   Tue, 2 Feb 2021 19:30:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Fix call to
 typec_partner_set_pd_revision
Message-ID: <YBmaLi5hhEj1zy8J@kroah.com>
References: <20210202164531.3982778-1-bleung@chromium.org>
 <YBmFo5L1eeUwCJ9B@kroah.com>
 <CANLzEkuFgLK9saqHhHdrKhOjsiG001d1N9EYXsnohoMPHsAPGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLzEkuFgLK9saqHhHdrKhOjsiG001d1N9EYXsnohoMPHsAPGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:52:13AM -0800, Benson Leung wrote:
> Hi Greg,
> 
> On Tue, Feb 2, 2021 at 9:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 02, 2021 at 08:45:31AM -0800, Benson Leung wrote:
> > > typec_partner_set_pd_revision returns void now.
> > >
> > > Fixes: cefc011f8daf ("platform/chrome: cros_ec_typec: Set Partner PD revision from status")
> > > Signed-off-by: Benson Leung <bleung@chromium.org>
> > > ---
> > >  drivers/platform/chrome/cros_ec_typec.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > What changed from "v1"?
> >
> 
> Just the "Fixes" line in the commit message.

That should always go below the --- line, remember, some of us deal with
hundreds of patches a day :)

I'll go take this...

thanks,

greg k-h

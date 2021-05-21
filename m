Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5438C8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhEUNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhEUNuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:50:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 744DE60C3E;
        Fri, 21 May 2021 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621604928;
        bh=uUYri9y6jUODf1ugzxdQCJl1zNbfbn1EgEalzAcKuWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYkCHzGpnmeOvqTV0TUhGbazPhjv0EZ14Q8T2AuyIhg/246GaiAertmegNGSOyKh5
         8zaK5wGsVyQ4qx5wC9WtiAdXkrkoNVFqCfcUZWQKgOidXv1X1nKyjhcTM/yleiu6L4
         P3qnaIAL82+ulpcV3q3B8hpViha8yh43xMlJ+t6yEy+86ruBaki+h0DDZ/8TT5ywAd
         ktUM7dyKgj4Xw2zuCqAvsNxz/ACWx0xDowes3Pbg5Sisgv4WaApEqBu29nFQJwR5pw
         vojX/9+2Y3C8SBlzmmHxqDgkAl9yCI4eOCvcPMEvb+op1nnnY/DqGFOzaYHFPjjNOu
         lYTutn0vpLRnA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lk5WD-0002qt-Uf; Fri, 21 May 2021 15:48:50 +0200
Date:   Fri, 21 May 2021 15:48:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] USB: serial: buffer-callback clean ups
Message-ID: <YKe6QTPlwBS578JY@hovoldconsulting.com>
References: <20210519092006.9775-1-johan@kernel.org>
 <YKemAh63ldwGUWBh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKemAh63ldwGUWBh@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:22:26PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 11:20:00AM +0200, Johan Hovold wrote:
> > This series clean up a few things related to the chars_in_buffer and
> > write_room callbacks that were found during review of the recent
> > conversion to have these callbacks return an unsigned int.
> > 
> > Johan
> > 
> > 
> > Johan Hovold (6):
> >   USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
> >   USB: serial: digi_acceleport: add chars_in_buffer locking
> >   USB: serial: io_edgeport: drop buffer-callback sanity checks
> >   USB: serial: mos7720: drop buffer-callback sanity checks
> >   USB: serial: mos7840: drop buffer-callback return-value comments
> >   USB: serial: drop irq-flags initialisations
> > 
> >  drivers/usb/serial/digi_acceleport.c | 34 ++++++++++++++--------------
> >  drivers/usb/serial/io_edgeport.c     | 27 +---------------------
> >  drivers/usb/serial/metro-usb.c       | 12 +++++-----
> >  drivers/usb/serial/mos7720.c         | 17 ++------------
> >  drivers/usb/serial/mos7840.c         |  5 ----
> >  drivers/usb/serial/quatech2.c        |  2 +-
> >  6 files changed, 27 insertions(+), 70 deletions(-)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied.

Johan

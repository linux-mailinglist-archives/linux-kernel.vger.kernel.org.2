Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B483D9595
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhG1Szs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhG1Szo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:55:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6127E60F9B;
        Wed, 28 Jul 2021 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627498542;
        bh=9zzJ3Jm5htU4Noed99vYY+Z7L4GodhLuLn7PTmd2Xec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wimi91y0rQ+X4+9Wv0hYaI+wRYIVaubHDnNkVCj4NXADLqxnNrX4FmdkJzcW7eRIF
         AJxZRbGnE55xLawF4OshI3fulfhsmmp5sd5MEtpLj38RaCkamTnKtHNUYnQqIczspQ
         40Psjps3ZtSnwMVIBVCxs4NHpObOW3vCBROerxOo=
Date:   Wed, 28 Jul 2021 20:55:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, martin@kaiser.cx
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <YQGoLPnL8s2buxFe@kroah.com>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <YQGenmf2m3Tu7FFg@kroah.com>
 <9902deed-021c-ad37-7fc7-f4279886c683@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9902deed-021c-ad37-7fc7-f4279886c683@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:41:15PM -0500, Larry Finger wrote:
> On 7/28/21 1:14 PM, Greg KH wrote:
> > Hm, I thought this would be in better shape than it is.
> > 
> > Right now we have 107 .c and .h files in drivers/staging/rtl8188eu/ that
> > come to a total of 44597 lines.
> > 
> > So we are taking double the size here?
> > 
> > I'm all for putting a "better" driver in here, but this feels odd to
> > me...  Is there major new functionality here that is not in the existing
> > driver to justify this?
> > 
> > Ok, let's see how this goes, I'll give it a few weeks to see how much
> > can easily be fixed up to hopefully get back to at least close the
> > existing driver size...
> 
> The major new functionality is that the new one uses cfg80211, whereas the
> old one uses the WEXT calls.

Ok, that's worth it alone.

> It really is an improvement. It just needs a severe cleanup.
> 
> I warned you that this code was rough. It took me several weeks to get the
> old one "ready" for staging. I never devoted that effort to the new one, and
> you wanted it in a place where multiple authors could improve it.

Fair enough, I did ask for it :)

I'll go through and do a license cleanup tomorrow morning to start with,
that should knock a bunch of lines off right away...

thanks,

greg k-h

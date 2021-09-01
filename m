Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260BA3FD6BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhIAJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243418AbhIAJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:27:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85E9060462;
        Wed,  1 Sep 2021 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630488383;
        bh=pqLXY4HtrR+J0Jdtegd/3av7bnGcsxFJPqwBnp716Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDWR4Ox1Uj5CAp+emITgvgRtQT/K2gSvoFh+Qmdxm6lexS/oZ9Ik1NL9CtHuOtGIJ
         xOMq/TDG4XZxkRCKgeKoE0dzvY6UbQpW4DKPDEr3PK4TW5cS7YrbbIlbAPtDrmZ2FH
         bfbK1RO1mj5wnPaHOX0xD1tAFS3GMeoUlnck0qps=
Date:   Wed, 1 Sep 2021 11:26:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ian Turner <vectro@vectro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <YS9HPQV3O6D9N7L/@kroah.com>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
 <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
 <YSDtCea3a9cuaEG3@kroah.com>
 <YSD5JlFfAGyq5Fpk@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSD5JlFfAGyq5Fpk@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 03:01:26PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Sat, Aug 21, 2021 at 02:09:45PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 20, 2021 at 03:01:53PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > > 
> > > On Fri, Nov 06, 2020 at 11:47:25AM +0100, Greg Kroah-Hartman wrote:
> > 
> > Note, you are responding to an email from a very long time ago...
> 
> Yeah, was sort of purpose :) (to try to retain the original context of
> the question of if the commits should be backported to stable series,
> which back then had no need raised)
> > 
> > > > Due to the lack of response, I guess they don't need to go to any stable
> > > > kernel, so will queue them up for 5.11-rc1.
> > > 
> > > At least one user in Debian (https://bugs.debian.org/992004) would be
> > > happy to have those backported as well to the 5.10.y series (which we
> > > will pick up).
> > > 
> > > So if Benjamin ack's this, this would be great to have in 5.10.y.
> > 
> > What are the git commit ids?  Just ask for them to be applied to stable
> > like normal...
> 
> Right, aplogies. The two commits were
> 47ea2929d58c35598e681212311d35b240c373ce and
> 217504a055325fe76ec1142aa15f14d3db77f94f.
> 
> 47ea2929d58c ("usb: typec: ucsi: acpi: Always decode connector change information")
> 217504a05532 ("usb: typec: ucsi: Work around PPM losing change information")
> 
> and in the followup Benjamin Berg mentioned to pick as well
> 
> 8c9b3caab3ac26db1da00b8117901640c55a69dd
> 
> 8c9b3caab3ac ("usb: typec: ucsi: Clear pending after acking connector change"
> 
> a related fix later on.

All now queued up, thanks.

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986FD3F3A84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhHUMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 08:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhHUMK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:10:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC5216120C;
        Sat, 21 Aug 2021 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629547789;
        bh=I5aDNaJ08T5XO2o5aYAHKwH94JnMv5efq84IlTwACnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POyQUS1cjHXA4BuQpzUAUU7IsJPBwctCL3L/A1OEVIWz/VaUr6/aG3oGbvz3sl1XI
         zv3rIpUbTMFPVAg4tPUV5dMHuz1GkAqoZEskiIvbskerJzwSZ3+6STMW3fZGXmV+IR
         Nsq/lLF7+0QE7PHUPr0tZKof14wsJhELbklGMmxY=
Date:   Sat, 21 Aug 2021 14:09:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ian Turner <vectro@vectro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <YSDtCea3a9cuaEG3@kroah.com>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
 <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR+nwZtz9CQuyTn+@lorien.valinor.li>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:01:53PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Fri, Nov 06, 2020 at 11:47:25AM +0100, Greg Kroah-Hartman wrote:

Note, you are responding to an email from a very long time ago...

> > Due to the lack of response, I guess they don't need to go to any stable
> > kernel, so will queue them up for 5.11-rc1.
> 
> At least one user in Debian (https://bugs.debian.org/992004) would be
> happy to have those backported as well to the 5.10.y series (which we
> will pick up).
> 
> So if Benjamin ack's this, this would be great to have in 5.10.y.

What are the git commit ids?  Just ask for them to be applied to stable
like normal...

thanks,

greg k-h

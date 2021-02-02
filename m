Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082EA30B8A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBBHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhBBHcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:32:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F33C464DDD;
        Tue,  2 Feb 2021 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612251129;
        bh=PEpcMlXbAvVlCef+LCydHc4SZgper6ya9C4OFl1mH14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQmHJzckD21+NYrm50hqqA0a5+ataMF5Qq5KGqL3JUZmSUOwVV/5TEc9vjyOt7heg
         Fb61fQvgJ7QCh8dBcza7Y1VZXc88ilgn+Rp72VzMs8zOlgAvozNA+f71lwwSXUf7yD
         JjkQRU5U7sxAPWSNPMeAiJxjSdBz7tl6RasVOG88=
Date:   Tue, 2 Feb 2021 08:32:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: Re: [PATCH 0/6] usb: typec: and platform/chrome: Add PD revision
 numbers
Message-ID: <YBj/9tP7b4CgeZ8r@kroah.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <YBgRDwszRs3ULl5J@kroah.com>
 <YBj5b7O60c6fh/nX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBj5b7O60c6fh/nX@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 11:04:15PM -0800, Benson Leung wrote:
> Hi Greg,
> 
> On Mon, Feb 01, 2021 at 03:32:47PM +0100, Greg KH wrote:
> > On Thu, Jan 28, 2021 at 10:14:00PM -0800, Benson Leung wrote:
> > > USB Power Delivery has a 3 entity handshake (port, cable, partner), and as
> > > of USB PD R3.0, each entity may independently support either Revision 2 or
> > > Revision 3 signaling and protocol. In order for userspace and the kernel
> > > to properly process the data objects received from a particular SOP*, we
> > > must know to which revision of the spec each conforms.
> > > 
> > > This series adds individual version numbers for the partner and the cable,
> > > and exposes them in the appropriate sysfs in /sys/class/typec.
> > > 
> > > I provide as a first implementation of this, platform/chrome's cros_ec_typec
> > > driver, whose underlying status messages convey the SOP and SOP' revisions
> > > already.
> > 
> > I've taken the first 3 patches in my tree now, but the last 3 (for the
> > chrome_ec_typec.c driver), they do not apply at all.
> > 
> 
> Ah, that's because we have some other changes for the cros_ec_typec.c driver
> already in platform/chrome for our 5.12 branch.
> 
> For 5.12, the changes for cros_ec_typec driver is pretty well contained,
> although there is some dependence on typec subsystem changes now.
> 
> If I send you a pull request containing all of the changes for this driver we
> have already merged, plus these last three that depend on both of our trees
> would you merge it through usb for 5.12?

If the subsystem maintainer says it is ok, yes, I will be glad to take a
stable git tag to pull from into my usb-next branch.

thanks,

greg k-h

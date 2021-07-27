Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099FF3D74FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhG0MYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:24:23 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:21194 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhG0MYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627388660; x=1658924660;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIgirbL+RRL8e8sFSnJ+GmFiuEmsrfCZ1wmXjFlRTIQ=;
  b=N7QihFuuWulDhit/6mdEZRaLKTIVnyeOEzpe7Iz37eMD3iKa5H/Of8me
   cDJsBAAXknKTuQORBM0yqfxJLs9MQFSlu1JmN+lvYRYVT5g5Ng6O2eY5z
   Ja6VRsVZj8Vc3F/0ZbN9y2O2/nkYsm314GymUcTCuaO0tysRqzDk30Uk0
   RgnO48yOb8fK8fUN34DthRPEDq1NkuhZqPsviI9UZpLCqg0lanzSe8mzb
   BNpZXLAbn8sb1POhb1Uw8Tv54jzV/eq4w8OzpdslVKby4PQFrck+BrtRu
   bokrnCJmP0ejKhA+za5reXoL5MuBifkuQxkrfewKWNoK/PMuR5/Ow5yXR
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,273,1620684000"; 
   d="scan'208";a="18665112"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Jul 2021 14:24:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 27 Jul 2021 14:24:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 27 Jul 2021 14:24:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627388659; x=1658924659;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIgirbL+RRL8e8sFSnJ+GmFiuEmsrfCZ1wmXjFlRTIQ=;
  b=Jp0SInTs6WNOezciRJwdtVOYp5hDsbzDA7aY3lOGbs8/RpHcGnJGF2SA
   owymwIcx3nmHSOsx1g6BD1FYlKxbVNbQTVSTZV/A9LMr7mxEbTiyVnMTP
   5VEe8mdC/8jX8jwUdlCyJbPEi8e3KxCiu8nGhTT7IHaJb0qXOCDoNMwYC
   OLqG3C8zwcar++GPN00DF10fWtMrP6PVegpdvbya53D3aL5pXcroVqOt6
   FEb2/AEiE2Egdt6DZcr8q2HbDYlVDBRq9LJstc8Jjw2BkLjmIqIiyozNc
   YSoonikm98L3aqahgQ/WvIboVVvUEl20mE6gsCzdnpwg21GmGBhxuy9hU
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,273,1620684000"; 
   d="scan'208";a="18665111"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jul 2021 14:24:19 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id BB3BF280070;
        Tue, 27 Jul 2021 14:24:19 +0200 (CEST)
Message-ID: <b42ce068884cf6bcf471425a30bc4e17711037b3.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] regmap: do not call regmap_debugfs_init()
 from regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Jul 2021 14:24:17 +0200
In-Reply-To: <20210726184805.GK4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
         <20210726114751.GE4670@sirena.org.uk>
         <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
         <20210726121140.GH4670@sirena.org.uk>
         <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
         <20210726184805.GK4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-26 at 19:48 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 26, 2021 at 02:18:42PM +0200, Matthias Schiffer wrote:
> > On Mon, 2021-07-26 at 13:11 +0100, Mark Brown wrote:
> > > That's not what your patch says it's fixing, your patch says it's
> > > fixing an attempt to recreate the same directory as we had originally
> > > (we should probably clean up the one with no device but that's not what
> > > your commit does).  I think what you need to look at here is that we
> > > store map->debugfs_name and don't overwrite it when the device is
> > > supplied.
> > That would be fine if regmap_debugfs_init() didn't do a lot more than
> > just create the debugfs directory. I'm more concerned about the mutex
> 
> The whole point here is to move the debugfs directory so if any fix
> stops that happening it's not really viable.

Looking at the history, I assume this already broke with cffa4b2122f5
("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev").
This is why the kernel is trying to recreate the "dummy" debugfs
directory on my system when regmap_attach_dev() is called by imx-
pinctrl.

I'm not convinced that the behaviour before that commit was strictly
better - when regmap_debugfs_init() was called for the second time, the
new debugfs paths would be created, but the old ones were never
removed, they just leaked.


>
>   If we knew that devices
> were definitely going to have a device bound we could just defer till
> the device is bound but it's not clear to me that that will always
> happen.

Right, there are definitely cases where that's not happening - the
mentioned syscon driver is a prime example, as it creates regmaps that
don't belong to a single device, but are shared between different
drivers. In most cases, nobody ever binds a device to these regmaps.

The thing on which I need clarification is whether it is okay to bind a
device to these shared regmaps at all:

There is nothing preventing two different drivers from calling
regmap_attach_dev() on the same regmap (AFAICT, this is actually
happening when both imx_rproc and reset-imx7 are enabled, as both use
the same syscon "SRC").

There is also nothing preventing one driver from calling
regmap_attach_dev() while another is accessing the regmap.

What I'm trying to find out here is if there are any legitimate users
of regmap_attach_dev(). If there aren't any, we can remove the API and
don't need to fix it.


> 
> > and list head initialization that is happening on an already
> > initialized structure. I haven't looked in detail what the mutex and
> > list head are used for, but I assume bad things™ are going to happen
> > when someone is already holding the mutex or using the list.
> 
> They're used to cache information on where registers are located in the
> debugfs files so seeks work much faster on large register maps, they
> won't be doing anything if userspace isn't up yet which should really be
> the case for anything that's initializing early enough that it needed to
> have a regmap prior to the driver model being up.  You're right that
> there is a potential issue there though, but that can be handled
> separately.
> 




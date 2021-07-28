Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78613D8A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhG1JNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:13:30 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:47878 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhG1JN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627463608; x=1658999608;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmBPPTZ8bhFZDfegDEBiHT1SYm+WxAR9KXbK4aFnuTg=;
  b=KZG7e46Ih2DMy8+tQVGgW6lWPTqRNfwzf1TK7WYmwOdwbK/P2HKufcCM
   HpQlZfzGLdKBZgmvb/jQ0DiV/reb1cb088V0vGZq8xaLAVakTUWC8qekx
   581Cu9kpMHd6cE41s0PDdHRKfFvTjFMYNSDYKvtiHkVD1qaTpClGwu4hI
   GQdF+HbYEKMjTcCFwMoRO1NsxHO0upF6nQhFDb2ts2OwaKmPq4HZBZxia
   rlk/jSt9dKLGUWtqrfustha9D+HoVouHMz7sNNQ+5FWPR11PddlgOp/Xe
   7jbprnpdMlJmpawSLziTpBSGf1RYPYBVR500AKVeaQK/P0Z+d/i64AcqY
   A==;
X-IronPort-AV: E=Sophos;i="5.84,275,1620684000"; 
   d="scan'208";a="18684613"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Jul 2021 11:13:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 28 Jul 2021 11:13:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 28 Jul 2021 11:13:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627463607; x=1658999607;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmBPPTZ8bhFZDfegDEBiHT1SYm+WxAR9KXbK4aFnuTg=;
  b=SkIatp3WCVYaiF3hMVJP+axNjZs6lqcA3sc8JwIIj64iGMKEigaqb0nJ
   5n+wHGnpgETmx6ZQovDQa8w5H5NRdIveAjnRwxx9vnful+FTAhlghh35c
   9xYlMWwolG98fiqEbVdZg0XLywrD7ogtEiWtfq3VM7WOQkDkFgxaufH/L
   O4YfAJDfPQhPPZBripcKyJaz/2ecuNah8TFmb5aWB9aJXgoz1nWVei1w+
   M0ENpt1uSx14suUaVov+T7bBMeDvecyLpY19uOCtB+KnwXEk2ZWv4H94D
   d0942HCuJXq+OgbyoiihN2SwSr4zQVVjuTPgfBk2Z+POqygtTgpI7ImeE
   A==;
X-IronPort-AV: E=Sophos;i="5.84,275,1620684000"; 
   d="scan'208";a="18684612"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jul 2021 11:13:27 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 62B1D280070;
        Wed, 28 Jul 2021 11:13:27 +0200 (CEST)
Message-ID: <fa7965d2ab94b8dd256450e27e36ebe368750f3f.camel@ew.tq-group.com>
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Jul 2021 11:13:25 +0200
In-Reply-To: <20210727170856.GA4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
         <20210726114751.GE4670@sirena.org.uk>
         <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
         <20210726121140.GH4670@sirena.org.uk>
         <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
         <20210726184805.GK4670@sirena.org.uk>
         <b42ce068884cf6bcf471425a30bc4e17711037b3.camel@ew.tq-group.com>
         <20210727170856.GA4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding syscon maintainers to CC again]

On Tue, 2021-07-27 at 18:08 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jul 27, 2021 at 02:24:17PM +0200, Matthias Schiffer wrote:
> > On Mon, 2021-07-26 at 19:48 +0100, Mark Brown wrote:
> > > The whole point here is to move the debugfs directory so if any fix
> > > stops that happening it's not really viable.
> > Looking at the history, I assume this already broke with cffa4b2122f5
> > ("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev").
> > This is why the kernel is trying to recreate the "dummy" debugfs
> > directory on my system when regmap_attach_dev() is called by imx-
> > pinctrl.
> 
> Right, before that we'd just overwrite the existing name.
> 
> > I'm not convinced that the behaviour before that commit was strictly
> > better - when regmap_debugfs_init() was called for the second time, the
> > new debugfs paths would be created, but the old ones were never
> > removed, they just leaked.
> 
> There's definitely a memory leak, although unless you're instantiating a
> lot of these devices it's going to be hard to notice.
> 
> > The thing on which I need clarification is whether it is okay to bind a
> > device to these shared regmaps at all:
> > There is nothing preventing two different drivers from calling
> > regmap_attach_dev() on the same regmap (AFAICT, this is actually
> > happening when both imx_rproc and reset-imx7 are enabled, as both use
> > the same syscon "SRC").
> 
> It's OK for one device to do it, but it should probably be the core
> syscon code not some random driver that happens to talk to the syscon.
> All the current users look at least somewhat suspicious unless they
> somehow coordinate with each other in ways that I can't determine.

The core syscon driver doesn't create a device anymore for regmaps
obtained using syscon_node_to_regmap() etc. since bdb0066df96e ("mfd:
syscon: Decouple syscon interface from platform devices") - so there is
no device the regmap could be bound to here.

(in fact, the platform_driver part of the syscon driver could have been
removed a while ago as suggested in that commit's description, as
nothing is using it anymore sice ~2018 - I'll send a patch to do that
later)

With no device available to own the regmap, leaving it unset seems
better to me than allowing an arbitrary consumer of the syscon regmap
to claim ownership.

> 
> > What I'm trying to find out here is if there are any legitimate users
> > of regmap_attach_dev(). If there aren't any, we can remove the API and
> > don't need to fix it.
> 
> There's a definite use case for it.  What's probably more interesting
> is if we have any users that create regmaps without a device, currently
> I can't seem to find any though it's possible my greps weren't good
> enough to spot them.  

`git grep 'regmap_init[^(]*(NULL'` gives me 5 places, one of them being
in the mentioned syscon driver (which in turn is used by 200~300 of
other drivers). There might be others where NULL isn't passed directly.



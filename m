Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2713D594D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhGZLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:38:18 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:39744 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233927AbhGZLiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627301926; x=1658837926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6BqAovoJSJ/354TmiwinWAu+ylcnd8r5szcvasIEkXc=;
  b=aEy71ig8Frqkk3lpNJBEFb/i2oNJC74FQJC0ouCR+fvruMGPHRkLtDKU
   B5BF9Marm6gEWeY3yGuDlug76tTvUnhdDg8N/aAu6LH2xzzsyYVHFyRn/
   xAeFmL9reNaIpQah7/SAtEIs9c1tXp7MwXaYQ4ci8uonmSISZI/8Ascsg
   79Knqq7Hl2q1sZaGQGuWtC45+9/KKN+6Neh6MMQoNZaj8f7vJmrPRRT5j
   ll4MZx8TJvU0u2chE38t3B/xrwj49N/Zja04XQKWuJc4GjffotathND63
   FxKrTiR2lGSY11QpxE5Hrp10cvk4gtapK6ygz/svYELPyt3jqPGDhJUI6
   w==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18639842"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jul 2021 14:18:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 26 Jul 2021 14:18:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 26 Jul 2021 14:18:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627301924; x=1658837924;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6BqAovoJSJ/354TmiwinWAu+ylcnd8r5szcvasIEkXc=;
  b=aa+0B2QGcI6ZIpnVCxs8kcY327pcAUIV3DU+Oo1QPOgHN8QhzmUxtZYJ
   dcsQj0JCo+ObNTgSxTc0kqMWpPhRD2XNmXyADp54sBZyNy4C3BI/uop+n
   OpqWTasr11coOK7mdGq55ZIw4TtxjF1kPNDA5FrIS+cBGGBDfR5T4PVL2
   mJUK6b6DENH+/nBLonPcjr9IBSHuMlMYxYvnZdXz6ZJlLKPkPXPwFJsVZ
   mVCwU2O4L03J9xk/s3uA9Rx+nd3wcBCUkc9POK5dlfBSYcjYKxR33j/AD
   fHd0jj3J0qZsSUexEliGNTycZiaYYKBKA9OnN/XKRB+UCElprqHHCPWvw
   w==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18639841"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jul 2021 14:18:44 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B6591280070;
        Mon, 26 Jul 2021 14:18:44 +0200 (CEST)
Message-ID: <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Jul 2021 14:18:42 +0200
In-Reply-To: <20210726121140.GH4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
         <20210726114751.GE4670@sirena.org.uk>
         <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
         <20210726121140.GH4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-26 at 13:11 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 26, 2021 at 02:01:51PM +0200, Matthias Schiffer wrote:
> > On Mon, 2021-07-26 at 12:47 +0100, Mark Brown wrote:
> > > The use case for regmap_attach_dev() is that there was no device when
> > > the regmap was initially instantiated due to it running very early, we
> > > want to attach the device when we figure out what it is which includes
> > > setting up the debugfs stuff.  Whatever is managing to call this with
> > > the same device as has already been set is clearly not that use case.
> > I'm not talking about a case where regmap_attach_dev() is called when
> > there is already a device attached; as far as I can tell such a thing
> > does not happen in current kernel code.
> 
> So in that case how are we managing to create a debugfs file with the
> same name given (which was the problem you were reporting) that the
> device name is embedded in the name of the debugfs file?
> 
> > Please have a look at the commit in the Fixes: tag. The duplicate
> > regmap_debugfs_init() happens even when no device was passed in
> > __regmap_init(), so the regmap_attach_dev() is the first time a device
> > it attached.
> 
> That's not what your patch says it's fixing, your patch says it's
> fixing an attempt to recreate the same directory as we had originally
> (we should probably clean up the one with no device but that's not what
> your commit does).  I think what you need to look at here is that we
> store map->debugfs_name and don't overwrite it when the device is
> supplied.
> 

That would be fine if regmap_debugfs_init() didn't do a lot more than
just create the debugfs directory. I'm more concerned about the mutex
and list head initialization that is happening on an already
initialized structure. I haven't looked in detail what the mutex and
list head are used for, but I assume bad things™ are going to happen
when someone is already holding the mutex or using the list.



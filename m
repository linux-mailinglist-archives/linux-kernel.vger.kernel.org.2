Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B374634D34C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhC2PG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:06:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:46836 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhC2PGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:06:15 -0400
IronPort-SDR: PKtnDDvBDJR80BaLe4+MJ6AfmDrhrYmiFhUAKzJpTHxJhiRrIKjaiJ055WWX8178VmpeEuRsO+
 MT6mf0sFVxaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="255562071"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="255562071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:06:13 -0700
IronPort-SDR: 545zvjtY9dG69WL9Ut7H/wMK+vDtjZmeAt2GKqPonMpv8o8JoGWp7DhNbafFxL0OqS+jLIAsQz
 asQHcfWxs7fg==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="417704531"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:06:10 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 29 Mar 2021 18:06:07 +0300
Date:   Mon, 29 Mar 2021 18:06:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <20210329150607.GJ2542@lahna.fi.intel.com>
References: <YGFulvAa5Kz6HTsd@mwanda>
 <20210329130220.GY2356281@nvidia.com>
 <20210329144323.GI2542@lahna.fi.intel.com>
 <20210329145405.GD2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329145405.GD2356281@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:54:05AM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 29, 2021 at 05:43:23PM +0300, Mika Westerberg wrote:
> 
> > The nvm is a separate (physical Linux) device that gets added under this
> > one. It cannot be added before AFAICT.
> 
> Hum, yes, but then it is odd that a parent is holding sysfs attributes
> that refer to a child.

Well the child (NVMem) comes from completely different subsystem that
does not have a concept of "authentication" or anythin similar. This is
what we add on top. We actually exposer two NVMem devices under each
retimer: one that is the current active one, and then the one that is
used to write the new firmware image.

> > The code you refer actually looks like this:
> > 
> > static ssize_t nvm_authenticate_store(struct device *dev,
> >  	struct device_attribute *attr, const char *buf, size_t count)
> > {
> > 	...
> >         if (!mutex_trylock(&rt->tb->lock)) {
> >                 ret = restart_syscall();
> >                 goto exit_rpm;
> >         }
> 
> Is that lock held during tb_retimer_nvm_add() I looked for a bit and
> didn't find something. So someplace more than 4 call site above
> mandatory locking is being held?

Yes it is. It is called from tb_scan_port() where that lock is held.

> static void tb_retimer_remove(struct tb_retimer *rt)
> {
> 	dev_info(&rt->dev, "retimer disconnected\n");
> 	tb_nvm_free(rt->nvm);
> 	device_unregister(&rt->dev);
> }
> 
> Here too?

Yes.

> And this is why it is all trylock because it deadlocks with unregister
> otherwise?

I tried to explain it in 09f11b6c99fe ("thunderbolt: Take domain lock in
switch sysfs attribute callbacks"), except that at that time we did not
have retimers exposed but the same applies here too.

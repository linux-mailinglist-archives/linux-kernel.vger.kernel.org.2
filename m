Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989A63467BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhCWSdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhCWSdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A82F7619C3;
        Tue, 23 Mar 2021 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616524380;
        bh=blp+hy/JGs0I9wj2BdEuYdLq8UU6QZuI7VWHXUe948g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmFaYaa0Z2BhwzXUK2yUbhUhMfWTQG3ks/JTARuWcLDimNspKxuEMHiRHWMVK7vor
         mrI5vuFgL3Uaux/dIoo1e5gZAUtBYWhkcdjt+dr5Z5we+ALkjb8uidCxQ86ogdvYfU
         c6TVKJMjhmaWz8VL291x0V3swP4DF7ssFDQpY8R4=
Date:   Tue, 23 Mar 2021 19:32:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFo0WW8hOsHesSFC@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:04:49PM -0500, Pierre-Louis Bossart wrote:
> 
> > > Note that the auxiliary bus API has separate init and add steps, which
> > > requires more attention in the error unwinding paths. The main loop
> > > needs to deal with kfree() and auxiliary_device_uninit() for the
> > > current iteration before jumping to the common label which releases
> > > everything allocated in prior iterations.
> > 
> > The init/add steps can be moved together in the aux bus code if that
> > makes this usage simpler.  Please do that instead.
> 
> IIRC the two steps were separated during the auxbus reviews to allow the
> parent to call kfree() on an init failure, and auxiliary_device_uninit()
> afterwards.
> 
> https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#auxiliary-device
> 
> With a single auxbus_register(), the parent wouldn't know whether to use
> kfree() or auxiliary_device_uinit() when an error is returned, would it?
> 

It should, you know the difference when you call device_register() vs.
device_initialize()/device_add(), for what to do, right?

Should be no difference here either :)

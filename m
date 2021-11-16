Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477CC452AED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhKPGbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhKPG3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:29:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AA8A614C8;
        Tue, 16 Nov 2021 06:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637044002;
        bh=AiP1xjR6qcKw8cmJ80lJrFN5bNbs0D2VyefHMyYb3z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAdWQ1YQxccyMONofsDbmG5JRlehNbsB99jOPJzaVFcdTRcA4ws39LiNWk3dB7uWb
         uNAT5/M4GeN3kEnYpwksavGrmR+POUUZtsZDKXx42L9m0V4gGSyQ+y+ecJSg6h7zao
         wwhvs9UzhWYf/FBFU0d7JfWEdkj/s1ZlCxm2+EV8=
Date:   Tue, 16 Nov 2021 07:26:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "d.mueller@elsoft.ch" <d.mueller@elsoft.ch>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "zweiss@equinix.com" <zweiss@equinix.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "bp@alien8.de" <bp@alien8.de>, "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 06/13] peci: Add device detection
Message-ID: <YZNPFGPXfCLfJMq3@kroah.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
 <20211115182552.3830849-7-iwona.winiarska@intel.com>
 <YZKr1Rqfx6Cmw+Ok@kroah.com>
 <368c990c30c5bacde15ac4bce5db8389aea3ec9c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <368c990c30c5bacde15ac4bce5db8389aea3ec9c.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:35:23PM +0000, Winiarska, Iwona wrote:
> On Mon, 2021-11-15 at 19:49 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 15, 2021 at 07:25:45PM +0100, Iwona Winiarska wrote:
> > > +void peci_device_destroy(struct peci_device *device)
> > > +{
> > > +       bool killed;
> > > +
> > > +       device_lock(&device->dev);
> > > +       killed = kill_device(&device->dev);
> > 
> > Eeek, why call this?
> > 
> > > +       device_unlock(&device->dev);
> > > +
> > > +       if (!killed)
> > > +               return;
> > 
> > What happened if something changed after you unlocked it?
> 
> We either killed it, or the other caller killed it.
> 
> > 
> > Why is kill_device() required at all?  That's a very rare function to
> > call, and one that only one "bus" calls today because it is very
> > special (i.e. crazy and broken...)
> 
> It's used to avoid double-delete in case of races between peci_controller
> unregister and "manually" removing the device using sysfs (pointed out by Dan in
> v2). We're calling peci_device_destroy() in both callsites.
> Other way to solve it would be to just have a peci-specific lock, but
> kill_device seemed to be well suited for the problem at hand.
> Do you suggest to remove it and just go with the lock?

Yes please, remove it and use the lock.

Also, why are you required to have a sysfs file that can remove the
device?  Who wants that?

thanks,

greg k-h

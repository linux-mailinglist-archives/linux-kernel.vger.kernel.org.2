Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D535E387A00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbhERNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244870AbhERNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DB60611CC;
        Tue, 18 May 2021 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621344664;
        bh=X53wMEAAhoR3qDgv6I72kl2g+HLNTa0WDNa3S6R6O5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMaBiMyrN7AbIR6l1QmB9cO8+qQ8w15UNy5GuSflZ2m2ZOLcF05ptFN9XRkrYCY8b
         AihL0TPjtCDRRR5ujG+5SmJpZlHUUpVSYaHkD+IoI8anHI5a1tscqaO2hfshTPvrUQ
         wrm24CUkxubvt/iYKGTrXFDJjdYnqFgxjvEALRig=
Date:   Tue, 18 May 2021 15:31:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 1/2] usb: typec: tcpm: Expose tcpm logs through a misc
 device
Message-ID: <YKPBlqRCXBKuXu1l@kroah.com>
References: <20210517233609.610248-1-badhri@google.com>
 <YKO6gANJ0Meaavas@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKO6gANJ0Meaavas@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 04:00:48PM +0300, Heikki Krogerus wrote:
> On Mon, May 17, 2021 at 04:36:08PM -0700, Badhri Jagan Sridharan wrote:
> > Although TCPM logs were primarily focussed to aid developers
> > during bringup, TCPM logs have proved to be critical even
> > post-bringup as it provides a good starting point to triage
> > interoperability issues with accessories. TCPM logs
> > are exposed through debugfs filesystem. For systems that
> > don't mount debugfs by default, this change introduces a
> > module parameter log_misc_dev which when set exports the
> > tcpm logs through a misc device. This change also leaves
> > the option of exporting tcpm logs through debugfs for
> > backwards compatibility.
> 
> This does not look correct to me. At the very least you need to now
> document your misc device interface. Why are you removing the choice
> whether to enable this or not? The module parameter does also not
> sound like a good idea at all.
> 
> I'm really not sure about this. This is just a poor man's debugfs that
> removes any choice of enabling it. Since clearly debugging related
> information is what you are after here, debugfs really should be
> enough for you.

I agree, this is an abuse of a misc device, not ok at all.

Just use debugfs if you really want this type of thing, that is what it
is there for.

> 
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 98 +++++++++++++++++++++++++----------
> >  1 file changed, 72 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index c4fdc00a3bc8..b79194919b27 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kthread.h>
> > +#include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/power_supply.h>
> > @@ -33,6 +34,10 @@
> >  
> >  #include <uapi/linux/sched/types.h>
> >  
> > +static bool modparam_log_misc_dev;
> > +module_param_named(log_misc_dev, modparam_log_misc_dev, bool, 0444);
> > +MODULE_PARM_DESC(log_misc_dev, "Expose tcpm logs through misc device");

This is not the 1990's, no new module parameters please.

thanks,

greg k-h

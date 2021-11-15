Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DD45013B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKOJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:27:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:64451 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237574AbhKOJ0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:26:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="257156736"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="257156736"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644783363"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 15 Nov 2021 01:21:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Nov 2021 11:21:31 +0200
Date:   Mon, 15 Nov 2021 11:21:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <YZImm0UIy3os5H6Q@kuha.fi.intel.com>
References: <20211108102833.2793803-1-megous@megous.com>
 <YZIILh++KIEK/ZA5@kuha.fi.intel.com>
 <20211115085532.xoufihjxkxzhxehv@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115085532.xoufihjxkxzhxehv@core>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:55:32AM +0100, Ondřej Jirman wrote:
> On Mon, Nov 15, 2021 at 09:11:42AM +0200, Heikki Krogerus wrote:
> > On Mon, Nov 08, 2021 at 11:28:32AM +0100, Ondrej Jirman wrote:
> > > The code that enables either BC_LVL or COMP_CHNG interrupt in tcpm_set_cc
> > > wrongly assumes that the interrupt is unmasked by writing 1 to the apropriate
> > > bit in the mask register. In fact, interrupts are enabled when the mask
> > > is 0, so the tcpm_set_cc enables interrupt for COMP_CHNG when it expects
> > > BC_LVL interrupt to be enabled.
> > > 
> > > This causes inability of the driver to recognize cable unplug events
> > > in host mode (unplug is recognized only via a COMP_CHNG interrupt).
> > > 
> > > In device mode this bug was masked by simultaneous triggering of the VBUS
> > > change interrupt, because of loss of VBUS when the port peer is providing
> > > power.
> > > 
> > > Fixes: 48242e30532b ("usb: typec: fusb302: Revert "Resolve fixed power role contract setup"")
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > 
> > Should this go to stable?
> 
> Without this patch, VBUS is not turned off when I disconnect a hub from the
> Type-C port (because fusb302 will not notice the disconnect), and it stays on
> until next plugin of some device, say a normal non PD charger.
> 
> So I guess for a brief period you can have both sides provide VBUS (until
> fusb302/tcpm processes the next plugin). It may be a problem if VBUS was more
> than 5V (not very likely for devices running this driver, I guess).

OK. So this should find it's way to the stable kernel releases as
well, and it should have the appropriate "Cc: stable@vger.kernel.org"
tag:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch

thanks,

-- 
heikki

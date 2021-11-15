Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF624500AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhKOJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:01:13 -0500
Received: from vps.xff.cz ([195.181.215.36]:41360 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236450AbhKOI6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636966533; bh=d50ygQIl4xyi+CFcaYZm/HWlHmRPB2BUhTqVe9UmMDQ=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=KsicvgdArPDyw6VC2zL2P5Q15EwRId0paiPvJQ0XEYwDOh7oV1V0cBmbNLaeYTkri
         F74QcaTCw9KeDl+IvNTeqdYqzeXlasssjRX1oLVKvF95SBb6dwjiY1qWIFVPiRl+8C
         TYzawrq2FdxC9Zyk6OzUqg2J2GkVSg7PsChQA3Vo=
Date:   Mon, 15 Nov 2021 09:55:32 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <20211115085532.xoufihjxkxzhxehv@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20211108102833.2793803-1-megous@megous.com>
 <YZIILh++KIEK/ZA5@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZIILh++KIEK/ZA5@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:11:42AM +0200, Heikki Krogerus wrote:
> On Mon, Nov 08, 2021 at 11:28:32AM +0100, Ondrej Jirman wrote:
> > The code that enables either BC_LVL or COMP_CHNG interrupt in tcpm_set_cc
> > wrongly assumes that the interrupt is unmasked by writing 1 to the apropriate
> > bit in the mask register. In fact, interrupts are enabled when the mask
> > is 0, so the tcpm_set_cc enables interrupt for COMP_CHNG when it expects
> > BC_LVL interrupt to be enabled.
> > 
> > This causes inability of the driver to recognize cable unplug events
> > in host mode (unplug is recognized only via a COMP_CHNG interrupt).
> > 
> > In device mode this bug was masked by simultaneous triggering of the VBUS
> > change interrupt, because of loss of VBUS when the port peer is providing
> > power.
> > 
> > Fixes: 48242e30532b ("usb: typec: fusb302: Revert "Resolve fixed power role contract setup"")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Should this go to stable?

Without this patch, VBUS is not turned off when I disconnect a hub from the
Type-C port (because fusb302 will not notice the disconnect), and it stays on
until next plugin of some device, say a normal non PD charger.

So I guess for a brief period you can have both sides provide VBUS (until
fusb302/tcpm processes the next plugin). It may be a problem if VBUS was more
than 5V (not very likely for devices running this driver, I guess).

regards,
	o.

> Acked-by: Heikki Krogerus@linux.intel.com
> 
> > ---
> >  drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > index 7a2a17866a823..72f9001b07921 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -669,25 +669,27 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
> >  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
> >  					     FUSB_REG_MASK_BC_LVL |
> >  					     FUSB_REG_MASK_COMP_CHNG,
> > -					     FUSB_REG_MASK_COMP_CHNG);
> > +					     FUSB_REG_MASK_BC_LVL);
> >  		if (ret < 0) {
> >  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
> >  				    ret);
> >  			goto done;
> >  		}
> >  		chip->intr_comp_chng = true;
> > +		chip->intr_bc_lvl = false;
> >  		break;
> >  	case TYPEC_CC_RD:
> >  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
> >  					     FUSB_REG_MASK_BC_LVL |
> >  					     FUSB_REG_MASK_COMP_CHNG,
> > -					     FUSB_REG_MASK_BC_LVL);
> > +					     FUSB_REG_MASK_COMP_CHNG);
> >  		if (ret < 0) {
> >  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
> >  				    ret);
> >  			goto done;
> >  		}
> >  		chip->intr_bc_lvl = true;
> > +		chip->intr_comp_chng = false;
> >  		break;
> >  	default:
> >  		break;
> 
> thanks,
> 
> -- 
> heikki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9D44FF25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhKOHTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:19:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:20291 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhKOHSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:18:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233636854"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="233636854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 23:15:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="644736296"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 14 Nov 2021 23:15:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Nov 2021 09:15:06 +0200
Date:   Mon, 15 Nov 2021 09:15:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <YZII+nKfVuPjn0wy@kuha.fi.intel.com>
References: <20211108102833.2793803-1-megous@megous.com>
 <YZIILh++KIEK/ZA5@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZIILh++KIEK/ZA5@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:11:48AM +0200, Heikki Krogerus wrote:
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
> 
> Acked-by: Heikki Krogerus@linux.intel.com

Sorry, that's wrong...

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


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

-- 
heikki

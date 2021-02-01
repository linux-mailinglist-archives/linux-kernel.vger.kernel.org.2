Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BF30ACDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBAQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhBAQjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:39:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E50DB60235;
        Mon,  1 Feb 2021 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612197537;
        bh=dmJ780YfV7WU9jyBknVx3SR8qV5fVlxQCRjWvZqC9nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIUE2A98mrYmpRQnu428tqjfCOGrx/PWVOBdeDsswJ7aIkxsG0L8h7raptbw1j6GF
         nHzdk28gIYl3FayMtxN9syesotPNFx3l3yXl35QGf9YrIn7c3vjzTPn2uoUrC7ni/S
         Rc1N/Lnv+MQuNsDfh0dq3vEq+LVRhxSltyzeoAKU=
Date:   Mon, 1 Feb 2021 17:38:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
Message-ID: <YBgunjrmQsFkYBvm@kroah.com>
References: <20210201095309.39486-1-badhri@google.com>
 <20210201151253.GG2465@kuha.fi.intel.com>
 <YBgcCu7lx036C+KN@kroah.com>
 <20210201160925.GA1433721@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201160925.GA1433721@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 06:09:25PM +0200, Heikki Krogerus wrote:
> On Mon, Feb 01, 2021 at 04:19:38PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 01, 2021 at 05:12:53PM +0200, Heikki Krogerus wrote:
> > > On Mon, Feb 01, 2021 at 01:53:07AM -0800, Badhri Jagan Sridharan wrote:
> > > > The USB Communications Capable bit indicates if port
> > > > partner is capable of communication over the USB data lines
> > > > (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
> > > > level drivers to perform chip specific operation.
> > > > For instance, low level driver enables USB switches on D+/D-
> > > > lines to set up data path when the bit is set.
> > > > 
> > > > Refactored from patch initially authored by
> > > > Kyle Tso <kyletso@google.com>
> > > > 
> > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > ---
> > > >  drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++++++++++
> > > >  include/linux/usb/tcpm.h      |  5 +++++
> > > >  2 files changed, 21 insertions(+)
> > > 
> > > ...
> > > 
> > > > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > > > index 3af99f85e8b9..42fcfbe10590 100644
> > > > --- a/include/linux/usb/tcpm.h
> > > > +++ b/include/linux/usb/tcpm.h
> > > > @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
> > > >   *		is supported by TCPC, set this callback for TCPM to query
> > > >   *		whether vbus is at VSAFE0V when needed.
> > > >   *		Returns true when vbus is at VSAFE0V, false otherwise.
> > > > + * @set_partner_usb_comm_capable:
> > > > + *              Optional; The USB Communications Capable bit indicates if port
> > > > + *              partner is capable of communication over the USB data lines
> > > > + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> > > >   */
> > > >  struct tcpc_dev {
> > > >  	struct fwnode_handle *fwnode;
> > > > @@ -139,6 +143,7 @@ struct tcpc_dev {
> > > >  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> > > >  						 bool pps_active, u32 requested_vbus_voltage);
> > > >  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> > > > +	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
> > > >  };
> > > >  
> > > >  struct tcpm_port;
> > > 
> > > There start to be a lot of callback there, separate for each function.
> > > And I guess flags too... Would it be possible to have a single
> > > notification callback instead, that would take the type of the
> > > notification as a parameter (we could have an enum for those), and
> > > then the specific object(s) for each type as another paramter (RDO I
> > > guess in this case)?
> > > 
> > > It would then be up to the TCPC driver to extract the detail it needs
> > > from that object. That would somehow feel more cleaner to me, but what
> > > do you guys think?
> > 
> > It's pretty much the same thing, a "mux" function vs. individual
> > function calls.  Personally, individual callbacks are much more
> > explicit, and I think make it easier to determine what is really going
> > on in each driver.
> > 
> > But it all does the same thing, if there's going to be loads of
> > callbacks needed, then a single one makes it easier to maintain over
> > time.
> > 
> > So it's up to the maintainer what they want to see :)
> 
> I understand your point, and I guess a "generic" notification callback
> for all that would not be a good idea. However, right now it looks
> like we are picking individual bits from various PD objects with those
> callbacks, and that does not feel ideal to me either. After all, each of
> those bits has its own flag now, even though the details is just
> extracted from some PD object that we should also have access to.
> 
> I think there are ways we can improve this for example by attempting
> to create the notifications per transaction instead of for each
> individual result of those transactions. That way we would not need to
> store the flags at least because we could deliver the entire object
> that was the result of the specific transaction.
> 
> So basically, I fear that dealing with these individual bits will in
> many case only serve individual device drivers, and in the worst case
> start making the tcpm.c a bit more difficult to manage if we start to
> have more and more of these bit callbacks.
> 
> But on the other hand, I guess we are nowhere near that point, so
> let's forget about this for now.

If it gets unwieldy, we can always change it in the future, there's no
reason these types of in-kernel apis can not be modified and cleaned up
over time.

thanks,

greg k-h

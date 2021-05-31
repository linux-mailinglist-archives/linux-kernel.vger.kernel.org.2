Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C52395605
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhEaH0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:26:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:15403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhEaH0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:26:16 -0400
IronPort-SDR: faWAdosKWOr2j3fnMnwGFkLhoyyvdyfEkuRe479N0mqx1BooIBVoj7Ry5xBSmSvDSIUiWBxHct
 aXyRH0576u8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="224579964"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="224579964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 00:24:34 -0700
IronPort-SDR: 5mCjVwBtiV3M+fkTUXd1gBdyjpQRkPKVFBDDKL/kf2RIV59Rwm9Tnj03BkeYQBQyvlyyvC8AzT
 z9Ys9jbgxBLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549328989"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 00:24:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 10:24:31 +0300
Date:   Mon, 31 May 2021 10:24:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Message-ID: <YLSPLxfyavO+AkLY@kuha.fi.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
 <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 07:26:43AM +0000, Jun Li wrote:
> Hi,
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Wednesday, May 26, 2021 11:36 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Hans de Goede
> > <hdegoede@redhat.com>; Jun Li <jun.li@nxp.com>
> > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 2/2] usb: typec: mux: Remove requirement for the
> > "orientation-switch" device property
> > 
> > The additional boolean device property "orientation-switch"
> > is not needed when the connection is described with device graph, so removing
> > the check and the requirement for it.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/mux.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c index
> > e40a555724fb6..603f3e698cc0b 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -30,9 +30,6 @@ static void *typec_switch_match(struct fwnode_handle
> > *fwnode, const char *id,  {
> >  	struct device *dev;
> > 
> > -	if (id && !fwnode_property_present(fwnode, id))
> > -		return NULL;
> > -
> 
> May this change the result of fwnode_connection_find_match()
> if there are multiple remote-endpoint node?
> 
> After the 2 patches change, typec_switch_match() will never
> return NULL, so
> 
>   17 static void *
>   18 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>   19                           void *data, devcon_match_fn_t match)
>   20 {               
>   21         struct fwnode_handle *node;
>   22         struct fwnode_handle *ep;
>   23         void *ret;
>   24                         
>   25         fwnode_graph_for_each_endpoint(fwnode, ep) {
>   26                 node = fwnode_graph_get_remote_port_parent(ep);
>   27                 if (!fwnode_device_is_available(node))
>   28                         continue;
>   29 
>   30                 ret = match(node, con_id, data);// ret can't be NULL;
>   31                 fwnode_handle_put(node); 
>   32                 if (ret) {
> 							 /*
> 							  * So loop will go to here and stop
> 							  * checking next ep, even this ep
> 							  * actually is not for typec_switch
> 							  */
>   33                         fwnode_handle_put(ep);
>   34                         return ret;
>   35                 }
>   36         }
>   37         return NULL;
>   38 }
> 
> fwnode_graph_devcon_match() Will return ERR_PTR(-EPROBE_DEFER)
> even this ep's remote parent already probed but it's not for
> typec_switch.

You are correct. With device graph I guess we really always need the
extra device property after all.

So let's forget about this one.


thanks,

-- 
heikki

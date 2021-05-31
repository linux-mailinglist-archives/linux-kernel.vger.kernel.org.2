Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF13956F2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:28:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:58531 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaI2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:28:09 -0400
IronPort-SDR: rmqRdEM9BC1IxzhuKkW0TH/+v5NG5gMEYWOBshg0KyotFGd1N3r3NfLrOrjh5PY5kN9Inpv7OH
 INBaI0tUNOyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="200302011"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="200302011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 01:26:17 -0700
IronPort-SDR: i8lA8981c5xok7E0UrTynadAi15BHb5g4AwL092wwf0sl+ddEBGgDE+Y/NAIWdnv25boJFccmF
 FqZqTjtBZjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549343754"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 01:26:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 11:26:14 +0300
Date:   Mon, 31 May 2021 11:26:14 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Message-ID: <YLSdptmScGo5TJ1D@kuha.fi.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
 <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
 <YLSPLxfyavO+AkLY@kuha.fi.intel.com>
 <YLSW0IoHdnzRSzUW@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLSW0IoHdnzRSzUW@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:57:04AM +0300, Heikki Krogerus wrote:
> On Mon, May 31, 2021 at 10:24:35AM +0300, Heikki Krogerus wrote:
> > On Fri, May 28, 2021 at 07:26:43AM +0000, Jun Li wrote:
> > > Hi,
> > > > -----Original Message-----
> > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Sent: Wednesday, May 26, 2021 11:36 PM
> > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Hans de Goede
> > > > <hdegoede@redhat.com>; Jun Li <jun.li@nxp.com>
> > > > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH 2/2] usb: typec: mux: Remove requirement for the
> > > > "orientation-switch" device property
> > > > 
> > > > The additional boolean device property "orientation-switch"
> > > > is not needed when the connection is described with device graph, so removing
> > > > the check and the requirement for it.
> > > > 
> > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > ---
> > > >  drivers/usb/typec/mux.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c index
> > > > e40a555724fb6..603f3e698cc0b 100644
> > > > --- a/drivers/usb/typec/mux.c
> > > > +++ b/drivers/usb/typec/mux.c
> > > > @@ -30,9 +30,6 @@ static void *typec_switch_match(struct fwnode_handle
> > > > *fwnode, const char *id,  {
> > > >  	struct device *dev;
> > > > 
> > > > -	if (id && !fwnode_property_present(fwnode, id))
> > > > -		return NULL;
> > > > -
> > > 
> > > May this change the result of fwnode_connection_find_match()
> > > if there are multiple remote-endpoint node?
> > > 
> > > After the 2 patches change, typec_switch_match() will never
> > > return NULL, so
> > > 
> > >   17 static void *
> > >   18 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >   19                           void *data, devcon_match_fn_t match)
> > >   20 {               
> > >   21         struct fwnode_handle *node;
> > >   22         struct fwnode_handle *ep;
> > >   23         void *ret;
> > >   24                         
> > >   25         fwnode_graph_for_each_endpoint(fwnode, ep) {
> > >   26                 node = fwnode_graph_get_remote_port_parent(ep);
> > >   27                 if (!fwnode_device_is_available(node))
> > >   28                         continue;
> > >   29 
> > >   30                 ret = match(node, con_id, data);// ret can't be NULL;
> > >   31                 fwnode_handle_put(node); 
> > >   32                 if (ret) {
> > > 							 /*
> > > 							  * So loop will go to here and stop
> > > 							  * checking next ep, even this ep
> > > 							  * actually is not for typec_switch
> > > 							  */
> > >   33                         fwnode_handle_put(ep);
> > >   34                         return ret;
> > >   35                 }
> > >   36         }
> > >   37         return NULL;
> > >   38 }
> > > 
> > > fwnode_graph_devcon_match() Will return ERR_PTR(-EPROBE_DEFER)
> > > even this ep's remote parent already probed but it's not for
> > > typec_switch.
> > 
> > You are correct. With device graph I guess we really always need the
> > extra device property after all.
> > 
> > So let's forget about this one.
> 
> Oh no. This patch just landed into Greg's usb-next. I'll prepare the
> revert. I'm sorry about this.

Actually, if we always need that extra (boolean) device property to
identify the device class when OF graph is used, shouldn't we just do
that always in fwnode_graph_devcon_match()?

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1421e9548857b..238da64375bb1 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1263,6 +1263,13 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
                if (!fwnode_device_is_available(node))
                        continue;
 
+               /*
+                * With device graph @con_id is expected to be the name of the
+                * "device class" of the fwnode.
+                */
+               if (con_id && !fwnode_property_present(node, con_id))
+                       continue;
+
                ret = match(node, con_id, data);
                fwnode_handle_put(node);
                if (ret) {

thanks,

-- 
heikki

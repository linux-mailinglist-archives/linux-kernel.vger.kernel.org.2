Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42513405770
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376810AbhIINe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:34:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:7486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358347AbhIINHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:07:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200306463"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="200306463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 05:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="606824869"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Sep 2021 05:55:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 09 Sep 2021 15:55:15 +0300
Date:   Thu, 9 Sep 2021 15:55:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Kun" <Kun.Liu2@amd.com>
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Message-ID: <YToEM3NLebXmLNrY@kuha.fi.intel.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org>
 <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
 <YSXwkKJ53d/uwnhy@kuha.fi.intel.com>
 <BL1PR12MB51443C94208DDE0AEBCB91A6F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YSef0Iyr3oDWv6Kt@kuha.fi.intel.com>
 <a06b1b50-771c-312d-c91e-b6707c4b9401@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06b1b50-771c-312d-c91e-b6707c4b9401@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 02, 2021 at 06:15:55PM +0530, Shah, Nehal-bakulchandra wrote:
> Hi Heikki,
> On 8/26/2021 7:36 PM, Heikki Krogerus wrote:
> > Hi Alexander,
> > 
> > On Wed, Aug 25, 2021 at 01:50:48PM +0000, Deucher, Alexander wrote:
> > > I'm not a USB expert, but I think the idea was to pop up a message asking the
> > > user what role they wanted when they plugged in USB cable?  Then based on
> > > their input, the role could be changed.
> > 
> > What exactly is the ACPI/EC interrupt in this case?
> > 
> > Note, that simply selecting one role will only work if the partner
> > device happens to be in the opposite role at the same time (actually,
> > even that may not be enough). So for example by selecting host role
> > will only work if the partner happens to be in device role. If the
> > parter is also in host role, nothing happens, or both ends just fail
> > to enumerate each other.
> > 
> > So you always have to negotiate the role with the partner one way or
> > the other. Now we need to understand how that negotiation is handled
> > (or is expected to be handled) on this platform.
> > 
> > Which type of connector are we talking about here? Is it USB Type-C,
> > or is it something else?
> > 
> > thanks,
> > 
> Sorry for the delayed response due to few designed changes. Now we have more
> clarity for the customer platform with respect to usage of DWC3 controller
> driver. So it is type C controller which will be using ACPI based UCSI
> driver. As UCSI driver has already role switch support we may not need this
> patch. However we need your input to understand this,
> 
> con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
> 
> For this to work, how should be ACPI entry to be defined. Do you have sample
> code, we had discussion on similar point in past but still need some clarity
> if we have sample ACPI ASL Code. I remember something on this line from
> previous discussion with following sample code.
> 
> /*
>  * I2C1 is the I2C host, and PDC1 is the USB PD Controller (I2C slave
> device).
>  */
> Scope (\_SB.PCI0.I2C1.PDC1)
> {
>         /* Each connector should have its own ACPI device entry (node). */
>         Device (CON0)
>         {
>                 Name (_ADR, 0)
> 
>                 Name (_DSD, Package () {
>                     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                     Package() {
>                         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
>                     }
>                 })
>         }
> }

In your case, the dwc3 is also the USB host controller, no?

The ACPI guys tell me that in ACPI we should rely on the _PLD
(Physical Location of Device) when determining to which USB Type-C
connector any given USB port (or any other port - like DP) is
connected to. Basically, the connector ACPI device node and the USB
port ACPI device node share the same _PLD, and that's how we know they
are connected. I'm already using that to create a symlink "connector"
for every USB port here: drivers/usb/typec/port-mapper.c

I'm not actually sure how did the ACPI guys think this will work with
USB device controllers, but if your controller is also the USB host
controller, then you will have a separate device node for every
port the host is controlling, and each of those will have the _PLD.

Can you send acpidump so I can take a look what you actually have
under your dwc3 ACPI device node?

        % acpidump -o my_acpi.dump

We most likely do need to update the fwnode_usb_role_switch_get() api
so that it also considers the _PLD, but your ACPI tables maybe
already OK (big maybe).


> So here is the another question , if we can not achieve this in BIOS , Can
> we register the software node with quirk in DWC3 controller something like
> this
> 
> static const struct software_node amd_dwc3_node[] = {
> 	{ "amd-dwc3-usb-sw", NULL, amd_dwc3_props },
> 	{},
> };
> 
> if (dwc->use_sw_node_quirk) {
> 		ret = software_node_register_nodes(amd_dwc3_node);
> 		if (ret)
> 			return ret;
> 		dwc3_role_switch.fwnode = software_node_fwnode(&amd_dwc3_node[0]);
> 	} else {
> 		dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
> 	}
> 	
> 
> And in UCSI driver again with quirk,
> 
> swnode = software_node_find_by_name(NULL, "amd-dwc3-usb-sw");
> 
> fwnode = software_node_fwnode(swnode);
> 
> con->usb_role_sw = usb_role_switch_find_by_fwnode(fwnode);
> 
> 
> Please provide your input that will help us .

Let's first check if we can we use _PLD for this.


thanks,

-- 
heikki

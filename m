Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A7349418
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhCYObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:31:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57591 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231349AbhCYObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:31:06 -0400
Received: (qmail 788278 invoked by uid 1000); 25 Mar 2021 10:31:04 -0400
Date:   Thu, 25 Mar 2021 10:31:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     liulongfang <liulongfang@huawei.com>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        tanxiaofei@huawei.com, liudongdong3@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:XHCI:Adjust the log level of hub
Message-ID: <20210325143104.GA785961@rowland.harvard.edu>
References: <1616666652-37920-1-git-send-email-liulongfang@huawei.com>
 <YFxmaEtKclXXpBfy@kroah.com>
 <d2fc6d09-c8e7-436f-3e0d-b2cfa9c75b9f@huawei.com>
 <YFyXJ1Zq5yP7vRWn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyXJ1Zq5yP7vRWn@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:59:03PM +0100, Greg KH wrote:
> On Thu, Mar 25, 2021 at 09:33:53PM +0800, liulongfang wrote:
> > On 2021/3/25 18:31, Greg KH wrote:
> > > On Thu, Mar 25, 2021 at 06:04:12PM +0800, Longfang Liu wrote:
> > >> When the number of ports of the hub is not between 1 and Maxports,
> > >> it will only exit the registration of the hub on the current controller,
> > >> but it will not affect the function of the controller itself. Its other
> > >> hubs can operate normally, so the log level here can be changed from
> > >> error to information.
> > >>
> > >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> > >> ---
> > >>  drivers/usb/core/hub.c | 10 ++++------
> > >>  1 file changed, 4 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > >> index b1e14be..70294ad 100644
> > >> --- a/drivers/usb/core/hub.c
> > >> +++ b/drivers/usb/core/hub.c
> > >> @@ -1409,13 +1409,11 @@ static int hub_configure(struct usb_hub *hub,
> > >>  		maxchild = min_t(unsigned, maxchild, USB_SS_MAXPORTS);
> > >>  
> > >>  	if (hub->descriptor->bNbrPorts > maxchild) {
> > >> -		message = "hub has too many ports!";
> > >> -		ret = -ENODEV;
> > >> -		goto fail;
> > >> +		dev_info(hub_dev, "hub has too many ports!\n");
> > > 
> > > Is this an error?  If so, report it as such, not as "information".
> > > 
> > >> +		return -ENODEV;
> > >>  	} else if (hub->descriptor->bNbrPorts == 0) {
> > >> -		message = "hub doesn't have any ports!";
> > >> -		ret = -ENODEV;
> > >> -		goto fail;
> > >> +		dev_info(hub_dev, "hub doesn't have any ports!\n");
> > > 
> > > Same here.
> > > 
> > > What problem are you trying to solve here?
> > > 
> > > What hub do you have that has no ports, or too many, that you think
> > > should still be able to work properly?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > .
> > On our test platform, the xhci usb3 hub has no port.
> 
> Sounds like a broken device, why not fix that?

If this device is used only for testing and not for production, who 
cares how severe the log message is?

> > when initializing the usb3 hub, an error will be reported
> > because the port is 0, but in fact it will not affect
> > the use of usb2, and the usb2 hub is working normally.
> 
> But you can not have a USB3 hub with no ports, isn't that against
> against the USB spec?  How does this device pass the USB-IF
> certification?
> 
> > thanks, therefore, in order to reduce the severity of the log,
> > we hope to lower the level of this log.
> 
> You did not reduce the severity at all, everyone can still see it.
> 
> Please try fixing your hardware :

Alternatively, you could change the xhci-hcd driver.  Make it skip 
registering the USB-3 root hub if that hub has no ports.

But don't change these log messages.  They describe real errors, so they 
should be actual error messages.

Alan Stern

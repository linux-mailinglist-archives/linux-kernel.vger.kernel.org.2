Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B33B1EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:44:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56843 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229938AbhFWQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:44:07 -0400
Received: (qmail 500580 invoked by uid 1000); 23 Jun 2021 12:41:48 -0400
Date:   Wed, 23 Jun 2021 12:41:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu.Beznea@microchip.com
Cc:     gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210623164148.GC499969@rowland.harvard.edu>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:33:14PM +0000, Claudiu.Beznea@microchip.com wrote:
> On 23.06.2021 17:19, Alan Stern wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 23, 2021 at 02:09:16PM +0000, Claudiu.Beznea@microchip.com wrote:
> >> On 23.06.2021 16:59, Alan Stern wrote:
> >>> One thing you might consider changing: The name of the
> >>> ohci_at91_port_suspend routine is misleading.  It doesn't really
> >>> handle suspending the port; instead it handles the clocks that drive
> >>> the entire OHCI controller.  Right?
> >>
> >> It does both as far as I can tell at the moment.
> > 
> > But the name suggests that it only handles suspending a port.  That's
> > misleading.
> > 
> > And the way it is used in the SetPortFeature(USB_PORT_FEAT_SUSPEND)
> > case in ohci_at91_hub_control is just plain wrong.  It won't merely
> > suspend a single port; it will disable the entire OHCI controller.
> 
> Agree with all the above!

Are there any systems beside the SAMA7G5 and others you tested which 
might be affected by this patch?  Do they all work pretty much the 
same way?  (I want to make sure no others will be adversely affected 
by this change.)

Alan Stern

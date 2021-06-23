Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E683B1C40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhFWOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:21:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49737 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230498AbhFWOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:21:25 -0400
Received: (qmail 493616 invoked by uid 1000); 23 Jun 2021 10:19:07 -0400
Date:   Wed, 23 Jun 2021 10:19:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu.Beznea@microchip.com
Cc:     gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210623141907.GC491169@rowland.harvard.edu>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:09:16PM +0000, Claudiu.Beznea@microchip.com wrote:
> On 23.06.2021 16:59, Alan Stern wrote:
> > One thing you might consider changing: The name of the
> > ohci_at91_port_suspend routine is misleading.  It doesn't really
> > handle suspending the port; instead it handles the clocks that drive
> > the entire OHCI controller.  Right?
> 
> It does both as far as I can tell at the moment.

But the name suggests that it only handles suspending a port.  That's 
misleading.

And the way it is used in the SetPortFeature(USB_PORT_FEAT_SUSPEND) 
case in ohci_at91_hub_control is just plain wrong.  It won't merely 
suspend a single port; it will disable the entire OHCI controller.

Alan Stern

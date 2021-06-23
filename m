Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7DD3B1BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhFWOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:01:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45973 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230274AbhFWOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:01:34 -0400
Received: (qmail 492480 invoked by uid 1000); 23 Jun 2021 09:59:15 -0400
Date:   Wed, 23 Jun 2021 09:59:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu.Beznea@microchip.com
Cc:     gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210623135915.GB491169@rowland.harvard.edu>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:47:56PM +0000, Claudiu.Beznea@microchip.com wrote:
> On 10.06.2021 02:07, Alan Stern wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 09, 2021 at 03:10:27PM +0300, Claudiu Beznea wrote:
> >> On SAMA7G5 suspending ports will cut the access to OHCI registers and
> >> any subsequent access to them will lead to CPU being blocked trying to
> >> access that memory. Same thing happens on resume: if OHCI memory is
> >> accessed before resuming ports the CPU will block on that access. The
> >> OCHI memory is accessed on suspend/resume though
> >> ohci_suspend()/ohci_resume().
> > 
> > That sounds very strange.
> 
> The clock scheme for OHCI and EHCI IPs on SAMA7G5 is as follows
> (I hope it is readable):
> 
>                                             Main Xtal
>                                                |
>                                                +-------------+
>                                                |             |
> +---------------------------+                 \ /            |
> |                 +------+  | 60MHz  +--------------------+  |
> |                 |      |  |        |                    |------+
> |                 | Port |<----------| UTMI Transceiver A |  |   |
> |                 |      |  |        |                    |----+ |
> |  USB 2.0 EHCI   |Router|  |        +--------------------+  | | |
> | Host Controller |      |  | 60MHz  +--------------------+  | | |
> |                 |      |<----------| UTMI Transceiver B |<-+ | |
> |                 |      |  |        +--------------------+  | | |
> |                 |      |  | 60MHz  +--------------------+  | | |
> |                 |      |<----------| UTMI Transceiver C |<-+ | |
> |                 |      |  |        +--------------------+    | |
> |                 +------+  |                                  | |
> |                           |                                  | |
> +---------------------------+                                  | |
>                                                                | |
> +---------------------------+                                  | |
> |                 +------+  |         UHP48M                   | |
> |                 | Root |  |<---------------------------------+ |
> |  USB 1.1 OHCI   | hub  |  |                                    |
> | Host Controller | and  |  |         UHP12M                     |
> |                 | host |  |<-----------------------------------+
> |                 | SIE  |  |
> |                 +------+  |
> |                           |
> +---------------------------+
> 
> Where UTMI transceiver A generates the 48MHz and 12MHz clocks for OHCI
> full-speed operations.
> 
> The ports control is done through AT91_SFR_OHCIICR via
> ohci_at91_port_suspend() function where. Setting 0 in AT91_SFR_OHCIICR
> means suspend is controlled by EHCI-OHCI and 1 forces the port suspend.
> Suspending the port A will cut the clocks for OHCI. I want to mention that
> AT91_SFR_OHCIICR register is not in the same memory space of OHCI, EHCI IPs
> and is clocked by other clocks.
> 
> > Suppose one of the ports is suspended, so access to the
> > OHCI registers is blocked.  Then how can you resume the port? 
> 
> For run-time control (via ohci_at91_hub_control()), I agree with you that
> the current implemented approach is not healthy (taking into account the
> clock scheme above) and the fact that we do force the ports suspend on
> ohci_at91_hub_control(). For suspend/resume it should be OK as the ports
> are suspended at the end of any OHCI accesses (I don't know how the Linux
> USB subsystem behaves so please do correct me if I'm wrong).

(I haven't checked the details recently, so I'm not certain about 
this.)  In some -- perhaps all -- cases, we don't suspend the ports at 
all during system suspend.  We just rely on the USB devices 
automatically going into suspend when the root hub stops sending 
packets.

> > Don't you have to
> > access the OHCI registers in order to tell the controller to do the port resume?
> 
> On our implementation we control the port suspend/resume via
> AT91_SFR_OHCIICR, a special kind of register, memory mapped at different
> address (compared w/ OHCI, EHCI IPs), so clocked by other clocks.
> 
> > 
> > What happens when there's more than one port, and one of them is suspended while
> > the other one is still running?  How can you communicate with the active port if
> > access to the OHCI registers is blocked?
> 
> For this kind of scenario (the run-time suspend of a port, not system
> suspend/resume) a different mechanism should be implemented taking into
> account the clock schema presented above.

Okay, I see.  It seems like the driver will need some significant 
changes to handle runtime power management properly.

One thing you might consider changing: The name of the 
ohci_at91_port_suspend routine is misleading.  It doesn't really 
handle suspending the port; instead it handles the clocks that drive 
the entire OHCI controller.  Right?

Alan Stern

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66E43B2FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFXNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:25:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49257 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231459AbhFXNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:25:24 -0400
Received: (qmail 528686 invoked by uid 1000); 24 Jun 2021 09:23:04 -0400
Date:   Thu, 24 Jun 2021 09:23:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu.Beznea@microchip.com
Cc:     gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210624132304.GA528247@rowland.harvard.edu>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
 <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 06:40:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 23.06.2021 19:41, Alan Stern wrote:
> > Are there any systems beside the SAMA7G5 and others you tested which
> > might be affected by this patch?  Do they all work pretty much the
> > same way?  (I want to make sure no others will be adversely affected
> > by this change.)
> 
> I tested it on SAMA7G5, SAMA5D2 and SAM9X60. I tested the suspend/resume
> to/from mem. On SAMA5D2 and SAM9X60 there is no clock provided by
> transceiver A to OHCI. I encountered no issues on tested systems. These IPs
> are also present on SAMA5D3 and SAMA5D4 systems which I haven't tested as I
> expect to behave as SAMA5D2 (as the clocking scheme is the same with
> SAMA5D2). I can also try it on a SAMA5D3 (I don't have a SAMA5D4 with me at
> the moment), tough, just to be sure nothing is broken there too.

That doesn't answer my question.  I asked if there were any systems 
which might be affected by your patch, and you listed a bunch of 
systems that _aren't_ affected (that is, they continue to work 
properly).

What systems might run into trouble with this patch?

Alan Stern

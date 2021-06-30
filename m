Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C23B8848
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhF3SYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:24:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49789 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233030AbhF3SYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:24:08 -0400
Received: (qmail 745964 invoked by uid 1000); 30 Jun 2021 14:21:38 -0400
Date:   Wed, 30 Jun 2021 14:21:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu.Beznea@microchip.com
Cc:     gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210630182137.GA743974@rowland.harvard.edu>
References: <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
 <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
 <20210623141907.GC491169@rowland.harvard.edu>
 <8bff20a7-8eb8-276a-086e-f1729fbbdbe4@microchip.com>
 <20210623164148.GC499969@rowland.harvard.edu>
 <f03ccb09-4b5e-4db7-2cf0-375d53234099@microchip.com>
 <20210624132304.GA528247@rowland.harvard.edu>
 <856493cd-9d53-24b3-8e8b-c3c366f282bd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <856493cd-9d53-24b3-8e8b-c3c366f282bd@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 02:46:47PM +0000, Claudiu.Beznea@microchip.com wrote:
> On 24.06.2021 16:23, Alan Stern wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Jun 24, 2021 at 06:40:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> >> On 23.06.2021 19:41, Alan Stern wrote:
> >>> Are there any systems beside the SAMA7G5 and others you tested which
> >>> might be affected by this patch?  Do they all work pretty much the
> >>> same way?  (I want to make sure no others will be adversely affected
> >>> by this change.)
> >>
> >> I tested it on SAMA7G5, SAMA5D2 and SAM9X60. I tested the suspend/resume
> >> to/from mem. On SAMA5D2 and SAM9X60 there is no clock provided by
> >> transceiver A to OHCI. I encountered no issues on tested systems. These IPs
> >> are also present on SAMA5D3 and SAMA5D4 systems which I haven't tested as I
> >> expect to behave as SAMA5D2 (as the clocking scheme is the same with
> >> SAMA5D2). I can also try it on a SAMA5D3 (I don't have a SAMA5D4 with me at
> >> the moment), tough, just to be sure nothing is broken there too.
> > 
> > That doesn't answer my question.  I asked if there were any systems
> > which might be affected by your patch, and you listed a bunch of
> > systems that _aren't_ affected (that is, they continue to work
> > properly).
> 
> I wrongly understood the initial question.
> 
> > 
> > What systems might run into trouble with this patch?
> 
> These are all I haven't tested and might be affected:
> AT91RM9200,
> SAM9260,
> SAM9261,
> SAM9263,
> SAM9N12,
> SAM9X35,
> SAM9G45.
> 
> The last two (SAM9X35 and SAM9G45) have the same clocking scheme with
> SAMA5D2 (which I tested). For the rest of them I cannot find the clocking
> scheme in datasheet and don't have them to test (at least at the moment).

I see.  That seems reasonable; the others are probably the same as the 
ones you tested.

Did you ever answer the question that Nicolas raised back on June 9 in:

	https://marc.info/?l=linux-usb&m=162324242003349&w=2

Alan Stern

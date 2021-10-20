Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78B4355A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJTV7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:59:55 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40851 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229695AbhJTV7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:59:53 -0400
Received: (qmail 1140230 invoked by uid 1000); 20 Oct 2021 17:57:38 -0400
Date:   Wed, 20 Oct 2021 17:57:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v16 6/7] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <20211020215738.GA1140001@rowland.harvard.edu>
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <dfac0025-b693-2431-04c8-1dba7ef32141@linux.intel.com>
 <YXB7vIP6ifQS3T4o@google.com>
 <20211020203720.GA1137200@rowland.harvard.edu>
 <YXCDobJSuytwthoA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXCDobJSuytwthoA@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 02:01:21PM -0700, Matthias Kaehlcke wrote:
> On Wed, Oct 20, 2021 at 04:37:20PM -0400, Alan Stern wrote:
> > On Wed, Oct 20, 2021 at 01:27:40PM -0700, Matthias Kaehlcke wrote:
> > > Hi Mathias,
> > > 
> > > On Wed, Oct 20, 2021 at 04:05:37PM +0300, Mathias Nyman wrote:
> > > > If separate devices for controlling onboard hub power is the right solution then
> > > > how about creating the onboard hub device in usb_add_hcd() (hcd.c), and
> > > > store it in struct usb_hcd.
> > > > 
> > > > A bit like how the roothub device is created, or PHYs are tuned.
> > > 
> > > Sure, that sounds feasible, even better if it's handled in a single place
> > > and different types of controllers don't have to add support separately.
> > 
> > Bear in mind that this would prevent you from working with onboard
> > non-root hubs.
> 
> My goal is to (architecturally) support nested hubs, but TBH I haven't
> looked much into such a configuration since I don't have hardware for
> testing. My assumption was that support for onboard hubs connected to
> non-root hubs whould have to be added to the generic hub driver.
> 
> Could you elaborate in how far you think it would be different for
> xhci_plat vs generic hcd?

A lot of this material has slipped from my mind.  However, I don't see 
much difference between those two approaches.

Alan Stern

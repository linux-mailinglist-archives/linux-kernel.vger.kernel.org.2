Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7B389B24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhETCGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:06:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59513 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230232AbhETCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:06:43 -0400
Received: (qmail 1187236 invoked by uid 1000); 19 May 2021 22:05:21 -0400
Date:   Wed, 19 May 2021 22:05:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <20210520020521.GB1186755@rowland.harvard.edu>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
 <20210518194511.GA1137841@rowland.harvard.edu>
 <YKQ0XxhIWaN37HMr@google.com>
 <20210519144356.GB1165692@rowland.harvard.edu>
 <YKWaJdrpj1ixx9+v@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKWaJdrpj1ixx9+v@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 04:07:17PM -0700, Matthias Kaehlcke wrote:
> On Wed, May 19, 2021 at 10:43:56AM -0400, Alan Stern wrote:
> > On Tue, May 18, 2021 at 02:40:47PM -0700, Matthias Kaehlcke wrote:
> > > 
> > > Could you also have a look at "[4/5] usb: host: xhci-plat:
> > > Create platform device for onboard hubs in probe()"
> > > (https://lore.kernel.org/patchwork/patch/1425453/)? It's a
> > > relatively short patch that creates the platform device for
> > > the driver from xhci-plat as you suggested in the v4
> > > discussion.
> > 
> > I'm not the maintainer for xhci-related drivers.
> > 
> > However, there is at least one thing about this patch which looks 
> > suspicious: Adding the onboard_hub_dev pointer to struct usb_hcd instead 
> > of to struct xhci_plat_priv, where it would make a lot more sense.
> 
> I can move it to struct usb_hcd if that's preferred

Thinko: The patch already has it in struct usb_hcd.  I suggested moving 
it to struct xhci_plat_priv.

Alan Stern

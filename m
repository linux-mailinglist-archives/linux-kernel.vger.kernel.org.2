Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE444C47B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhKJPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhKJPip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:38:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98CE3610CF;
        Wed, 10 Nov 2021 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636558558;
        bh=URiugvpGHTALMYCylZuNWuUm3jBP0rgFHdNaUl92irI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnsXp4TJKnfFIis0DvvcIVUpj0ASTwbbrkeCeHxNID92un6H+XdAHBth7ntYKvytL
         6l01z3oT9OkWGcMX6qO+H5ChO6hCmRkUXmcfffUVxmm4TuknE9aXa+WxiovxDzK5CB
         eukQA5NZvHkOcTLxYbCCo8spaKsWRm3GbVbJmvL8=
Date:   Wed, 10 Nov 2021 16:35:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of/unittest: Disable new dtc
 node_name_vs_property_name and interrupt_map warnings
Message-ID: <YYvm21SK1xH/KlUg@kroah.com>
References: <20211028130423.4025578-1-robh@kernel.org>
 <YYvJn8ds5iI9SqVR@kroah.com>
 <CAL_JsqLZPb_WhfGdL6kt27c4+3KM7cDaXcSytyfF0p6cqunHJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLZPb_WhfGdL6kt27c4+3KM7cDaXcSytyfF0p6cqunHJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:48:16AM -0600, Rob Herring wrote:
> On Wed, Nov 10, 2021 at 7:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 28, 2021 at 08:04:23AM -0500, Rob Herring wrote:
> > > The unittest dtbs have various intentional errors which cause warnings.
> > > With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
> > > some new checks: node_name_vs_property_name and interrupt_map warnings.
> > > These warnings are also generated for static_base_1.dtb, so add
> > > DTC_FLAGS for it.
> > >
> > > Note that the interrupt_map warnings only appear once interrupt_provider
> > > warning is re-enabled globally.
> > >
> > > drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
> > >
> > > Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/of/unittest-data/Makefile | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> > > index a5d2d9254b2c..fbded24c608c 100644
> > > --- a/drivers/of/unittest-data/Makefile
> > > +++ b/drivers/of/unittest-data/Makefile
> > > @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
> > >  DTC_FLAGS_testcases += -@
> > >
> > >  # suppress warnings about intentional errors
> > > -DTC_FLAGS_testcases += -Wno-interrupts_property
> > > +DTC_FLAGS_testcases += -Wno-interrupts_property \
> > > +     -Wno-node_name_vs_property_name \
> > > +     -Wno-interrupt_map
> > >
> > >  # Apply overlays statically with fdtoverlay.  This is a build time test that
> > >  # the overlays can be applied successfully by fdtoverlay.  This does not
> > > @@ -82,6 +84,10 @@ apply_static_overlay_1 := overlay_0.dtbo \
> > >
> > >  apply_static_overlay_2 := overlay.dtbo
> > >
> > > +DTC_FLAGS_static_base_1 += -Wno-interrupts_property \
> > > +     -Wno-node_name_vs_property_name \
> > > +     -Wno-interrupt_map
> > > +
> > >  static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
> > >  static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
> > >
> > > --
> > > 2.32.0
> > >
> >
> > Note this commit in Linus's tree breaks clang-based systems with the
> > following build errors:
> >         FATAL ERROR: Unrecognized check name "interrupt_map"
> >         FATAL ERROR: Unrecognized check name "node_name_vs_property_name"
> >
> > Any thoughts about what to do?
> 
> I don't think it has anything to do with clang. These messages come
> from dtc and there's not any 'test the options are supported'
> mechanism for new options. It looks like the dtc update referenced in
> Fixes is missing or dtc is stale. There's no error in kernelci[1].

Ah, yes, turns out that Android is building their kernel with an old
version of dtc.  So that's the issue here, I'll go work to fix that
up...

Sorry for the noise.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9547A314982
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBIH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhBIH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:27:16 -0500
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF9C061788;
        Mon,  8 Feb 2021 23:26:36 -0800 (PST)
Received: from [2a01:cb14:a98:4900:be5f:f4ff:fe8b:2fc1] (helo=sonata)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1l9NPn-000589-7q; Tue, 09 Feb 2021 08:26:27 +0100
Received: from agriveaux by sonata with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1l9NPm-0001QB-Qv; Tue, 09 Feb 2021 08:26:26 +0100
Date:   Tue, 9 Feb 2021 08:26:26 +0100
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20210209072413.GA5159@localhost.localdomain>
References: <20210124193903.21401-1-agriveaux@deutnet.info>
 <20210128172329.ncuda3xlgpmefpqk@gilmour>
 <20210201171236.GA7024@localhost.localdomain>
 <20210203092103.7nznjzlr2t3llwj5@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092103.7nznjzlr2t3llwj5@gilmour>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 10:21:03AM +0100, Maxime Ripard wrote:
> On Mon, Feb 01, 2021 at 06:18:18PM +0100, agriveaux wrote:
> > On Thu, Jan 28, 2021 at 06:23:29PM +0100, Maxime Ripard wrote:
> > > Hi,
> > Hi,
Hello,
> > > 
> > > On Sun, Jan 24, 2021 at 08:39:03PM +0100, Alexandre GRIVEAUX wrote:
> > > > Add Inet 86V Rev 2 support, based upon Inet 86VS.
> > > > 
> > > > The Inet 86V use SL1536 touchpanel controller, the Inet 86VS a GSL1680,
> > > > which make them both incompatible.
> > > > 
> > > > Missing things:
> > > > - Accelerometer (MXC6225X)
> > > > - Touchpanel (Sitronix SL1536)
> > > > - Nand (29F32G08CBACA)
> > > > - Camera (HCWY0308)
> > > > 
> > > > Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> > > > ---
> > > >  arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++
> > > 
> > > You have to add it to the Makefile
> > > 
> > Ok.
> > > >  1 file changed, 17 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > > > new file mode 100644
> > > > index 000000000000..581083e932d8
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > > > @@ -0,0 +1,17 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright 2021 Alexandre Griveaux <agriveaux@deutnet.info>
> > > > + *
> > > > + * Minimal dts file for the iNet 86V
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "sun5i-a13.dtsi"
> > > > +#include "sun5i-reference-design-tablet.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "iNET 86V Rev 02";
> > > > +	compatible = "inet,86v-rev2", "allwinner,sun5i-a13";
> > > 
> > > inet should be documented in the vendor prefixes, and that compatible
> > > should be documented in Documentation/devicetree/bindings/arm/sunxi.yaml
> > > 
> > 
> > I forgot, but should be:
> > 
> >       - description: iNet-86V Rev 02
> >         items:
> >           - const: primux,inet86v-rev2
> >           - const: allwinner,sun5i-a13
> > 
> > > Having the first rev compatible would be good too
> > 
> > Unfortunatly, I didn't find inet86v rev1 on FCC website and on
> > linux-sunxi. 
> > 
> > > 
> > > > +
> > > > +};
> > > 
> > > But I'm wondering. If there's nothing here to add, why would we need
> > > that DT in the first place?
> > > 
> > I prefer to add often instead of bulk adding, and to show there are some
> > board to add missing things like those above.
> 
> Yeah, I get that, but the point really is that you're not really adding
> anything here except an empty device tree.
> 
> Maxime
In this case, I keep this patch to send it when I have more to add . 

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E483E8CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhHKJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhHKJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:06:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:05:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mDkB9-0002B3-8x; Wed, 11 Aug 2021 11:05:39 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mDkB8-0001Be-GU; Wed, 11 Aug 2021 11:05:38 +0200
Message-ID: <6d396b18455a228719ac4ffeeddcca20b0aa0184.camel@pengutronix.de>
Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Aug 2021 11:05:38 +0200
In-Reply-To: <VI1PR04MB6800D794307B1BDF7100E773E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
         <20210810073510.18218-2-qiangqing.zhang@nxp.com>
         <17daf0f387dff8145559df6a983b0a222c100514.camel@pengutronix.de>
         <VI1PR04MB6800F6169275A323DE0FD782E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
         <VI1PR04MB6800D794307B1BDF7100E773E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-08-11 at 08:06 +0000, Joakim Zhang wrote:
> 
> > -----Original Message-----
> > From: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Sent: 2021年8月11日 16:05
> > To: Jan Lübbe <jlu@pengutronix.de>; srinivas.kandagatla@linaro.org;
> > robh+dt@kernel.org; shawnguo@kernel.org
> > Cc: devicetree@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > kernel@pengutronix.de; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
> > property
> > 
> > 
> > > -----Original Message-----
> > > From: Jan Lübbe <jlu@pengutronix.de>
> > > Sent: 2021年8月10日 23:14
> > > To: Joakim Zhang <qiangqing.zhang@nxp.com>;
> > > srinivas.kandagatla@linaro.org; robh+dt@kernel.org;
> > > shawnguo@kernel.org
> > > Cc: devicetree@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > kernel@pengutronix.de; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
> > > property
> > > 
> > > On Tue, 2021-08-10 at 15:35 +0800, Joakim Zhang wrote:
> > > > Introduce "reverse-data" property for nvmem provider to reverse buffer.
> > > > 
> > > > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > index b8dc3d2b6e92..bc745083fc64 100644
> > > > --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > @@ -61,6 +61,11 @@ patternProperties:
> > > >                description:
> > > >                  Size in bit within the address range specified by reg.
> > > > 
> > > > +      reverse-data:
> > > > +        $ref: /schemas/types.yaml#/definitions/flag
> > > > +        description:
> > > > +          Reverse the data that read from the storage device.
> > > 
> > > I'd prefer if it was more explicit that the *bytes* will be reversed.
> > > Otherwise a reader might think that this is reversing on the *bit* level.
> > 
> > Make sense, how about 'reverse-byte-order'?
> 
> Sorry, 'reverse-bytes-order'.

'reverse-byte-order' sounds better to me, but I'm not a native English speaker.
I'd be fine with either, though.

Thanks
Jan


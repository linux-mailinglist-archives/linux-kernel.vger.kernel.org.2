Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B33E9DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhHLFT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhHLFT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:19:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41286C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:19:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mE37I-0000TW-MH; Thu, 12 Aug 2021 07:18:56 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1mE37H-0003wc-ID; Thu, 12 Aug 2021 07:18:55 +0200
Date:   Thu, 12 Aug 2021 07:18:55 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] dt-bindings: timer: fsl,imxgpt: add optional osc_per
 clock
Message-ID: <20210812051855.vrwisusfqkbb5v6a@pengutronix.de>
References: <20210803072958.4815-1-o.rempel@pengutronix.de>
 <YRQRNrLXIYERa6FT@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRQRNrLXIYERa6FT@robh.at.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:58:51 up 252 days, 19:05, 12 users,  load average: 0.02, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:04:38PM -0600, Rob Herring wrote:
> On Tue, Aug 03, 2021 at 09:29:58AM +0200, Oleksij Rempel wrote:
> > Add optional osc_per and fix dts validation warnings on imx6 SoCs.
> > 
> > Fixes: df8cad689eae ("dt-bindings: timer: Convert i.MX GPT to json-schema")
> 
> I don't think you can say the above commit was broken.
>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/timer/fsl,imxgpt.yaml   | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> > index a4f51f46b7a1..e496dd9f4988 100644
> > --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> > +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> > @@ -43,11 +43,15 @@ properties:
> >      items:
> >        - description: SoC GPT ipg clock
> >        - description: SoC GPT per clock
> > +      - description: optional SoC GPT oscillator
> > +    minItems: 2
> 
> The 3rd clock is valid on every version of the h/w?

No.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C663D1866
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGUULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGUULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:11:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:51:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m6JBx-0006PE-GH; Wed, 21 Jul 2021 22:51:45 +0200
Message-ID: <689e5fd6c290ebec09d45c5d55354d78f5cea647.camel@pengutronix.de>
Subject: Re: [PATCH V2 00/13] soc: imx: gpcv2: support i.MX8MM
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 21 Jul 2021 22:51:43 +0200
In-Reply-To: <89534836-6688-9cbd-1f33-ca78a4db47d4@kontron.de>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
         <3c5ef283-0895-05ab-7568-0d108b761008@kontron.de>
         <f7937500-f2bb-aa5c-caa2-1788693895a7@kontron.de>
         <89534836-6688-9cbd-1f33-ca78a4db47d4@kontron.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Am Donnerstag, dem 20.05.2021 um 17:16 +0200 schrieb Frieder Schrempf:
> On 19.05.21 18:09, Frieder Schrempf wrote:
> > On 06.05.21 10:32, Frieder Schrempf wrote:
> > > On 06.05.21 03:04, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > 
> > > > V2:
> > > >  - Add R-b/A-b tag
> > > >  - Merge V1 patch 13 to V2 patch 6
> > > >  - Drop V1 patch 15
> > > >  - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5
> > > > to explain
> > > >  details
> > > >  - Add explaination in patch 8 for "why the resets are not
> > > > defined"
> > > > 
> > > > This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and
> > > > several
> > > > minor changes from me to make it could work with i.MX BLK-CTL
> > > > driver.
> > > > 
> > > > Thanks for Lucas's work and suggestion, Frieder Schrempf for
> > > > collecting
> > > > all the patches, Jacky Bai on help debug issues.
> > > 
> > > I tested this series together with the BLK CTL patches by using
> > > the GPU and the display stack. Everything looks good to me.
> > > 
> > > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > So after some more testing on different hardware I stumbled upon
> > the problem that USB autosuspend doesn't work properly anymore.
> > 
> > I have an onboard LTE module that is connected to OTG2 on the
> > i.MX8MM. When using the mainline TF-A (that enables USB power-
> > domains by default) and removing the power-domain control from the
> > kernel, the device comes up after a few seconds and is enumerated
> > on the bus.
> > 
> > Now, when I let the kernel control the power-domains, the device
> > comes up at boot, but isn't enumerated on the USB bus. As soon as I
> > disable autosuspend for the port, it comes up.
> > 
> > Is this something that needs to be fixed on the USB driver side or
> > is something to be considered for the GPCv2 driver?
> 
> So I think this is something that needs to be covered on the USB
> driver side. I would expect that a device appearing on the bus should
> resume the autosuspended bus, but I don't really know much about USB
> so there might be other things I miss. For now I will disable
> autosuspend in this case.
> 
> A different, probably more severe problem is that I was still able to
> reliably run into lockups with suspend/resume and the GPU. I thought
> I had tested this before as it was one of the things that already
> failed with the previous implementation, but I must have missed
> something as it still fails with kernel v5.12.1 + v2 of the GPC
> patches.
> 
> This is how I run into the lockup:
> 
> echo mem > /sys/power/state  # Sleep
>                              # Wake up again
> glmark2-es2-drm              # Use the GPU
>                              # Device locks up
> 
> Peng, is this something you can reproduce?

I could reproduce this issue on my last GPC+BLK_CTRL series. This was
caused by a bad interaction between our slightly unusual way to control
the nested power domains via runtime PM and the system suspend/resume
code, which lead to some of the power domains not properly coming up
again in the resume path. v2 of my series fixes this issue and the
above sequence works as expected.

Regards,
Lucas



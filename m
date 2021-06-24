Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B313B2C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhFXKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFXKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:38:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8ECC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:36:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lwMiK-0007jE-Cs; Thu, 24 Jun 2021 12:36:04 +0200
Message-ID: <b8ce9abd075a65272bdbe6142c9cd877fa25c701.camel@pengutronix.de>
Subject: Re: [EXT] regression due to soc_device_match not handling defer
 (Was: [PATCH v4 4/4] soc: imx8m: change to use platform driver)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 24 Jun 2021 12:36:02 +0200
In-Reply-To: <DB6PR0402MB27607D28703D8C3E614E2F2A884D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20201120101112.31819-4-alice.guo@nxp.com>
         <YGGZJjAxA1IO+/VU@atmark-techno.com>
         <AM6PR04MB60536EF0DEEE6EB64CF29390E27D9@AM6PR04MB6053.eurprd04.prod.outlook.com>
         <YHeWnuDQo76rYoz5@atmark-techno.com>
         <DB6PR0402MB27607D28703D8C3E614E2F2A884D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Am Donnerstag, dem 15.04.2021 um 01:33 +0000 schrieb Peng Fan:
> > (Was: [PATCH v4 4/4] soc: imx8m: change to use platform driver)
> > 
> > Alice Guo (OSS) wrote on Tue, Mar 30, 2021 at 02:41:23AM +0000:
> > > Thanks for reporting this issue, I'll check and add a fix to handle defer probe.
> > 
> > I haven't seen any follow up on this, have you had a chance to take a look?
> 
> We are trying to find a proper solution for this.
> 
> The proper method might be make soc_device_match return probe defer,
> and take early soc attr into consideration, but I am not sure this would win
> maintainer's vote.
> 
> > If this won't make it for 5.12 (in a couple of week probably?) would it make
> > sense to revert 7d981405d0fd ("soc: imx8m: change to use platform
> > driver") for now?
> 
> Please no. We are targeting android GKI, make driver as modules.
> And reverting to original method will also break kexec.
> 
> I am on IRC #linux-imx, we could take more if you would like to.

It seems this stalled. This regression totally breaks the kernel boot
on all i.MX8M devices including the CAAM. 5.13 is about to be released,
as the second upstream kernel release after 5.12 without a fix for this
issue. What's the plan here?

If there is no good solution small enough to be ported to the stable
kernels in sight, I think the only sensible option here is to revert
this change.

Regards,
Lucas


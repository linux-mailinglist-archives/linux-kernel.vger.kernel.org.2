Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81E5357772
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhDGWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhDGWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:13:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C18C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 15:13:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lUGQ8-0002Ir-PK; Thu, 08 Apr 2021 00:13:08 +0200
Message-ID: <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de>
Subject: Re: [PATCH v1 0/7] imx-gpcv2 improvements
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, krzk@kernel.org, peng.fan@nxp.com,
        aisheng.dong@nxp.com, qiangqing.zhang@nxp.com, alice.guo@nxp.com,
        aford173@gmail.com, agx@sigxcpu.org, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 00:13:06 +0200
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

I feel like I already mentioned to you some time ago that there is
already a much more complete patch series to add this functionality on
the list [1].

If you want this functionality to go upstream, please help test and
extend this patch series.

Regards,
Lucas

[1] https://lore.kernel.org/linux-arm-kernel/20201105174434.1817539-1-l.stach@pengutronix.de/

Am Mittwoch, dem 07.04.2021 um 23:21 +0200 schrieb Adrien Grassein:
> Hi,
> 
> This patch set aims is to add the support of the i.MX8 MM power domains
> on the mainline kernel.
> 
> To achieve this, I do several patches
>   - Check errors when reading or writing registers (concerns i.MX8M base
>     implementation);
>   - Fix power up/down sequence. Handshake was not checked and it was
>     not called at the appropriate time (concerns i.MX8M base
> implementaions);
>   - Allow domains without power sequence control like the HSIOMIX of the
>     i.MX8MM.
>   - Add some i.MX8MM domains (HSIO and OTGS);
>   - Introduce quirks. For example, i.MX8MM OTG domains should not be
>     powered off (seen n the source code of th i.MX ATF). Quirks are
> easily upgrable for other cases.
>   - Finally I defined power domains into the imx8mm.dtb file.
> 
> I know that this kind of patch is rejected by NXP ut the other way
> (callin ATF directly) was also rejected.
> 
> I also know that NXP is concerned abou adding hundred lines of codes for
> each new SOC but it' the way it works on Linux. And the "added code"
> mainly consist of adding structures, defines and generic methods for
> regmap.
> 
> If it's a real problem, maybe we can introduc a new "gpcv3" driver for
> i.MX8MM, i.MX8MN and i.MX8MP.
> 
> Thanks,  
> 
> Adrien Grassein (7):
>   soc: imx: gpcv2: check for errors when r/w registers
>   soc: imx: gpcv2: Fix power up/down sequence
>   soc: imx: gpcv2: allow domains without power sequence control
>   dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
>   soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
>   soc: imx: gpcv2: add quirks to domains
>   arm64: dts: imx8mm: add power-domains
> 
>  .../bindings/power/fsl,imx-gpcv2.yaml         |   7 +-
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  35 ++
>  drivers/soc/imx/gpcv2.c                       | 336 ++++++++++++++----
>  include/dt-bindings/power/imx8mm-power.h      |  21 ++
>  4 files changed, 333 insertions(+), 66 deletions(-)
>  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> 



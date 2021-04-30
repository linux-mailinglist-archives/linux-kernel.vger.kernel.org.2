Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764BA36F74F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhD3IsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3IsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:48:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:47:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lcOnm-0002EN-QZ; Fri, 30 Apr 2021 10:47:10 +0200
Message-ID: <914b4e28b1313fc3b0293faa60a21cb6afb83e40.camel@pengutronix.de>
Subject: Re: [PATCH 16/16] soc: imx: gpcv2: remove waiting handshake in
 power up
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Date:   Fri, 30 Apr 2021 10:47:08 +0200
In-Reply-To: <e5a94506-7bd3-93b6-b331-1cf04672a459@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
         <20210429073050.21039-17-peng.fan@oss.nxp.com>
         <abde5337ac265287f8e1225846e140e8df370f47.camel@pengutronix.de>
         <e5a94506-7bd3-93b6-b331-1cf04672a459@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 30.04.2021 um 15:14 +0800 schrieb Peng Fan (OSS):
> 
> On 2021/4/29 22:34, Lucas Stach wrote:
> > Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > i.MX8MM has blk ctl module, the handshake can only finish after setting
> > > blk ctl. The blk ctl driver will set the bus clk bit and the handshake
> > > will finish there. we just add a delay and suppose the handshake will
> > > finish after that.
> > 
> > Instead of this patch, just drop patch 05/16 from this series. I think
> > we should leave a comment in the code on why we aren't waiting for the
> > handshake ack, as this is non-obvious from looking at the driver code.
> > 
> > Basically add a polished version of the commit log from this patch into
> > the driver code.
> 
> After thinking more, for power down, we need wait handshake. For power 
> up, we could ignore handshake, because BLK-CTL setting bus clk en
> will auto trigger handshake.
> 
> For power down, the bus clk en already set, and we need wait, otherwise
> we need add delay there.
> 
> So I would only drop the power up waiting and add some comments there.

Ah, right. This way makes a lot of sense.

Regards,
Lucas


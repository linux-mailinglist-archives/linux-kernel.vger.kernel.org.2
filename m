Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341D033F255
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhCQOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhCQOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:11:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:11:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lMWsv-0004Qw-QZ; Wed, 17 Mar 2021 15:10:53 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lMWsu-00032p-MK; Wed, 17 Mar 2021 15:10:52 +0100
Date:   Wed, 17 Mar 2021 15:10:52 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, shawnguo@kernel.org,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6ull: fix ubi mount failed on MYS-6ULX-IOT
 board
Message-ID: <20210317141052.GW4207@pengutronix.de>
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
 <20210309121836.GU4207@pengutronix.de>
 <CAL9mu0JOyM8n9LABwrOYgV4Qxj27XKTchWiGKsE3dMU0W5RNbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL9mu0JOyM8n9LABwrOYgV4Qxj27XKTchWiGKsE3dMU0W5RNbw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:07:52 up 27 days, 17:31, 85 users,  load average: 0.07, 0.24,
 0.23
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:54:05AM +0800, dillon min wrote:
> Hi Sascha,
> 
> Thanks for reviewing.
> 
> On Tue, Mar 9, 2021 at 8:18 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Tue, Mar 09, 2021 at 02:15:19PM +0800, dillon.minfei@gmail.com wrote:
> > > From: dillon min <dillon.minfei@gmail.com>
> > >
> > > This patch intend to fix ubi filesystem mount failed on MYS-6ULX-IOT board,
> > > from Micron MT29F2G08ABAEAWP's datasheets, we need to choose 4-bit ECC.
> > >
> > > Table 18: Error Management Details
> > >
> > > Description                                   Requirement
> > >
> > > Minimum number of valid blocks (NVB) per LUN  2008
> > > Total available blocks per LUN                        2048
> > > First spare area location                     x8: byte 2048 x16: word 1024
> > > Bad-block mark                                        x8: 00h x16: 0000h
> > > Minimum required ECC                          4-bit ECC per 528 bytes
> > > Minimum ECC with internal ECC enabled         4-bit ECC per 516 bytes (user data) + 8
> > >                                               bytes (parity data)
> > > Minimum required ECC for block 0 if PROGRAM/
> > > ERASE cycles are less than 1000                       1-bit ECC per 528 bytes
> >
> > 4-bit ECC is the minimum this chip requires. There's nothing wrong with
> > choosing a better ECC like the GPMI driver does by default.
> >
> Yes, indeed, the mt29f2g08's minimum ecc is 4-bit, you can use 8-bits ecc.
> but there is a dependency between new kernel gpmi-nand with the old
> mfg-kernel's , which means
> if the old nand ecc layout is 4-bits, you should use ecc 4-bit in the
> new kernel (by fsl,use-minimum-ecc),
> else use 8-bits.
> 
> For my case, the ubifs filesystem was created by ecc 4-bits, without
> reflash filesystem or change

Then this is the justification for this patch, not anything from the
datasheet like you've written in your commit message.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

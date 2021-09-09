Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055FD404354
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349279AbhIIByE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:54:04 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:55456 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhIIByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:54:03 -0400
Received: from [172.16.66.38] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 03D262012C;
        Thu,  9 Sep 2021 09:52:44 +0800 (AWST)
Message-ID: <9fa4ae962c185e0e4f07f0299356969c17ae5ea5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Morris Mao <morris_mao@aspeedtech.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Date:   Thu, 09 Sep 2021 09:52:43 +0800
In-Reply-To: <HK0PR06MB377924CFCBFE9BD40E1C4A5D91D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
         <20210901033015.910-4-chiawei_wang@aspeedtech.com>
         <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
         <HK0PR06MB37792273A075533C2570002391CE9@HK0PR06MB3779.apcprd06.prod.outlook.com>
         <513cb05f8d83d08a5c1e491dc0a9b6784195e7dd.camel@codeconstruct.com.au>
         <HK0PR06MB37799C48533B084CF864E49D91D29@HK0PR06MB3779.apcprd06.prod.outlook.com>
         <6593206c0bc90186f255c6ea86339576576f70dc.camel@codeconstruct.com.au>
         <HK0PR06MB377924CFCBFE9BD40E1C4A5D91D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chiawei,

> Yes, there is security concern using HW mode.
> Our designer is considering to remove the HW mode support in the next
> generation of Aspeed SoCs.
> So far we haven't encountered a scenario demanding HW mode.

Great to hear :) can we unconditionally set ESPI000[9] in the driver
then?

> > With than in mind, if we're disabling hardware mode - what does the
> > direction control setting effect when we're in software mode
> > (ESPICTRL[9] == 1)? Does it even matter?
> 
> Yes, the direction matters even in SW mode.
> When the direction is 'master-to-slave' and the GPIO value is updated
> by the Host through PUT_VW, a VW interrupt is trigger to notify BMC.
> For the 'slave-to-master' GPIO, a alert is generated to notify the
> Host to issue GET_VW for the GPIO value updated by the BMC by
> ESPI09C.

OK, but the datasheet mentions that ESPICFG804 is only applicable when
ESPI000[9] = 0, or is that not the case?

But based on what you've said: yes, it sounds like the generic gpiodev
parts won't be useful for this.

> > Separate from this: I'm also proposing that we represent the system
> > event VWs
> > as gpiodevs as well.
> > 
> > > A raw packet, primitive interface should have better flexibility
> > > to
> > > manage MCTP packets over the OOB channel.
> > 
> > OK, let me phrase this differently: can the OOB channel be used for
> > anything other than SMBus messaging? Is it useful to provide an
> > interface that isn't a standard SMBus/i2c device?
> 
> Yes, the PCH spec. also defines two additional packet format for an
> eSPI slave to retrieve PCH Temperature Data and RTC time.
> It should be trivial to prepare a byte buffer in that format and send
> it through the raw packet interface.

OK, understood.

> > If you need custom uapi definitions for this driver, that might be
> > okay, but it's going to be more work for you (to define an interface
> > that can be supported long-term), rather than using standard
> > infrastructure that already exists.
> 
> Thus I suggested that we can refer to the IPMI KCS BMC driver, which
> supports the selection of different user interfaces, RAW or IPMI.

Yep, but the KCS "raw" register set is standardised as part of the IPMI
spec too, which helps to define a stable user API. We don't have that in
this case.

Overall though, if you want to start with the "low-level" API, then
introduce "enhanced" functionality - like an actual SMBus driver -
alongside that, then that sounds like an OK approach.

> If IOCTL is considered to be not user friendly or magic code
> polluting, file-based read/write on the miscdevice node is also an
> option.

It's not really my decision to make, but a read/write event interface
would seem to be more consistent to me. Is there an obvious event format
that would be common across all channels, perhaps? We'd probably also
need a poll too - to make use of incoming events, like master-to-slave
VW changes, perhaps?

Cheers,


Jeremy


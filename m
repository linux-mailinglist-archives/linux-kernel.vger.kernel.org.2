Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD713FE7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 05:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhIBDap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 23:30:45 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:52978 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhIBDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 23:30:44 -0400
Received: from [172.16.66.18] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AF9A620164;
        Thu,  2 Sep 2021 11:29:37 +0800 (AWST)
Message-ID: <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ryan_chen@aspeedtech.com
Date:   Thu, 02 Sep 2021 11:29:35 +0800
In-Reply-To: <20210901033015.910-4-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
         <20210901033015.910-4-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chiawei,

> The Aspeed eSPI controller is slave device to communicate with
> the master through the Enhanced Serial Peripheral Interface (eSPI).
> All of the four eSPI channels, namely peripheral, virtual wire,
> out-of-band, and flash are supported.

I'm still not confinced this raw packet user-ABI is the right approach
for this. The four channels that you're exposing would be much more
useful to use existing kernel subsystems.

Specifically:

1) The VW channel is essentially a GPIO interface, and we have a kernel
   subsystem to expose GPIOs. We might want to add additional support
   for in-kernel system event handlers, but that's a minor addition that
   can be done separately if we don't want that handled by a gpio
   consumer in userspace.

2) The out-of-band (OOB) channel provides a way to issue SMBus
   transactions, so could well provide an i2c controller interface.
   Additionally, the eSPI specs imply that this is intended to support
   MCTP - in which case, you'll *need* a kernel i2c controller device to
   be able to use the new kernel MCTP stack.

3) The flash channel exposes read/write/erase operations, which would be
   much more useful as an actual flash-type device, perhaps using the
   existing mtd interface? Or is there additional functionality
   expected for this?

4) The peripheral channel is the only one that would seem to require
   arbitrary cycle access, but we'll still need a proper uapi definition
   to support that. At the minimum, your ioctl definitions should go
   under include/uapi/ - you shouldn't need to duplicate the header into
   each userspace repo, as you've done for the test examples.

Cheers,


Jeremy


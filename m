Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6173F92DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhH0DU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:20:57 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:45310 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbhH0DUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:20:55 -0400
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 740922012C;
        Fri, 27 Aug 2021 11:20:05 +0800 (AWST)
Message-ID: <7e7378c49ecfb21fef6a0640f92c1b3a7a5878d0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>, joel@jms.id.au,
        robh+dt@kernel.org, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 11:20:05 +0800
In-Reply-To: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
References: <20210826061623.6352-1-chiawei_wang@aspeedtech.com>
         <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chia-Wei,

[apologies for the re-send, dropping HTML part...]

> The Aspeed eSPI controller is slave device to communicate with
> the master through the Enhanced Serial Peripheral Interface (eSPI).
> All of the four eSPI channels, namely peripheral, virtual wire,
> out-of-band, and flash are supported.

Great to have this added submitted upstream! A few comments though:

> ---
>  drivers/soc/aspeed/Kconfig             |  11 +
>  drivers/soc/aspeed/Makefile            |   1 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c  | 205 +++++++++
>  drivers/soc/aspeed/aspeed-espi-ctrl.h  | 304 ++++++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.h | 380 +++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-ioc.h   | 153 +++++++
>  drivers/soc/aspeed/aspeed-espi-oob.h   | 611 +++++++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-perif.h | 539 ++++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-vw.h    | 142 ++++++

This structure is a bit odd - you have the one -crtl.c file, which
defines the actual driver, but then a bunch of headers that contain more
code than header-type definitions.

Is there any reason that -flash, -ioc, -oob, -perif and -vw components
can't be standard .c files?

Then, for the userspace ABI: it looks like you're exposing everything
through new device-specific ioctls. Would it not make more sense to use
existing interfaces? For example, the virtual wire bits could be regular
GPIOs; the flash interface could be a mtd or block device.

I understand that we'll likely still need some level of custom device
control, but the more we can use generic interfaces for, the less custom
code (and interfaces) we'll need on the userspace side.

Cheers,


Jeremy



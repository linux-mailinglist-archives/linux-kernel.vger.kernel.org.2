Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BB341DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhCSNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCSNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:06:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:06:27 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lNEpW-0005sd-0P; Fri, 19 Mar 2021 14:06:18 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lNEpT-0005ea-IO; Fri, 19 Mar 2021 14:06:15 +0100
Date:   Fri, 19 Mar 2021 14:06:15 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com
Subject: Re: [PATCH v5 3/3] ARM: imx7d-remarkable2.dts: Initial device tree
 for reMarkable2
Message-ID: <20210319130615.k2y6u7otnzbs3hpx@pengutronix.de>
References: <20210316022740.132-1-alistair@alistair23.me>
 <20210316022740.132-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316022740.132-3-alistair@alistair23.me>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:02:05 up 107 days,  3:08, 44 users,  load average: 0.21, 0.14,
 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

the patch looks quite good only a few notes inline.

PS: It would be cool to have a log to previous patch versions.

On 21-03-15 22:27, Alistair Francis wrote:

...

> +&crypto {
> +	status = "disabled";
> +};

Why do you disable the crypto subsystem?

> +&dma_apbh {
> +	status = "disabled";
> +};

Why do you disable this dma controller?

> +
> +&sdma {
> +	status = "okay";
> +};

This is the default state so you can drop this node.

Regards,
  Marco

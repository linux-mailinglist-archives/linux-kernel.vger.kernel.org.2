Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5433D332551
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCIMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCIMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:18:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22553C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:18:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lJbJt-0005ex-71; Tue, 09 Mar 2021 13:18:37 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lJbJs-0007ZH-1M; Tue, 09 Mar 2021 13:18:36 +0100
Date:   Tue, 9 Mar 2021 13:18:36 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, parthiban@linumiz.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull: fix ubi mount failed on MYS-6ULX-IOT
 board
Message-ID: <20210309121836.GU4207@pengutronix.de>
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:14:07 up 19 days, 15:38, 88 users,  load average: 0.34, 0.43,
 0.30
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:15:19PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patch intend to fix ubi filesystem mount failed on MYS-6ULX-IOT board,
> from Micron MT29F2G08ABAEAWP's datasheets, we need to choose 4-bit ECC.
> 
> Table 18: Error Management Details
> 
> Description					Requirement
> 
> Minimum number of valid blocks (NVB) per LUN	2008
> Total available blocks per LUN			2048
> First spare area location			x8: byte 2048 x16: word 1024
> Bad-block mark					x8: 00h x16: 0000h
> Minimum required ECC				4-bit ECC per 528 bytes
> Minimum ECC with internal ECC enabled		4-bit ECC per 516 bytes (user data) + 8
> 						bytes (parity data)
> Minimum required ECC for block 0 if PROGRAM/
> ERASE cycles are less than 1000			1-bit ECC per 528 bytes

4-bit ECC is the minimum this chip requires. There's nothing wrong with
choosing a better ECC like the GPMI driver does by default.

It looks like you are papering over some other problem.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

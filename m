Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835FC457676
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhKSSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:38:25 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43539 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhKSSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:38:24 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 11A31240005;
        Fri, 19 Nov 2021 18:35:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: core: provide unique name for nvmem device
Date:   Fri, 19 Nov 2021 19:35:19 +0100
Message-Id: <20211119183519.1329924-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104134843.2642800-1-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cefe446f5e02a821f16d85c642c5c7c364b424ae'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 13:48:43 UTC, Michael Walle wrote:
> If there is more than one mtd device which supports OTP, there will
> be a kernel warning about duplicated sysfs entries and the probing will
> fail. This is because the nvmem device name is not unique. Make it
> unique by prepending the name of the mtd. E.g. before the name was
> "user-otp", now it will be "mtd0-user-otp".
> 
> For reference the kernel splash is:
> [    4.665531] sysfs: cannot create duplicate filename '/bus/nvmem/devices/user-otp'
> [    4.673056] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-next-20211101+ #1296
> [    4.680565] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
> [    4.688856] Call trace:
> [    4.691303]  dump_backtrace+0x0/0x1bc
> [    4.694984]  show_stack+0x24/0x30
> [    4.698306]  dump_stack_lvl+0x68/0x84
> [    4.701980]  dump_stack+0x18/0x34
> [    4.705302]  sysfs_warn_dup+0x70/0x90
> [    4.708973]  sysfs_do_create_link_sd+0x144/0x150
> [    4.713603]  sysfs_create_link+0x2c/0x50
> [    4.717535]  bus_add_device+0x74/0x120
> [    4.721293]  device_add+0x330/0x890
> [    4.724791]  device_register+0x2c/0x40
> [    4.728550]  nvmem_register+0x240/0x9f0
> [    4.732398]  mtd_otp_nvmem_register+0xb0/0x10c
> [    4.736854]  mtd_device_parse_register+0x28c/0x2b4
> [    4.741659]  spi_nor_probe+0x20c/0x2e0
> [    4.745418]  spi_mem_probe+0x78/0xbc
> [    4.749001]  spi_probe+0x90/0xf0
> [    4.752237]  really_probe.part.0+0xa4/0x320
> ..
> [    4.873936] mtd mtd1: Failed to register OTP NVMEM device
> [    4.894468] spi-nor: probe of spi0.0 failed with error -17
> 
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

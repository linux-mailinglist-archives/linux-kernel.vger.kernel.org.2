Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF153CAF6E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhGOWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:53:29 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58645 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhGOWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:53:28 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 96E311BF204;
        Thu, 15 Jul 2021 22:50:31 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor.Ambarus@microchip.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] mtd: core: handle flashes without OTP gracefully
Date:   Fri, 16 Jul 2021 00:50:31 +0200
Message-Id: <20210715225031.65986-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210707135359.32398-1-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'45bb1faa29effbd4ca4d581b32373f2eda309b95'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-07 at 13:53:59 UTC, Michael Walle wrote:
> There are flash drivers which registers the OTP callbacks although the
> flash doesn't support OTP regions and return -ENODATA for these
> callbacks if there is no OTP. If this happens, the probe of the whole
> flash will fail. Fix it by handling the ENODATA return code and skip
> the OTP region nvmem setup.
> 
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

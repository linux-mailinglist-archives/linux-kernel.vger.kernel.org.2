Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249A13B002F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFVJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:29:17 -0400
Received: from first.geanix.com ([116.203.34.67]:43574 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVJ3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:29:14 -0400
Received: from localhost (80-62-117-165-mobile.dk.customer.tdc.net [80.62.117.165])
        by first.geanix.com (Postfix) with ESMTPSA id A441B4C2DC9;
        Tue, 22 Jun 2021 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624354016; bh=CI/UIeqUzxTnGGW8cnJKPUsCdom4VckZy8Qh8chQnF8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=ONk7l8oSYZdBJtfZcOBaGgh8J2uvn8SoApvaFm6j6/VrjaU9Y1FAYct/7iq+ouc2V
         fMxHVpPXcwm0IScSLwbe0uKPdQswxYmE3MLb8m0lj3xUqPZSDR4WMrIOk/4hrfU0at
         Qj6Z1mH3vHdq9VJ8U47lZH05zhjVXk/ppbOBQ9m3lT7BhGA/3goUkEZsRpYXzQr3/b
         VDZz97Og0dFJUEjwbwzUWVF31bg2fILe2NK6RuDURCc240FcQ2IZJJGUZmtTJmQljH
         6D2AZnJqYn5xKGqadie3w4V1QjFq5h4UbEorDvjMxrBdTORzqAdRhdVE5U3AEQtaq8
         15pExHBguy8xg==
From:   Esben Haabendal <esben@geanix.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-mtd@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] mtd: spi-nor: dealing with reused JEDEC id c22016
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
Date:   Tue, 22 Jun 2021 11:26:55 +0200
In-Reply-To: <20210621152320.3811194-1-linux@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Mon, 21 Jun 2021 17:23:17 +0200")
Message-ID: <8735taxna8.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:

> We use the Macronix chip mx25l3233f in a number of
> products.
>
> Unfortunately, it has the same JEDEC id as another chip which is
> already listed in macronix_parts[]. Since that other one does not
> support SFDP, and its data sheet warns against issuing commands not
> explicitly listed, we can't just do RDSFDP anyway and decide that it's
> an mx25l3205d when the chip returns garbage.
>
> For lack of better alternative, start allowing multiple entries with
> the same JEDEC id in the parts tables. That allows a correctly written
> device tree to specify the right chip, without being overruled by the
> "JEDEC knows better" heuristic, while being backwards-compatible (as
> long as new chips with recycled ids get added after the existing
> ones).
>
> While a step forward, this isn't quite a complete solution for our case:
>
> Some of our platforms are based on LS1021A, thus using the
> spi-fsl-qspi driver. Back in the 4.19 kernel, when the driver was
> fsl-quadspi, we couldn't get the flash recognized unless we
> monkey-patch-replaced the mx25l3205d entry with the mx25l3233f one
> (i.e. added the SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ bits) - we'd
> fail in spi_nor_select_read() because
> shared_hwcaps&SNOR_HWCAPS_READ_MASK would be empty. In contrast, with
> current master, the chip works with or without the third patch in this
> series, i.e. whether it is detected as a mx25l3205d or mx25l3233f. But
> the read performance is ~3 times worse than in our patched 4.19 - I
> haven't quite figured out why quad read doesn't seem to be used or
> work.
>
>
> Rasmus Villemoes (3):
>   mtd: spi-nor: core: create helper to compare JEDEC id to struct
>     flash_info
>   mtd: spi-nor: core: compare JEDEC bytes to already found flash_info
>   mtd: spi-nor: macronix: add entry for mx25l3233f
>
>  drivers/mtd/spi-nor/core.c     | 18 +++++++++++++-----
>  drivers/mtd/spi-nor/macronix.c |  3 +++
>  2 files changed, 16 insertions(+), 5 deletions(-)

For whole series:

Acked-by: Esben Haabendal <esben@geanix.com>

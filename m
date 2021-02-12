Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCB3198CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBLDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhBLDb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:31:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4155B60231;
        Fri, 12 Feb 2021 03:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613100648;
        bh=ugam9oRjHrtW+kW58+/nzrA/HAjnVYvAzMVFQMenhL8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b03ZFsREcxdYdDbXCEOrVGDbW9ssf/LODbDEekBwTb5nMnlapPHkLQuUJKzWShCRO
         zYadfIEcSxFGT5Ty9I8TTFe4DlXY0tWhTtfhotALNPJL6j9R1r9PVVJ0Ho9tQLbpAa
         dgh3eoysJB3QqMd+FF4/8LRFj0UIBZoL0SD4FFH33RMMYT4bdqwvr4y3nI4ViREK+u
         QDIIlbAENuP40QIFtKxWffew5H5r2MWWkcoFQOv9smG2XcRLnlx9EfxDxkFaZqoGjr
         l1YfrKreTfPBqPV86gKQ/1scEHRc5nrLhzh7dF8LvRwlhy44ICYWoYDnwQKakyGviZ
         rLowkfOxKekNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210106070436.14870-1-mike.looijmans@topic.nl>
References: <20210106070436.14870-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] clk-si5341: Support NVM programming through sysfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-clk@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Thu, 11 Feb 2021 19:30:44 -0800
Message-ID: <161310064437.1254594.4211144292317753592@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2021-01-05 23:04:36)
> Export an attribute program_nvm_bank that when read reports the current
> bank value. To program the chip's current state into NVM, write the
> magic value 0xC7 into this attribute.
>=20
> This allows the clock chip to be programmed "in system" to reduce boot
> time by 300ms and allows the clock to be up and running before the
> kernel boots (e.g. for bootloader usage). Some vendors initialize PLLs
> only in their bootloader and thus need the clock running at boot.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Add description in Documentation/ABI/
>     Use regmap_read_poll_timeout()
>     Abort on sysfs_create_group error
>=20
>  .../ABI/testing/sysfs-devices-clk-si5341      | 24 +++++++
>  drivers/clk/clk-si5341.c                      | 68 +++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-clk-si5341
>=20
> diff --git a/Documentation/ABI/testing/sysfs-devices-clk-si5341 b/Documen=
tation/ABI/testing/sysfs-devices-clk-si5341
> new file mode 100644
> index 000000000000..7243b82a3729
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-clk-si5341
> @@ -0,0 +1,24 @@
> +What:          /sys/bus/i2c/devices/.../clk-si534*/program_nvm_bank

I'm still curious why this is exposed here instead of through nvmem
framework. I think we talked about it before, but it would be great if
the commit text could quiet any concerns about that so we have a record
of why using the existing nvmem framework wasn't suitable.

> +Date:          Jan 2021
> +KernelVersion: 5.12
> +Contact:       Mike Looijmans <mike.looijmans@topic.nl>
> +Description:   Allows programming the NVM memory of the clock chip, so i=
t boots
> +               up in the current configuration. This saves boot time (30=
0ms
> +               clock initialization) and allows the clock to be available
> +               before the kernel boots (e.g. u-boot ethernet clock).
> +
> +               Write the magic value 0xc7 to this attribute to program t=
he
> +               chip's current settings into its NVM storage. This magic =
value
> +               is taken from the datasheet, it's the same value that mus=
t be
> +               written to the hardware to program it. Programming can on=
ly be
> +               done twice in the lifetime of the chip.
> +
> +               Read the value to check the state of the chip. This retur=
ns the
> +               raw value as read from the hardware. Possible values:
> +               0x03: Not programmed
> +               0x0f: Programmed once
> +               0x3f: Programmed twice, can no longer be programmed
> +
> +Users:         User space applications for embedded boards equipped with=
 one
> +               or more Si534x programmable clock devices. Would typicall=
y be
> +               used at the end of production stages.

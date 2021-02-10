Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DED315CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhBJCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhBJA5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:57:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFF8464DD1;
        Wed, 10 Feb 2021 00:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612918583;
        bh=ZoQKIvVzok/hLz9EFCq34atnXspGgvkIzh21om9yf9Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lH61zkME6hI0vZ2FBumenHdEiQmkwo43JrWepWx95jTF8qVLqmwlXDoCFjCy4esvT
         4edw8tpJ6Dj9FiMVm11V6alosLd0xuk/nOZAz2ow0Q82m/+KKL9MeF8U2dOm7jU7Ew
         3kgCHxa8nHIl+AcyW+BUzfCJHwEmmej6X2wts5d8NIrJBy1PnzMQNyD9SuaUjLELpx
         +IxjL2RQDUq6sQYWZ8cR1ZvyDgIR3VLbF8nVV0P73CYP7+GzDnuFfv8tfvSKyxTJN6
         i9lHFEofsfAaBwVxnxRu/+7oncUH60p1HYLq1DhySAwej2RVWl8VuzRjuDvgTfsCAb
         7TgbRaKwyO5AA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210203154332.470587-1-tudor.ambarus@microchip.com>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mirq-linux@rere.qmqm.pl, claudiu.beznea@microchip.com,
        a.fatoum@pengutronix.de, krzk@kernel.org,
        codrin.ciubotariu@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        alexandre.belloni@bootlin.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        saravanak@google.com
Date:   Tue, 09 Feb 2021 16:56:22 -0800
Message-ID: <161291858241.418021.7620663458602138308@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tudor Ambarus (2021-02-03 07:43:32)
> These are all "early clocks" that require initialization just at
> of_clk_init() time. Use CLK_OF_DECLARE() to declare them.
>=20
> This also fixes a problem that was spotted when fw_devlink was
> set to 'on' by default: the boards failed to boot. The reason is
> that CLK_OF_DECLARE_DRIVER() clears the OF_POPULATED and causes
> the consumers of the clock to be postponed by fw_devlink until
> the second initialization routine of the clock has been completed.
> One of the consumers of the clock is the timer, which is used as a
> clocksource, and needs the clock initialized early. Postponing the
> timers caused the fail at boot.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Applied to clk-next

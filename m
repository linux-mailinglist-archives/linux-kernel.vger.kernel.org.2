Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92CF44F730
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 09:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKNIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 03:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 03:05:06 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EAAC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 00:02:11 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id DECF22800B3C7;
        Sun, 14 Nov 2021 09:02:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C8FB3161A13; Sun, 14 Nov 2021 09:02:09 +0100 (CET)
Date:   Sun, 14 Nov 2021 09:02:09 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <20211114080209.GA9914@wunner.de>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:18:44PM +0800, LH.Kuo wrote:
> +	if (mode == SPI_SLAVE)
> +		ctlr = spi_alloc_slave(&pdev->dev, sizeof(*pspim));
> +	else
> +		ctlr = spi_alloc_master(&pdev->dev, sizeof(*pspim));
> +	if (!ctlr)
> +		return -ENOMEM;

You need to use devm_spi_alloc_master() and devm_spi_alloc_slave() here
to avoid a use-after-free in pentagram_spi_controller_remove():

That's because spi_unregister_master() frees the spi_controller struct
and the adjacent pspim allocation and pentagram_spi_controller_remove()
accesses pspim afterwards.

The allocation is *not* freed by spi_unregister_master() if the devm_*
variants are used for allocation.  Rather, the allocation is freed only
after pentagram_spi_controller_remove() has finished.


> +free_alloc:
> +	spi_controller_put(ctlr);

This can be dropped if the devm_* variants are used for allocation.


> +	spi_unregister_master(pspim->ctlr);

Please use spi_unregister_controller() here.  (It could be a slave.)

Thanks,

Lukas

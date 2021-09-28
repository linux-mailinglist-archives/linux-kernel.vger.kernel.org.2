Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691A941ABC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhI1J3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:29:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbhI1J3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:29:15 -0400
Received: from [IPv6:2a00:23c6:c31a:b300:d923:587a:81:4f33] (unknown [IPv6:2a00:23c6:c31a:b300:d923:587a:81:4f33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3554D1F43477;
        Tue, 28 Sep 2021 10:27:35 +0100 (BST)
Message-ID: <e50923c01c77ee84141eba071c009ff4b59982be.camel@collabora.com>
Subject: Re: [PATCH] misc: gehc: Add SPI ID table
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 28 Sep 2021 10:27:33 +0100
In-Reply-To: <20210923194609.52647-1-broonie@kernel.org>
References: <20210923194609.52647-1-broonie@kernel.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-23 at 20:46 +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table,
> it uses
> SPI modalises. Supporting OF modalises is going to be difficult if
> not
> impractical, an attempt was made but has been reverted, so ensure
> that
> module autoloading works for this driver by adding a SPI ID table
> entry
> for the device name part of the compatible - currently only the full
> compatible is listed which isn't very idiomatic and won't match the
> modalias that is generated.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested-by: Martyn Welch <martyn.welch@collabora.com>

> ---
>  drivers/misc/gehc-achc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> index 02f33bc60c56..4c9c5394da6f 100644
> --- a/drivers/misc/gehc-achc.c
> +++ b/drivers/misc/gehc-achc.c
> @@ -539,6 +539,7 @@ static int gehc_achc_probe(struct spi_device
> *spi)
>  
>  static const struct spi_device_id gehc_achc_id[] = {
>         { "ge,achc", 0 },
> +       { "achc", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(spi, gehc_achc_id);



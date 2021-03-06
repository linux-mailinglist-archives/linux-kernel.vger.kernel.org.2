Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21DF32F9AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhCFLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:19:26 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:58585 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCFLTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:19:06 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 44EB422239;
        Sat,  6 Mar 2021 12:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615029544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX9fO4b7o8NQG+rCtbaK0gMHIlmYCHWUTWEk7uKieYc=;
        b=fiqyZFA/qmJlYzwdeAt10ZrSLagIBQZmdfpkR2tHYfM9AmLraABBY8FcKm6KlO2ZHk4nNz
        3VmwoKfU2I2soU6Kyrhmejh454b5RGbDGQepd928pxzB6lR1VjJarDydRBxPnsxRJHKxut
        hvWbbV6H1FTaWQS8S1r8uPvUo8c1JF0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Mar 2021 12:19:03 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     vigneshr@ti.com, p.yadav@ti.com, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
In-Reply-To: <20210306095002.22983-5-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <7fb8af561eda06444ee0e0c592147af7@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-06 10:50, schrieb Tudor Ambarus:
> It makes the core file a bit smaller and provides better separation
> between the Software Write Protection features and the core logic.
> All the next generic software write protection features (e.g. 
> Individual
> Block Protection) will reside in swp.c.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

[..]

> @@ -3554,6 +3152,9 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name,
>  	if (ret)
>  		return ret;
> 
> +	if (nor->params->locking_ops)

Should this be in spi_nor_register_locking_ops(), too? I.e.

void spi_nor_register_locking_ops() {
     if (!nor->params->locking_ops)
         return;
..
}

I don't have a strong opinion on that so far. I just noticed because
I put the check into spi_nor_otp_init() for my OTP series. They should
be the same though.

> +		spi_nor_register_locking_ops(nor);

-michael

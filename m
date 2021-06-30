Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403F3B8487
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhF3OAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:00:38 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58285 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbhF3N7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:59:13 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7769522256;
        Wed, 30 Jun 2021 15:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625061401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUNG7j6CiyOnF/U9YKLnvgfplN/scC5c3CBGJyaaHlA=;
        b=C/9rYuoWsJO+Pw3rlE0TJpcYZnGwoloC8PRKKOsyG3BegvI3BXgchO9SsmNijCIGzecNwU
        +IW0lW+1wKQNJQIhXDQNSxspEe55/gmQxs/IOP/bCKmkiN/xVQ4DVIkH1Zww8930ap1eW9
        5U1JpcJc/gcOom6R71iE1I27TaHH+FU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jun 2021 15:56:41 +0200
From:   Michael Walle <michael@walle.cc>
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
In-Reply-To: <20210629150846.21547-2-hongweiz@ami.com>
References: <20210629150846.21547-1-hongweiz@ami.com>
 <20210629150846.21547-2-hongweiz@ami.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <95865068f95f7d75a67e8eb3ab4fe906@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongwei,

Am 2021-06-29 17:08, schrieb Hongwei Zhang:
> Add some Micron M45PEx flash memeories into the IDs table.

Did you test all these flashes?

> Fixes: dd1e9367157f900616f (ARM: dts: everest: Add phase corrections 
> for
> eMMC)

Bogus Fixes tag. First, I cannot find this commit id, which tree is
that? Secondly, adding new flash ids don't fix anything, esp not
something related to eMMC.

> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index ef3695080710..379b14e339ff 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -95,8 +95,12 @@ static const struct flash_info st_parts[] = {
>  	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
> 
>  	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
> +	{ "m45pe20", INFO(0x204012,  0, 64 * 1024,    4, 0) },
> +	{ "m45pe40", INFO(0x204013,  0, 64 * 1024,    8, 0) },
>  	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
>  	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
> +	{ "m45pe32", INFO(0x204016,  0, 64 * 1024,   64, 0) },
> +	{ "m45pe64", INFO(0x204017,  0, 64 * 1024,  128, 0) },
> 
>  	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
>  	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },

-- 
-michael

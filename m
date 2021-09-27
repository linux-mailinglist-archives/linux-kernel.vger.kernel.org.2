Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706494198EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhI0QfM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Sep 2021 12:35:12 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35573 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhI0QfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:11 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 872CA1C0005;
        Mon, 27 Sep 2021 16:33:29 +0000 (UTC)
Date:   Mon, 27 Sep 2021 18:33:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] mtd: fixup CFI on ixp4xx
Message-ID: <20210927183328.2f200fc2@xps13>
In-Reply-To: <20210927141045.1597593-1-arnd@kernel.org>
References: <20210927141045.1597593-1-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@kernel.org wrote on Mon, 27 Sep 2021 16:10:37 +0200:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> drivers/mtd/maps/ixp4xx.c requires MTD_CFI_BE_BYTE_SWAP to be set
> in order to compile.
> 
> drivers/mtd/maps/ixp4xx.c:57:4: error: #error CONFIG_MTD_CFI_BE_BYTE_SWAP required
> 
> This patch avoids the #error output by enforcing the policy in
> Kconfig. Not sure if this is the right approach, but it helps doing
> randconfig builds.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Any other ideas for how to address it?

I am fine with the approach. Should I wait for someone else's Ack?

Thanks,
Miquèl

> ---
>  drivers/mtd/chips/Kconfig | 2 ++
>  drivers/mtd/maps/Kconfig  | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
> index aef14990e5f7..19726ebd973d 100644
> --- a/drivers/mtd/chips/Kconfig
> +++ b/drivers/mtd/chips/Kconfig
> @@ -55,12 +55,14 @@ choice
>  	  LITTLE_ENDIAN_BYTE, if the bytes are reversed.
>  
>  config MTD_CFI_NOSWAP
> +	depends on !ARCH_IXP4XX || CPU_BIG_ENDIAN
>  	bool "NO"
>  
>  config MTD_CFI_BE_BYTE_SWAP
>  	bool "BIG_ENDIAN_BYTE"
>  
>  config MTD_CFI_LE_BYTE_SWAP
> +	depends on !ARCH_IXP4XX
>  	bool "LITTLE_ENDIAN_BYTE"
>  
>  endchoice
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index aaa164b977fe..4945caa88345 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -302,7 +302,7 @@ config MTD_DC21285
>  
>  config MTD_IXP4XX
>  	tristate "CFI Flash device mapped on Intel IXP4xx based systems"
> -	depends on MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX
> +	depends on MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX && MTD_CFI_ADV_OPTIONS
>  	help
>  	  This enables MTD access to flash devices on platforms based
>  	  on Intel's IXP4xx family of network processors such as the


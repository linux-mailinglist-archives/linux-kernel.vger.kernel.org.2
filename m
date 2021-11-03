Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27E444A8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCWBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:01:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42341 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhKCWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:01:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DFC35C01BA;
        Wed,  3 Nov 2021 17:58:54 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute3.internal (MEProxy); Wed, 03 Nov 2021 17:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=BFpSeydUYykvcAWDIgLlGSO9wEbN
        OyaIHwPaFMxP/F4=; b=dhq3viT30ECLz3CJRaKXrfE9trD60xuBLLsYO7wLoEWL
        VGBgefCayJ51vBmfdoAl5h2rh9vDRGH9NTdqh4GnmECobauRG/OeX4svUp8ASYij
        VsM5UR5vvz1QCqNuIHLpLaVqWgQlZYwRFz+RSfcxVR5Ljda+XzTvyBLoc2cdczIW
        Q5IUddHTqVQ1ZXsZDnbSz4UBFWV+yjRXBgcaF8nDeVAG4Lg3636q9WNCi5vPqwxb
        t9WpNKOR5XOT6mdF0v1zWC00WWkf4+5tN35mb/I4iC6nwYFCq1wC1PZOGCZ9szO1
        FhNj26At01LrEglvdKQB+u/JgBDz/XGyqZ5tkW1O3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BFpSey
        dUYykvcAWDIgLlGSO9wEbNOyaIHwPaFMxP/F4=; b=Q2NMiEaVv+T07SBx3JFC5D
        X5sV3s34z8+Tn2vl1xx41UTM7dpzWAstujczJZicggQHbZsD8eepaYkog0RRfmsE
        X9PFMPdGoxf6JLWODR5OTJGq1P9ivotJTCWWuvRe9+Jn8swekrNKVLjmZ5yI4w5Z
        TqOF6x/Xun/yx9wogMyCabV/Qt3XeCfRTjbod7ynWhex5lNkcBldKEg1IlXBMczs
        5ZoC1mdBXjz7NSUgqW3wjt1dQBqHK+MXhbcRdk9yXyEx9xY1BB2J0R0GTqZXaJeo
        hN+Im8egD3X51RDXR+ys1/32qq+fPRSxZcgegyUrR1Lf2nYkFou0MwUo88wXzsKQ
        ==
X-ME-Sender: <xms:HQaDYUR_wGDTc-3gPm4-XcLFNNvUh_GcaqiPGTeW_2zL0bo_vbC2yA>
    <xme:HQaDYRxk87bXl6-VKhul7oy3LGQcmPuFNAFlhgmo6NalYJ0x3L-emnCOZzas3DS5Y
    _eNdDwN0jHMydDzs5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddvgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeuffekveehjeeltdeuveeikeelkeejhfejheduhfdtgfdtgfejjeekvdev
    jeevueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:HQaDYR0gwxoQ18fyxMi6fYSRUul3lYNatAPDT6uWbQYj8AnH2hM__Q>
    <xmx:HQaDYYAmjrndaRPuq7xju33-E4OB2vo4SjO2x5Z_adhBDISWaKajww>
    <xmx:HQaDYdgoYXJoLWFJOzvsT_dvoc6hzplyB7NfnQw0SL8ODutuY216Mg>
    <xmx:HgaDYdJDl3MSLvtCYwRRgbzcF77iqHyblKASTAEJdN0maGwhktg12g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A584AC0DD1; Wed,  3 Nov 2021 17:58:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <107f229e-9060-49f2-bc4b-c12e2d0c1b59@www.fastmail.com>
In-Reply-To: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
Date:   Thu, 04 Nov 2021 07:58:33 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Tyler Hicks" <tyhicks@linux.microsoft.com>,
        "Lee Jones" <lee.jones@linaro.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new mfd-core
 dependency
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021, at 5:04 AM, Tyler Hicks wrote:
> Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> linker error:
> 
> ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
> make: *** [Makefile:1187: vmlinux] Error 1
> 
> Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> drivers/mfd/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ca0edab91aeb..d2f345245538 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1194,6 +1194,7 @@ config MFD_SI476X_CORE
> config MFD_SIMPLE_MFD_I2C
> tristate
> depends on I2C
> + select MFD_CORE
> select REGMAP_I2C
> help
>   This driver creates a single register map with the intention for it
> -- 
> 2.25.1
> 
> 

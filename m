Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8432348522
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhCXXPR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 19:15:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24291 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238989AbhCXXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:14:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-223-zjCwL4CNMgSnfl37WyP4uA-1; Wed, 24 Mar 2021 23:14:41 +0000
X-MC-Unique: zjCwL4CNMgSnfl37WyP4uA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 24 Mar 2021 23:14:41 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 24 Mar 2021 23:14:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] ARM: delay: avoid clang -Wtautological-constant warning
Thread-Topic: [PATCH] ARM: delay: avoid clang -Wtautological-constant warning
Thread-Index: AQHXH+dwZysyW/ACIU21groL09xJy6qTxo9A
Date:   Wed, 24 Mar 2021 23:14:40 +0000
Message-ID: <caf7e56984c347da9e342e89ce530748@AcuMS.aculab.com>
References: <20210323132031.2858996-1-arnd@kernel.org>
In-Reply-To: <20210323132031.2858996-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann
> Sent: 23 March 2021 13:20
> Passing an 8-bit constant into delay() triggers a warning when building
> with 'make W=1' using clang:
> 
> drivers/clk/actions/owl-pll.c:182:2: error: result of comparison of constant 2000 with expression of
> type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         udelay(pll_hw->delay);
>         ^~~~~~~~~~~~~~~~~~~~~
> arch/arm/include/asm/delay.h:84:9: note: expanded from macro 'udelay'
>           ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :              \
>            ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
> arch/arm/mach-omap2/wd_timer.c:89:3: error: result of comparison of constant 2000 with expression of
> type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                 udelay(oh->class->sysc->srst_udelay);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Shut up the warning by adding a cast to a 64-bit number. A cast to 'int'
> would usually be sufficient, but would fail to cause a link-time error
> for large 64-bit constants.

Adding 0u probably has the desired effect - without any side effects of a cast.

	David


> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/delay.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index 4f80b72372b4..1bb6417a3a83 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -81,7 +81,7 @@ extern void __bad_udelay(void);
> 
>  #define udelay(n)							\
>  	(__builtin_constant_p(n) ?					\
> -	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
> +	  ((u64)(n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
>  			__const_udelay((n) * UDELAY_MULT)) :		\
>  	  __udelay(n))
> 
> --
> 2.29.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EB93A70B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhFNUuz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Jun 2021 16:50:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40413 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhFNUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:50:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-65-ON67q3ytPwmYheTyY52QOw-1; Mon, 14 Jun 2021 21:48:46 +0100
X-MC-Unique: ON67q3ytPwmYheTyY52QOw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Jun
 2021 21:48:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 14 Jun 2021 21:48:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jhih-Ming Huang' <fbihjmeric@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "ross.schm.dev@gmail.com" <ross.schm.dev@gmail.com>,
        "maqianga@uniontech.com" <maqianga@uniontech.com>,
        "marcocesati@gmail.com" <marcocesati@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw_security: fix cast to restricted __le32
Thread-Topic: [PATCH] rtw_security: fix cast to restricted __le32
Thread-Index: AQHXYD46HyWlcwiQGkiXWqpP7mZmBasT+umQ
Date:   Mon, 14 Jun 2021 20:48:45 +0000
Message-ID: <8974a58823d74d118595d4f8db5ac870@AcuMS.aculab.com>
References: <20210613102229.1424495-1-fbihjmeric@gmail.com>
In-Reply-To: <20210613102229.1424495-1-fbihjmeric@gmail.com>
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

From: Jhih-Ming Huang
> Sent: 13 June 2021 11:22
> 
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c
> b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..2f4da67e31c6 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		arc4_crypt(ctx, payload, payload,  length);
> 
>  		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +		*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));
> 
>  	}
>  }
> @@ -618,7 +618,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);

Is someone using 'rc4' and 'security' in the same file?

> 
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload,
> +						length - 4));
> 
>  			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
>  			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])

In both cases the *((u32 *)crc) is also very dubious.
Casts of pointers to integer types are almost always broken.
Given the code that follows the second hunk I'm guessing you
have 'u8 crc[4];' (or equivalent).
That can be misaligned and then access will panic on some systems.

There is a get_unaligned_be32() (or something similar) that can be used
to read the crc from (payload + length - 4).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


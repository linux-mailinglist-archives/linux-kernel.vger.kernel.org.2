Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E043F1674
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhHSJoV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 05:44:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25556 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237583AbhHSJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:44:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-25-tzJRfeh1Naq-lFeOcnhxig-1; Thu, 19 Aug 2021 10:43:38 +0100
X-MC-Unique: tzJRfeh1Naq-lFeOcnhxig-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 19 Aug 2021 10:43:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 19 Aug 2021 10:43:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aakash Hemadri' <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] staging: rtl8723bs: fix cast to restricted __le32
Thread-Topic: [PATCH 2/2] staging: rtl8723bs: fix cast to restricted __le32
Thread-Index: AQHXksUjJhmKROZmZkOAch25AOXZzqt6ltFA
Date:   Thu, 19 Aug 2021 09:43:37 +0000
Message-ID: <eb38f6e0ae60489ca396de32d64f0513@AcuMS.aculab.com>
References: <cover.1629135143.git.aakashhemadri123@gmail.com>
 <1be80f0196bed681bf55bfe3155f564b4ebf3b76.1629135143.git.aakashhemadri123@gmail.com>
In-Reply-To: <1be80f0196bed681bf55bfe3155f564b4ebf3b76.1629135143.git.aakashhemadri123@gmail.com>
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

From: Aakash Hemadri
> Sent: 16 August 2021 18:35
> 
> Fix sparse warning:
> warning: cast to restricted __le32

How many different copies of this crappy copy are there?
> 
...
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c
> b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 381deeea99d0..5320b1a46dfb 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -122,7 +122,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		arc4_crypt(ctx, payload, payload,  length);
> 
>  		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);

You've removed a byteswap which is needed on BE architectures.

>  	}
>  }
> @@ -621,7 +621,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);
> 
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
> 
>  			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
>  			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])

As above - crc32_le() does a 'little-endian crc' but returns a host-ordered value.
The (horrid) array cast means you need to store a LE value.

There are a dozen better ways to do this - I'm bored of quoting them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


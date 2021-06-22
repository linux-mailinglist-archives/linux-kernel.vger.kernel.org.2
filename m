Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706393B0047
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVJeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Jun 2021 05:34:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41763 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFVJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:34:13 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-67-DIPGu8glMReRJXuoThpP9w-1; Tue, 22 Jun 2021 10:31:55 +0100
X-MC-Unique: DIPGu8glMReRJXuoThpP9w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 10:31:54 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 10:31:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jhih-Ming Huang' <fbihjmeric@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "ross.schm.dev@gmail.com" <ross.schm.dev@gmail.com>,
        "maqianga@uniontech.com" <maqianga@uniontech.com>,
        "marcocesati@gmail.com" <marcocesati@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] rtw_security: fix cast to restricted __le32
Thread-Topic: [PATCH v5] rtw_security: fix cast to restricted __le32
Thread-Index: AQHXZnYzS3EO6qxolE+NbuqnsEK0NKsfxZUw
Date:   Tue, 22 Jun 2021 09:31:54 +0000
Message-ID: <bdc0c31a7d28426995d229eb9014cd2b@AcuMS.aculab.com>
References: <20210619075255.107807-1-fbihjmeric@gmail.com>
 <20210621081928.145203-1-fbihjmeric@gmail.com>
In-Reply-To: <20210621081928.145203-1-fbihjmeric@gmail.com>
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
> Sent: 21 June 2021 09:19
> 
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> There was a change for replacing private CRC-32 routines with in kernel
> ones.
> However, the author used le32_to_cpu to convert crc32_le(), and we
> should cpu_to_le32.
> 
> Ths commit also fixes the payload checking by memcmp instead of checking element
> by element and removes the unused variable.
...
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c
> b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..8dc6a976b487 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
...
> @@ -537,7 +532,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  	u32 pnh;
>  	u8   rc4key[16];
>  	u8   ttkey[16];
> -	u8 crc[4];
> +	__le32 crc;
>  	signed int			length;
> 
>  	u8 *pframe, *payload, *iv, *prwskey;
> @@ -618,10 +613,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);
> 
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> 
> -			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
> -			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
> +			if (memcmp(&crc, payload + length - 4, 4) != 0)

Shouldn't this be using (IIRC) get_unaligned_le32() ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


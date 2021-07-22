Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC63D26A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhGVOtl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 10:49:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34661 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232138AbhGVOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:49:39 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-154-E8XI6R9BMwq2Wfp8lcAmRg-1; Thu, 22 Jul 2021 16:30:10 +0100
X-MC-Unique: E8XI6R9BMwq2Wfp8lcAmRg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 22 Jul 2021 16:30:09 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 22 Jul 2021 16:30:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Topic: [PATCH v3 1/2] staging: rtl8188eu: Replace a custom function
 with crc32_le()
Thread-Index: AQHXfiEvucvRPynR106nc+5J/iJ13qtPHROQ
Date:   Thu, 22 Jul 2021 15:30:08 +0000
Message-ID: <f396ffee4a414ee092625ee486b871fe@AcuMS.aculab.com>
References: <20210721110052.26376-1-fmdefrancesco@gmail.com>
 <20210721110052.26376-2-fmdefrancesco@gmail.com>
In-Reply-To: <20210721110052.26376-2-fmdefrancesco@gmail.com>
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

From: Fabio M. De Francesco
> Sent: 21 July 2021 12:01
> 
> Use crc32_le() in place of the custom getcrc32().
> 
...
> @@ -609,14 +595,15 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame
> *pxmitframe)
> 
>  				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
>  					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len -
> pattrib->icv_len;
> -					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
> +					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
> 
>  					arcfour_init(&mycontext, rc4key, 16);
>  					arcfour_encrypt(&mycontext, payload, payload, length);
>  					arcfour_encrypt(&mycontext, payload + length, crc, 4);
>  				} else {
>  					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len -
> pattrib->icv_len;
> -					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
> +					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
> +
>  					arcfour_init(&mycontext, rc4key, 16);
>  					arcfour_encrypt(&mycontext, payload, payload, length);
>  					arcfour_encrypt(&mycontext, payload + length, crc, 4);

Change crc to be __le32, kill the casts and pass &crc in the last call.

> @@ -682,7 +669,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
>  			arcfour_init(&mycontext, rc4key, 16);
>  			arcfour_encrypt(&mycontext, payload, payload, length);
> 
> -			*((__le32 *)crc) = getcrc32(payload, length - 4);
> +			*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> 
>  			if (crc[3] != payload[length - 1] ||
>  			    crc[2] != payload[length - 2] ||

You could to the same here, or make crc u32, remove the cpu_to_le32()
and use get_unaligned_u32(payload + length - 4) (or whatever it is called).

But it is much better to do:
	crc = crc32_le(~0, payload, length);
	if (crc != VALID_CRC32)
		res = _FAIL;

You can lookup VALID_CRC32, but it is crc32_le(0, "\xff\xff\xff\xff", 4);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


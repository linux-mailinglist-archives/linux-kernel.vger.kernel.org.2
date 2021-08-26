Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706213F83F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhHZIwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Aug 2021 04:52:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32936 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233195AbhHZIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:52:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-140-kV8jce2GMwKPSLUR9I4nHg-1; Thu, 26 Aug 2021 09:51:25 +0100
X-MC-Unique: kV8jce2GMwKPSLUR9I4nHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 26 Aug 2021 09:51:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 26 Aug 2021 09:51:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Skripkin' <paskripkin@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
Thread-Topic: [PATCH v3 5/6] staging: r8188eu: add error handling of
 rtw_read32
Thread-Index: AQHXmLmWEBrRSWSvqkChOMAmAhSABKuFfA1Q
Date:   Thu, 26 Aug 2021 08:51:23 +0000
Message-ID: <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
In-Reply-To: <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
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

From: Pavel Skripkin <paskripkin@gmail.com>
> Sent: 24 August 2021 08:28
> 
> _rtw_read32 function can fail in case of usb transfer failure. But
> previous function prototype wasn't designed to return an error to
> caller. It can cause a lot uninit value bugs all across the driver code,
> since rtw_read32() returns local stack variable to caller.
> 
> Fix it by changing the prototype of this function. Now it returns an
> int: 0 on success, negative error value on failure and callers should pass
> the pointer to storage location for register value.

Pretty horrid API interface.
Functions like readl() - which can fail just return ~0u and let
the caller worry about whether that causes serious grief.

You could make all the read functions return __u64 and return ~0ull
on error.
Testing for (value & 1ull << 63) will be reasonable even on 32bit.

...
> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>  {
>  	u8 requesttype;
>  	u16 wvalue;
>  	u16 len;
> -	__le32 data;
> +	int res;
> +	__le32 tmp;
> +
> +	if (WARN_ON(unlikely(!data)))
> +		return -EINVAL;
> 

Kill the NULL check - it is a silly coding error.
An OOPS is just as easy to debug.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


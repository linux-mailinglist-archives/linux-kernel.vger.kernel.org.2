Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2340B0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhINOer convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 10:34:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40685 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233948AbhINOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-GKhXO-hBN5qLmGUxZGUZaQ-1; Tue, 14 Sep 2021 15:33:26 +0100
X-MC-Unique: GKhXO-hBN5qLmGUxZGUZaQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:33:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 14 Sep 2021 15:33:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>
CC:     Pavel Skripkin <paskripkin@gmail.com>
Subject: RE: [PATCH v4 16/18] staging: r8188eu: hal: Clean up rtw_read*() and
 rtw_write*()
Thread-Topic: [PATCH v4 16/18] staging: r8188eu: hal: Clean up rtw_read*() and
 rtw_write*()
Thread-Index: AQHXqMsDtDyprOASeUiv/PXb20u/Xaujl9CA
Date:   Tue, 14 Sep 2021 14:33:24 +0000
Message-ID: <abe86b14417b41cfaaea2707fa304c1a@AcuMS.aculab.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-17-fmdefrancesco@gmail.com>
In-Reply-To: <20210913181002.16651-17-fmdefrancesco@gmail.com>
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
> Sent: 13 September 2021 19:10
...
> +	u16 address = (u16)(addr & 0xffff);
> 
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);

You really don't need the (u16) cast or the '& 0xffff'.
The assignment will just truncate.

But do you even need to truncate the value at all?
It rather depends on what happens inside usbctrl_vendorreq()
and whether the parameter to this code is already constrained.

I think modern gcc are better, but I have seen code where
the '& 0xffff' masked the value, then the (u16) masked the
value and finally the low 16 bits were written into a structure.

(Oh the other patches are now readable - a lot of junk down the pan.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


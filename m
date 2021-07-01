Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59F93B9395
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhGAOyn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jul 2021 10:54:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54108 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232413AbhGAOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:54:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-113-DqUz9PK-PK6sTLwh_3HG4w-1; Thu, 01 Jul 2021 15:52:09 +0100
X-MC-Unique: DqUz9PK-PK6sTLwh_3HG4w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 1 Jul
 2021 15:52:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Thu, 1 Jul 2021 15:52:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Topic: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Index: AQHXbn5ab3Zj0XkM6U+MISzKcNjhyasuNAtw
Date:   Thu, 1 Jul 2021 14:52:08 +0000
Message-ID: <2fac9d8813374e95bcc04134a0f40f45@AcuMS.aculab.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210701133809.26534-1-fmdefrancesco@gmail.com>
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
> Sent: 01 July 2021 14:38
> 
> Use crc32_le in place of the custom getcrc32. This change makes GCC
> to warn about incorrect castings to the restricted type __le32, but
> they can be safely ignored because crc32_le calculates bitwise
> little-endian Ethernet AUTODIN II CRC32.
> 
...
> -					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
> +					*((__le32 *)crc) = ~crc32_le(~0, payload, length);

Haven't we been round this before?
You need to get rid of these crappy casts.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


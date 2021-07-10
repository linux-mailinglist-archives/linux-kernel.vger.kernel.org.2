Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D73C36D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhGJUo4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jul 2021 16:44:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24631 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhGJUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 16:44:54 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-288-KIu4VRrmNiiz93j7OdgeJQ-1; Sat, 10 Jul 2021 21:42:03 +0100
X-MC-Unique: KIu4VRrmNiiz93j7OdgeJQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Sat, 10 Jul 2021 21:42:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Sat, 10 Jul 2021 21:42:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>
Subject: RE: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Topic: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Index: AQHXdZlS7uKLeikeukSCM0Q+7FrN3Ks8qnww
Date:   Sat, 10 Jul 2021 20:42:02 +0000
Message-ID: <d53fb195104a4b269a7cd320049a133b@AcuMS.aculab.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com>
 <202107100829.RxcC1tei-lkp@intel.com> <1790135.9ZQ2ZFNHWj@linux.local>
In-Reply-To: <1790135.9ZQ2ZFNHWj@linux.local>
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
> Sent: 10 July 2021 15:39
...
> [CUT]
[PASTE}
> 597						*((__le32 *)crc) = ~crc32_le(~0, payload, length);
> 
> I suppose that these warnings are false positives for the reasons explained in
> my patch.

No they are an indication you aren't doing things 'right'.
You shouldn't need an __le32 cast in this code.
'crc' should be defined as __le32 (not u8[4]) and IIRC
get_unaligned_le32() used in the latter check.

Actually what is this code actually doing.
ISTR it is doing a crc32() and then comparing the result with the
crc in the buffer?
No hardware ever does that.
What happens is the receiver does the crc of the whole buffer
including the transmitted crc and then checks the value is the
required 'magic' constant'.
This all works because the crc is inverted before transmission.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


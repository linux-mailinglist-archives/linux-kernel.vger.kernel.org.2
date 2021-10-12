Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91F42AE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhJLVMn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Oct 2021 17:12:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48208 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233060AbhJLVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:12:38 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127-z6UcphpBN2u1BZkCwo7MKw-1; Tue, 12 Oct 2021 22:10:34 +0100
X-MC-Unique: z6UcphpBN2u1BZkCwo7MKw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 12 Oct 2021 22:10:32 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 12 Oct 2021 22:10:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: RE: Use of '%#02x' is almost always wrong
Thread-Topic: Use of '%#02x' is almost always wrong
Thread-Index: AQHXvfZAETUX8XTqNU6mI/eVjyEZpqvP3atg
Date:   Tue, 12 Oct 2021 21:10:32 +0000
Message-ID: <f41e216ed5074c55ad024e68a7dfaa3c@AcuMS.aculab.com>
References: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
In-Reply-To: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
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

From: Joe Perches
> Sent: 10 October 2021 17:46
> 
> Perhaps too many developers do not know that using '%#<width>x'
> in printf output _includes_ the 0x prefix in the output width.
> 
> So %#02x already has the width taken by the 0x prefix and will
> always emit 3 or more output bytes.
> 
> sprintf(buf, "%#02x", 1) emits 0x1 (3 bytes of output)
> sprintf(buf, "%#02x", 255) emits 0xff (4 bytes of output)
> 
> So presumably all the uses of %#02x in the kernel are not outputting
> what is actually expected.  Perhaps all of these should use %#04x.

Doesn't help. The definition of "%#x" is completely broken.
Basically 0 doesn't get the "0x" prefix, so "%#04x" outputs
"0000" if the value is zero.
So the correct replacement is (probably) "0x%02x".

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


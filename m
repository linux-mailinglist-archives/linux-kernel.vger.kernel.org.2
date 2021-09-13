Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1A409826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbhIMP6x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Sep 2021 11:58:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:41565 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345583AbhIMP63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:58:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-266-1-KPiJzgMQSV9QbqBO6u9w-1; Mon, 13 Sep 2021 16:57:11 +0100
X-MC-Unique: 1-KPiJzgMQSV9QbqBO6u9w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 13 Sep 2021 16:57:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 13 Sep 2021 16:57:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: RE: [PATCH] xtensa: Increase size of gcc stack frame check
Thread-Topic: [PATCH] xtensa: Increase size of gcc stack frame check
Thread-Index: AQHXp4FD14pA8IBSYEm3jyWL1V8qFauiH7lQ
Date:   Mon, 13 Sep 2021 15:57:08 +0000
Message-ID: <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
References: <20210912025235.3514761-1-linux@roeck-us.net>
In-Reply-To: <20210912025235.3514761-1-linux@roeck-us.net>
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

From: Guenter Roeck
> Sent: 12 September 2021 03:53
> 
> xtensa frame size is larger than the frame size for almost all other
> architectures. This results in more than 50 "the frame size of <n> is
> larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.
> 
> Increase frame size for xtensa to 1536 bytes to avoid compile errors
> due to frame size limits.

Have you done anything to check what happens at run-time?
I'd guess that the deepest stack use is inside printk() in
some obscure error path.

In reality all these 1k+ stack frames need killing
rather than the limit for the compiler warning increased.

While it may be sensible for a system call entry function
so allocate a reasonable size buffer on stack (as poll()
and sendmsg() probably do) allocating big buffers way
down the call stack could easily cause stack overflow.
Even a 1k stack frame is huge.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


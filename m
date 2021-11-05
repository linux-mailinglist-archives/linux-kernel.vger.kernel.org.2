Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB894462BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhKELdY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Nov 2021 07:33:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52206 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhKELdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:33:23 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-285-i4H1R1XWNb-mEq-pU1oHjA-1; Fri, 05 Nov 2021 11:30:41 +0000
X-MC-Unique: i4H1R1XWNb-mEq-pU1oHjA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Fri, 5 Nov 2021 11:30:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Fri, 5 Nov 2021 11:30:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yang Guang' <davidcomponentone@gmail.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>
CC:     "jdike@addtoit.com" <jdike@addtoit.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        "yang.guang5@zte.com.cn" <yang.guang5@zte.com.cn>,
        "zealci@zte.com.cn" <zealci@zte.com.cn>
Subject: RE: [PATCH v2] um: use swap() to make code cleaner
Thread-Topic: [PATCH v2] um: use swap() to make code cleaner
Thread-Index: AQHX0g0JzvytdeFoH0ShjyqJj7xKbqv0zFIg
Date:   Fri, 5 Nov 2021 11:30:40 +0000
Message-ID: <e392bf23c3ae4b93b1ffb23e40728873@AcuMS.aculab.com>
References: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
 <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
In-Reply-To: <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
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

From: Yang Guang
> Sent: 05 November 2021 06:19
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

Is there any real point to any of these patches??

If I'm reading a 'random' piece of code I now have to assume
that swap() is something that 'magically' exchanges two items.
This requires more brain-power than parsing the three lines
that do an actual swap.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


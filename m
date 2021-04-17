Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F336307F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhDQOAD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Apr 2021 10:00:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20565 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhDQOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:00:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-vl0FeB5ZN9KlyvtC7G0NGQ-1; Sat, 17 Apr 2021 14:59:33 +0100
X-MC-Unique: vl0FeB5ZN9KlyvtC7G0NGQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 17 Apr 2021 14:59:32 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 17 Apr 2021 14:59:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Thread-Topic: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Thread-Index: AQHXMvjk6jXIkdHnG0KLlGcZVxHm0qq4vBHA
Date:   Sat, 17 Apr 2021 13:59:32 +0000
Message-ID: <ff0feb86ea63487f96f14fc9f8f9222f@AcuMS.aculab.com>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk>
In-Reply-To: <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk>
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

From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: 16 April 2021 20:44
> On Fri, Apr 16, 2021 at 12:24:13PM -0700, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > We have to loop only to copy u64 values.
> > After this first loop, we copy at most one u32, one u16 and one byte.
> 
> Does it actually yield a better code?
> 
> FWIW, this
> void bar(unsigned);
> void foo(unsigned n)
> {
> 	while (n >= 8) {
> 		bar(n);
> 		n -= 8;
> 	}
> 	while (n >= 4) {
> 		bar(n);
> 		n -= 4;
> 	}
> 	while (n >= 2) {
> 		bar(n);
> 		n -= 2;
> 	}
> 	while (n >= 1) {
> 		bar(n);
> 		n -= 1;
> 	}
> }

This variant might be better:

void foo(unsigned n)
{
	while (n >= 8) {
		bar(8);
		n -= 8;
	}
	if (likely(!n))
		return;
	if (n & 4)
		bar(4);
	if (n & 2)
		bar(2);
	if (n & 1)
		bar(1);
}

I think Al's version might have optimised down to this,
but Eric's asm contains the n -= 4/2/1;

OTOH gcc can make a real pig's breakfast of code like this!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


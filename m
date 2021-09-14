Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6440A918
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhINIZB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 04:25:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:55755 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhINIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:25:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-spjJskWLOtKyxaxI53WEXQ-1;
 Tue, 14 Sep 2021 09:23:41 +0100
X-MC-Unique: spjJskWLOtKyxaxI53WEXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 09:23:41 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 14 Sep 2021 09:23:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>
CC:     Douglas Gilbert <dgilbert@interlog.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: how many memset(,0,) calls in kernel ?
Thread-Topic: how many memset(,0,) calls in kernel ?
Thread-Index: AQHXp5KEgy5ggGKXu0iAcdzvqjgoc6uiIXMA///yLYCAAR6/oA==
Date:   Tue, 14 Sep 2021 08:23:40 +0000
Message-ID: <15cd0a8e72b3460db939060db25dd59a@AcuMS.aculab.com>
References: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
 <20210912045608.GB16216@1wt.eu>
 <88976a40175c491fb5e3349f6686ad67@AcuMS.aculab.com>
 <20210913160945.GA2456@1wt.eu>
In-Reply-To: <20210913160945.GA2456@1wt.eu>
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

From: Willy Tarreau
> Sent: 13 September 2021 17:10
> 
> On Mon, Sep 13, 2021 at 04:03:09PM +0000, David Laight wrote:
> > >   36:   b9 06 00 00 00          mov    $0x6,%ecx
> > >   3b:   4c 89 e7                mov    %r12,%rdi
> > >   3e:   f3 ab                   rep stos %eax,%es:(%rdi)
> > >
> > > The last line does exactly "memset(%rdi, %eax, %ecx)". Just two bytes
> > > for some code that modern processors are even able to optimize.
> >
> > Hmmm I'd bet that 6 stores will be faster on ~everything.
> > 'modern' processors do better than some older ones [1], but 6
> > writes isn't enough to get into the really fast paths.
> > So you'll still take a few cycles of setup.
> 
> The exact point is, here it's up to the compiler to decide thanks to
> its builtin what it considers best for the target CPU. It already
> knows the fixed size and the code is emitted accordingly. It may
> very well be a call to the memset() function when the size is large
> and a power of two because it knows alternate variants are available
> for example.
> 
> The compiler might even decide to shrink that area if other bytes
> are written just after the memset(), leaving only holes touched by
> memset().

You might think the compiler will make sane choices for the target CPU.
But it often makes a complete pig's breakfast of it.
I'm pretty sure 6 'rep stos' is slower than 6 write an absolutely
everything - with the possible exception of an 8088.

By far the worst ones are when the compiler decides to pessimise
a loop by using the simd (eg avx512) instructions to do 4 (or 8)
loop iterations in one pass.
It might be fine if the loop count is in the 100s - but not when it is 3.

One compiler I've used nicely converted any byte copy loop
into a 'rep movsb' instruction.
That was contemporary with P4 netburst - where it was terribly slow.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


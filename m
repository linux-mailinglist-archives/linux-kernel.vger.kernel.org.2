Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA83F2234
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHSVXg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 17:23:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39061 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhHSVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:23:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-jK_kyUcYM325kxK8jwd6cg-1;
 Thu, 19 Aug 2021 22:22:56 +0100
X-MC-Unique: jK_kyUcYM325kxK8jwd6cg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 19 Aug 2021 22:22:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 19 Aug 2021 22:22:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "terrelln@fb.com" <terrelln@fb.com>
Subject: RE: [PATCH] lib/zstd: Fix bitwise vs logical operators
Thread-Topic: [PATCH] lib/zstd: Fix bitwise vs logical operators
Thread-Index: AQHXkwP9hKCn1U30S0yWYygV6tj6Nat7Wbtg
Date:   Thu, 19 Aug 2021 21:22:54 +0000
Message-ID: <defb9e5133234835950c21511d776fb9@AcuMS.aculab.com>
References: <20210815004154.1781834-1-nathan@kernel.org>
 <20210816180532.6e85c93f84d62dc720d21178@linux-foundation.org>
In-Reply-To: <20210816180532.6e85c93f84d62dc720d21178@linux-foundation.org>
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

From: Andrew Morton
> Sent: 17 August 2021 02:06
> 
> On Sat, 14 Aug 2021 17:41:54 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > clang warns several times along the lines of:
> >
> > lib/zstd/compress.c:1043:7: warning: bitwise and of boolean expressions; did you mean logical and?
> [-Wbool-operation-and]
> >                 if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                    &&
> >
> > Bitwise ANDs do not short circuit, meaning that the ZSTD_read32 calls
> > will be evaluated even if the first condition is not true. This is not
> > always a problem but it is not a standard way to do conditionals so
> > replace the bitwise ANDs with logical ones to fix the warning and make
> > the code clearer.
> >
> > ...
> >
> > --- a/lib/zstd/compress.c
> > +++ b/lib/zstd/compress.c
> > @@ -1040,7 +1040,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t
> sr
> >  		const BYTE *match = base + matchIndex;
> >  		hashTable[h] = curr; /* update hash table */
> >
> > -		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
> > +		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
> 
> yeah, this is a late night party trick which is sometimes used to
> attempt to speed things up by avoiding a branch.  It is perhaps
> beneficial if the LHS is almost always true.  I guess.
> 
> I'd prefer that the code not do this - it's silly, looks wrong and I
> bet it's unmeasurable.
> 
> But I think this code is supposed to be kept in sync with an
> out-of-tree upstream version so this change might be problematic.

Except that in this case you want the short-circuit.
The RH condition is slow and always true when offset_1 is zero.
OTOH subtracting offset_1 makes the lines look odd (out of context).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


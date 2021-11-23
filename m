Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B445A0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhKWLB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Nov 2021 06:01:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:44821 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234392AbhKWLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:01:55 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-216-XlLQYH2JOpGrDdyJLmGKag-1; Tue, 23 Nov 2021 10:58:45 +0000
X-MC-Unique: XlLQYH2JOpGrDdyJLmGKag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 10:58:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 10:58:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     "'Vaittinen, Matti'" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoCAAAQ4gIAABfAAgAFlEYCAAAMFAIAAAGHg
Date:   Tue, 23 Nov 2021 10:58:44 +0000
Message-ID: <89f18bd93ce545feb7a02889ae49f079@AcuMS.aculab.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
 <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
 <YZzGwubCr8RZtbFM@smile.fi.intel.com>
In-Reply-To: <YZzGwubCr8RZtbFM@smile.fi.intel.com>
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

From: Andy Shevchenko
> Sent: 23 November 2021 10:48
> 
> On Tue, Nov 23, 2021 at 10:42:45AM +0000, David Laight wrote:
> > From: Vaittinen, Matti
> > > Sent: 22 November 2021 13:19
> > >
> > > On 11/22/21 14:57, Andy Shevchenko wrote:
> > > > On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > > >> On 11/22/21 13:28, Andy Shevchenko wrote:
> > > >>> On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > > >
> > > > What do you mean by this?
> > > >
> > > > hweight() will return you the number of the non-zero elements in the set.
> > >
> > > Exactly. The function I added did only check if given set of bits had
> > > only one bit set.
> >
> > Checking for exactly one bit can use the (x & (x - 1)) check on
> > non-zero values - which may even be better on some cpus with a
> > popcnt instruction.
> 
> In the discussed case the value pretty much can be 0, meaning you have
> to add an additional test which I believe diminishes all efforts for
> the is_power_of_2() call.

I wouldn't have thought so.
Code would be:
	if (!scan_for_non_zero())
		return 0;
	if (!is_power_of_2())
		return 0;
	return scan_for_non_zero() ? 0 : 1;

Hand-crafting asm you'd actually check for (x - 1) generating
carry in the initial scan.

The latency of popcnt it worse than arithmetic on a lot of x86 cpu.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


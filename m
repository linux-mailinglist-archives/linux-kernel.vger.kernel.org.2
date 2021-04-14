Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9D35F7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbhDNPcd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Apr 2021 11:32:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21862 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233644AbhDNPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:32:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-260-2ItaeQAlMXO4xATmhgmnXw-1; Wed, 14 Apr 2021 16:32:05 +0100
X-MC-Unique: 2ItaeQAlMXO4xATmhgmnXw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 16:32:05 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 16:32:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when
 possible
Thread-Topic: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when
 possible
Thread-Index: AQHXMUHmVAfluj7FfEq84rYmesOs4qq0IuPA
Date:   Wed, 14 Apr 2021 15:32:04 +0000
Message-ID: <efcabc9410cf4d03b203749a02e5a935@AcuMS.aculab.com>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412215428.GM26583@gate.crashing.org>
 <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
 <20210413215803.GT26583@gate.crashing.org>
 <1618365589.67fxh7cot9.astroid@bobo.none>
 <20210414122409.GV26583@gate.crashing.org>
 <daacce9f-1900-1034-980b-be5a58d6be09@csgroup.eu>
 <20210414151921.GW26583@gate.crashing.org>
In-Reply-To: <20210414151921.GW26583@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 14 April 2021 16:19
...
> > Could the kernel use GCC builtin atomic functions instead ?
> >
> > https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> 
> Certainly that should work fine for the simpler cases that the atomic
> operations are meant to provide.  But esp. for not-so-simple cases the
> kernel may require some behaviour provided by the existing assembler
> implementation, and not by the atomic builtins.
> 
> I'm not saying this cannot work, just that some serious testing will be
> needed.  If it works it should be the best of all worlds, so then it is
> a really good idea yes :-)

I suspect they just add an extra layer of abstraction that makes it
even more difficult to verify and could easily get broken by a compiler
update (etc).

The other issue is that the code needs to be correct with compiled
with (for example) -O0.
That could very easily break anything except the asm implementation
if additional memory accesses and/or increased code size cause grief.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7733C24D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhCOQjC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 12:39:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57867 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233294AbhCOQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:38:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-domXswKeOEeQ-pCojPyt9g-1; Mon, 15 Mar 2021 16:38:53 +0000
X-MC-Unique: domXswKeOEeQ-pCojPyt9g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 16:38:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 15 Mar 2021 16:38:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <rasmus.villemoes@prevas.dk>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
Thread-Topic: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
Thread-Index: AQHXGbeqwOTgfnOElE2I7+OcNDHUgqqFPWMA
Date:   Mon, 15 Mar 2021 16:38:52 +0000
Message-ID: <14e2cfb8c3f141aaba8fe0fb2d8f1885@AcuMS.aculab.com>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
 <20210312022940.GO29191@gate.crashing.org>
 <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk>
In-Reply-To: <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk>
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

From: Rasmus Villemoes
> Sent: 15 March 2021 16:24
> 
> On 12/03/2021 03.29, Segher Boessenkool wrote:
> > Hi!
> >
> > On Tue, Mar 09, 2021 at 06:19:30AM +0000, Christophe Leroy wrote:
> >> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> >> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> >> generates a call to _restgpr_31_x.
> >
> >> I don't know if there is a way to tell GCC not to emit that call, because at the end we get more
> instructions than needed.
> >
> > The function is required by the ABI, you need to have it.
> >
> > You get *fewer* insns statically, and that is what -Os is about: reduce
> > the size of the binaries.
> 
> Is there any reason to not just always build the vdso with -O2? It's one
> page/one VMA either way, and the vdso is about making certain system
> calls cheaper, so if unconditional -O2 could save a few cycles compared
> to -Os, why not? (And if, as it seems, there's only one user within the
> DSO of _restgpr_31_x, yes, the overall size of the .text segment
> probably increases slightly).

Sometimes -Os generates such horrid code you really never want to use it.
A classic is on x86 where it replaces 'load register with byte constant'
with 'push byte' 'pop register'.
The code is actually smaller but the execution time is horrid.

There are also cases where -O2 actually generates smaller code.

Although you may need to disable loop unrolling (often dubious at best)
and either force or disable some function inlining.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


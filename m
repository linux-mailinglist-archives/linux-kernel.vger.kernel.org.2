Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584C033D0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhCPJfs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Mar 2021 05:35:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54566 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233885AbhCPJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:35:31 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-IBslWWs2N5Cmqi95XwcuXQ-1; Tue, 16 Mar 2021 09:35:27 +0000
X-MC-Unique: IBslWWs2N5Cmqi95XwcuXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 09:35:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 16 Mar 2021 09:35:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>
CC:     'Rasmus Villemoes' <rasmus.villemoes@prevas.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
Thread-Topic: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
Thread-Index: AQHXGbeqwOTgfnOElE2I7+OcNDHUgqqFPWMAgAB9u4CAAJjNQA==
Date:   Tue, 16 Mar 2021 09:35:26 +0000
Message-ID: <e2493e6aaa454604a10dd811a369d104@AcuMS.aculab.com>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
 <20210312022940.GO29191@gate.crashing.org>
 <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk>
 <14e2cfb8c3f141aaba8fe0fb2d8f1885@AcuMS.aculab.com>
 <20210315235947.GD16691@gate.crashing.org>
In-Reply-To: <20210315235947.GD16691@gate.crashing.org>
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
> Sent: 16 March 2021 00:00
...
> > Although you may need to disable loop unrolling (often dubious at best)
> > and either force or disable some function inlining.
> 
> The cases where GCC does loop unrolling at -O2 always help quite a lot.
> Or, do you have a counter-example?  We'd love to see one.

The real problem with loop unrolling is that quite often a modern
out-of-order superscaler processor actually has 'spare' execution
cycles where the loop control can be done 'for free'.
Sometimes you do need to unroll (or interleave) a couple of
times to get enough spare execution cycles.

But the unrolled loop has to read a lot more code into cache
- so unless the code is 'hot cache' (that is usually arranged
for benchmarking) those delays apply as well.
The larger code footprint also displaces other code.

My real annoyance with gcc is unrolling (and vectorizing)
loops that I know are never executed as many times as even one
copy of the unrolled loop.

As an example intel (ivy bridge onwards) cpu execute the
following code (the middle of the ip checksum) at 8 bytes/clock.
(Limited by the carry flag.)
It just doesn't need any further unrolling.

+               "10:    jecxz 20f\n"
+               "       adc   (%[buff], %[len]), %[sum_0]\n"
+               "       adc   8(%[buff], %[len]), %[sum_1]\n"
+               "       lea   32(%[len]), %[len_tmp]\n"
+               "       adc   16(%[buff], %[len]), %[sum_0]\n"
+               "       adc   24(%[buff], %[len]), %[sum_1]\n"
+               "       mov   %[len_tmp], %[len]\n"
+               "       jmp   10b\n"

Annoyingly that loop is slow on my 8-core atom. 
The existing code only does 4 bytes/clock on intel cpu prior
to either broadwell or haswell (forgotten which) in spite
of much more unroling.


> And yup, inlining is hard.  GCC's heuristics there are very good
> nowadays, but any single decision has big effects.  Doing the important
> spots manually (always_inline or noinline) has good payoff.

Latest inline gripe was a function replicated about 20 times
when the non-inline version was a register load and 'tail call'.
The inlining is just bloat.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9202843C8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhJ0L6r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Oct 2021 07:58:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56398 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241746AbhJ0L6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:58:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-1d04a16FMIGKdwG7JXoMtw-1; Wed, 27 Oct 2021 12:56:15 +0100
X-MC-Unique: 1d04a16FMIGKdwG7JXoMtw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 12:56:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Wed, 27 Oct 2021 12:56:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Paul_Heidekr=FCger=27?= 
        <paul.heidekrueger@in.tum.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
CC:     "elver@google.com" <elver@google.com>,
        "charalampos.mainas@gmail.com" <charalampos.mainas@gmail.com>,
        "pramod.bhatotia@in.tum.de" <pramod.bhatotia@in.tum.de>
Subject: RE: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Thread-Topic: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Thread-Index: AQHXyx14IIc6Crq8PkmcLvT6nyYhravmu2LQ
Date:   Wed, 27 Oct 2021 11:56:14 +0000
Message-ID: <dcf9431eb760424bbf01b0cc8bff6d92@AcuMS.aculab.com>
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
In-Reply-To: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
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

From: Paul Heidekrüger
> Sent: 27 October 2021 11:20
> 
> For my bachelor thesis, I have been working on the infamous problem of
> potentially broken dependency orderings in the Linux kernel. I'm being
> advised by Marco Elver, Charalampos Mainas, Pramod Bhatotia (Cc'd).
> 
> For context, see:
> https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--
> _Dependency_ordering.pdf
> 
> Our approach consists of two LLVM compiler passes which annotate
> dependencies in unoptimised intermediate representation (IR) and verify
> the annotated dependencies in optimised IR. ATM, the passes only
> recognise a subset of address dependencies - everything is still WIP ;-)
> 
> We have been cross-compiling with a slightly modified version of
> allyesconfig for arm64, and the passes have now found a case that we
> would like to share with LKML for feedback: an address dependency being
> broken (?) through compiler optimisations in
> fs/afs/addr_list.c::afs_iterate_addresses().
> 
> Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:
> 
> > [...]
> >   index = READ_ONCE(ac->alist->preferred);
> >   if (test_bit(index, &set))
> >     goto selected;
> > [...]
> 
> where test_bit() expands to the following in
> include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> 
> > static __always_inline int
> > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > {
> >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > }
> > #define test_bit arch_test_bit

I don't think there is expected to be an address dependency.
The READ_ONCE() is needed to ensure the generated code doesn't use
two different values for 'index' - eg for 'nr' inside arch_test_bit().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


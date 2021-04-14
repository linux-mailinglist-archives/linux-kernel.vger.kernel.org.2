Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0550F35F891
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352747AbhDNP7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Apr 2021 11:59:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:34975 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351163AbhDNP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:59:40 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-gB8-kn-7OJerCywESBUe9A-2; Wed, 14 Apr 2021 16:59:15 +0100
X-MC-Unique: gB8-kn-7OJerCywESBUe9A-2
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 16:59:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 16:59:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>
CC:     =?iso-8859-1?Q?Christoph_M=FCllner?= <christophm30@gmail.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Subject: RE: [RFC][PATCH] locking: Generic ticket-lock
Thread-Topic: [RFC][PATCH] locking: Generic ticket-lock
Thread-Index: AQHXMS3QDy7Ki/2OMUKsa3pFr4OLI6q0KzPA
Date:   Wed, 14 Apr 2021 15:59:12 +0000
Message-ID: <9b3bbe8f20e14a7b91dc85737ecb99c0@AcuMS.aculab.com>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <CAJF2gTRsQQ=RunxK6R9MfK70dULt=RJOXXGCOT9oDPEsBgvKtQ@mail.gmail.com>
 <YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net>
In-Reply-To: <YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 14 April 2021 13:56
> 
> > I've tested it on csky SMP*4 hw (860) & riscv SMP*4 hw (c910) and it's okay.
> 
> W00t :-)
> 
> > Hope you can keep
> > typedef struct {
> >         union {
> >                 atomic_t lock;
> >                 struct __raw_tickets {
> > #ifdef __BIG_ENDIAN
> >                         u16 next;
> >                         u16 owner;
> > #else
> >                         u16 owner;
> >                         u16 next;
> > #endif
> >                 } tickets;
> >         };
> > } arch_spinlock_t;
> >
> > Using owner & next is much more readable.
> 
> That almost doubles the line-count of the thing ;-)

And relies on the compiler not ever spilling it to stack.
Which it is much more likely to do that for the version
that uses shifts.

Have you checked what happens with -O0 ?
I don't think that is banned by the build system.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


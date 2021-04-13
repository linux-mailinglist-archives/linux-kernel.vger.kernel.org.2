Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C635DCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbhDMKzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Apr 2021 06:55:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:40439 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344172AbhDMKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:55:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-196-tpOvhhP9PI6OZgNvLUAArQ-1; Tue, 13 Apr 2021 11:54:37 +0100
X-MC-Unique: tpOvhhP9PI6OZgNvLUAArQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 11:54:36 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 11:54:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Catalin Marinas' <catalin.marinas@arm.com>,
        =?iso-8859-1?Q?Christoph_M=FCllner?= <christophm30@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: RE: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Thread-Topic: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Thread-Index: AQHXMFIUXH3Voi0JlEKNZc90N7zZnaqyRXDQ
Date:   Tue, 13 Apr 2021 10:54:36 +0000
Message-ID: <73cab48b63ea4ba3b1ef532f47d146f4@AcuMS.aculab.com>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net>
 <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
 <20210413104503.GD15806@arm.com>
In-Reply-To: <20210413104503.GD15806@arm.com>
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

From: Catalin Marinas
> Sent: 13 April 2021 11:45
...
> This indeed needs some care. IIUC RISC-V has similar restrictions as arm
> here, no load/store instructions are allowed between LR and SC. You
> can't guarantee that the compiler won't spill some variable onto the
> stack.

You can probably never guarantee the compiler won't spill to stack.
Especially if someone compiles with -O0.

Which probably means that anything using LR/SC must be written in
asm and the C wrappers disabled.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


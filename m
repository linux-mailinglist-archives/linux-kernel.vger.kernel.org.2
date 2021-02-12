Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C182F31A11C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBLPHt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Feb 2021 10:07:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35506 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhBLPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:07:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-31-hrJHvB6rMCGK0AN18ZrM-g-1; Fri, 12 Feb 2021 15:06:03 +0000
X-MC-Unique: hrJHvB6rMCGK0AN18ZrM-g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 12 Feb 2021 15:06:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 12 Feb 2021 15:06:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Catalin Marinas' <catalin.marinas@arm.com>
CC:     Mark Brown <broonie@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "sonicadvance1@gmail.com" <sonicadvance1@gmail.com>,
        "amanieu@gmail.com" <amanieu@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        "Amit Daniel Kachhap" <amit.kachhap@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Kristina Martsenko" <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Thread-Topic: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Thread-Index: AQHXAUNInwWNlJur40qqyYPDj4lGvapUi6pAgAAM0ICAAAPe4A==
Date:   Fri, 12 Feb 2021 15:06:04 +0000
Message-ID: <427bfdffb2da4561879c720881d9dc96@AcuMS.aculab.com>
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
 <20210212123515.GC6057@sirena.org.uk> <20210212132807.GC7718@arm.com>
 <7300c3cbce95498b9fbe7ee754250794@AcuMS.aculab.com>
 <20210212144400.GD7718@arm.com>
In-Reply-To: <20210212144400.GD7718@arm.com>
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

> > Any user space adaption layer would have to know which actual
> > driver has been opened and what internal structures it has.
> > Getting that right is hard and difficult.
> > The recent changes to move (IIRC) sockopt compatibility down
> > into the protocol code found quite a few places where it was
> > previously broken.
> > It is much easier to get it right in the code that knows about
> > the actual structures.
> 
> As Arnd I think was suggesting, we could have an ioctl32() syscall that
> allows compat arguments but not opening up the whole set of compat
> syscalls to native processes.

Why is that a problem.
The kernel has to allow absolute garbage in syscall parameters.
So it really shouldn't matter.
It may give processes extra ways to 'shoot themselves in the foot'
but surely that is their problem.

Certainly, on x86, a 64bit process can make all three different
types of system call.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


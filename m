Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D643B0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhJZLIr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 07:08:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32028 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235408AbhJZLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:08:38 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-Oxs7BlRtPqSKlsdjAPt0vw-1; Tue, 26 Oct 2021 12:06:12 +0100
X-MC-Unique: Oxs7BlRtPqSKlsdjAPt0vw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Tue, 26 Oct 2021 12:06:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Tue, 26 Oct 2021 12:06:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Topic: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Index: AQHXylVlgIVfu8vswkCI9TVLTUwuCavlHODQ
Date:   Tue, 26 Oct 2021 11:06:11 +0000
Message-ID: <7d807624275a4938871f8e433e510e3c@AcuMS.aculab.com>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
 <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
 <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
 <20211026103655.GB30152@C02TD0UTHF1T.local>
In-Reply-To: <20211026103655.GB30152@C02TD0UTHF1T.local>
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

From: Mark Rutland
> Sent: 26 October 2021 11:37
...
> My preference overall is to keep the trampoline self-contained, and I'd
> prefer to keep the RET inline in the trampoline rather than trying to
> factor it out so that all the control-flow is clearly in one place.
> 
> So I'd prefer that we have the sequence as-is:
> 
> | 0:	.quad 0x0
> | 	bti	c
> | 	< insn >
> | 	ldr	x16, 0b
> | 	cbz	x16, 1f
> | 	br	x16
> | 1:	ret

What is wrong with:
0:	.quad 1f
	bti	c
	< insn >
	ldr	x16, 0b
	br	x16
1:	bti	c
	ret

Self-contained and reasonably easy to read.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


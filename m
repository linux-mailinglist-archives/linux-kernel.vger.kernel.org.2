Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C34183C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhIYRsD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Sep 2021 13:48:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:26270 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhIYRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:48:02 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-156-ewJMD0BWPVa3vtUVviHdjQ-1; Sat, 25 Sep 2021 18:46:24 +0100
X-MC-Unique: ewJMD0BWPVa3vtUVviHdjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 25 Sep 2021 18:46:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 25 Sep 2021 18:46:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: RE: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Topic: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Index: AQHXrwWrezksd71Yok+e/XO37WsWo6u1CydQ
Date:   Sat, 25 Sep 2021 17:46:23 +0000
Message-ID: <944ef479f1104c4a97d0e3f629a9b765@AcuMS.aculab.com>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
 <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
 <20210921153352.GC35846@C02TD0UTHF1T.local>
 <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
 <20210921162804.GD35846@C02TD0UTHF1T.local>
In-Reply-To: <20210921162804.GD35846@C02TD0UTHF1T.local>
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
> Sent: 21 September 2021 17:28
> 
> On Tue, Sep 21, 2021 at 05:55:11PM +0200, Ard Biesheuvel wrote:
> > On Tue, 21 Sept 2021 at 17:33, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
> > ...
...
> > >
> > > I think so, yes. We can do sligntly better with an inline literal pool
> > > and a PC-relative LDR to fold the ADRP+LDR, e.g.
> > >
> > >         .align 3
> > > tramp:
> > >         BTI     C
> > >         {B <func> | RET | NOP}
> > >         LDR     X16, 1f
> > >         BR      X16
> > > 1:      .quad   <literal>
> > >
> > > Since that's in the .text, it's RO for regular accesses anyway.
> > >
> >
> > I tried to keep the literal in .rodata to avoid inadvertent gadgets
> > and/or anticipate exec-only mappings of .text, but that may be a bit
> > overzealous.
> 
> I think that in practice the risk of gadgetisation is minimal, and
> having it inline means we only need to record a single address per
> trampoline, so there's less risk that we get the patching wrong.

But doesn't that mean that it is almost certainly a data cache miss?
You really want an instruction that reads the constant from the I-cache.
Or at least be able to 'bunch together' the constants so they
stand a chance of sharing a D-cache line.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


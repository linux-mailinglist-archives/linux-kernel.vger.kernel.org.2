Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5F43F9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2Jf5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Oct 2021 05:35:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:38619 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhJ2Jfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:35:55 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-gvdEMqvHMk-PYV3PyIWZ-Q-1; Fri, 29 Oct 2021 10:33:25 +0100
X-MC-Unique: gvdEMqvHMk-PYV3PyIWZ-Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Fri, 29 Oct 2021 10:33:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Fri, 29 Oct 2021 10:33:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
Subject: RE: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Thread-Topic: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Thread-Index: AQHXy/FMvPPgdVpuSEu91k2NumunhqvpsYaQ
Date:   Fri, 29 Oct 2021 09:33:24 +0000
Message-ID: <6215f764fffc41c39c74a871124aa4ed@AcuMS.aculab.com>
References: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
In-Reply-To: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
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
> Sent: 28 October 2021 12:44
> 
> This little patch makes use of an upcomming GCC feature to mitigate
> straight-line-speculation for x86:
...

This all generates the instruction sequence:
	ret
	int3
because there are (apparently) times when the cpu will speculatively
execute the instruction following a 'ret'.

I suspect this is likely to have a small performance impact
on at least some cpu that has not been mentioned by anyone.
As well as the slight increase in code size I can think of
two more problems.

1) The cpu may not be able to quickly 'abort' the speculative
   execution of the 'int3' instruction.
   Since the is a slow instruction (not as slow as 'tan'!)
   this might add quite a few clocks.
   ISTR there have always been warnings about the problem
   of speculative execution of trig functions - eg if non-code
   follows a 'ret'.

2) int3 is almost certainly slow to decode.
   Plausibly this might block the decoders from decoding
   from the branch/return target.
   Although I suspect the I-cache fetch will take longer
   unless the decode time is really horrid.
   The tables I have don't give execution times for int3.

While slightly longer, it may be that 'jmp .' is actually
a better instruction than 'int3'.
Since it will block speculative execution while still
being fast to decode and (not) execute.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


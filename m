Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875E439879
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhJYO2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Oct 2021 10:28:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42929 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233522AbhJYO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:28:18 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-NSW77ASPPcCfQF4garZMjA-1; Mon, 25 Oct 2021 15:25:54 +0100
X-MC-Unique: NSW77ASPPcCfQF4garZMjA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Mon, 25 Oct 2021 15:25:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Mon, 25 Oct 2021 15:25:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Frederic Weisbecker' <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Topic: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Index: AQHXyZrPgIVfu8vswkCI9TVLTUwuCavjxAog
Date:   Mon, 25 Oct 2021 14:25:53 +0000
Message-ID: <1b19fbeccf3d4a75a5ed3a507d29f7dd@AcuMS.aculab.com>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
In-Reply-To: <20211025122102.46089-3-frederic@kernel.org>
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

From: Frederic Weisbecker
> Sent: 25 October 2021 13:21
> 
> Implement arm64 support for the 'unoptimized' static call variety, which
> routes all calls through a single trampoline that is patched to perform a
> tail call to the selected function.
> 
> It is expected that the direct branch instruction will be able to cover
> the common case. However, given that static call targets may be located
> in modules loaded out of direct branching range, we need a fallback path
> that loads the address into R16 and uses a branch-to-register (BR)
> instruction to perform an indirect call.
> 
...
> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	/*
> +	 * -0x8	<literal>
> +	 *  0x0	bti c		<--- trampoline entry point
> +	 *  0x4	<branch or nop>
> +	 *  0x8	ldr x16, <literal>
> +	 *  0xc	cbz x16, 20
> +	 * 0x10	br x16
> +	 * 0x14	ret
> +	 */

Since the 'ldr x16, <literal>' is just a 32bit constant
(for a pc-relative load).

Can't you save a word by making offset 0x4 <branch or ldr x16, <literal>> ?

Or am I missing something?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


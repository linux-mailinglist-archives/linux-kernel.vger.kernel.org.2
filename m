Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52133C26A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhCOQp4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 12:45:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:55275 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233137AbhCOQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:45:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-109-yclGcDiMOFSHt-lp5eeiPA-1; Mon, 15 Mar 2021 16:45:31 +0000
X-MC-Unique: yclGcDiMOFSHt-lp5eeiPA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 16:45:30 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 15 Mar 2021 16:45:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] x86/alternatives: Optimize optimize_nops()
Thread-Topic: [RFC][PATCH] x86/alternatives: Optimize optimize_nops()
Thread-Index: AQHXGbJnWkdUrRVzokWSeuH0ep/II6qFQPVA
Date:   Mon, 15 Mar 2021 16:45:30 +0000
Message-ID: <90126210af5441c1830b1325ef996e77@AcuMS.aculab.com>
References: <YE+BFIil8wj+q8Qi@hirez.programming.kicks-ass.net>
In-Reply-To: <YE+BFIil8wj+q8Qi@hirez.programming.kicks-ass.net>
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
> Sent: 15 March 2021 15:45
> 
> Currently optimize_nops() scans to see if the alternative starts with
> NOPs. However, the emit pattern is:
> 
>   141:	\oldinstr
>   142:	.skip (len-(142b-141b)), 0x90
> 
> That is, when oldinstr is short, we pad the tail with NOPs. This case
> never gets optimized.
> 
> Rewrite optimize_nops() to replace any string of NOPs inside the
> alternative to larger NOPs. Also run it irrespective of patching,
> replacing NOPs in both the original and replaced code.

This should even speed up old 64bit cpu.
Although the nopl instruction has to go through the 'big decoder'
(so only one per clock) it is much bigger than the 0x90 'nop'
instructions currently used.
So although (probably) 3 'nop' can be decoded each clock
that is less bytes of padding per clock.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


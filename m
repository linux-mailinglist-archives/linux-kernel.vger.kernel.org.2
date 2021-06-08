Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83C39F4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFHLOL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Jun 2021 07:14:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:22189 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhFHLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:14:10 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-30-guQiPO4kPrqaSB27Et2hIQ-1; Tue, 08 Jun 2021 12:12:14 +0100
X-MC-Unique: guQiPO4kPrqaSB27Et2hIQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 12:12:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 12:12:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Ricardo Ribalda <ribalda@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: RE: [PATCH] tools/perf: Do not set a variable unless it will be used
Thread-Topic: [PATCH] tools/perf: Do not set a variable unless it will be used
Thread-Index: AQHXWSUW63LkalkO1EC8vlerZJxmp6sJ+mDw
Date:   Tue, 8 Jun 2021 11:12:13 +0000
Message-ID: <369424fbd25444d39352d3ee0f24a89d@AcuMS.aculab.com>
References: <20210604092638.985694-1-ribalda@chromium.org>
 <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
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
> Sent: 04 June 2021 10:36
> 
> On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > clang-13 triggers the following warning:
> >
> > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-
> variable]
> >         u64 len = 0;
> >
> > This patch sets the value to len only if it will be used afterwards.
> 
> My vote would be to kill that warning, what absolute shite.

The compiler folk need their heads examining.

On one hand they are adding code to initialise everything
to avoid leaking information, and on the other they moan
when you do defensive coding.

There might be a justification for:
	foo = complex_expression;
where, maybe, you might have assigned it to the wrong variable.
But for simple constants (especially on declarations)
it is really silly.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


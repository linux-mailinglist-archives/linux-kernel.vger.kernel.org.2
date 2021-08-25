Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98533F7138
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhHYIn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 04:43:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25166 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhHYIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:43:26 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-211-acg3lIP0NjC_OiehBTtT1g-1; Wed, 25 Aug 2021 09:42:37 +0100
X-MC-Unique: acg3lIP0NjC_OiehBTtT1g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 25 Aug 2021 09:42:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 25 Aug 2021 09:42:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non
 volatile regs
Thread-Topic: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non
 volatile regs
Thread-Index: AQHXmPzihkMZIJQywUykgaGdDaInuauD5vuA
Date:   Wed, 25 Aug 2021 08:42:35 +0000
Message-ID: <7afe86ab2d934aa694a0461b1abbd2ce@AcuMS.aculab.com>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
 <20210823184648.GY1583@gate.crashing.org>
 <9bbc9797-cfc7-1484-90ad-2146ff1a5e18@csgroup.eu>
 <20210824131600.GF1583@gate.crashing.org>
 <20210824152813.GG1583@gate.crashing.org>
In-Reply-To: <20210824152813.GG1583@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 24 August 2021 16:28

> 
> On Tue, Aug 24, 2021 at 08:16:00AM -0500, Segher Boessenkool wrote:
> > On Tue, Aug 24, 2021 at 07:54:22AM +0200, Christophe Leroy wrote:
> > > >On mpccore both lmw and stmw are only N+1 btw.  But the serialization
> > > >might cost another cycle here?
> > >
> > > That coherent on MPC8xx, that's only 2 cycles.
> > > But on the mpc832x which has a e300c2 core, it looks like I have 10 cycles
> > > difference. Is anything wrong ?
> >
> > I don't know that core very well, I'll have a look.
> 
> So, I don't see any difference between e300c2 and e300c1 (which is 603
> basically, for this) that is significant here.  The e300c2 has two
> integer units instead of just one, but it still has only one load/store
> unit, and I don't see anything else that could matter either.  Huh.

Is the cpu as brain-damaged as the (old) strongarm (SA1100 etc)
where ldm/stm always took 1 clock to check each register bit
regardless of the number of registers to copy?
(IIRC it also took the same length of time when conditionally not
executed.)

If x86 had ever had ldm/stm then it would end up being a microcoded
instruction and take forever to decode.
Intel never managed to optimise 'loop' (dec %cx and jump nz).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


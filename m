Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD93F229D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhHSV6o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 17:58:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:37977 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235771AbhHSV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:58:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-K8o7LF4xO6exf4bKEugwaw-1; Thu, 19 Aug 2021 22:58:04 +0100
X-MC-Unique: K8o7LF4xO6exf4bKEugwaw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 19 Aug 2021 22:58:03 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 19 Aug 2021 22:58:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        "torvic9@mailbox.org" <torvic9@mailbox.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>
Subject: RE: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Thread-Topic: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Thread-Index: AQHXlAD0agS+R5TrUku3Pq8hTf8Ltqt7Yd3A
Date:   Thu, 19 Aug 2021 21:58:03 +0000
Message-ID: <b09a7be32cef407cb6b6361554411bda@AcuMS.aculab.com>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRyzhWJrqcRZkYRM@infradead.org>
In-Reply-To: <YRyzhWJrqcRZkYRM@infradead.org>
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

From: Christoph Hellwig
> Sent: 18 August 2021 08:15
> 
> On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
> > +	  Generic x86-64 CPU.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> 
> > +	help
> > +	  Generic x86-64-v3 CPU with v3 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> > +
> 
> > +	help
> > +	  Generic x86-64 CPU with v4 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> 
> How the f&%$% is a user supposed to know what these garbage descriptions
> are supposed to mean?

My thoughts.
I then looked up the link.
Most of the extra instructions are the AVX related ones.
They better not get enabled for a kernel build at all.

I wish I knew whether 'no-avx' actually implied 'no-avx2' and
all later avx options?
Or do kernel builds have to spot each new option and disable
in in turn?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A747D455089
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbhKQWeg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Nov 2021 17:34:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29270 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241328AbhKQWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:28 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-_Tp0z3ELP4CvBamUzus0mQ-1; Wed, 17 Nov 2021 22:31:22 +0000
X-MC-Unique: _Tp0z3ELP4CvBamUzus0mQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 17 Nov 2021 22:31:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 17 Nov 2021 22:31:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in
 memmove_64.S
Thread-Topic: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in
 memmove_64.S
Thread-Index: AQHX2/aBIpegHmlt3EiJPKc4pU+GYawITRxw
Date:   Wed, 17 Nov 2021 22:31:21 +0000
Message-ID: <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com>
In-Reply-To: <20211117210245.843374-1-goldstein.w.n@gmail.com>
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

From: Noah Goldstein
> Sent: 17 November 2021 21:03
> 
> Add check for "short distance movsb" for forwards FSRM usage and
> entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> modes" that are an order of magnitude slower than usual.
> 
> 'rep movsb' has some noticeable VERY slow modes that the current
> implementation is either 1) not checking for or 2) intentionally
> using.

How does this relate to the decision that glibc made a few years
ago to use backwards 'rep movs' for non-overlapping copies?

Did they find a different corner case??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


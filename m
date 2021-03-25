Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F934963F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYQAN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Mar 2021 12:00:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:31746 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229592AbhCYQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:00:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-54-d-BEr4zCNlCTYsjGhGGrMA-1; Thu, 25 Mar 2021 16:00:04 +0000
X-MC-Unique: d-BEr4zCNlCTYsjGhGGrMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 25 Mar 2021 15:59:56 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 25 Mar 2021 15:59:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH v2 0/4] vmalloc: Improve vmalloc(4MB) performance
Thread-Topic: [PATCH v2 0/4] vmalloc: Improve vmalloc(4MB) performance
Thread-Index: AQHXIL93smWggbtuakOz/LFGaMnBoqqU3Ndw
Date:   Thu, 25 Mar 2021 15:59:56 +0000
Message-ID: <38da93959bc948c992fc7fc1efd4d25c@AcuMS.aculab.com>
References: <20210324150518.2734402-1-willy@infradead.org>
In-Reply-To: <20210324150518.2734402-1-willy@infradead.org>
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

From: Matthew Wilcox
> Sent: 24 March 2021 15:05
> 
> I may have gone a little too far with the first patch.  It turns out we
> have a lot of code using the vmalloc caller functionality, and I decided
> to convert it all to unsigned long instead of leaving some paths as void *
> and casting later.

What is the 'address of the caller' needed for?
If it gets printed anywhere it ought to be a pointer type
throughout so that it will get hashed and not leak the
real address.

Even then it is probably better to use a typed pointer
(eg to an undefined structure) than 'void *'.
That might also pick up more incorrect uses.

Of course things like _RET_IP_ would need changing to return
the same pointer type.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


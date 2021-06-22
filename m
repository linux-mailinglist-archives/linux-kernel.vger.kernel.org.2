Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBA3B0018
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhFVJXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Jun 2021 05:23:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35327 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhFVJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:23:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-r6XmkbAiMNK5YbqqXuWvZw-1; Tue, 22 Jun 2021 10:20:48 +0100
X-MC-Unique: r6XmkbAiMNK5YbqqXuWvZw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 10:20:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 10:20:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'gumingtao' <gumingtao1225@gmail.com>,
        "cl@linux.com" <cl@linux.com>
CC:     "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        gumingtao <gumingtao@xiaomi.com>
Subject: RE: [PATCH v2] slab: Use %s instead of function name
Thread-Topic: [PATCH v2] slab: Use %s instead of function name
Thread-Index: AQHXZkbiYct5qvuec0akJnkI2adQvKsfwtqw
Date:   Tue, 22 Jun 2021 09:20:47 +0000
Message-ID: <69d13da56fd04cfe81e9754c6982a825@AcuMS.aculab.com>
References: <cover.1624240708.git.gumingtao@xiaomi.com>
 <e73123325fa47200f7b94ce36a0152fb774c0538.1624240708.git.gumingtao@xiaomi.com>
In-Reply-To: <e73123325fa47200f7b94ce36a0152fb774c0538.1624240708.git.gumingtao@xiaomi.com>
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

From: gumingtao
> Sent: 21 June 2021 03:41
> 
> It is better to replace the function name with %s.

Should this (and the subject) be:

Use __func__ to trace function names.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


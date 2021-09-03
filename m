Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80793FFBF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348248AbhICI2h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Sep 2021 04:28:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28368 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348197AbhICI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:28:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-3d9V2QZ9O8Co0U925nMRmA-1; Fri, 03 Sep 2021 09:27:26 +0100
X-MC-Unique: 3d9V2QZ9O8Co0U925nMRmA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 3 Sep 2021 09:27:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 3 Sep 2021 09:27:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Johannes Berg' <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: RE: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
Thread-Topic: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
Thread-Index: AQHXn9SPoN4pW3t210qkf8kng5akKquR+fUg
Date:   Fri, 3 Sep 2021 08:27:24 +0000
Message-ID: <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
References: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
In-Reply-To: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
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

From: Johannes Berg
> Sent: 02 September 2021 09:28
> 
> The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
> both "real" x86 architecture builds and ARCH=um today.
> However, clearly most people and places in the code are
> treating it as the architecture Kconfig (technically
> that's just CONFIG_X86) and use it to indicate that the
> architecture is X86 in 32- or 64-bit flavour.
> 
> This has caused a fair amount of issues in the past,
> for example drivers not building because use x86 macros
> or similar under CONFIG_X86_{32,64} ifdef, and then we
> find build reports and add "!UML" to their Kconfig etc.
> 
> However, this is error-prone and a kind of whack-a-mole
> game, even with the build bots reporting things.

I suspect you've just changed the 'mole'.

You've now got lots of lines like:

#if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)

Missing off the UML define is going to cause the 32bit code
to get compiled by mistake - which is likely to be more
confusing that the places where you need to do special 'stuff'
for UML.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


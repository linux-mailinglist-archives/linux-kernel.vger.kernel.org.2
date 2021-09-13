Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7730D409848
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbhIMQE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Sep 2021 12:04:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:43962 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346501AbhIMQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:04:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-270-naWZEAVdMh-RMZ74W2aCvQ-1; Mon, 13 Sep 2021 17:03:12 +0100
X-MC-Unique: naWZEAVdMh-RMZ74W2aCvQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 13 Sep 2021 17:03:09 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 13 Sep 2021 17:03:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, Douglas Gilbert <dgilbert@interlog.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: how many memset(,0,) calls in kernel ?
Thread-Topic: how many memset(,0,) calls in kernel ?
Thread-Index: AQHXp5KEgy5ggGKXu0iAcdzvqjgoc6uiIXMA
Date:   Mon, 13 Sep 2021 16:03:09 +0000
Message-ID: <88976a40175c491fb5e3349f6686ad67@AcuMS.aculab.com>
References: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
 <20210912045608.GB16216@1wt.eu>
In-Reply-To: <20210912045608.GB16216@1wt.eu>
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

>   36:   b9 06 00 00 00          mov    $0x6,%ecx
>   3b:   4c 89 e7                mov    %r12,%rdi
>   3e:   f3 ab                   rep stos %eax,%es:(%rdi)
> 
> The last line does exactly "memset(%rdi, %eax, %ecx)". Just two bytes
> for some code that modern processors are even able to optimize.

Hmmm I'd bet that 6 stores will be faster on ~everything.
'modern' processors do better than some older ones [1], but 6
writes isn't enough to get into the really fast paths.
So you'll still take a few cycles of setup.

[1] P4 netburst had a ~40 clock setup for any 'rep' operation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


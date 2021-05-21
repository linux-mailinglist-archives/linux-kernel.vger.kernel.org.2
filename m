Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0870338C73D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhEUM5p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 May 2021 08:57:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56575 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhEUM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:57:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-LgHmD7NGNGu8CptD9BGd7A-1; Fri, 21 May 2021 13:55:32 +0100
X-MC-Unique: LgHmD7NGNGu8CptD9BGd7A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 21 May 2021 13:55:30 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Fri, 21 May 2021 13:55:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Austin Kim' <austindh.kim@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tj@kernel.org" <tj@kernel.org>, "neilb@suse.de" <neilb@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "austin.kim@lge.com" <austin.kim@lge.com>
Subject: RE: [PATCH] kernfs: move return value check after kmalloc()
Thread-Topic: [PATCH] kernfs: move return value check after kmalloc()
Thread-Index: AQHXTezGW1ASuOoVY06iiixFMRipz6rt467w
Date:   Fri, 21 May 2021 12:55:30 +0000
Message-ID: <b698a7530ce747d180e93967572d3d88@AcuMS.aculab.com>
References: <20210521025525.GA1379@raspberrypi>
In-Reply-To: <20210521025525.GA1379@raspberrypi>
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

From: Austin Kim
> Sent: 21 May 2021 03:55
> 
> With 414985ae23c0 ("sysfs, kernfs: move file core code to fs/kernfs/file.c"),
> 'return -ENOMEM' is executed when kmalloc() returns NULL.
> 
> Since 'commit 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc
> files use the buffer.")', 'return -ENOMEM' statement is not properly located.

Much more interesting is that the read is bounded to PAGE_SIZE
but the buffer is of->atomic_write_len bytes long.

Seems far too easy for the read() function to overwrite the buffer.
Either that, or you can have files longer than PAGE_SIZE that you
can write but not read all of!

There is also the question of whether the atomic operations
needed lock and unlock the preallocated buffer are actually
slower than kmalloc removing a buffer from a cpu-local list.

And, of course, kmalloc(PAGE_SIZE + 1, ) is horrid...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


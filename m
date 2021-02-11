Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA8318C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhBKNpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 08:45:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27724 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhBKNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:30:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-13-swhvU-StNEyBgOa2ePf8zg-1; Thu, 11 Feb 2021 13:28:43 +0000
X-MC-Unique: swhvU-StNEyBgOa2ePf8zg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 11 Feb 2021 13:28:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 11 Feb 2021 13:28:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v4] staging: gdm724x: Fix DMA from stack
Thread-Topic: [PATCH v4] staging: gdm724x: Fix DMA from stack
Thread-Index: AQHXADh2uOSDdqHkV0CFTPfMMb6Y/6pS8lIg
Date:   Thu, 11 Feb 2021 13:28:41 +0000
Message-ID: <500e7317567548b48604ed9972062da2@AcuMS.aculab.com>
References: <20210211053819.34858-1-ameynarkhede03@gmail.com>
In-Reply-To: <20210211053819.34858-1-ameynarkhede03@gmail.com>
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

> Stack allocated buffers cannot be used for DMA
> on all architectures so allocate hci_packet buffer
> using kmalloc.

I wonder if the usb stack ought/could support a short bounce
buffer within the memory is already has to allocate?

For hci and lengths less than 8 the immediate data can be
placed directly in the ring structure replacing the data
pointer itself.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


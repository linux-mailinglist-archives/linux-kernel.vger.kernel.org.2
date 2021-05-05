Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E53738D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEEKu5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 May 2021 06:50:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:22287 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhEEKuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:50:55 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-KOeRTqsfPFCBXFwKiQHgGw-1; Wed, 05 May 2021 11:49:56 +0100
X-MC-Unique: KOeRTqsfPFCBXFwKiQHgGw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 11:49:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 11:49:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stefan Kanthak' <kanthak@arcor.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vsscanf() in lib/vsprintf.c
Thread-Topic: [PATCH] vsscanf() in lib/vsprintf.c
Thread-Index: AQHXQRwAOtVxxBSk3E+t7e+RYJucb6rUtkYg
Date:   Wed, 5 May 2021 10:49:55 +0000
Message-ID: <0be89b55a4064ef88d6b8ae73fd9ee01@AcuMS.aculab.com>
References: <6C7CD73845304CDE98F6DB165904B571@H270>
In-Reply-To: <6C7CD73845304CDE98F6DB165904B571@H270>
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

It is so stupendously hard to use scanf() safely
the best thing is probably to just delete it :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


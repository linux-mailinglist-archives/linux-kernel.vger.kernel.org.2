Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9113F2A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhHTK0z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Aug 2021 06:26:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45591 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237319AbhHTK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:26:54 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-209-2-6vmu0eMHOQf-5S9nljzg-1; Fri, 20 Aug 2021 11:26:14 +0100
X-MC-Unique: 2-6vmu0eMHOQf-5S9nljzg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 11:26:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 20 Aug 2021 11:26:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aakash Hemadri' <aakashhemadri123@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH] staging: r8188eu: clean up endianness issues
Thread-Topic: [PATCH] staging: r8188eu: clean up endianness issues
Thread-Index: AQHXlEkXQkbL0ATyNUWA80Flf1ESnat8MnfA
Date:   Fri, 20 Aug 2021 10:26:13 +0000
Message-ID: <3dfde3cd06094e52b71b48a3a2524226@AcuMS.aculab.com>
References: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
In-Reply-To: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
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

From: Aakash Hemadri
> Sent: 18 August 2021 16:53
> 
> Fix these sparse warnings:

Did you test this code before and after the changes?

I think you've changed the behaviour on LE systems which
are probably the ones it was actually tested on.

Don't blindly change code to fix sparse warnings.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


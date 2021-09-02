Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4D3FEF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbhIBOGK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Sep 2021 10:06:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27180 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345370AbhIBOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:04:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-90-tzR3TaFjMtSaC8iSrW3zwg-1; Thu, 02 Sep 2021 15:03:18 +0100
X-MC-Unique: tzR3TaFjMtSaC8iSrW3zwg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 15:03:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 2 Sep 2021 15:03:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] fs/ntfs3: Use kmalloc_array over kmalloc with
 multiply
Thread-Topic: [PATCH 1/5] fs/ntfs3: Use kmalloc_array over kmalloc with
 multiply
Thread-Index: AQHXntrPdHiUovXUwEmoBRmrkk5W9KuQyAlw
Date:   Thu, 2 Sep 2021 14:03:17 +0000
Message-ID: <6c078835254b43ec82bf45db3b241510@AcuMS.aculab.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
         <20210831181505.1074767-2-kari.argillander@gmail.com>
 <5197939870d1867dd2131a8fdff8842b777c6016.camel@perches.com>
In-Reply-To: <5197939870d1867dd2131a8fdff8842b777c6016.camel@perches.com>
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

From: Joe Perches
> Sent: 01 September 2021 03:41
> 
> On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> > If we do not use kmalloc_array we get checkpatch warning. It is also
> > little safer if something goes wrong with coding.
> []
> > diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> []
> > @@ -707,7 +707,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
> >  		u16 *ptr;
> >  		int new_slots = ALIGN(2 * nslots, 8);
> >
> >
> > -		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);
> > +		ptr = kmalloc_array(new_slots, sizeof(u16), GFP_NOFS);
> >  		if (ptr)
> >  			memcpy(ptr, offs, sizeof(u16) * max_idx);
> 
> This multiplication could also overflow.

Not if kmalloc_array() has suceeded.
OTOH the ALIGN(2 * nslots, 8) can also go wrong.
(But probably not if the previous kmalloc() for 1/2 the size worked.)

But there really ought to be some kind of bound check earlier.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


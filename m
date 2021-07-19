Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2C3CDEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbhGSPEy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 11:04:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:52391 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237683AbhGSOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:44:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-178-iMvtmtATPRWN2iDCvXdP_A-1; Mon, 19 Jul 2021 16:24:39 +0100
X-MC-Unique: iMvtmtATPRWN2iDCvXdP_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 19 Jul 2021 16:24:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 19 Jul 2021 16:24:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Len Baker <len.baker@gmx.com>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Thread-Topic: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Thread-Index: AQHXfGBOiwzYJ/Wx2kuQ1xZyGR2EOqtKavEA
Date:   Mon, 19 Jul 2021 15:24:38 +0000
Message-ID: <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
References: <20210717155145.15041-1-len.baker@gmx.com>
 <20210719053747.GN1931@kadam>
In-Reply-To: <20210719053747.GN1931@kadam>
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

From: Dan Carpenter
> Sent: 19 July 2021 06:38
...
> Not related to your patch but this code is bad.  What it does is the
> "ifname" can be set as a module parameter.  So instead of testing if it
> has been set, it uses the checking inside dev_alloc_name() to see if we
> can allocate what the user requested.  If not then set it to "wlan%d".
> If we cannot allocate what the user wants then we should return an
> error.
> 
> It should do:
> 
> 	if (ifname[0] == '\0')
> 		strscpy(ifname, "wlan%d", sizeof(ifname));
> 
> 	ret = dev_alloc_name(pnetdev, ifname);
> 	if (ret < 0) {
> 		dev_err(pnetdev, "allocating device name failed.\n");
> 		return NULL;
> 	}

I know only root can set module parameters, but having one
that contains a string used as a printf format seems
dangerous at best.

Isn't it best to let userspace rename the interfaces later on?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


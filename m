Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD23F72DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhHYKWW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 06:22:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:56258 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237516AbhHYKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:22:17 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-2GvGDmlwPsiQ0AnOLMju9A-1; Wed, 25 Aug 2021 11:21:25 +0100
X-MC-Unique: 2GvGDmlwPsiQ0AnOLMju9A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 25 Aug 2021 11:21:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 25 Aug 2021 11:21:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>
CC:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Thread-Topic: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Thread-Index: AQHXmCqSnSVpiVCtaEyxz8Go65B0FauD8RPg///yZ4CAACGg0A==
Date:   Wed, 25 Aug 2021 10:21:23 +0000
Message-ID: <c5cfa7262fca44abb08f1ec5881fac4c@AcuMS.aculab.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
 <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
 <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
 <ba4668725f944d12843529f0b0d4a8a2@AcuMS.aculab.com>
 <20210825091921.GR1931@kadam>
In-Reply-To: <20210825091921.GR1931@kadam>
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
> Sent: 25 August 2021 10:19
> 
> On Wed, Aug 25, 2021 at 09:13:44AM +0000, David Laight wrote:
> > From: Larry Finger
> > > Sent: 23 August 2021 15:24
> > >
> > > On 8/23/21 3:44 AM, Aakash Hemadri wrote:
> > > > On 21/08/21 09:48PM, Aakash Hemadri wrote:
> > > >> Fix sparse warning:
> > > >>> rtw_br_ext.c:836:54: warning: cast to restricted __be32
> > > >>
> > > >> dhpch->cookie is be32, change it's type.
> > ...
> > > >> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c
> b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > >> index f6d1f6029ec3..f65d94bfa286 100644
> > > >> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > >> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > ...
> > > >> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
> > > >>   				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> > > >>   					struct dhcpMessage *dhcph =
> > > >>   						(struct dhcpMessage *)((size_t)udph + sizeof(struct
> udphdr));
> >
> > This assignment looks dubious at best - WTF is (size_t) for?
> > I don't seem to have a source tree with this driver in it (probably only in 'next'?).
> > I suspect it should be:
> > 	struct dhcp_message *dhcph = (void *)(udph + 1);
> 
> Those are equivalent.  Either way works.

size_t isn't guaranteed to be large enough to hold a pointer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


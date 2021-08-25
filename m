Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB83F71A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhHYJYU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 05:24:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56879 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239681AbhHYJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:24:17 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-121-slYRAeD_NeiPOZBTIJBABQ-1; Wed, 25 Aug 2021 10:23:30 +0100
X-MC-Unique: slYRAeD_NeiPOZBTIJBABQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 25 Aug 2021 10:23:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 25 Aug 2021 10:23:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aakash Hemadri' <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Thread-Topic: [PATCH v4 3/5] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Thread-Index: AQHXmEBzodgQnjGhvkqCA8EvgQbhz6uD8/vA
Date:   Wed, 25 Aug 2021 09:23:28 +0000
Message-ID: <f2ab21eab23c4863b1b5c004a75d834d@AcuMS.aculab.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
 <392082864befe91bb03d16ff7ca5e57ba2a8e549.1629563318.git.aakashhemadri123@gmail.com>
In-Reply-To: <392082864befe91bb03d16ff7ca5e57ba2a8e549.1629563318.git.aakashhemadri123@gmail.com>
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
> Sent: 23 August 2021 18:00
> 
> Fix sparse warning:
> > rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> > rtw_br_ext.c:773:110: warning: incorrect type in argument 2
>     (different base types)
> > rtw_br_ext.c:773:110:    expected int len
> > rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> 
> csum_ipv6_magic and csum_partial expect int len not __be16, use
> be16_to_cpu()

This is a behaviour change on LE systems.
Even if you are testing on BE the commit message should say
that it fixes the length passed to the checksum code and
was detected by sparse.

...
>  			hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
> -						iph->payload_len,
> +						be16_to_cpu(iph->payload_len),
>  						IPPROTO_ICMPV6,
> -						csum_partial((__u8 *)hdr, iph->payload_len, 0));
> +						csum_partial((__u8 *)hdr, be16_to_cpu(iph->payload_len), 0));

Oh - that code is indented far too many times.
I had to delete a load of tabs to stop my mail crapping it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31DA4354C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJTUsg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Oct 2021 16:48:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60961 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhJTUsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:48:33 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-115-nfpx-aVSOSaqIrh6sNXYUQ-1; Wed, 20 Oct 2021 21:46:13 +0100
X-MC-Unique: nfpx-aVSOSaqIrh6sNXYUQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 21:46:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 20 Oct 2021 21:46:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        Sebastian Luchetti <luchetti.linux@gmail.com>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: rts5208: ms.c: Remove two udelay calls and use
 usleep_range instead
Thread-Topic: [PATCH] staging: rts5208: ms.c: Remove two udelay calls and use
 usleep_range instead
Thread-Index: AQHXxCaBnEk8xGF8+EezDebeqGnpw6vcXlsg
Date:   Wed, 20 Oct 2021 20:46:11 +0000
Message-ID: <15e2c625c8004534a3394271d49a3ba6@AcuMS.aculab.com>
References: <YWwWoB3+4HQTD4/t@Mononoke> <YWwoCuBIBc/xTPIu@kroah.com>
In-Reply-To: <YWwoCuBIBc/xTPIu@kroah.com>
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

From: Greg KH
> Sent: 17 October 2021 14:42
> 
> On Sun, Oct 17, 2021 at 02:27:12PM +0200, Sebastian Luchetti wrote:
> > This patch fixes the issue:
> > CHECK: usleep_range is preferred over udelay; see
> > Documentation/timers/timers-howto.txt
> > in two occurrences.
> >
> > Signed-off-by: Sebastian Luchetti <luchetti.linux@gmail.com>
> > ---
> >  drivers/staging/rts5208/ms.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> > index 2a6fab5c117a..7292c8f013fd 100644
> > --- a/drivers/staging/rts5208/ms.c
> > +++ b/drivers/staging/rts5208/ms.c
> > @@ -3236,7 +3236,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
> >  			return STATUS_FAIL;
> >  		}
> >
> > -		udelay(30);
> > +		usleep_range(27, 32);
> 
> These are very odd choices of a number, where did they come from?
> 
> And as the other thread on this mailing list a few hours ago describes,
> for this same type of change, you need to test this with the actual
> hardware to know if this works properly or not.  Have you done so?

You also need to check that it is actually safe to sleep.
The style of the commit messages doesn't give massive
confidence that you have checked.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


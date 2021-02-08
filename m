Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0E312D93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBHJnF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 04:43:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55507 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231613AbhBHJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:30:31 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-186-5nZVffcuP9aUc65kc1ph8w-1; Mon, 08 Feb 2021 09:28:26 +0000
X-MC-Unique: 5nZVffcuP9aUc65kc1ph8w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Feb 2021 09:28:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Feb 2021 09:28:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Yejune Deng <yejune.deng@gmail.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yejune.deng@gmail.com" <yejune.deng@gmail.com>
Subject: RE: [PATCH] ntp: use memset and offsetof init
Thread-Topic: [PATCH] ntp: use memset and offsetof init
Thread-Index: AQHW+/XmZ/hgh4r3dkyEzm1InFXTWKpN/+Qg
Date:   Mon, 8 Feb 2021 09:28:25 +0000
Message-ID: <0e0242149d664d76a663fcad853904bf@AcuMS.aculab.com>
References: <20210120025114.16294-1-yejune.deng@gmail.com>
 <87k0rm8lmh.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0rm8lmh.fsf@nanos.tec.linutronix.de>
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

From: Thomas Gleixner
> Sent: 05 February 2021 17:34
> 
> On Wed, Jan 20 2021 at 10:51, Yejune Deng wrote:
> > In pps_fill_timex(), use memset and offsetof instead of '= 0'.
> >
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> > ---
> >  kernel/time/ntp.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> > index 87389b9e21ab..3416c0381104 100644
> > --- a/kernel/time/ntp.c
> > +++ b/kernel/time/ntp.c
> > @@ -225,14 +225,11 @@ static inline int is_error_status(int status)
> >  static inline void pps_fill_timex(struct __kernel_timex *txc)
> >  {
> >  	/* PPS is not implemented, so these are zero */
> > -	txc->ppsfreq	   = 0;
> > -	txc->jitter	   = 0;
> > -	txc->shift	   = 0;
> > -	txc->stabil	   = 0;
> > -	txc->jitcnt	   = 0;
> > -	txc->calcnt	   = 0;
> > -	txc->errcnt	   = 0;
> > -	txc->stbcnt	   = 0;
> > +	int offset, len;
> > +
> > +	offset = offsetof(struct __kernel_timex, ppsfreq);
> > +	len    = offsetof(struct __kernel_timex, tai) - offset;
> > +	memset(txc + offset, 0, len);
> 
> That zeros bytes at a memory location which is
> 
>      (offset) * sizeof(struct __kernel_timex)
> 
> bytes away from txc. How did this every boot?
> 
> And no, even if you fix that pointer math problem then this kind of
> calculation from the middle of a struct is error prone.

It is also, at best, a code size optimisation.
If memset() is actually called (not inlined) then you get a whole
lot of tests against the size and alignment before any writes
of zero happen - which will be the same ones as in the inline code.

It can be worth using memcpy to copy part of a structure
but usually for one with lots of small fields (especially bitfields).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


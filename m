Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD253151BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBIOei convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 09:34:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40625 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232077AbhBIOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:32:58 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-288-A_ICKLg_PmetPQrYbE_D-A-1; Tue, 09 Feb 2021 14:31:16 +0000
X-MC-Unique: A_ICKLg_PmetPQrYbE_D-A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 9 Feb 2021 14:31:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 9 Feb 2021 14:31:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
Thread-Topic: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
Thread-Index: AQHW/uu6M1m95GjSlEGhmhkEL2m4wKpP4cNQ
Date:   Tue, 9 Feb 2021 14:31:16 +0000
Message-ID: <d35cc46eca474b2c9f94a4de269321e7@AcuMS.aculab.com>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
 <1612838134.rvncv9kzls.astroid@bobo.none>
 <20210209135053.GD27854@gate.crashing.org>
In-Reply-To: <20210209135053.GD27854@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 09 February 2021 13:51
> 
> On Tue, Feb 09, 2021 at 12:36:20PM +1000, Nicholas Piggin wrote:
> > What if you did this?
> 
> > +static inline struct task_struct *get_current(void)
> > +{
> > +	register struct task_struct *task asm ("r2");
> > +
> > +	return task;
> > +}
> 
> Local register asm variables are *only* guaranteed to live in that
> register as operands to an asm.  See
>   https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables
> ("The only supported use" etc.)
> 
> You can do something like
> 
> static inline struct task_struct *get_current(void)
> {
> 	register struct task_struct *task asm ("r2");
> 
> 	asm("" : "+r"(task));
> 
> 	return task;
> }
> 
> which makes sure that "task" actually is in r2 at the point of that asm.

If "r2" always contains current (and is never assigned by the compiler)
why not use a global register variable for it?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


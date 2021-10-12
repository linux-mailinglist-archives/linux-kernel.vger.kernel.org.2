Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D142AEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhJLVXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Oct 2021 17:23:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39890 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232418AbhJLVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:23:15 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-16-WXo4MLwIMSmkOaZgZkYLag-1; Tue, 12 Oct 2021 22:21:11 +0100
X-MC-Unique: WXo4MLwIMSmkOaZgZkYLag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 12 Oct 2021 22:21:09 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 12 Oct 2021 22:21:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Thread-Topic: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Thread-Index: AQHXv0iGTncX5QIgaEymHCfZB5yMpqvP3eCA
Date:   Tue, 12 Oct 2021 21:21:09 +0000
Message-ID: <40f6f29f26f14b5b88076f5b12e1ecaa@AcuMS.aculab.com>
References: <20211012052822.GA28951@1wt.eu>
 <20211012083644.543775-1-ammarfaizi2@gmail.com>
 <20211012090638.GD28951@1wt.eu>
In-Reply-To: <20211012090638.GD28951@1wt.eu>
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

From: Willy Tarreau
> Sent: 12 October 2021 10:07
> 
> On Tue, Oct 12, 2021 at 03:36:44PM +0700, Ammar Faizi wrote:
> > I have tried to search for the documentation about this one, but I
> > couldn't find any. Checking at `Documentation/x86/entry_64.rst`, but
> > it doesn't tell anything relevant.
> (...)
> 
> OK thanks for the detailed story, thus I didn't miss any obvious
> reference.
> 
> > My stance comes from SO, Telegram group discussion, and reading source
> > code. Therefore, I don't think I can attach the link to it as
> > "authoritative information". Or can I?
> 
> You're right, that's not exactly what we can call authoritative :-)

Given the cost of a system call the code benefit from telling
gcc that r8 to r10 are preserved is likely to be noise.
Especially since most syscalls are made from C library stubs
so the application calling code will assume they are trashed.

There may even be a bigger gain from the syscall exit code just
setting the registers to zero (instead of restoring them).

There are probably even bigger gains from zeroing the AVX
registers (which, IIRC, are all caller-saved) somewhere
between syscall entry and the process sleeping.
(This can't be done for non-syscall kernel entry.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


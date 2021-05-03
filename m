Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFB3718F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhECQKn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 May 2021 12:10:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22108 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231182AbhECQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:10:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-kFw4Vq1gOwC5lu5CIeuZOg-1; Mon, 03 May 2021 17:09:46 +0100
X-MC-Unique: kFw4Vq1gOwC5lu5CIeuZOg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 3 May 2021 17:09:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 3 May 2021 17:09:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Theodore Ts'o' <tytso@mit.edu>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: RE: Very slow clang kernel config ..
Thread-Topic: Very slow clang kernel config ..
Thread-Index: AQHXQCnxH46G91tEpEmd7WaoBDaEqarR6NJg
Date:   Mon, 3 May 2021 16:09:45 +0000
Message-ID: <71e42d2a3c9d415188984f34f602425c@AcuMS.aculab.com>
References: <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk>
 <YJAK1C1uLknYGYrH@mit.edu>
In-Reply-To: <YJAK1C1uLknYGYrH@mit.edu>
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

From: Theodore Ts'o <tytso@mit.edu>
> Sent: 03 May 2021 15:38
...
> If people could actually guarantee stable ABI's, then shared libraries
> might make sense.  E2fsprogs hasn't had a major version bump in shared
> libraries for over a decade (although some developers whine and
> complain about how I reject function signature changes in the
> libext2fs library to provide that ABI stability).  But how many
> userspace packages can make that claim?

Indeed. Stable ABIs are really mandatory for anything released as
a shared library.
You can add new functions, and (if careful) new features to
existing functions (if you remembered to check all those unused
fields and flags), but the function signatures must not change.
You also can't change the exported data area.

We've got some simple drivers, they don't do anything complex.
Just hardware interrupts and PCIe accesses.
It wouldn't require many structure to be fixed, and a few
non-inlined versions of some access functions to make these
reasonably binary compatible.
At least to the point that they don't need rebuilding when
a distribution releases a new minor kernel version.

Solaris had stable kernel ABIs.
The windows version of our drivers installs on everything
from Windows 7 (maybe even Vista) through to the latest
Windows 10 (apart from the 'driver signing' fiasco).

With multiple symbol namespaces it ought to be possible
to keep them separately stable - so that drivers that only
use some symbols are portable.

Of course, there are the people who only want to support
in-tree source drivers.
They clearly exist outside the commercial world.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


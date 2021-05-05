Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0C373DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhEEOu4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 May 2021 10:50:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:48276 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhEEOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:50:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-122-_Y0hW93EMm-eOjbjZrBEGQ-1; Wed, 05 May 2021 15:49:54 +0100
X-MC-Unique: _Y0hW93EMm-eOjbjZrBEGQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 15:49:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 15:49:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Waiman Long" <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Borislav Petkov" <bp@alien8.de>
Subject: RE: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHXQbqHu8vqbxm3x0CYXgd0hdGkc6rU8ocA
Date:   Wed, 5 May 2021 14:49:53 +0000
Message-ID: <ae4ca10422824546bca3a184a280a308@AcuMS.aculab.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <20210505142542.GC5605@C02TD0UTHF1T.local>
In-Reply-To: <20210505142542.GC5605@C02TD0UTHF1T.local>
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

From: Mark Rutland
> Sent: 05 May 2021 15:26
...
> > +/*
> > + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> > + * pointer.  This prevents speculatively dereferencing a user-controlled
> > + * pointer to kernel space if access_ok() speculatively returns true.  This
> > + * should be done *after* access_ok(), to avoid affecting error handling
> > + * behavior.
> > + */
> > +#define mask_user_ptr(ptr)						\
> > +({									\
> > +	unsigned long _ptr = (__force unsigned long)ptr;		\
> > +	unsigned long mask;						\
> > +									\
> > +	asm volatile("cmp %[max], %[_ptr]\n\t"				\
> > +		     "sbb %[mask], %[mask]\n\t"				\
> > +		     : [mask] "=r" (mask)				\
> > +		     : [_ptr] "r" (_ptr),				\
> > +		       [max] "r" (TASK_SIZE_MAX)			\
> > +		     : "cc");						\
> > +									\
> > +	mask &= _ptr;							\
> > +	((typeof(ptr)) mask);						\
> > +})
> 
> On arm64 we needed to have a sequence here because the addr_limit used
> to be variable, but now that we've removed set_fs() and split the
> user/kernel access routines we could simplify that to an AND with an
> immediate mask to force all pointers into the user half of the address
> space. IIUC x86_64 could do the same, and I think that was roughly what
> David was suggesting.

Something like that :-)

For 64bit you can either unconditionally mask the user address
(to clear a few high bits) or mask with a calculated value
if the address is invalid.
The former is almost certainly better.

The other thing is that a valid length has to be less than
the TASK_SIZE_MAX.
Provided there are 2 zero bits at the top of every user address
you can check 'addr | size < limit' and know that 'addr + size'
won't wrap into kernel space.

32bit is more difficult.
User addresses (probably) go up to 0xc0000000 and the kernel
starts (almost) immediately.
If you never map a 4k page on one side of the boundary then
you only need to check the base address provided the user buffer
is less than 4k, or the accesses are guaranteed to be sequential.
While the full window test isn't that complicated ignoring the
length will remove some code - especially for hot paths that
use __get_user() to access a fixed size structure

> That does mean that you could still speculatively access user memory
> erroneously other than to NULL, but that's also true for speculated
> pointers below TASK_SIZE_MAX when using the more complex sequence.

True, but there are almost certainly easier ways to speculatively
access user addresses than passing a kernel alias of the address
into a system call!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


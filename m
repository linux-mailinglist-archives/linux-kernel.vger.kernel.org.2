Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56122373696
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEEItx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 May 2021 04:49:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:34430 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbhEEItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:49:49 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-215-3K92nTLWNMu_AZz6pphPbw-1; Wed, 05 May 2021 09:48:49 +0100
X-MC-Unique: 3K92nTLWNMu_AZz6pphPbw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 09:48:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 09:48:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "x86@kernel.org" <x86@kernel.org>,
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
        "Mark Rutland" <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHXQWJqu8vqbxm3x0CYXgd0hdGkc6rUkPgw
Date:   Wed, 5 May 2021 08:48:48 +0000
Message-ID: <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
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

From: Josh Poimboeuf
> Sent: 05 May 2021 04:55
> 
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
...
> Remove existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing with uaccess_mask_ptr().
...
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index fb75657b5e56..ebe9ab46b183 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -66,12 +66,35 @@ static inline bool pagefault_disabled(void);
>   * Return: true (nonzero) if the memory block may be valid, false (zero)
>   * if it is definitely invalid.
>   */
> -#define access_ok(addr, size)					\
> +#define access_ok(addr, size)						\
>  ({									\
>  	WARN_ON_IN_IRQ();						\
>  	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
>  })
> 
> +/*
> + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> + * pointer.  This prevents speculatively dereferencing a user-controlled
> + * pointer to kernel space if access_ok() speculatively returns true.  This
> + * should be done *after* access_ok(), to avoid affecting error handling
> + * behavior.
> + */
> +#define mask_user_ptr(ptr)						\
> +({									\
> +	unsigned long _ptr = (__force unsigned long)ptr;		\
> +	unsigned long mask;						\
> +									\
> +	asm volatile("cmp %[max], %[_ptr]\n\t"				\
> +		     "sbb %[mask], %[mask]\n\t"				\
> +		     : [mask] "=r" (mask)				\
> +		     : [_ptr] "r" (_ptr),				\
> +		       [max] "r" (TASK_SIZE_MAX)			\
> +		     : "cc");						\
> +									\
> +	mask &= _ptr;							\
> +	((typeof(ptr)) mask);						\
> +})
> +

access_ok() and mask_user_ptr() are doing much the same check.
Is there scope for making access_ok() return the masked pointer?

So the canonical calling code would be:
	uptr = access_ok(uptr, size);
	if (!uptr)
		return -EFAULT;

This would error requests for address 0 earlier - but I don't
believe they are ever valid in Linux.
(Some historic x86 a.out formats did load to address 0.)

Clearly for a follow up patch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


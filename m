Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF34338E24B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhEXIay convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 May 2021 04:30:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47067 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232279AbhEXIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:30:52 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-287-jZos3xe8MRC6svOSyzJzVQ-1; Mon, 24 May 2021 09:29:21 +0100
X-MC-Unique: jZos3xe8MRC6svOSyzJzVQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 24 May 2021 09:29:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 24 May 2021 09:29:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Samuel Neves' <sneves@dei.uc.pt>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/usercopy: speed up 64-bit __clear_user() with
 stos{b,q}
Thread-Topic: [PATCH] x86/usercopy: speed up 64-bit __clear_user() with
 stos{b,q}
Thread-Index: AQHXT/9yOXqO/LIr3EWA7KTWrkvuyaryStrQ
Date:   Mon, 24 May 2021 08:29:18 +0000
Message-ID: <58be4e3df1954458890d69c2684fb748@AcuMS.aculab.com>
References: <20210523180423.108087-1-sneves@dei.uc.pt>
In-Reply-To: <20210523180423.108087-1-sneves@dei.uc.pt>
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

From: Samuel Neves
> Sent: 23 May 2021 19:04
> 
> The current 64-bit implementation of __clear_user consists of a simple loop
> writing an 8-byte register per iteration. On typical x86_64 chips, this will
> result in a rate of ~8 bytes per cycle.
> 
> On those same typical chips, much better is often possible, ranging from 16
> to 32 to 64 bytes per cycle. Here we want to avoid bringing vector
> instructions for this, but we can still achieve something close to those fill
> rates using `rep stos{b,q}`. This is actually how it is already done in
> usercopy_32.c.
> 
> This patch does precisely this. But because `rep stosb` can be slower for
> short fills, I've retained the old loop for sizes below 256 bytes. This is a
> somewhat arbitrary threshold; some documents say that `rep stosb` should be
> faster after 128 bytes, whereas glibc puts the threshold at 2048 bytes (but
> there it is competing against vector instructions). My measurements on
> various (but not an exhaustive variety of) machines suggest this is a
> reasonable threshold, but I could be mistaken.
> 
> It should also be mentioned that the existent code contains a bug. In the loop
> 
>     "0: movq $0,(%[dst])\n"
>     "   addq   $8,%[dst]\n"
>     "   decl %%ecx ; jnz   0b\n"
> 
> The `decl %%ecx` instruction truncates the register containing `size/8` to
> 32 bits, which means that calling __clear_user on a buffer longer than 32 GiB
> would leave part of it unzeroed.
> 
> This change is noticeable from userspace. That is in fact how I spotted it; in
> a hashing benchmark that read from /dev/zero, around 10-15% of the CPU time
> was spent in __clear_user. After this patch, on a Skylake CPU, these are the
> before/after figures:
> 
> $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
> 
> $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s
> 
> The difference decreases when reading in smaller increments, but I have
> observed no slowdowns.
> 
> Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
> ---
>  arch/x86/lib/usercopy_64.c | 59 +++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index 508c81e97..af0f3089a 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
> +#include <asm/alternative.h>
> 
>  /*
>   * Zero Userspace
> @@ -16,33 +17,51 @@
> 
>  unsigned long __clear_user(void __user *addr, unsigned long size)
>  {
> -	long __d0;
> +	long __d0, __d1;
>  	might_fault();
>  	/* no memory constraint because it doesn't change any memory gcc knows
>  	   about */
>  	stac();
>  	asm volatile(
> -		"	testq  %[size8],%[size8]\n"
> -		"	jz     4f\n"
> -		"	.align 16\n"
> -		"0:	movq $0,(%[dst])\n"
> -		"	addq   $8,%[dst]\n"
> -		"	decl %%ecx ; jnz   0b\n"
> -		"4:	movq  %[size1],%%rcx\n"
> -		"	testl %%ecx,%%ecx\n"
> -		"	jz     2f\n"
> -		"1:	movb   $0,(%[dst])\n"
> -		"	incq   %[dst]\n"
> -		"	decl %%ecx ; jnz  1b\n"
> -		"2:\n"
> +		"	cmp    $256, %[size]\n"
> +		"	jae    3f\n"  /* size >= 256 */
> +		"	mov    %k[size], %k[aux]\n"
> +		"	and    $7, %k[aux]\n"
> +		"	shr    $3, %[size]\n"
> +		"	jz     1f\n"  /* size < 8 */
> +		".align 16\n"
> +		"0:	movq   %%rax,(%[dst])\n"
> +		"	add    $8,%[dst]\n"
> +		"	dec    %[size]; jnz 0b\n"

No need for a loop, just write zeros to the end of the buffer.
It may be worth doing that even if the size is a multiple of
8 and the last 'block zero' clears the same bytes.

> +		"1:	mov    %k[aux],%k[size]\n"
> +		"	test   %k[aux], %k[aux]\n"
> +		"	jz     6f\n"
> +		"2:	movb   %%al,(%[dst])\n"
> +		"	inc    %[dst]\n"
> +		"	dec    %k[size]; jnz 2b\n"
> +		"	jmp	   6f\n"
> +		"3:	\n"
> +		ALTERNATIVE(
> +			"mov   %k[size], %k[aux]\n"
> +			"shr   $3, %[size]\n"
> +			"and   $7, %k[aux]\n"
> +			"4:    rep stosq\n"
> +			"mov   %k[aux], %k[size]\n",

You really don't want to use 'rep stosb' here.
There are a large class of x86 cpu where it is really horrid.
IIRC there is one small set (just before the ERMS ones) where
short 'rep movsb' isn't too bad.

	David

> +			"",
> +			X86_FEATURE_ERMS
> +		)
> +		"5: rep stosb\n"
> +		"6:	\n"
>  		".section .fixup,\"ax\"\n"
> -		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
> -		"	jmp 2b\n"
> +		"7:	lea 0(%[aux],%[size],8),%[size]\n"
> +		"	jmp    6b\n"
>  		".previous\n"
> -		_ASM_EXTABLE_UA(0b, 3b)
> -		_ASM_EXTABLE_UA(1b, 2b)
> -		: [size8] "=&c"(size), [dst] "=&D" (__d0)
> -		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
> +		_ASM_EXTABLE_UA(0b, 7b)
> +		_ASM_EXTABLE_UA(2b, 6b)
> +		_ASM_EXTABLE_UA(4b, 7b)
> +		_ASM_EXTABLE_UA(5b, 6b)
> +		: [size] "=&c"(size), [dst] "=&D" (__d0), [aux] "=&r"(__d1)
> +		: "[size]" (size), "[dst]"(addr), "a"(0));
>  	clac();
>  	return size;
>  }
> --
> 2.31.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


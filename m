Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C62366706
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDUIcL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Apr 2021 04:32:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:25643 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235219AbhDUIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:32:09 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-g07RpUZBPa6J7oZEm98CFQ-1; Wed, 21 Apr 2021 09:31:33 +0100
X-MC-Unique: g07RpUZBPa6J7oZEm98CFQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 21 Apr 2021 09:31:32 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 21 Apr 2021 09:31:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: Show three registers per line
Thread-Topic: [PATCH] arm64: Show three registers per line
Thread-Index: AQHXNgoYyzkcKOScw0mUJJFkt/fGqaq+o1Zw
Date:   Wed, 21 Apr 2021 08:31:32 +0000
Message-ID: <c3ef59f1c06b42ecaa05a84beb7321b3@AcuMS.aculab.com>
References: <20210420172245.3679077-1-willy@infradead.org>
In-Reply-To: <20210420172245.3679077-1-willy@infradead.org>
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

From: Matthew Wilcox
> Sent: 20 April 2021 18:23
>
> Displaying two registers per line takes 15 lines.  That improves to just
> 10 lines if we display three registers per line, which reduces the amount
> of information lost when oopses are cut off.  It stays within 80 columns
> and matches x86-64.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/arm64/kernel/process.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6e60aa3b5ea9..aff5a2c12297 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -294,13 +294,10 @@ void __show_regs(struct pt_regs *regs)
>  	i = top_reg;
> 
>  	while (i >= 0) {
> -		printk("x%-2d: %016llx ", i, regs->regs[i]);
> -		i--;
> +		printk("x%-2d: %016llx", i, regs->regs[i]);
> 
> -		if (i % 2 == 0) {
> -			pr_cont("x%-2d: %016llx ", i, regs->regs[i]);
> -			i--;
> -		}
> +		while (i-- % 3)
> +			pr_cont(" x%-2d: %016llx", i, regs->regs[i]);
> 
>  		pr_cont("\n");
>  	}

I think I'd avoid pr_cont() to avoid 'mishaps' during concurrent oops.
This probably needs something like:
	for (; i >= 0; i -= 3) {
		switch (i) {
		case 0:
			printk("x%-2d: %016llx\n", i, regs->regs[i]);
			break;
		case 1:
			printk("x%-2d: %016llx x%-2d: %016llx\n",
			       i, regs->regs[i], i - 1, regs->regs[i - 1]);
			break;
		default:
			printk("x%-2d: %016llx x%-2d: %016llx x%-2d: %016llx\n",
			       i, regs->regs[i], i - 1, regs->regs[i - 1],
				 i - 2, regs->regs[i - 2]);
			continue;
		}
		break;
	}

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


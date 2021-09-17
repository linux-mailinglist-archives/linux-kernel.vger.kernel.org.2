Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99A40FA34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbhIQOdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Sep 2021 10:33:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32494 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241700AbhIQOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:33:49 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-62-I8DWIADxNXumcC2ZvYPdxg-1; Fri, 17 Sep 2021 15:32:25 +0100
X-MC-Unique: I8DWIADxNXumcC2ZvYPdxg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 17 Sep 2021 15:32:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 17 Sep 2021 15:32:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Thread-Topic: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Thread-Index: AQHXq8wPR5JW25uF60m9xktVKLekzquoSMug
Date:   Fri, 17 Sep 2021 14:32:22 +0000
Message-ID: <505920070e5f4bf8ad7ccaa12f346469@AcuMS.aculab.com>
References: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
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

From: Christophe Leroy
> Sent: 17 September 2021 14:58
> 
> Long time ago we had a config item called STRICT_MM_TYPECHECKS
> to build the kernel with pte_t defined as a structure in order
> to perform additional build checks or build it with pte_t
> defined as a simple type in order to get simpler generated code.
> 
...
> diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
> index d11b4c61d686..c60199fc6fa6 100644
> --- a/arch/powerpc/include/asm/pgtable-types.h
> +++ b/arch/powerpc/include/asm/pgtable-types.h
> @@ -5,14 +5,26 @@
>  /* PTE level */
>  #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>  typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> -#else
> +#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)
>  typedef struct { pte_basic_t pte; } pte_t;
> +#else
> +typedef pte_basic_t pte_t;
>  #endif
> +
> +#if defined(__CHECKER__) || !defined(CONFIG_PPC32) || \
> +    (defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES))
>  #define __pte(x)	((pte_t) { (x) })
>  static inline pte_basic_t pte_val(pte_t x)
>  {
>  	return x.pte;
>  }
> +#else
> +#define __pte(x)	((pte_t)(x))
> +static inline pte_basic_t pte_val(pte_t x)
> +{
> +	return x;
> +}
> +#endif

Would it be better to define:
static inline pte_basic_*pte_basic(pte_t *x)
{
#if xxx
	return x;
#else
	return &x->pte;
#endif
}

Then pte_val(x) is always *pt_basic(x)
and the casts like:

> -	pte_basic_t *entry = &ptep->pte;
> +	pte_basic_t *entry = (pte_basic_t *)ptep;

can go away.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


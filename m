Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2638AA79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhETLON convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 07:14:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56184 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238690AbhETKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:53:12 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-SZ-uRtyiMuiGND1F0dV4yw-1; Thu, 20 May 2021 11:51:42 +0100
X-MC-Unique: SZ-uRtyiMuiGND1F0dV4yw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 20 May 2021 11:51:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 20 May 2021 11:51:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "jniethe5@gmail.com" <jniethe5@gmail.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 12/12] powerpc: Replace PPC_INST_NOP by PPC_RAW_NOP()
Thread-Topic: [PATCH v1 12/12] powerpc: Replace PPC_INST_NOP by PPC_RAW_NOP()
Thread-Index: AQHXTWKqsFNaBF2Go0GIp2jNepTo56rsMM/Q
Date:   Thu, 20 May 2021 10:51:40 +0000
Message-ID: <30d3299cdf8a49e488834fe0c02d03c0@AcuMS.aculab.com>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
 <ad46c195ca1b8572629ef07ba6bfe247585239a6.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ad46c195ca1b8572629ef07ba6bfe247585239a6.1621506159.git.christophe.leroy@csgroup.eu>
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
> Sent: 20 May 2021 11:23
> 
> On the road to removing all PPC_INST_xx defines in
> asm/ppc-opcodes.h, change PPC_INST_NOP to PPC_RAW_NOP().
...
> @@ -475,7 +474,7 @@
>  #define PPC_RAW_ADD_DOT(t, a, b)	(PPC_INST_ADD | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
>  #define PPC_RAW_ADDC(t, a, b)		(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
>  #define PPC_RAW_ADDC_DOT(t, a, b)	(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
> -#define PPC_RAW_NOP()			(PPC_INST_NOP)
> +#define PPC_RAW_NOP()			PPC_RAW_ORI(0, 0, 0)

Shouldn't that be PPC_RAW_ORI(_R0, _R0, 0) ?

Also PPC_RAW_ADC_DOT() could be (PPC_RAW_ADC(t, a, b) | 0x1)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


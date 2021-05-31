Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4623957BA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhEaJCA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 May 2021 05:02:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46578 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhEaJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:01:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-283-mSf_5bWqPy28qntS7Ax19g-1; Mon, 31 May 2021 09:59:55 +0100
X-MC-Unique: mSf_5bWqPy28qntS7Ax19g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 31 May 2021 09:59:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 31 May 2021 09:59:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>,
        "patches@arm.linux.org.uk" <patches@arm.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ARM: simplify the build rule of mach-types.h
Thread-Topic: [PATCH] ARM: simplify the build rule of mach-types.h
Thread-Index: AQHXU3S/FcHjrcZ4IU6mGXTOsVEkx6r9StNA
Date:   Mon, 31 May 2021 08:59:52 +0000
Message-ID: <60fb7c6374e74b6d9e7597b19772209a@AcuMS.aculab.com>
References: <20210528034913.2157657-1-masahiroy@kernel.org>
In-Reply-To: <20210528034913.2157657-1-masahiroy@kernel.org>
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

From: Masahiro Yamada
> Sent: 28 May 2021 04:49
> 
> The directory of mach-types.h is created a couple of lines above:
> 
>   _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
> 
> The 'mkdir -p' command is redundant.
(In the rule itself)
...
>  quiet_cmd_gen_mach = GEN     $@
> -      cmd_gen_mach = mkdir -p $(dir $@) && \
> -		     $(AWK) -f $(filter-out $(PHONY),$^) > $@
> +      cmd_gen_mach = $(AWK) -f $(real-prereqs) > $@

There is a much easier way to get directories created.
gmake lets you define dependencies that only need to exist
(ie there file timestamps are't checked)
These are ideal for creating directories.

So if can define:

%/.:
	mkdir -p $@

You can just use

$(OBJ)/$(FILE): | ${OBJ)/.

to get any directories created.

Annoyingly gmake doesn't seem to support the 'dynamic dependencies'
of SYSV make (it's only useful feature).
So you can't use:
xxxxx: | $$@D/.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


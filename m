Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72AA363038
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhDQNTe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Apr 2021 09:19:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:25273 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbhDQNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:19:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-64-ukSddvvgMNiXwlfphh9iPw-1; Sat, 17 Apr 2021 14:19:03 +0100
X-MC-Unique: ukSddvvgMNiXwlfphh9iPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 17 Apr 2021 14:19:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 17 Apr 2021 14:19:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     He Zhe <zhe.he@windriver.com>, "oleg@redhat.com" <oleg@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Thread-Topic: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Thread-Index: AQHXMsVKs7ekp24ri06bsZbID/QU96q4sqsA
Date:   Sat, 17 Apr 2021 13:19:02 +0000
Message-ID: <ba281040abc146fca5a2117d5476aa1b@AcuMS.aculab.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com> <20210416133431.GA2303@C02TD0UTHF1T.local>
In-Reply-To: <20210416133431.GA2303@C02TD0UTHF1T.local>
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
> Sent: 16 April 2021 14:35
..
> @@ -51,13 +48,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  					    struct pt_regs *regs,
>  					    int error, long val)
>  {
> -	if (error)
> -		val = error;
> -
> -	if (is_compat_thread(task_thread_info(task)))
> -		val = lower_32_bits(val);
> -
> -	regs->regs[0] = val;
> +	regs->regs[0] = (long) error ? error : val;

	= error ? (long)error : rval;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


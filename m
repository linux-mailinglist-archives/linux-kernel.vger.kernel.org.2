Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A735FD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhDNVk0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Apr 2021 17:40:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:44698 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231459AbhDNVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:40:25 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-grvJhRMvO7O3_liCxi_SMA-1;
 Wed, 14 Apr 2021 22:40:01 +0100
X-MC-Unique: grvJhRMvO7O3_liCxi_SMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 22:40:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 22:40:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oleg Nesterov' <oleg@redhat.com>
CC:     He Zhe <zhe.he@windriver.com>, Paul Moore <paul@paul-moore.com>,
        "Eric Paris" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Thread-Topic: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Thread-Index: AQHXMUAOqLMsGXFf70mFNgTI1J74Jqq0MByg///6qICAAF7FQA==
Date:   Wed, 14 Apr 2021 21:39:59 +0000
Message-ID: <a4cffbd2aee74105864a7d68be829888@AcuMS.aculab.com>
References: <20210414080245.25476-1-zhe.he@windriver.com>
 <20210414150810.GA19371@redhat.com>
 <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
 <20210414165547.GA22294@redhat.com>
In-Reply-To: <20210414165547.GA22294@redhat.com>
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

From: Oleg Nesterov
> Sent: 14 April 2021 17:56
> 
> On 04/14, David Laight wrote:
> >
> > From: Oleg Nesterov
> > > Sent: 14 April 2021 16:08
> > >
> > > Add audit maintainers...
> > >
> > > On 04/14, He Zhe wrote:
> > > >
> > > > When 32-bit userspace application is running on 64-bit kernel, the 32-bit
> > > > syscall return code would be changed from u32 to u64 in regs_return_value
> > > > and then changed to s64. Hence the negative return code would be treated
> > > > as a positive number and results in a non-error in, for example, audit
> > > > like below.
> > >
> > > Sorry, can understand. At least on x86_64 even the 32-bit syscall returns
> > > long, not u32.
> > >
> > > Hmm. And afaics on x86 is_compat_task() is only defined if !CONFIG_COMPAT,
> > > so this patch looks wrong anyway.
> >
> > And, as with the other patch a x64_64 64bit process can make both types
> > of 32bit system call - so it needs to depend on the system call entry type
> > not any type of the task.
> 
> I don't understand... but iirc is_compat_task() used to check TS_COMPAT and
> this is what we need to detect the 32-bit syscall.

Not on X86_64.
The syscall entry code sets the type on the current system call entry.
So a process that is created as a 64bit process can make both i386
and x32 system calls as well as normal 64bit ones.

> But it looks deprecated,
> I think in_compat_syscall() should be used instead.

That does the right checks on x86.
Most code doesn't need to know about the subtle difference between
normal 32bit calls and x32 ones.

> But this doesn't matter, I still can't understand the problem.

Dunno, I only know the 'fix' is borked.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


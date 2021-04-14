Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD035F8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352653AbhDNQR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Apr 2021 12:17:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45860 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345859AbhDNQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:17:27 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-118-qT5hAe95OjawYbLmY3sI9g-1; Wed, 14 Apr 2021 17:17:02 +0100
X-MC-Unique: qT5hAe95OjawYbLmY3sI9g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 17:17:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 17:17:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oleg Nesterov' <oleg@redhat.com>, He Zhe <zhe.he@windriver.com>,
        "Paul Moore" <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Thread-Topic: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Thread-Index: AQHXMUAOqLMsGXFf70mFNgTI1J74Jqq0MByg
Date:   Wed, 14 Apr 2021 16:17:02 +0000
Message-ID: <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
References: <20210414080245.25476-1-zhe.he@windriver.com>
 <20210414150810.GA19371@redhat.com>
In-Reply-To: <20210414150810.GA19371@redhat.com>
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
> Sent: 14 April 2021 16:08
> 
> Add audit maintainers...
> 
> On 04/14, He Zhe wrote:
> >
> > When 32-bit userspace application is running on 64-bit kernel, the 32-bit
> > syscall return code would be changed from u32 to u64 in regs_return_value
> > and then changed to s64. Hence the negative return code would be treated
> > as a positive number and results in a non-error in, for example, audit
> > like below.
> 
> Sorry, can understand. At least on x86_64 even the 32-bit syscall returns
> long, not u32.
> 
> Hmm. And afaics on x86 is_compat_task() is only defined if !CONFIG_COMPAT,
> so this patch looks wrong anyway.

And, as with the other patch a x64_64 64bit process can make both types
of 32bit system call - so it needs to depend on the system call entry type
not any type of the task.

	David

> 
> Oleg.
> 
> > type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> > success=yes exit=4294967283
> >
> > This patch forces the u32->s32->s64 for compat tasks.
> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > ---
> >  include/linux/ptrace.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> > index b5ebf6c01292..bc3056fff8a6 100644
> > --- a/include/linux/ptrace.h
> > +++ b/include/linux/ptrace.h
> > @@ -260,7 +260,9 @@ static inline void ptrace_release_task(struct task_struct *task)
> >   * is an error value.  On some systems like ia64 and powerpc they have different
> >   * indicators of success/failure and must define their own.
> >   */
> > -#define is_syscall_success(regs) (!IS_ERR_VALUE((unsigned long)(regs_return_value(regs))))
> > +#define is_syscall_success(regs) (!IS_ERR_VALUE(is_compat_task() ? \
> > +	(unsigned long)(s64)(s32)(regs_return_value(regs)) : \
> > +	(unsigned long)(regs_return_value(regs))))
> >  #endif
> >
> >  /*
> > --
> > 2.17.1
> >

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


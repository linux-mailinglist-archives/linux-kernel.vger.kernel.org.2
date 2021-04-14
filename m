Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23DE35F7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhDNPgA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Apr 2021 11:36:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:36676 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232199AbhDNPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:35:56 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-280-yCSjejJUOvK-aMJmq-FkHQ-1; Wed, 14 Apr 2021 16:35:29 +0100
X-MC-Unique: yCSjejJUOvK-aMJmq-FkHQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 16:35:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 16:35:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'He Zhe' <zhe.he@windriver.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] audit: Add syscall return code handling for compat
 task
Thread-Topic: [PATCH 1/2] audit: Add syscall return code handling for compat
 task
Thread-Index: AQHXMQSgd93SjGF360CTpLfjJEaKJKq0JSJA
Date:   Wed, 14 Apr 2021 15:35:28 +0000
Message-ID: <e3e058cb2605482d9cfcb3466d680b71@AcuMS.aculab.com>
References: <20210414080145.17378-1-zhe.he@windriver.com>
In-Reply-To: <20210414080145.17378-1-zhe.he@windriver.com>
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

From: He Zhe
> Sent: 14 April 2021 09:02
> 
> When 32-bit userspace application is running on 64-bit kernel, the 32-bit
> syscall return code would be changed from u32 to u64 in regs_return_value
> and then changed to s64. Hence the negative return code recorded by audit
> would end up being a big positive number like below.
> 
> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> success=yes exit=4294967283
> 
> This patch forces the u32->s32->s64 for compat tasks.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  include/linux/audit.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 82b7c1116a85..32cb853f3029 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -334,7 +334,9 @@ static inline void audit_syscall_exit(void *pt_regs)
>  {
>  	if (unlikely(audit_context())) {
>  		int success = is_syscall_success(pt_regs);
> -		long return_code = regs_return_value(pt_regs);
> +		long return_code = is_compat_task() ?

Should that be is_compat_syscall() ?
A x86-64 process can make both types of 32bit system calls.

	David

> +			(s64)(s32)regs_return_value(pt_regs) :
> +			regs_return_value(pt_regs);
> 
>  		__audit_syscall_exit(success, return_code);
>  	}
> --
> 2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22832A869
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbhCBRgf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 12:36:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:26380 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1384474AbhCBPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-55-u2cLqoF3NgiPbPzefNzsww-1; Tue, 02 Mar 2021 14:59:19 +0000
X-MC-Unique: u2cLqoF3NgiPbPzefNzsww-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 2 Mar 2021 14:59:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Mar 2021 14:59:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wang Qing' <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: Return -EFAULT if copy_to_user() fails
Thread-Topic: [PATCH] mm: Return -EFAULT if copy_to_user() fails
Thread-Index: AQHXDpc1nTDef+ZvgkK8MJDT0a5yVapwy5xQ
Date:   Tue, 2 Mar 2021 14:59:17 +0000
Message-ID: <b329897d699b483387acb43a4111e599@AcuMS.aculab.com>
References: <1614601963-25812-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1614601963-25812-1-git-send-email-wangqing@vivo.com>
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

From: Wang Qing <wangqing@vivo.com>
> Sent: 01 March 2021 12:33
> 
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ab51132..a116e56
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1667,7 +1667,7 @@ COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
>  	if (!err && nmask) {
>  		unsigned long copy_size;
>  		copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
> -		err = copy_from_user(bm, nm, copy_size);
> +		err = copy_from_user(bm, nm, copy_size) ? -EFAULT : 0;
>  		/* ensure entire bitmap is zeroed */
>  		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
>  		err |= compat_put_bitmap(nmask, bm, nr_bits);

Given the 'err |= xxx' that follow I suspect the error code
doesn't matter at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


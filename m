Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5740835DC85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbhDMKhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Apr 2021 06:37:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22620 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245151AbhDMKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:37:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-nVjCyOMmNoSV_7KKXm-MGA-1; Tue, 13 Apr 2021 11:36:49 +0100
X-MC-Unique: nVjCyOMmNoSV_7KKXm-MGA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 11:36:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 13 Apr 2021 11:36:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH 3/3] rseq: optimise for 64bit arches
Thread-Topic: [PATCH 3/3] rseq: optimise for 64bit arches
Thread-Index: AQHXMETc4NN4/ddyHEK6qBKOxo8eAaqyQOlA
Date:   Tue, 13 Apr 2021 10:36:48 +0000
Message-ID: <fbf1a4449b0148b5b9c3baa32088c32a@AcuMS.aculab.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
 <20210413073657.2308450-4-eric.dumazet@gmail.com>
 <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net>
In-Reply-To: <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 13 April 2021 10:10
> 
> On Tue, Apr 13, 2021 at 12:36:57AM -0700, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> > update includes") added regressions for our servers.
> >
> > Using copy_from_user() and clear_user() for 64bit values
> > on 64bit arches is suboptimal.
> >
> > We might revisit this patch once all 32bit arches support
> > get_user() and/or put_user() for 8 bytes values.
> 
> Argh, what a mess :/ afaict only nios32 lacks put_user_8, but get_user_8
> is missing in a fair number of archs.
> 
> That said; 32bit archs never have to actually set the top bits in that
> word, so they _could_ only set the low 32 bits. That works provided
> userspace itself keeps the high bits clear.

Does that work for 32bit BE ?

	David

> So I suppose that if we're going to #ifdef this, we might as well do the
> whole thing.
> 
> Mathieu; did I forget a reason why this cannot work?
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index a4f86a9d6937..94006190b8eb 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -115,20 +115,25 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>  static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
>  {
>  	struct rseq_cs __user *urseq_cs;
> -	u64 ptr;
> +	unsigned long ptr;
>  	u32 __user *usig;
>  	u32 sig;
>  	int ret;
> 
> -	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
> +#ifdef CONFIG_64BIT
> +	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
>  		return -EFAULT;
> +#else
> +	if (get_user(ptr, &t->rseq->rseq_cs.ptr32))
> +		return -EFAULT;
> +#endif
>  	if (!ptr) {
>  		memset(rseq_cs, 0, sizeof(*rseq_cs));
>  		return 0;
>  	}
>  	if (ptr >= TASK_SIZE)
>  		return -EINVAL;
> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> +	urseq_cs = (struct rseq_cs __user *)ptr;
>  	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
>  		return -EFAULT;
> 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


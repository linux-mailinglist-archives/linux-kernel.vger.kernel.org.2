Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959A39FE34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhFHRxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhFHRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:53:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C508C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b3WsjQdgR3MSJTjU3lrqrbMQ+LQT0nybe5G1JEwCYNk=; b=wPbpuXpgSFM4faHH4KLtmHiMyd
        4OQ2bRX+8TbH7QnWknOg5vlX55XClwOYMBKk1wXomhFP/XN0apMWnfmUuScLPMNK8tf9RUukCrQhI
        WjbNFsUc6iKJrJqIMTdwicyGlk8v1KFNJuq+xr0fAyNCVAKH5bLG8+3Rz55yliFlkdRbAhWAUfYkm
        Pk0M4BOTtaMyDiY9gruqiuhWp2NoKN0r7pe4zDvyNs016VVN1+EIwVOaYd5kNkpVth39xvlIAWD9c
        t/wNKGD+CK6WeRUxmaKb2dOFs0IJ7refvDrgS4P9qrL0kaBBaQ5WIGxplainMEy2RyxiBY5+wIvzh
        D498pu0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqfsV-00HEEL-Jg; Tue, 08 Jun 2021 17:51:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B24A73001E3;
        Tue,  8 Jun 2021 19:51:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B9E42D1D1298; Tue,  8 Jun 2021 19:51:02 +0200 (CEST)
Date:   Tue, 8 Jun 2021 19:51:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        matthias.bgg@gmail.com, andreyknvl@google.com,
        akpm@linux-foundation.org, oleg@redhat.com,
        walter-zh.wu@mediatek.com, frederic@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_work: record irq_work_queue() call stack
Message-ID: <YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net>
References: <20210331063202.28770-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331063202.28770-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:32:02PM +0800, qiang.zhang@windriver.com wrote:

> @@ -70,6 +70,9 @@ bool irq_work_queue(struct irq_work *work)
>  	if (!irq_work_claim(work))
>  		return false;
>  
> +	/*record irq_work call stack in order to print it in KASAN reports*/
> +	kasan_record_aux_stack(work);
> +
>  	/* Queue the entry and raise the IPI if needed. */
>  	preempt_disable();
>  	__irq_work_queue_local(work);

Thanks for the Cc :/ Also NAK.

I shall go revert this instantly. KASAN is not NMI safe, while
irq_work_queue() is very carefully crafted to be exactly that.

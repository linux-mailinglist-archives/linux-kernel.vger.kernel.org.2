Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA239FE50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhFHSBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhFHSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:01:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kEDBey//uODOhAAOZPxn7gDKkNRZBwUx1r7R/fxovBg=; b=K3hlsFJ/iecAA+uzItPMaCACYH
        zK91L/90rEItXQuNGP9W+c8KX+NHl8hJ2vJSRZUaPBuCIYOV1fvt3Q7je/EjJxNWLZZgh1/41hn+p
        cgt1CaIqiJFw65F9inz7XOWPz1Y3QQsAP8566wLOUt4nFMEnJ6kejF1+XhcIBSipP+zaAXnUYWiI6
        7E2eGw5zosNNKxMEu+CWKVOzmv584foghP5o0/P5A8kz70NqJDnvebS6n8LWJWTWN25yOHvhRI/yE
        ehQ5bN9bouTaGdyhzLeJLmb3Md11yMwH1McK7B3ojWm24Fg6ygTFIe7v6DWNhe91l0IQ5l+OCOkk2
        7sI6/jLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqg0T-004pG6-Ad; Tue, 08 Jun 2021 17:59:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AFF530018A;
        Tue,  8 Jun 2021 19:59:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32B3E201DEF0B; Tue,  8 Jun 2021 19:59:23 +0200 (CEST)
Date:   Tue, 8 Jun 2021 19:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        matthias.bgg@gmail.com, andreyknvl@google.com,
        akpm@linux-foundation.org, oleg@redhat.com,
        walter-zh.wu@mediatek.com, frederic@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] irq_work: Make irq_work_queue() NMI-safe again
Message-ID: <YL+v+yMA1dZegUN9@hirez.programming.kicks-ass.net>
References: <20210331063202.28770-1-qiang.zhang@windriver.com>
 <YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:51:02PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 31, 2021 at 02:32:02PM +0800, qiang.zhang@windriver.com wrote:
> 
> > @@ -70,6 +70,9 @@ bool irq_work_queue(struct irq_work *work)
> >  	if (!irq_work_claim(work))
> >  		return false;
> >  
> > +	/*record irq_work call stack in order to print it in KASAN reports*/
> > +	kasan_record_aux_stack(work);
> > +
> >  	/* Queue the entry and raise the IPI if needed. */
> >  	preempt_disable();
> >  	__irq_work_queue_local(work);
> 
> Thanks for the Cc :/ Also NAK.
> 
> I shall go revert this instantly. KASAN is not NMI safe, while
> irq_work_queue() is very carefully crafted to be exactly that.

The below goes in tip/perf/urgent ASAP.

---
Subject: irq_work: Make irq_work_queue() NMI-safe again
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Jun  8 19:54:15 CEST 2021

Someone carelessly put NMI unsafe code in irq_work_queue(), breaking
just about every single user. Also, someone has a terrible comment
style.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/irq_work.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,9 +70,6 @@ bool irq_work_queue(struct irq_work *wor
 	if (!irq_work_claim(work))
 		return false;
 
-	/*record irq_work call stack in order to print it in KASAN reports*/
-	kasan_record_aux_stack(work);
-
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 	__irq_work_queue_local(work);

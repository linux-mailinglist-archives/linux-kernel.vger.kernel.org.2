Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D943F3FECA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhIBLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhIBLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:07:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6703C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z73x2L2rOoDwRYkagwjL/Oyo2Vlc7NsRgYgsKEc/tB0=; b=mP6/AXJfjGwoPVKWYucX3Lxbj5
        n5BKtbgjARzVRDFN8GMkTEhqQJd52WYOHXCDsscuWFO8m7O9143u9rSJ6C5YfvKbRzpY1qFoQJ2XA
        RhXxbYNtvaU9FyN3DtjY36yEDdvKugurh7fCSeX4kdujnsXqGqZdnA4xpEYKT1WaUTgH6tMhUBYyG
        9nP+yTvDP+i0fOC84Ai0tJhVr0pSaotaemv+aN1j81emkTUWJMSihEMuu8qiYWevNFA5TzKa9yv0B
        fMuMIZWCFaDjcEPIufN1fjVRCNNhV+eb42FFN0gL22k/qTFaatWQCscH3+bfboNO3flCpUrCXNPO6
        cizt5Atg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLkXr-0006dL-Ot; Thu, 02 Sep 2021 11:06:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C65030029F;
        Thu,  2 Sep 2021 13:06:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65C162BC01581; Thu,  2 Sep 2021 13:06:13 +0200 (CEST)
Date:   Thu, 2 Sep 2021 13:06:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 0/3] futex: Prevent inconsistent state and exit race
Message-ID: <YTCwJULJRc2WtKaD@hirez.programming.kicks-ass.net>
References: <20210902093755.087908334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902093755.087908334@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:48:47AM +0200, Thomas Gleixner wrote:
> The recent requeue PI changes introduced a condition where a waiter can
> escape to user space with inconsistent state and in the worst case exit
> before state has been made correct.
> 
> The following series addresses this.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

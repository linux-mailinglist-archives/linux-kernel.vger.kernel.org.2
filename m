Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965633282D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCIOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhCIOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:08:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WROz8RdWyey49f/4p5eiBf1pKVdeKca3IAQW6TVZjwA=; b=fEh7bVICuNc30fuabtH1CdN7W1
        DWQVblY/CesRf1W6G8sZjKdhKW+XyrvEW7Yd2uElENngEUnGWwphQVaoIMC4s8NkQ3YWWUL7zcqJ6
        lo/Qz5amlm9G9fXg1H3JLE5K5kQeQfKs6qoSjJhxo//7GoI20cRHf1oR2+b7vg6Dw4NWSChTBBw51
        PmOI9LHlLD+owDeu6NHNzkCwWQ7QmM5EMgVROTPxElQS/CEc1FpHLIbBryf+DdFiGPS6cocFkH/90
        Dp0YUgYW1VJeIVtIwTf6r2synImZ6sMfeMCRJJ9fxoC0DFgZUnUjqTrAo18vG8/xI5o9bOm//GUHV
        YQnzD2tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJd1X-000fde-Dj; Tue, 09 Mar 2021 14:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4080300455;
        Tue,  9 Mar 2021 15:07:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFAE722B8D9BA; Tue,  9 Mar 2021 15:07:46 +0100 (CET)
Date:   Tue, 9 Mar 2021 15:07:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch V3 0/6] softirq: Add RT specific softirq accounting
Message-ID: <YEeBMgdyHV/nsjjk@hirez.programming.kicks-ass.net>
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309085552.815026890@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 09:55:52AM +0100, Thomas Gleixner wrote:
> RT runs softirq processing always in thread context and it requires that
> both the softirq execution and the BH disabled sections are preemptible.
> 
> This is achieved by serialization through per CPU local locks and
> substituting a few parts of the existing softirq processing code with
> helper functions.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

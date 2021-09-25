Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86141810C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhIYKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhIYKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 06:34:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676DBC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GQsiNXKkdSWCgdiriw76mEZVS2By0QMkbd+bhGBkFcw=; b=tofAG10O1c/O3BP+eJApnIDbJX
        cBH7elfkiZS9ebXHNEItnUOiEMV2tw1RvK1sl5ZiJ/fJjtZ3hFFPQ0sKTxEYcu3HrTV52NdyBseWz
        3TZXCpLfxdfh0+VW5tce2WC9gBa3a+mOl0Qt9ZzonTWfSDzcjX4/CDfBPY6ELitlzr5i4tdnxUzCc
        QrPFDk4NwWUt4AVZrOufO0P1B4iblfHEqgktiqjkjPKG9fSdt4eG2ZGFPaAvD94E6D3XaMLcolqQM
        fTTilfL09jW56/iGQnQMk1hH/hJyzoD+Jm3xIzM7OU5OdCHXet2+gXf9PijMpnPjL65hZhJfJMV9C
        MTvnS06w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mU4yG-0081Th-KK; Sat, 25 Sep 2021 10:31:56 +0000
Date:   Sat, 25 Sep 2021 11:31:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
Message-ID: <YU76mB5hzvw3xZRB@infradead.org>
References: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:47:55AM +0200, Sebastian Andrzej Siewior wrote:
> +	if (local_softirq_pending()) {
> +
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			do_softirq();
> +		} else {
> +			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
> +
> +			if (ksoftirqd && !task_is_running(ksoftirqd))
> +				wake_up_process(ksoftirqd);
> +		}
> +	}

At a cosmetic level this looks pretty weird.  Why the empty line inside
the indented block?  Why the pointless negation instead of the obvious
more straightforward order?

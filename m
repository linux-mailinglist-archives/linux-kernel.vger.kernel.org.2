Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DB3FDDD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhIAObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhIAObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:31:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71582C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=abSoqmL6UmYJk1xVljHxCr9/UeBUB47I3MqPPo8dZRU=; b=aKJMa9QPyXndZc+w43+OcTLROr
        lTyNwExfN95Qc41Q2+it7K16pLO7ioscuvpbFdFYp2yxZrspEJDWHs9GyDsBK63u44ZJhJT8mstsN
        F5CNVbMGfY0J0BQtywiM0PEeu6Ocf1U+HAUzrwINWb8LZhu+A4nDxVkHaVEDvHq5hnDEjVFEeK/rr
        k/vQr0Vq/DiAi16fd/RF5wMlXXLdxUCqu0V7ygjS/KnFDBasXt47lW0ZN8k+n53toLmLcEoMc2vbw
        Tm07t+rqgOeGUyCzaaAmIdZbYif9ILd+eb7MQRY4Vlv7ljnl05Al5MARlyDCukQFL7/n+HlzilmVn
        jJwog0AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLRF0-002R6Y-7l; Wed, 01 Sep 2021 14:29:38 +0000
Date:   Wed, 1 Sep 2021 15:29:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
Message-ID: <YS+ORkbD9NuEOl0D@casper.infradead.org>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <6155058.TBsaUTXu4T@localhost.localdomain>
 <794b3ff8-0240-ff14-8721-cdf510f52be3@linaro.org>
 <8914101.vIO1HAjRha@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8914101.vIO1HAjRha@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 03:56:20PM +0200, Fabio M. De Francesco wrote:
> Anyway I tried to reason about it. I perfectly know what is required to 
> protect critical sections of code, but I don't know how drivers work; I mean 
> I don't know whether or not different threads that run concurrently could 
> really interfere in that specific section. This is because I simply reason in 
> terms of general rules of protection of critical section but I really don't 
> know how Greybus works or (more in general) how drivers work.

From a quick look, it is indeed possible to get rid of the mutex.
If this were a high-performance path which needed to have many threads
simultaneously looking up the gb_tty, or it were core kernel code, I
would say that you should use kfree_rcu() to free gb_tty and then
you could replace the mutex_lock() on lookup with a rcu_read_lock().

Since this is low-performance and driver code, I think you're better off
simply doing this:

	xa_lock((&tty_minors);
	gb_tty = xa_load(&tty_minors, minor);
	... establish a refcount ...
	xa_unlock(&tty_minors);

EXCEPT ...

establishing a refcount currently involves taking a mutex.  So you can't
do that.  First, you have to convert the gb_tty mutex to a spinlock
(which looks fine to me), and then you can do this.  But this is where
you need to work with the driver authors to make sure it's OK.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC863149C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhBIHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBIHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:54:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FDDC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3gOG9mayuPRITYpE4PJ6WJPHCQ1vybdblsZqw9M3u7k=; b=2bdHBsO2BbQWSjn8fiMam99DVg
        OA2WHtpg/L+j4iYChqJ796qeWJKYRKDrEfU+ENjzZ2HWcx1NCiHhoGllsmzW4zVMi2sZuV4TjGdT9
        PM200E20M79IMScOQTWhGOk6qpy9q1mUvSLQaglTtY5FTEX+ARpK5wlv1u2z6sqwISiSiOnSDvsFu
        YNDdT+lBTHZztqJfmmw0HTQ591ZopGe0M9rQNs2UVCbcm4goGrSSCAj29+SVJCzGYONqyKQypr+1x
        6SEUzkwPjehtGfBqPpLfr0kRm1A2nYGSmJ2WnqTB9hQFAPKSiI1Rh9EJQzWVfijF/7u/bE9IEk3UP
        F+6NcBFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9Npj-0006EM-Ka; Tue, 09 Feb 2021 07:53:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F42830066E;
        Tue,  9 Feb 2021 08:53:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72E6C2040C5A8; Tue,  9 Feb 2021 08:53:10 +0100 (CET)
Date:   Tue, 9 Feb 2021 08:53:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] kernel/smp: Split call_single_queue into 3 queues
Message-ID: <YCI/ZrfkBOAHZyDF@hirez.programming.kicks-ass.net>
References: <20210128065506.618426-1-leobras.c@gmail.com>
 <20210128103348.rtbtffmvt7mwjohx@linutronix.de>
 <c0b145ea557087ebbabe1fcca3b2bf69bedbaff6.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b145ea557087ebbabe1fcca3b2bf69bedbaff6.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:03:47PM -0300, Leonardo Bras wrote:

> > with the patch at the bottom of the mail. This shows that in my
> > smoke test at least, the number of items in the individual list is low.
> 
> Yes, but depending on workload this list may get longer.

Get a median number of entries on the list, if you can get your median
anywhere near large enough to any of this to matter I'd be very
surprised.

This needs lots of numbers..

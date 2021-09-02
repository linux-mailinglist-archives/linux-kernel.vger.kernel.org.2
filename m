Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8F3FED79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbhIBMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhIBMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:07:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OFWN9tRAqjXVBWOOIV9ZZ6Jy1jkGoZ0Z+UnlsnwjGdI=; b=o9Q8XmnGgkCLz6DBO6oFYi7bW2
        hN9hu/1ks1tCKFlvIUQG9uuIFTzavPWpoCIP8lm5JA1YMSDq/u3ejrmat93FltSnNlQ0SR+LfaZKv
        iYIv8nuOKLqoBeO6IcBVtvTIn7l7dskPUMRcO/sY4aqVyKuLrvwabw2xtKTtk61+l9XXdzGHG3j+J
        c330J3ah9ZCxRQPIoXyjOXa2j/xlFqpERuUV+a2qkq3qr2VL4yB2P08ARrWedTXlNrJwPzXFMTQ59
        v6TS9bhsfdT/GnwE0rv+CI//GItD7RxOo4Rgy+ChBnOoK1RcNTrB18Nfi8f0+zb2Y8ytRurZFpwvz
        pofT6LSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLlTP-0007Cz-UD; Thu, 02 Sep 2021 12:05:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E27830003A;
        Thu,  2 Sep 2021 14:05:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 556CE285E116C; Thu,  2 Sep 2021 14:05:41 +0200 (CEST)
Date:   Thu, 2 Sep 2021 14:05:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Message-ID: <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com>
 <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
 <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 07:54:25PM +0800, Lai Jiangshan wrote:
> For example, stack-protector is instrumenting many noninstr functions now
> if the CONFIG is yes.  It is normally Ok and gcc is adding per-function control
> on it.

IIRC the latest compiler have an attribute for this too, that really
should be added to noinstr. Lemme go find.

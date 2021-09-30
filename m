Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88FD41D873
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350336AbhI3LN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbhI3LNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EBC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oWMoz5wTbwWrh2dxyrG4urGyYFHzJe3tevSGO+e8ExU=; b=qTUp6sLhixW9WlCDpM1VP0Oyq4
        LqJ8ifMlbuNbOMvTA6WawVwrEmF0t+kxfhqUT3DtEaWGLr7FEPYcEr8rzlK37HRdUvR/XUHxIYCNk
        SLjZa15UyCU8q/o6urhjekaULVUyFQ2zYN1oDntqUKdUQVTYqmpHItuyhBNna+AfgeuvA0DhHkIFQ
        TxiixmkXetQCdioyLEWdAMFxNlwncFSyAAJqn9Iy3FQbNSZ8gS6CW7sApomtAEqZm07l/NFas15ha
        YoIPUtlQ+09CcfkR5wNgwlFYv3zyNLvosqm4RtSXZB33XfpAAsZEp64gZ+EBI17PexepgZBy+GPim
        7CtFVwjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVtxY-00CmDo-KW; Thu, 30 Sep 2021 11:10:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11AB2300268;
        Thu, 30 Sep 2021 13:10:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9F0D2C904C19; Thu, 30 Sep 2021 13:10:39 +0200 (CEST)
Date:   Thu, 30 Sep 2021 13:10:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/process: directly use try_get_task_stack()
 return value in get_wchan
Message-ID: <YVWbL1TbfuxnznxV@hirez.programming.kicks-ass.net>
References: <20210930185229.09d463ab@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930185229.09d463ab@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:52:29PM +0800, Jisheng Zhang wrote:
> try_get_task_stack() has already properly gets target task's stack,
> no need to call task_stack_page() again.

Please see:

  https://lkml.kernel.org/r/20210929220218.691419-1-keescook@chromium.org

Whichever way around, this code doesn't live much longer.

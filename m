Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6E42A515
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhJLNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhJLNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:09:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F80FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UIyFzqtjDrrV/LoTu85FR8nzJEt8XBEGmIGqLme6FJg=; b=HlpGjt6mci79Wtn2PRnwgCR5qb
        zjrcQjFOwqOx2i2D8jAnKHLhjyB7J+Vh3UaxiYTdWrXREq8ivXVtIh/677QEYF4nOiUcyfGXSjL7M
        vV1+eUj6Um0xPpceF1JZ/7ORDwFWBXzW3ncSfylSUGq3bd5Xmp+2hw+yJp3t2oyTmaXsUAtcOPPix
        dQgcP4wzDubipYMzPm8OWKuctpfJge5toU0unsMWM3A46ds6+z4MkrkS0uvnuz4yG5gvDfkU81Y/s
        7eOX7yTn4EXTvV06E022DTRRfqoh3m1K1XlSY8VObmlGKGac9lLExmSY2aEM3yx38g2wGgKWQ2IgL
        /4LLV2RA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maHTK-006WJv-MS; Tue, 12 Oct 2021 13:05:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA67130032E;
        Tue, 12 Oct 2021 15:05:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AED992C10165A; Tue, 12 Oct 2021 15:05:34 +0200 (CEST)
Date:   Tue, 12 Oct 2021 15:05:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007193525.755160804@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:23:47PM -0300, Marcelo Tosatti wrote:
> Add basic prctl task isolation interface, which allows
> informing the kernel that application is executing 
> latency sensitive code (where interruptions are undesired).
> 
> Interface is described by task_isolation.rst (added by
> next patch).

That does not absolve you from actually writing a changelog here.
Life is too short to try and read rst shit.

What is the envisioned usage of these isolating prctl() thingies,
including the kill-me-on-any-interruption thing, vs the inherently racy
nature of some of the don't disturb me stuff.

Also, see:

  https://lkml.kernel.org/r/20210929152429.186930629@infradead.org

Suppose:

	CPU0					CPU1

	sys_prctl()
	<kernel entry>
	  // marks task 'important'
						text_poke_sync()
						  // checks CPU0, not userspace, queues IPI
	<kernel exit>

	$important userspace			  arch_send_call_function_ipi_mask()
	<IPI>
	  // finds task is 'important' and
	  // can't take interrupts
	  sigkill()

*Whoopsie*


Fundamentally CPU1 can't elide the IPI until CPU0 is in userspace,
therefore CPU0 can't wait for quescence in kernelspace, but if it goes
to userspace, it'll get killed on interruption. Catch-22.


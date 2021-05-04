Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB251372A17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEDMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:32:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Q2Tl348rX3wm0zCEE028a6mHAZuedaCAfijiKQsq7o=; b=q3y201nDiFQ3QHlrEznT0p4WLo
        CY07pfMGkKT93AEalnZS4ISlhZjlbuQ/hsjLnWB4tzyJ/Tep0nMNCqqFLJsyHHuv3eSedjuL9uU9U
        nx9vGzoz94C9Hq/ojIFPwmyUKqcE6wB471f3Keqn8m2fPHH1k0arDy0DLoSS9UP/U21yiei4273zB
        LA2g9DhFIGfKik6jb1waVATbyYVrx6bC+kp1qqrsd6g5WLDU0/RuNP37cDgm2ph6OW4SGMEskiDrR
        7D8W1BcWv3w8CdtHrivCRYdTwF/+a/CFdoQyV3JG9kc8c90eq2zehyw2xbx+c/QA4DKYAC7ElF7uM
        woAeruew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lduD5-00GBeR-Nq; Tue, 04 May 2021 12:31:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5120D30022A;
        Tue,  4 May 2021 14:31:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E85552026F4B8; Tue,  4 May 2021 14:31:29 +0200 (CEST)
Date:   Tue, 4 May 2021 14:31:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 1/8] tick/nohz: Evaluate the CPU expression after the
 static key
Message-ID: <YJE+oXuZ7KxxSMLK@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422120158.33629-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:51PM +0200, Frederic Weisbecker wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> When tick_nohz_full_cpu() is called with smp_processor_id(), the latter
> is unconditionally evaluated whether the static key is on or off. It is
> not necessary in the off-case though, so make sure the cpu expression
> is executed at the last moment.
> 
> Illustrate with the following test function:
> 
> 	int tick_nohz_test(void)
> 	{
> 		return tick_nohz_full_cpu(smp_processor_id());
> 	}
> 
> The resulting code before was:
> 
> 	mov    %gs:0x7eea92d1(%rip),%eax   # smp_processor_id() fetch
> 	nopl   0x0(%rax,%rax,1)
> 	xor    %eax,%eax
> 	retq
> 	cmpb   $0x0,0x29d393a(%rip)        # <tick_nohz_full_running>
> 	je     tick_nohz_test+0x29         # jump to below eax clear
> 	mov    %eax,%eax
> 	bt     %rax,0x29d3936(%rip)        # <tick_nohz_full_mask>
> 	setb   %al
> 	movzbl %al,%eax
> 	retq
> 	xor    %eax,%eax
> 	retq
> 
> Now it becomes:
> 
> 	nopl   0x0(%rax,%rax,1)
> 	xor    %eax,%eax
> 	retq
> 	cmpb   $0x0,0x29d3871(%rip)        # <tick_nohz_full_running>
> 	je     tick_nohz_test+0x29         # jump to below eax clear
> 	mov    %gs:0x7eea91f0(%rip),%eax   # smp_processor_id() fetch, after static key
> 	mov    %eax,%eax
> 	bt     %rax,0x29d3866(%rip)        # <tick_nohz_full_mask>
> 	setb   %al
> 	movzbl %al,%eax
> 	retq
> 	xor    %eax,%eax
> 	retq
> 
> Not-Yet-Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Thanks for writing the Changelog.

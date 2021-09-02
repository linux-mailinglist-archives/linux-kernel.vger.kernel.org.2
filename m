Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6D3FEBF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhIBKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbhIBKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:17:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55582C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hSXBOO+IhYekR6dWOzJNmWSb5Ms7mb6kt3x7AvComFM=; b=eOo0Q11qJRuSuvby/5TbqaJjP2
        vunrDMHLbEbfYUpHYLHtDhW1KWFQAMWA43YOks9BSU8Wefw5ar8LCjs+0Sg6mL8snxgQlL+aMwn2o
        JktuCzRvXep42Yffb/lAUfKNrze+Xa6R4XMSOvLZGH1ozY4L4gH6JDuHgHn8CQhd3X/e/lkQI2TmM
        AsXPaFPpadPtWhCWG9AHVYhOF87E6Aabja3BLnwS5QqEsB9qI/nIpJf976qAFLgosmLFe7aR+wz//
        XJy71W+z0LZiaCekYW3CaGiB8Obbqpkm+qV/A1yYgUUBtSTEkQ9CfTTrBrLh6D+PRDGZdKb7PrlOE
        3XWZ3aGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLjlq-0006KW-R4; Thu, 02 Sep 2021 10:16:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87981300332;
        Thu,  2 Sep 2021 12:16:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FFDB285E114E; Thu,  2 Sep 2021 12:16:35 +0200 (CEST)
Date:   Thu, 2 Sep 2021 12:16:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 11/24] x86/entry: Replace the most of asm code of
 error_entry to C code
Message-ID: <YTCkgw/4v+mBBUIN@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-12-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-12-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:12AM +0800, Lai Jiangshan wrote:
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 42d2918f5646..bc9e2f5ad370 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -972,83 +972,14 @@ SYM_CODE_START_LOCAL(error_entry)
>  	cld
>  	PUSH_AND_CLEAR_REGS save_ret=1
>  	ENCODE_FRAME_POINTER 8
>  
>  	popq	%r12				/* save return addr in %12 */
>  	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
> +	call	do_error_entry
>  	movq	%rax, %rsp			/* switch stack */
>  	ENCODE_FRAME_POINTER
>  	pushq	%r12
>  	ret

There's only a single error_entry callsite, which is idtentry_body. One
of the things I wanted to do is change this lot so we change to the
task_stack in 'C', using an adaptation of call_on_irqstack() and
basically don't return frrom C until we're done with \cfunc.

That is, once we call C, stay there, and don't do this back and forth
between C and asm.

As is, the resulting asm in error_entry is somewhat confusing given that
we sometimes don't actually switch stacks.


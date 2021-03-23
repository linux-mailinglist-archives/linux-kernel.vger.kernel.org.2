Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D353461F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCWOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhCWOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:52:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PxxQd2ZsPGCsw7fnjYXdR2/2SQeRMXFxuYQjc6sjQYU=; b=jDoHwzB/RBJmc7iCZU9tlo6evO
        GNkqAijJYx4DkOnvz1TNHDHnuwd3egbSYoUq6u8JztDI8F4u2a5kMAclQYb3zjeNCp9LhGagfa7dF
        d0Jlc1JbAruc93ppiJp5oGxwI3LU4lcowPfnd38XK7B9bW23dycWSnlpIUSr3cNjf2HaTmRi4lQUs
        jta6u0ib4XQ5DGE8cVw4Mg7aWmHyEy2s5XD+wT/8oPWG0eHQm1DcmdkdZk7NIGBEdw/KI0RYaJ7R7
        MTughG/J+vubg8sB/Hcu1Ob8ELiKqVUHtO2yb69EvBhgf8KlT5G8ajg0B/9VJphr+vMx9iZQupOTC
        ZvXfWaBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOiOc-00FCVZ-CL; Tue, 23 Mar 2021 14:52:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55CA530377D;
        Tue, 23 Mar 2021 15:52:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D34C2360188E; Tue, 23 Mar 2021 15:52:37 +0100 (CET)
Date:   Tue, 23 Mar 2021 15:52:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     x86@kernel.org, rostedt@goodmis.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org, sumit.garg@linaro.org,
        oliver.sang@intel.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: treat exit sections the same as init sections
 when !CONFIG_MODULE_UNLOAD
Message-ID: <YFoAtV58k+1zgH50@hirez.programming.kicks-ass.net>
References: <20210323142756.11443-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323142756.11443-1-jeyu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:27:56PM +0100, Jessica Yu wrote:
> Dynamic code patching (alternatives, jump_label and static_call) can
> have sites in __exit code, even if __exit is never executed. Therefore
> __exit must be present at runtime, at least for as long as __init code
> is.
> 
> Additionally, for jump_label and static_call, the __exit sites must also
> identify as within_module_init(), such that the infrastructure is aware
> to never touch them after module init -- alternatives are only ran once
> at init and hence don't have this particular constraint.
> 
> By making __exit identify as __init for !MODULE_UNLOAD, the above is
> satisfied.
> 
> So the section ordering should look like the following when
> !CONFIG_MODULE_UNLOAD, with the .exit sections moved to the init region of
> the module.
> 
> Core section allocation order:
>  	.text
>  	.rodata
>  	__ksymtab_gpl
>  	__ksymtab_strings
>  	.note.* sections
>  	.bss
>  	.data
>  	.gnu.linkonce.this_module
>  Init section allocation order:
>  	.init.text
>  	.exit.text
>  	.symtab
>  	.strtab
> 
> [jeyu: thanks to Peter Zijlstra for most of the changelog]
> 
> Link: https://lore.kernel.org/lkml/YFiuphGw0RKehWsQ@gunter/
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> 
> Do you want to take this patch with the other static_call patches? Or
> should I take this through modules-next?

Take it through modules-next, I haven't seen an actual report on this
and it's been broken forever afaict. I only found it by accident while
chasing this other problem.

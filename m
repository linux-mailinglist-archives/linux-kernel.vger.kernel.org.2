Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839E839A687
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFCRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:01:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17289 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFCRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:01:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739606; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=6sGBQMxHgyxCwDyzxIWgWc7VKrWyLjlK6AkJSzo3n/M=; b=l6DHztRDgfxmY003GCfsyiPluspjgQmCCiATlmi7y8ZHW+sMQH3R2618bg05H0kfsnlRkFa3
 TPNwh/v7aujArOLpp78WmjQ7LtByxC0QBhnq1US/2S82YmhYVVt38UEb9tt8lVr+kaMz6ZwH
 zFqDSc5vRtkvS/F999HnTnSavFY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60b90a8af726fa4188c6c5cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 16:59:54
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7137EC43217; Thu,  3 Jun 2021 16:59:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 342B1C433D3;
        Thu,  3 Jun 2021 16:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 342B1C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-2-nathan@kernel.org>
In-Reply-To: <20210521011239.1332345-2-nathan@kernel.org>
Subject: RE: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
Date:   Thu, 3 Jun 2021 11:59:51 -0500
Message-ID: <09a501d75899$df036060$9d0a2120$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQImhg45Cwtn7gWc92+5nwbl9gAFPwHydMNpqlSTsfA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Thursday, May 20, 2021 8:13 PM
> To: Brian Cain <bcain@codeaurora.org>; Andrew Morton <akpm@linux-
> foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
> 
> Patch "mm/slub: use stackdepot to save stack trace in objects" in -mm
> selects CONFIG_STACKDEPOT when CONFIG_STACKTRACE_SUPPORT is
> selected and
> CONFIG_STACKDEPOT requires IRQENTRY_TEXT and SOFTIRQENTRY_TEXT to
> be
> handled after commit 505a0ef15f96 ("kasan: stackdepot: move
> filter_irq_stacks() to stackdepot.c") due to the use of the
> __{,soft}irqentry_text_{start,end} section symbols. If those sections
> are not handled, the build is broken.
> 
> $ make ARCH=hexagon CROSS_COMPILE=hexagon-linux- LLVM=1 LLVM_IAS=1
> defconfig all
> ...
> ld.lld: error: undefined symbol: __irqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __irqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __softirqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __softirqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> ...
> 
> Add these sections to the Hexagon linker script so the build continues
> to work. ld.lld's orphan section warning would have caught this prior to
> the -mm commit mentioned above:
> 
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> 
> Fixes: 505a0ef15f96 ("kasan: stackdepot: move filter_irq_stacks() to
> stackdepot.c")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1381
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S
> b/arch/hexagon/kernel/vmlinux.lds.S
> index 35b18e55eae8..20f19539c5fc 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -38,6 +38,8 @@ SECTIONS
>  	.text : AT(ADDR(.text)) {
>  		_text = .;
>  		TEXT_TEXT
> +		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT
>  		LOCK_TEXT
> --
> 2.32.0.rc0

Acked-by: Brian Cain <bcain@codeaurora.org>


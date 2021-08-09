Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8493E4DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhHIUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:25:31 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:53830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232730AbhHIUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:25:30 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 80618180361AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 20:25:09 +0000 (UTC)
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A8ACC1CFD9;
        Mon,  9 Aug 2021 20:25:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 058871D42FA;
        Mon,  9 Aug 2021 20:25:07 +0000 (UTC)
Message-ID: <50d0f2e41fdb909998d94395909572c0a6d997d1.camel@perches.com>
Subject: Re: Possible false positive from checkpatch.pl?
From:   Joe Perches <joe@perches.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:25:06 -0700
In-Reply-To: <387aeb72-6285-72b4-427a-bcd0a0211c33@linux.microsoft.com>
References: <387aeb72-6285-72b4-427a-bcd0a0211c33@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 058871D42FA
X-Spam-Status: No, score=-0.77
X-Stat-Signature: ebgjxjaiebbnqxb9j1tadrpsiuwzydg8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+CmefBgRVVAiuktUzqIbpEG7ugG6BKc0Y=
X-HE-Tag: 1628540707-702640
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-09 at 15:15 -0500, Madhavan T. Venkataraman wrote:
> Hi,
> 
> I have defined the SYM_CODE_END() macro for ARM64 in arch/arm64/include/asm/linkage.h like this:
> 
> #define SYM_CODE_END(name)                              \
>         SYM_END(name, SYM_T_NONE)                       ;\
>         99:                                             ;\
>         .pushsection "sym_code_functions", "aw"         ;\
>         .quad   name                                    ;\
>         .quad   99b                                     ;\
>         .popsection
> 
> SYM_CODE_START() and SYM_CODE_END() macros are only used while defining assembly functions.
> They are never used in C code.
> 
> But checkpatch.pl is emitting the following messages (enclosed within ========). Looks like
> it is treating them like macros used in C code.
> 
> 
> =================
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #21: FILE: arch/arm64/include/asm/linkage.h:68:
> +#define SYM_CODE_END(name)				\
> +	SYM_END(name, SYM_T_NONE)			;\
> +	99:						;\
> +	.pushsection "sym_code_functions", "aw"		;\
> +	.quad	name					;\
> +	.quad	99b					;\
> +	.popsection
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> #23: FILE: arch/arm64/include/asm/linkage.h:70:
> +	99:						;\
>  	  ^
> 
> WARNING: labels should not be indented
> #23: FILE: arch/arm64/include/asm/linkage.h:70:
> +	99:						;\
> 
> total: 2 errors, 1 warnings, 124 lines checked
> 
> Wrote EXPERIMENTAL --fix correction(s) to '/tmp/x.EXPERIMENTAL-checkpatch-fixes'
> 
> Do _NOT_ trust the results written to this file.
> Do _NOT_ submit these changes without inspecting them for correctness.
> 
> This EXPERIMENTAL file is simply a convenience to help rewrite patches.
> No warranties, expressed or implied...
> 
> /tmp/x has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> ==================
> 
> How do I fix this? Can you please help?

Fix checkpatch?  If you _really_ want, you could change checkpatch
to skip .h file tests when $realfile =~ m@/asm/@;

Otherwise, just be sensible and ignore checkpatch output that doesn't
make sense.  It's a stupid brainless script.  You are not.
> 
> Thanks in advance.
> 
> Madhavan T. Venkataraman



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1731A0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBLOlq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Feb 2021 09:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhBLOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:41:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB6864DD9;
        Fri, 12 Feb 2021 14:41:01 +0000 (UTC)
Date:   Fri, 12 Feb 2021 09:40:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] RFC: x86/jump_label: Mark arguments as const to satisfy
 asm constraints
Message-ID: <20210212094059.5f8d05e8@gandalf.local.home>
In-Reply-To: <20210211214848.536626-1-jason.gerecke@wacom.com>
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 13:48:48 -0800
Jason Gerecke <killertofu@gmail.com> wrote:

> When compiling an external kernel module with `-O0` or `-O1`, the following
> compile error may be reported:
> 
>     ./arch/x86/include/asm/jump_label.h:25:2: error: impossible constraint in ‘asm’
>        25 |  asm_volatile_goto("1:"
>           |  ^~~~~~~~~~~~~~~~~
> 
> It appears that these lower optimization levels prevent GCC from detecting
> that the key/branch arguments can be treated as constants and used as
> immediate operands. To work around this, explicitly add the `const` label.

Yes this makes sense. The "i" constraint needs to be a constant.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
> Marked RFC since I'm not familiar with this subsystem or the asm blocks that
> are impacted. Extra-close inspection would be appreciated.
> 
>  arch/x86/include/asm/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 06c3cc22a058..7f2006645d84 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -20,7 +20,7 @@
>  #include <linux/stringify.h>
>  #include <linux/types.h>
>  
> -static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> +static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
>  {
>  	asm_volatile_goto("1:"
>  		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
> @@ -36,7 +36,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  	return true;
>  }
>  
> -static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
> +static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
>  {
>  	asm_volatile_goto("1:"
>  		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"


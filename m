Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1B429896
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhJKVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhJKVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:05:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC74C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:03:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w6so4266952pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOvPlgGsvz1o68z30Oj8xU/y35om3WqFihLWqsrocn0=;
        b=XEKFjYPcCtO/4gw0r/5Y8TRb7p3nFOLX0v4LVEa93jgIxxXmIeo9Y66xIc2rkOtytH
         1W10eYvRHxq0Nq8N2L/06XUR/0oeTeUJlWpiOA134mffBfTDOSF3UOuvOSv/qvo/UqL+
         kfrTixXQn0vIZZIw5VXo0yXWfIy+O5POlHsVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOvPlgGsvz1o68z30Oj8xU/y35om3WqFihLWqsrocn0=;
        b=c+vrWTP/Wj564wmmkSyTyY8LxemhEoH/NHzwMa08du3VbxmFa5YO+kuNflMKtKFvyD
         YvPZiOmNrh58vWCK2TewpcI89O8LsVPoeQRJOhiJof4mbaM6VpXZmdu9Dtuhf0cSjlN6
         uSJC4glTKnvLx7K93mF3Pev7iu4eem86c1WMg3UjqCzUlSwFuLk1T2M4TPqCn6vfLqB6
         4xn1xVFNN136XHCptG+7YpAtGleKr83QjQvnrWWgg1snvu9iIzeJ8eXwMfArtzEnw+BN
         y7PA/TfQqDYD1VdQf9h9gYE51Ilb7JpU4QGjfjPnNCymE+cnG+FvKNEGxQCI8tUV/ij/
         wxQQ==
X-Gm-Message-State: AOAM5322nljitBYZbxve/IjMIh477VcbOyY84utwRlVx1BYSo9dhMJkJ
        mpqE3ppjAyYHtMRIb2UMa/46PQ==
X-Google-Smtp-Source: ABdhPJy8r9sfgD2lnXl9Go507o8uqoQ16Mr9lbA42rFPW5IwrKmvQ/VJRg6hcY5Wjro79XIUaJjfWw==
X-Received: by 2002:a63:5956:: with SMTP id j22mr19827611pgm.58.1633986207824;
        Mon, 11 Oct 2021 14:03:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm9131390pgn.31.2021.10.11.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:03:27 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:03:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Marios Pomonis <pomonis@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-ID: <202110111403.3C59BF77@keescook>
References: <20210903021326.206548-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903021326.206548-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> From: Marios Pomonis <pomonis@google.com>
> 
> Fix a bug in the ORC unwinder when kretprobes has replaced a return
> address with the address of `kretprobes_trampoline'. ORC mistakenly
> assumes that the address in the stack is a return address and decrements
> it by 1 in order to find the proper depth of the next frame.
> 
> This issue was discovered while testing the FG-KASLR series[0][1] and
> running the live patching test[2] that was originally failing[3].
> 
> [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> [1] https://github.com/KSPP/linux/issues/132
> [2] https://github.com/lpechacek/qa_test_klp
> [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> 
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping again; Josh can you take this please?

-Kees

> ---
>  arch/x86/kernel/unwind_orc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index a1202536fc57..8c5038b3b707 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -7,6 +7,7 @@
>  #include <asm/unwind.h>
>  #include <asm/orc_types.h>
>  #include <asm/orc_lookup.h>
> +#include <asm/kprobes.h>
>  
>  #define orc_warn(fmt, ...) \
>  	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
> @@ -414,6 +415,15 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
>  	return false;
>  }
>  
> +static bool is_kretprobe_trampoline(unsigned long ip)
> +{
> +#ifdef	CONFIG_KRETPROBES
> +	if (ip == (unsigned long)&kretprobe_trampoline)
> +		return true;
> +#endif
> +	return false;
> +}
> +
>  bool unwind_next_frame(struct unwind_state *state)
>  {
>  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> @@ -540,7 +550,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		state->sp = sp;
>  		state->regs = NULL;
>  		state->prev_regs = NULL;
> -		state->signal = false;
> +		state->signal = is_kretprobe_trampoline(state->ip);
>  		break;
>  
>  	case UNWIND_HINT_TYPE_REGS:
> -- 
> 2.30.2
> 

-- 
Kees Cook

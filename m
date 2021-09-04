Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476A400C55
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhIDR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237265AbhIDR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630778117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6lcQHSayde3n9IkdvfIrHZle4H+zzn24IgjkiwSRWcs=;
        b=WbZDWpl1ekuRB4uUHGfJyt7NfcbkHgDjICxSRwp5nHPbWwXaKF/LC0s4unrIkQ/4HgvrkX
        snwcNTZjZVMf7ykOqJEGG9MeU0FeJHqJ/EtZiEVXvSyZo79RWcPgZxhCLZXpbWPyyOGIrj
        UjAIO8UJOGI/U99npUBuAthFJbDxJKg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-XyoGkpWlMvGGf20obw8w7Q-1; Sat, 04 Sep 2021 13:55:16 -0400
X-MC-Unique: XyoGkpWlMvGGf20obw8w7Q-1
Received: by mail-qk1-f198.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso3855742qki.15
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lcQHSayde3n9IkdvfIrHZle4H+zzn24IgjkiwSRWcs=;
        b=jzOkbN5tzo+UOEzZkDaiJ3cjnYqZenqS0eqZdYZk9x+3bdrjN6J7bvZd8wxnRaX8Rz
         dHf2kdB72UsXMENdDM8HgZchE6jcl8Z4wXwbvBNWOslofLk5VBjLdI/GuE2/qs2P96T7
         +ZVqWLaO87tGo1K1DOTBXpfXp2hRXXgS0ySF8OGVDDKhPfJ7TS7IIu8U0dcniTqgexai
         3oKC6XVraKuaZ6EYbHuVxaMgybNVQrXPLBIu+HSoq0pHe7bzrnTJGurn+d212p5bQ9rh
         cp1gE73ot45YHd2FGI8vg+ihgjukSvFjh6B/9T0H9aNbMns16L50LHzGMdabUKwDYOzX
         gzUQ==
X-Gm-Message-State: AOAM531fhU9LUO/eQVinipWJphVg9pK/9+0sU0HMKehfZX/ZyKeSMxeu
        iIXyctl8gOIv5lTw5zV0+KUncbGVbyEezmQ3RCcz9exMr6gpwSa3IcoOUPInYWSWKUmQ/o6mCQA
        xnAEUsRVoPVI9Da+YaA5QtGMW
X-Received: by 2002:a37:f515:: with SMTP id l21mr4158594qkk.234.1630778115887;
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynF9Y6BjqxIWiaX6cDMwcVqync6czUcP+2+d9LbHh6ElU+IIqbVYZyvvi6UbQI6IemnJWkUQ==
X-Received: by 2002:a37:f515:: with SMTP id l21mr4158578qkk.234.1630778115683;
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l7sm2148433qki.99.2021.09.04.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
Date:   Sat, 4 Sep 2021 10:55:11 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
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
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-ID: <20210904175511.oijbn4f2tzghwk7l@treble>
References: <20210903021326.206548-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

I suspect this is fixed by:

  https://lkml.kernel.org/r/162756755600.301564.4957591913842010341.stgit@devnote2


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
Josh


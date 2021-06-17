Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE93AAA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhFQElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623904753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXAtG29jTxyW93s1DINERmZIv/hxZD6wZZuuCpDcgko=;
        b=C/bLVTW8iSqtpstlJepi7ket0d1ok0wBOim9o2Vx49ILSohPC2bTorH4NzfmQquwr8KwmR
        c6aHeo+8oXlyow0ADdHt3smpD21ZvEI1iFCQ9W/MDdVcCMwOM2QD7BIpCYJ3B4NUVrxQ/L
        r+H+AsfD7kTVO5wehiOrw1N98wqFKQQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-iPUvsTLbMROi0jO-TEfRUg-1; Thu, 17 Jun 2021 00:39:12 -0400
X-MC-Unique: iPUvsTLbMROi0jO-TEfRUg-1
Received: by mail-qv1-f69.google.com with SMTP id v7-20020a0ccd870000b0290219d3e21c4eso1254689qvm.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXAtG29jTxyW93s1DINERmZIv/hxZD6wZZuuCpDcgko=;
        b=qAiPZUfq1DLV6aRLht9EqdtYPTKFGV/ku8xgELWcuuLIaTiLYHGogx2OgrRtBjH2LJ
         t+KCsj7Nv3dICa57pZaL0UwObf/8L8rWA4yjeUUY7bLxDYb4xyLM4Rr3KYQKEMNVv/CD
         5zaIzfgPKeIDlyiwx7wDrXWqJQQ38vruavgx5u8Q4zkLunLBU/LQWF8gLK+NF8NVaVAO
         V23EezsTo7zthRkgNLjWXTqhWABcg6T6N54ACj90Apx358oFYJEU6V9I8O6S8mgkJyS0
         hEd9ToSbIU1VdnchWvKLQEG6Hkx3tCoNWnPnjN0p56eQStNI7AiaVBRZDo4OiA97eqUV
         APDw==
X-Gm-Message-State: AOAM533TFZg6Cn0PZrSKZ92mwC8Y6bFOsVM2/kiwAb07/5dmwvhQ2wfz
        6q6q64fRWAbLyY4MQgTUDiodX7ZG+xzj//siXnQi1F02MAnZjvwTrUccUmRnvCAeSKlR2q8BiFn
        m+kFoO5sCRQB9wh7MIcyp072x
X-Received: by 2002:a37:27d8:: with SMTP id n207mr1867860qkn.291.1623904751833;
        Wed, 16 Jun 2021 21:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMWx/7CL95CI6q7G8cEtMdsBBnM8Q9P5BgWg54jwMOBTYUfFvdo49kUzpZcnT9jQAsgHkqBg==
X-Received: by 2002:a37:27d8:: with SMTP id n207mr1867849qkn.291.1623904751617;
        Wed, 16 Jun 2021 21:39:11 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id q16sm2700191qtp.18.2021.06.16.21.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:39:11 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:39:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-ID: <20210617043909.fgu2lhnkxflmy5mk@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162209762943.436794.874947392889792501.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:40:29PM +0900, Masami Hiramatsu wrote:
> To simplify the stacktrace with pt_regs from kretprobe handler,
> set the correct return address to the instruction pointer in
> the pt_regs before calling kretprobe handlers.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>
> ---
>  Changes in v3:
>   - Cast the correct_ret_addr to unsigned long.
> ---
>  kernel/kprobes.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 54e5b89aad67..1598aca375c9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  		BUG_ON(1);
>  	}
>  
> +	/* Set the instruction pointer to the correct address */
> +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> +
>  	/* Run them. */
>  	first = current->kretprobe_instances.first;
>  	while (first) {
> 

Hi Masami,

I know I suggested this patch, but I believe it would only be useful in
combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
think that would be tricky to pull off correctly.  Instead, we have
UNWIND_HINT_FUNC, which is working fine.

So I'd suggest dropping this patch, as the unwinder isn't actually
reading regs->ip after all.

(I apologize for the churn, and my lack of responsiveness in general.
I've been working on moving to California, which is no small task with a
family, and in this housing market...)

-- 
Josh


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4C45CBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350604AbhKXSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:09:50 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:46008 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350720AbhKXSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:07:15 -0500
Received: by mail-wm1-f49.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2794938wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=12nEyDPdQY104trlboJVHkikF9Dqv57os2czAFrCZIo=;
        b=Llv+hZqljkrkl5Liownvp2gL1SFWYvPXAj/i/0LBH0iEynKgr3dEkVFVfyV0SPFWjt
         zA4TKks5xhJ+zPhe+Et9+9pCmliiwMLgCLSrteuye2gkah3IW3E4wL3kJ6GKVlp7JDhQ
         n1kewzgYgdMcHajh8BlXdmUoA9Ia2i+w5XkOsAxtSEQeGRdopyqpFLKO+CsdcRBkUNGd
         Je5sTd+cLqP7sVr/pu307keGPuTs70xy2zCQvAuwy6WtAJi2SGWPSq3mbbgmM8oybYUA
         EqJZCPnErs0T9A8EsKvBAOylF3XVzwYGT6fCyUsuyOXjNmHpGT3aCPefrRQZMHkpmQhC
         IAXA==
X-Gm-Message-State: AOAM5332VLI2t+/Mit2w6fbdSSnBh4OUAfRI1CFwlkhZybcLqGFHmp08
        zVx3u8QzRuJNrsX6+ylfs0c=
X-Google-Smtp-Source: ABdhPJw1n+UVyU6j0GU6WvHoGyUBZQxkTlsL7kk+SxeJSHAJbtKfJomtiuBkh6LclpXUFjH5xvacGA==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr18093671wmi.134.1637777044293;
        Wed, 24 Nov 2021 10:04:04 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y7sm472211wrw.55.2021.11.24.10.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:04:03 -0800 (PST)
Message-ID: <d42117da-f6a4-053b-c498-5686cc06aca4@kernel.org>
Date:   Wed, 24 Nov 2021 19:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] kasan: distinguish kasan report from generic BUG()
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 11. 21, 18:41, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> The typical KASAN report always begins with
> 
> 	BUG: KASAN: ....
> 
> in kernel log. That 'BUG:' prefix creates a false impression that it's an
> actual BUG() codepath being executed, and as such things like
> 'panic_on_oops' etc. would work on it as expected; but that's obviously
> not the case.
> 
> Switch the order of prefixes to make this distinction clear and avoid
> confusion.

Thinking about it more in the scope of panic_on_oops above: wouldn't it 
make more sense to emit "KASAN: WARNING:" instead? All that provided the 
fact the code explicitly does "if (panic_on_warn) { panic(); }"?

> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>   mm/kasan/report.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0bc10f452f7e..ead714c844e9 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -86,7 +86,7 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
>   
>   static void print_error_description(struct kasan_access_info *info)
>   {
> -	pr_err("BUG: KASAN: %s in %pS\n",
> +	pr_err("KASAN: BUG: %s in %pS\n",
>   		kasan_get_bug_type(info), (void *)info->ip);
>   	if (info->access_size)
>   		pr_err("%s of size %zu at addr %px by task %s/%d\n",
> @@ -366,7 +366,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>   #endif /* IS_ENABLED(CONFIG_KUNIT) */
>   
>   	start_report(&flags);
> -	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
> +	pr_err("KASAN: BUG: double-free or invalid-free in %pS\n", (void *)ip);
>   	kasan_print_tags(tag, object);
>   	pr_err("\n");
>   	print_address_description(object, tag);
> @@ -386,7 +386,7 @@ void kasan_report_async(void)
>   #endif /* IS_ENABLED(CONFIG_KUNIT) */
>   
>   	start_report(&flags);
> -	pr_err("BUG: KASAN: invalid-access\n");
> +	pr_err("KASAN: BUG: invalid-access\n");
>   	pr_err("Asynchronous mode enabled: no access details available\n");
>   	pr_err("\n");
>   	dump_stack_lvl(KERN_ERR);
> 
> 


-- 
js
suse labs

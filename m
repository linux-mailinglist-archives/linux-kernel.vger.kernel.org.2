Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2334747B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhCXJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCXJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:24:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80447C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:24:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so26833698edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+FGJ7/guNSO2yP3RvOrB7OOjjLpe/Yu+GhufYT7ltU=;
        b=YhJaFQIbbZNuY+xzGcZFOGQFzxwUESq5268SL+HTD5FOWx2xPRntw6bLM8kP5YOgO7
         Lz8BAFobwKW/07DHR1WaCSkuas0rFproVKa+xEcUYAd87qD4MsIXtAoHMx7XbweG2fIi
         v1DxUZYFMiSRC2Mr1Fkc9doToqEWY8owHqBEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+FGJ7/guNSO2yP3RvOrB7OOjjLpe/Yu+GhufYT7ltU=;
        b=uLHR4JDXg/yGJuZJ01TcWjrg4DUp3BlxJe4ZVvW1K7pNDZRDKNWYTl6btD4gNMFRaq
         NI64cE2mXcc423Rn1mej3bZ8xRlNldOCt7TRPgF4TFqRCPOsCW7IlKDrba/AmmwMOtl4
         IUP1NExhzsaEs3lZ7UIZe1GAzOVK1M57gePfn5pU77YMMLrhxDHFc4ykgrdilJ8mCPum
         JzDQQa4DTu5F0OLvlIR8NUBbKQAuv1PcZklDLzw4/EGkrtSPjCygqwwCkKKL1m7loH96
         lIs5ZxD1iy2vjAwMNEe99sF5ub3KQh5+NFL4Q0lIxBr3FKAXLqx0hy7jgVOb9jUhlyd3
         hw1A==
X-Gm-Message-State: AOAM530T3GuyDYBOKxHbYx7KI1OH1ochUrnkHpOvBvWn9p5c8gOmsZ1y
        JGh8AgUjOxcwrI+JqtTVNtlPgQ==
X-Google-Smtp-Source: ABdhPJxQ5nYH2NVaLQVfh+1oPdAv3q5/ZEZS8FtMejmfMSOb+x8qrS+4CMkV7sHQFwSUPXwUhv2iVg==
X-Received: by 2002:a05:6402:8c2:: with SMTP id d2mr2484268edz.4.1616577869156;
        Wed, 24 Mar 2021 02:24:29 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id j25sm859100edy.9.2021.03.24.02.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 02:24:28 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] buildid: Add method to get running kernel's
 build ID
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-3-swboyd@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7ef21ff8-8056-3b07-31ac-bc2de89fa7a0@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 10:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324020443.1815557-3-swboyd@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 03.04, Stephen Boyd wrote:
> Add vmlinux_build_id() so that callers can print a hex format string
> representation of the running kernel's build ID. This will be used in
> the kdump and dump_stack code so that developers can easily locate the
> vmlinux debug symbols for a crash/stacktrace.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <kexec@lists.infradead.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/buildid.h |  2 ++
>  lib/buildid.c           | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index ebce93f26d06..2ff6b1b7cc9b 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -10,4 +10,6 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
> +const unsigned char *vmlinux_build_id(void);
> +
>  #endif
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 010ab0674cb9..fa1b6466b4b8 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -4,6 +4,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/string.h>
>  
>  #define BUILD_ID 3
>  
> @@ -171,3 +172,21 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
>  {
>  	return parse_build_id_buf(build_id, NULL, buf, buf_size);
>  }
> +
> +/**
> + * vmlinux_build_id - Get the running kernel's build ID
> + *
> + * Return: Running kernel's build ID
> + */
> +const unsigned char *vmlinux_build_id(void)
> +{
> +	extern const void __start_notes __weak;
> +	extern const void __stop_notes __weak;
> +	unsigned int size = &__stop_notes - &__start_notes;
> +	static unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> +
> +	if (!memchr_inv(vmlinux_build_id, 0, BUILD_ID_SIZE_MAX))
> +		build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
> +
> +	return vmlinux_build_id;
> +}
> 

Hm, is there any reason to do that initialization lazily and thus need
an accessor? If the system is coming down hard, there's a (very very
small) risk that one thread starts finding the build id, is in the
middle of the memcpy, another thread also ends up wanting the vmlinux
build id, sees some non-nul byte, and proceeds to using the partially
written vmlinux_build_id.

Perhaps consider just exposing the vmlinux_build_id[] array itself,
adding a init_vmlinux_build_id() call somewhere early in start_kernel().

It could then also be made __ro_after_init.

In any case, if you decide to keep the current way, please rename the
local variable (just "build_id" is fine) so that it doesn't shadow the
very function it resides in, that's very confusing.

Rasmus

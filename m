Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C605379A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEJWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhEJWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:40:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E15C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:39:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so26858574ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kH1/lqZ2NQP1a9fznT6J9FoyYxZoXrz6MnF/IsF/LD8=;
        b=OIU8Pc6oDAnDeHaRZizpqtco+PESrEQcRKrfoct3xvNNzamiviTvQXnXZnu1/0a1qL
         qtwI6P+gZoHEGCl3lVFz4EszzhXNfaReWGEfg1OHrtMbfx3Z/6ssKMUSn58LtasxgzPg
         lYlRVUI/zl6SMsTQ6BvQHFcfn/eK0Sgf//CNz3vnuQZih/oPmwhwuKV3gZklxmGpANOv
         4mQqnvdTn0mctcyeAu65LExOZMzBdOlcFPHlF6D5WpC0slUZZM561kfGXPzv4bd3CBvC
         OosiQYZy2sRNc4eJzLC80kYejb+UR+jiVFTIV/hoORV/TDixQC75n1X07MfRPIAm14F8
         PyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kH1/lqZ2NQP1a9fznT6J9FoyYxZoXrz6MnF/IsF/LD8=;
        b=EUN7F6HcrSX1eYyGc4UrXy1Ef5rSMS9ZwT+/SQJlG7Lk3lo9aKMd+HqD1QLcUOW47m
         EJ8IlebGAkTsfyl/OUY7KPyH0wGvFRZ0eANUEf7mVKlpQDWxJbVwdmcveeTQrav3HRab
         EOtfr0Mh50Chz1OSGLxCyI/eyNTTZqehKsCnlR0R118hdbOqe/uqHB/J/DxMoeK301uc
         6WCmH88uwhgMpXp0FSLMj+nN9/vPgvbh+EanZwzXEsXWIaQQy7Qwxs9kBJVQVfPlSmpO
         HlGWKlutrEtwHldLGNymVqkrWvZpEtPbLM9nfysGWVfMMu9SXoF1QJnKFud2DJT/CRPO
         FAkA==
X-Gm-Message-State: AOAM530EWfJq9ukoQdkA3MFpHXyJOg98ufuca9VIoozNNxFXQii2gNOQ
        PXcaYok1WIJvKwWOCPi+DdddXtgC14/tlxfzjCEh
X-Google-Smtp-Source: ABdhPJxlvCV7PFOsLnBX3Na+g8t7Ve4oLOc7zDm2RO/5Nqb08hUq9UvLY1JOFhRgKMR4J+srbEqkAyyjCKBHNlK/AfA=
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr28108053ejb.488.1620686344212;
 Mon, 10 May 2021 15:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210423103533.30121-1-zhe.he@windriver.com> <20210423103533.30121-3-zhe.he@windriver.com>
In-Reply-To: <20210423103533.30121-3-zhe.he@windriver.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 18:38:53 -0400
Message-ID: <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall
 return code in audit_syscall_exit
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 6:36 AM He Zhe <zhe.he@windriver.com> wrote:
>
> regs_return_value for some architectures like arm64 simply retrieve
> register value from pt_regs without sign extension in 32-bit compatible
> case and cause audit to have false syscall return code. For example,
> 32-bit -13 would be treated as 4294967283 below.
>
> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> success=yes exit=4294967283
>
> We just added proper sign extension in syscall_get_return_value which
> should be used instead.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v1 to v2: No change
>
>  include/linux/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Perhaps I missed it but did you address the compile error that was
found by the kernel test robot?

Regardless, one comment inline below ...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 82b7c1116a85..135adbe22c19 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
>  {
>         if (unlikely(audit_context())) {
>                 int success = is_syscall_success(pt_regs);

Since we are shifting to use syscall_get_return_value() below, would
it also make sense to shift to using syscall_get_error() here instead
of is_syscall_success()?

> -               long return_code = regs_return_value(pt_regs);
> +               long return_code = syscall_get_return_value(current, pt_regs);
>
>                 __audit_syscall_exit(success, return_code);
>         }

-- 
paul moore
www.paul-moore.com

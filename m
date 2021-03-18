Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63A3404F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCRLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCRLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:51:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13AC06174A;
        Thu, 18 Mar 2021 04:51:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 11so3316116pfn.9;
        Thu, 18 Mar 2021 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UME5341F20O4YSlPgDYAA4Q0BzH+eMkJMlXuJ22FVc=;
        b=BhP42TPgrKM8T7ks3K4MByvG/Uj1dMnc/BTxc56ycY3yQkWUWyYjG7quVJQCawgxGG
         9iASnYetIYX6v8S2I0TDgHH8yCt+ULSqWcEUxlJPbUL49IYU9CdOZYNAoQQUBCWTTkmG
         EuhU4DhX4KKPjrWuFXGmSYUtXCSi6OyxsAtr3u7JGpvbVCwZEVVmyovQH3eDWZRk0LYD
         eel++qX/eusSnuUhn57NSiVDEQaAixAStweDR6fE4VzxfoPrBfKdX8pgkWbBCL5d9Eoc
         T5ZmewMUQJykriLzvIQlszG2H9QlWB4+egYkRK3xg4dTZOEpH1I4URKW6jWv/9J6mCPX
         jHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UME5341F20O4YSlPgDYAA4Q0BzH+eMkJMlXuJ22FVc=;
        b=V3/VjO1nFJWAu6gV7qivfad8kaTJVuhFm7rc89Kf0RN27gnX+pxJuABA0yEGffS2U2
         qHPfo5wHFzInZY3+IdGdFpOn0pjRfDpaVIiLVgj0nJrmrXvX9QF2a5QcwkV4cJ+Of44J
         ebhMGCOQVhVo5fr4nzLeR9IQ6nM2elEcAinWDi8FgZLYZhvvubh0lCEANZ0x6k+I6xb+
         IBw50Y8xlQ4Prk/djtKVOzjRV5+Zr59xacKZCZr3iMPj9HZBPF1i8H2R/W5IfPQxxA7z
         Y/2ylHoIFQ/JHOl12zjIAjq2z8uvojtbIoqqsb7Ym3lGs8svA04oHRs194bUdkyaj30d
         gklg==
X-Gm-Message-State: AOAM533AAD8hBaG45Fg6mLCbrKIJCMkTGnglNfRVBPvKQNs/xOiwP404
        LLjxrnZuTzmc6/lwWCnFRirRR1NAIwCzMxSqXJc=
X-Google-Smtp-Source: ABdhPJwW6yC52Fl0EWloY3PwXG594KzByYwrWjXmVzmSuLYCcQyA5yDJUq6Pob06NGv+ayCICHgM2WMqro8cgHOls50=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr3825516pfc.40.1616068290602; Thu, 18
 Mar 2021 04:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210318061250.8593-1-unixbhaskar@gmail.com>
In-Reply-To: <20210318061250.8593-1-unixbhaskar@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Mar 2021 13:51:14 +0200
Message-ID: <CAHp75VcnkrisWsf4SUjz+r8zybL+zYEGGi8thF_6AqSsxomwaQ@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/intel-quark: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 8:15 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> s/secton/section/

Reviewed-by: Andy Shevchenko <andy.,shevchenko@gmail.com>

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/x86/platform/intel-quark/imr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
> index 0286fe1b14b5..122e0f37b1f5 100644
> --- a/arch/x86/platform/intel-quark/imr.c
> +++ b/arch/x86/platform/intel-quark/imr.c
> @@ -551,7 +551,7 @@ static void __init imr_fixup_memmap(struct imr_device *idev)
>
>         /*
>          * Setup an unlocked IMR around the physical extent of the kernel
> -        * from the beginning of the .text secton to the end of the
> +        * from the beginning of the .text section to the end of the
>          * .rodata section as one physically contiguous block.
>          *
>          * We don't round up @size since it is already PAGE_SIZE aligned.
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko

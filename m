Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCE407B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 05:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhILDGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 23:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILDGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 23:06:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 20:05:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t6so7204828edi.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sd5WF+pIcO5DhcoFv/B3hGgVVb1vEUiUbaxcHE8vxMU=;
        b=B+4CSmBgsYiW+AwniIyTYkaAPXBby22GaaGzVbP5WI4XE6SNgGuAI2ywXMVO7Gt5Fp
         8WRHCCvJNyi/cki0pJhLfppO13sT/2TPS32KMgYOhYzUAfeaohf7qBlZi4POsT/uuMzc
         1+LkGID0kTpGpaFJpkrTxL+5kmesiZYp7HfZMTcwccrz0lKQdNn5Tm/n1rBKCl/L2Hkj
         bBiZ1mk46IaSGEu6oT/SZ9e0xm/dcBWLca4PpzXJvcKLusqTlEpnYMBOLfyd1YDXdjly
         y3NaPNUJ5EScxTYQhJg0sWKMEToNVOFZaUGFBnjVOlsHjSJ2P3/iOz4HI0ajEKKr/AUh
         hxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sd5WF+pIcO5DhcoFv/B3hGgVVb1vEUiUbaxcHE8vxMU=;
        b=Y5cK1IAH6yYgxXCmQF7tVPh8JtnK+iVwt/3W1ZDNaxbVmLGISl8JI2NYePSIId9nWZ
         k5ChuuWCQ9yChW1Ac1bOSas9LWv7qa1pyLdfnkN3gPGuaW+Wmyb+HkHO+5LZ0cucgWC1
         OZ8TECkPX87W/jc1bxRed38oUBeJzFN1cyrD8WuUrKKZkOnujd4vGP08Vs8DcSg+zgC5
         4NH7mR1zqj3if28gEUt8ROWVYCUguhr7y93ra7n156GiR7EJKWFB4UibD2Lt9sSFODv7
         4XB7/PbDby2GwkjNIdjOJf/BSkgPl4zMqj8GiQ/8Xf5ea/VtSFnZTPsfX0bgTO5arDOo
         FfJw==
X-Gm-Message-State: AOAM5313WXwYN/oGDz6r10GEbA29G1hM1Htv5zQ5iMPvvYFJM62wIkgV
        YKzt16D4WNoP0g6bl+6XgDo16knD0clTKI4Mp/Y=
X-Google-Smtp-Source: ABdhPJw7cIZLpKPkFy1iGfM4QfhtKcxAPMVJ4l/whWicwMKSgIzLcMG1Pvd4yZ1pMGu7o5Tyb2ZOh6o0yXVTnUwfemY=
X-Received: by 2002:aa7:d592:: with SMTP id r18mr6041634edq.172.1631415921224;
 Sat, 11 Sep 2021 20:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210912025235.3514761-1-linux@roeck-us.net>
In-Reply-To: <20210912025235.3514761-1-linux@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 11 Sep 2021 20:05:09 -0700
Message-ID: <CAMo8BfJ8f+4AmBD1B7J9vOp0xQbB=zRW-NyGZP6gTPTA-74OPQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 7:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> xtensa frame size is larger than the frame size for almost all other
> architectures. This results in more than 50 "the frame size of <n> is
> larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.
>
> Increase frame size for xtensa to 1536 bytes to avoid compile errors
> due to frame size limits.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ed4a31e34098..afad11e57d6b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -346,7 +346,7 @@ config FRAME_WARN
>         int "Warn for stack frames larger than"
>         range 0 8192
>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> -       default 1536 if (!64BIT && PARISC)
> +       default 1536 if (!64BIT && (PARISC || XTENSA))
>         default 1024 if (!64BIT && !PARISC)

Shouldn't that line also be changed to
  default 1024 if (!64BIT && !(PARISC || XTENSA))
?

>         default 2048 if 64BIT
>         help
> --
> 2.33.0
>

-- 
Thanks.
-- Max

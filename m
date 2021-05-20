Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40338AE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhETMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhETMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:40:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDDC04C3F4;
        Thu, 20 May 2021 04:56:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g38so22373388ybi.12;
        Thu, 20 May 2021 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtLuHF6z7UgNsxkYSCkrtjLaJueixWRiunK7AUVux9A=;
        b=qN+O3tvfeSsZLPGFWfKsDD0t5wX8hic7UDaqW1PTbFTiqWkCLKVuSEV20edtQIPjAN
         8ahdsffMecVwLQb3sOhht8+/1v+oz1Zu8ehQQzsaMEztz3EMLx4kWewmjns3nhkmuS7O
         NQTWiNgdD0u6FEpGf/rStUS76awzCsjKTGlh+T3YZa9xYU2dWZePF54jPlXiTMxtl4HX
         JVP+M78fgBC6X9Nr7Si86QsYWe3V8FZrsQC7c0KVsu5KxByI/VFo6klM+Jkgs6IZVgJL
         a20AQFnnlNo/LbVdAS2LvnQ59cfbF8WNhHgcHetXpQWZ19EH4hUqT78Ilaq3ruc3WVFG
         TTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtLuHF6z7UgNsxkYSCkrtjLaJueixWRiunK7AUVux9A=;
        b=eQYZQAdKtAZ3BgI/HMWeqM9nJn8VdPmyL1qXo2Cfz82t/sRwOOL0HVsajZkxloRrRS
         TXYEIfSxPBD5449Np00O9jeAF/PZeubCSTD9M+87U7L7RyRevcx8sw55mWSSkgaT+dO9
         287wV0kAt72mdzaKLHFrKQ1QHWMbi72anaVE4p8Is2tjmxJvm8CsIN+1YmtyeHtf+p1W
         G4L/VYd56axSVkcInNSVSe4IFoaSxIFeUKmK6h91d5/OehmhPnFPNxhMZB7zEfOAypac
         TDlCxvKzhIZdBtKJbP6WZLbfSrEzLgmxDt7ac7qww0PS0LybfxT+PsqWTWBtsgbBx11q
         vcKA==
X-Gm-Message-State: AOAM530rCWbTByfo5ko36hbLSoaf8e2ezyEIM9tS2jfB6BtT3Akv3RrJ
        0ZBv4edbKxWca/ACZx9+xORXwcpcFm2fRE0LOYM=
X-Google-Smtp-Source: ABdhPJyBD0p/eM/csawKlA4Hsro6iMvr3JZ8tWIUdHs2En0vB/vTvHKG4rvyyV4uxcS/JoDMWwqONzeiIMIRTk4DXg4=
X-Received: by 2002:a25:b112:: with SMTP id g18mr6696595ybj.281.1621511795095;
 Thu, 20 May 2021 04:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210520093949.511471-1-andrew@aj.id.au>
In-Reply-To: <20210520093949.511471-1-andrew@aj.id.au>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 20 May 2021 13:56:24 +0200
Message-ID: <CAKXUXMy0CziXXHJBzz8bJBj-wE0f6L1JSK2KuHwBzkbk_F+4iA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:40 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> While include/linux/bitops.h brings in the BIT() macro, it was moved to
> include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
>
> Since that commit BIT() has moved again into include/vdso/bits.h via
> commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
>
> I think the move to the vDSO header can be considered an implementation
> detail, so for now update the checkpatch documentation to recommend use
> of include/linux/bits.h.
>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>


Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Jonathan, can you please pick this patch into your doc-next tree? Thanks.

Lukas

> ---
>  Documentation/dev-tools/checkpatch.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1bd72ec..59fcc9f627ea 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -472,7 +472,7 @@ Macros, Attributes and Symbols
>
>    **BIT_MACRO**
>      Defines like: 1 << <digit> could be BIT(digit).
> -    The BIT() macro is defined in include/linux/bitops.h::
> +    The BIT() macro is defined via include/linux/bits.h::
>
>        #define BIT(nr)         (1UL << (nr))
>
> --
> 2.30.2
>

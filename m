Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D733B05D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCOKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:50:25 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:37385 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCOKt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:49:58 -0400
Received: by mail-vk1-f175.google.com with SMTP id s136so1408956vks.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cn0hjLBIKyevwPH7uud+eEnfZFG55NE7s3jjb3XGsvA=;
        b=W7Ekkfjf8nSvveX57BXX7ax6sIBPNMp2SgfQlWKh+iGUzQZtS0xpzmAelfUepdl0ln
         pOzCXpPv4c8QPYfxLryEntk4MglCLrhejnfphRdd9IuLq/+3E1FK0HPz52GMHmKEguru
         L5v0+lfIYHytBgGTMFqZBaK+sbOpogtE3aNt5dq/ZSwD1kRhwzkwynBiinEf6UNzEKxk
         6dTyu6Rk6zE5/RW5bZIvc8Wv/hstxBM/n+vFMDjUncc5Jm+4wNbYBZjlaUcp+1sB1/U/
         +IHWPS+eTY8SH3anHG5yzH/Dl5HZAFmSOAUqnA+e1F31dZEHPkY6WqlU1ICL4YccjRBZ
         aRYg==
X-Gm-Message-State: AOAM5301SPW+ios0jJt0oZMjwvLA9WndFnOLEEGeDQte/N3v8e4rm2kT
        yAFus872+zkjKfVl1mOpAxpom+Nf2tSBubXZNXd9AoQxz94=
X-Google-Smtp-Source: ABdhPJz/2sDUrzcpIsQ6biizvJmEwGiuZAGWwvTIIvT7E2fQOhXFFkNTN7gCCw4ooKjDvbhBVrDcJvhyw+mnpboooBw=
X-Received: by 2002:a1f:e543:: with SMTP id c64mr3902353vkh.2.1615805397738;
 Mon, 15 Mar 2021 03:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210315104409.1598822-1-geert@linux-m68k.org>
In-Reply-To: <20210315104409.1598822-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Mar 2021 11:49:46 +0100
Message-ID: <CAMuHMdVJFprsj9njwv13jWTBELuq8RcXOmR7AoR9dqDdydLcNQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:46 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.12-rc3[1] to v5.12-rc2[3], the summaries are:
>   - build errors: +2/-2

> 2 error regressions:
>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_248' declared with attribute error: BUILD_BUG failed:  => 320:38
>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_249' declared with attribute error: BUILD_BUG failed:  => 320:38

powerpc-gcc4.9/ppc64_book3e_allmodconfig

So we traded implicit declaration errors:

  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'disable_kernel_vsx'
[-Werror=implicit-function-declaration]: 674:2 =>
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'enable_kernel_vsx'
[-Werror=implicit-function-declaration]: 638:2 =>

for compile-time assertions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1343382F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhJSOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:16:58 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:43972 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhJSOQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:16:48 -0400
Received: by mail-vk1-f181.google.com with SMTP id u206so3555579vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7OXO0cTTPDAmdC1CM/ZvjOOYwFvCUDeRh1FJ6rmnQRw=;
        b=sP1JuCnwpJde3+5v75/Mzg+TaV62/CTAzKatG60sBcFJeFkwPG/MJmHgzzZvN+zcJS
         aJwKuq2P/0uZhB+leemjdsbYItMlECn3zfk+nuvWRrWbMctTITV7eMMBnu3H37tHjmtb
         m0I3XdMSXZHRDtRvgN80twJ0/0wubQnIknKSbpn2sEy+Jbp14KCObeAKr7jmRc4UB28s
         lq7XyNgXGsZR/dcJtpwp1O8FES/OhDoYrJ60qqX/mEE5ZkPK7D7c2u3Wd4XfdSdQuafL
         Mniz2wucvnWT1uKFd2XEv54Uq9GyB+JAipSRIC8FGESvqr7o7WlW5gFnsRgOU7CgzHAU
         IOgg==
X-Gm-Message-State: AOAM533zCU41ugmObACUQiHMHcAuV/OdMz9Aq2Py2/u1leLLK2i125tG
        K+gHqPouR+jVSsSBVgoAdISwj4QNLGeyzw==
X-Google-Smtp-Source: ABdhPJx9SkS9+gwGkq5pFV4BTiZX0EhsKRDAWMU9+20+BD9A7iBPWfhG1uHelXqNDbCXpAksi0Yd5A==
X-Received: by 2002:a05:6122:168c:: with SMTP id 12mr27693419vkl.0.1634652875346;
        Tue, 19 Oct 2021 07:14:35 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id u13sm3737608vsl.11.2021.10.19.07.14.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 07:14:35 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id f3so112742uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:14:35 -0700 (PDT)
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr112089uac.89.1634652874854;
 Tue, 19 Oct 2021 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123335.3391283-1-geert@linux-m68k.org>
In-Reply-To: <20211019123335.3391283-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Oct 2021 16:14:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZqN3WbuVEm4mDnPG-tJRFYZ=FwQOKK7r5zK+f36H+3A@mail.gmail.com>
Message-ID: <CAMuHMdUZqN3WbuVEm4mDnPG-tJRFYZ=FwQOKK7r5zK+f36H+3A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.15-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 2:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.15-rc6[1] to v5.15-rc5[3], the summaries are:
>   - build errors: +2/-4

  + /kisskb/src/drivers/spi/spi-tegra20-slink.c: error:
'tegra_slink_runtime_resume' defined but not used
[-Werror=unused-function]:  => 1197:12

m68k-allmodconfig, parisc-allmodconfig, s390-all{mod,yes}config (fix available)

  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10

um-all{mod,yes}config (fix available)


> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/519d81956ee277b4419c723adfb154603c2565ba/ (90 out of 182 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc/ (90 out of 182 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

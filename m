Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9B4024F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbhIGITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:19:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIGIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:18:58 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3sye-1n5gp447n6-00zrwp for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021
 10:17:51 +0200
Received: by mail-wr1-f47.google.com with SMTP id t18so2392396wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:17:48 -0700 (PDT)
X-Gm-Message-State: AOAM5333FfVtncRDYHCet4WwvSBjGz7/FeNyKUasKq0niOXNeTOMy8Pe
        FJCROFqdOlI1STny7uCh9cUn4R6sl3PHU75SRkY=
X-Google-Smtp-Source: ABdhPJyiTwB42Ik9Nd62RhRczNyAg0nbb/ltMSwY4nNsSbCmZOvOZpJebJwSFy4ShYpdcFJayx1+05VvpIVcJPUKXQE=
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr17191037wrv.71.1631002668640;
 Tue, 07 Sep 2021 01:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210906194917.376116-1-palmer@dabbelt.com> <CAMuHMdUtg1qA7hx-QGGwd6nfe_vDEzoH95732T736FPH0Jb5dA@mail.gmail.com>
In-Reply-To: <CAMuHMdUtg1qA7hx-QGGwd6nfe_vDEzoH95732T736FPH0Jb5dA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Sep 2021 10:17:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2R=GhAjBNjKk7hs6E7Fr6j3yAbSvf29+TdiZtpsSgisQ@mail.gmail.com>
Message-ID: <CAK8P3a2R=GhAjBNjKk7hs6E7Fr6j3yAbSvf29+TdiZtpsSgisQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume
 unused warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:frjT1zc6wkJ0LfHg5LVnCSJUMFSQyIJELUTauH/IC4lHxD5K3Y6
 IGnEFLYv8MZRO6GUbvfU32pNE5ly38zmgWc+jX2dW47JVwqJCm9jxLJa0uGh95UBCCWBmMy
 0+MWwWCE0MBKO55CUk7FSCSdYVGrVjfgruKQx9nnW2BzSgbac6A+6GmsNuuvcEyftxXJurY
 cBtKfDSlp+otxG/1uGYDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jkk6WWd73Yc=:YjKpsB0EkVKvIoT5hDPGVf
 8CG5VxrDoSF96SsTxW/hMUbAZPVHZf1YcQST38LIoS2Xp6fr3b/taPAcF/olfciRbozNZfZZc
 nWIyVqR1GVucpfrxMiJl0sp6orSXTqnSwPPk5tVkZZ9Bi1U5bHgFBrk/u2Yn0mW/RELzlai5J
 Oz4p8WXeHOnZ+318eLFKN3DeAyDAsAIioGryuNrVzFvsseqExPQTYLLtA8LftejERfCsJTXLr
 BfcLmnQFXk/clKGOww8asVZWxDyPvcjlnQWLmV2kEg5iY4nODpPM4kti7lBqvEeIlsdDYK+KH
 ICzjHlpsqUv5UIY3OSEP5h0gAN12CF4Q53Xa6YRvh0LtiIMcUJjdjNZcXv1dSUDCQRxNYi1QH
 HIDvHnunIXGSH3zGdzUWfoVYY7EBHNPHSBWIzdcVeJhoTAG4LIKiKyIag5wGUJGZfZ+1oSgGs
 MbNbS8rePFf9U6YnwD/K2OjLXXAuZXnWMlI3voYCazb5XMs6HnAXQXLfXhEW9kkyXBUf7uQy0
 xWvY/Q5IZw9ViW8deCdCfQcZIiTN2+PlMfgXnfnOG5Nyk3MxYjJ+g6bRuikLYZwii+Xd26LOm
 sDCLuKVdJVy620uZ7yHFWA9OpcP073I1qsL1S2JNmkKVEwcL2oor4/77t/paoh97APjlGp7qV
 IkjpAt3XQ0l6IZ9tBUQ8yyj8yrptBo31EmfDwjFxRqppxkfFJtSA12CUw/h086BwH9TdVvj2f
 v8ex+A+wMQCgNTaJ/2qTRE+p7bDBig7iWQiAskFNnhcIonVxNckyXKrpbZl1yhY4PTkQiMK24
 ZqGQdG3GIfugemqUQvTQIpiMHczZwcp+Rt6L459K63cHwgVlA0h/GkgQVhsC+O8DoQ01GdeFI
 xKdX0F8UenpIe/hB4FoA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:02 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Sep 6, 2021 at 9:58 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > From: Palmer Dabbelt <palmerdabbelt@google.com>

> >
> > +#ifdef CONFIG_PM_SLEEP
> >  static int cdn_dp_resume(struct device *dev)
>
> An alternative solution would be to tag the function with
> __maybe_unused.

Right. In this case, both are correct, but generally speaking I tend to use the
__maybe_unused variant because it's more reliable at fixing the warning for
good when there are additional functions called by the suspend/resume
helpers that now become unused in some configurations, or when you pick
the wrong set of #ifdefs.

Having fewer #ifdef checks also helps with build coverage testing when there
is a warning inside of an #ifdef.

       Arnd

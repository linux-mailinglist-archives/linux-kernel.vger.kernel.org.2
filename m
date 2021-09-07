Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61D402BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbhIGPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:23:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345019AbhIGPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:23:43 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5mSj-1n2aSF0CeR-017An7; Tue, 07 Sep 2021 17:22:36 +0200
Received: by mail-wr1-f46.google.com with SMTP id t18so4286991wrb.0;
        Tue, 07 Sep 2021 08:22:35 -0700 (PDT)
X-Gm-Message-State: AOAM531Qj5eAw082QSGq2LSDC9NOTCV/5nBOC8L2hA7BCC+/VXXbLwoT
        gV1hOIvFb2DS2s0HJpRMedZfa6Pph+Nt8m35YC0=
X-Google-Smtp-Source: ABdhPJy58uScJqBW+UrC1EYruygZaDSlaishAvDFwCVWkwTrM6LrtBlVbOuI4LZO9PhoP1L02EP4ZshmBSt6whgyAaA=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr19521551wre.336.1631028155500;
 Tue, 07 Sep 2021 08:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210907102722.47543-1-bert@biot.com> <20210907102722.47543-5-bert@biot.com>
 <CAFr9PXmCKPfdHnHU7=ALh=j2SDf71ibd8kEnLTK6aPN1vmQVdg@mail.gmail.com>
 <CAK8P3a21N8khjyV-f=p28ZogoakhLTrkoPBd6PeXrigba=7-TQ@mail.gmail.com>
 <CAFr9PXn4JXGKSCDNeKMJDPgfezktyfBsTcq8GErt+ROuumDgrg@mail.gmail.com>
 <CAK8P3a0y0PhmOdMPnx10zG6s6RfiuC9Ju9s5SMnOk8oZ+cAFMw@mail.gmail.com> <CAFr9PX=Oi-HJYUFBfJn4pHUSk=drf7otyx473hvq1UC5_gaTHQ@mail.gmail.com>
In-Reply-To: <CAFr9PX=Oi-HJYUFBfJn4pHUSk=drf7otyx473hvq1UC5_gaTHQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Sep 2021 17:22:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xZjg-SFs-bjtOrWMi5H7Ou4eRGsUEmy4XQUXqej+M9A@mail.gmail.com>
Message-ID: <CAK8P3a3xZjg-SFs-bjtOrWMi5H7Ou4eRGsUEmy4XQUXqej+M9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: Add basic support for Airoha EN7523 SoC
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bert Vermeulen <bert@biot.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rQn/ggVZMxa0impJfQu8ANKJ9Dp7zg0dW2eal7JvpWIuEul96Ar
 Xkr3e0hnz1cLDzZGn+sApKVyW1IMpPGEzJq6V5YWxQHyIkkCUtdRSW91FAK//0nFNd1sauu
 0cZlJFVgQ9DrCUqAj/EIFb09cqN2HOAbM1p04UFUBphWUYZ/QX7MlI7qn1NG1py4UUqNU+L
 Ap67sOktLDWI2IZCcclIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pyPB3Zm4iTE=:2bqXNR9fPUqGjkg6buYqX4
 VhRN3wA7ve8Fed0iN6H2fdosLHYx2IvCcwFbk1TwB4NigdPVZO9czH1gUfcF2ztr795zOOj8s
 tD9i4ofsEbIiKYTPdQojrf2Z79BLqf4splyTBekMSwJaqZCIUUx5FXpypoGiY3SxaniNW4FY1
 11LicF6Ke8O26wmCxWmc8q5zEE2LMinz2q9PWjHW+LnsSvtB5os+JiTwxz+odx9J2G2lpH2zl
 gzBWR7UxnCgzBkQQdtTkKTpnAz622rXkBIRit5r3bc6Zvyke8kLPMl3drjlL6VJzjNVyuXq5C
 cRR9MgFnUK7Nzs6dooS5nOvFqTfGfQg9e/vp9Xy1iT2a3Y1ZhW05AaXOzoGUOD+K6j3BgJV/4
 Et7Bymb2rt5LlmVnzpNtDNWY9U4bqVNdn+GLC9EHj7j6hZ4VetT/zKAV6r+zDHruIkrj9Y01+
 +loiYxtD8wZZTZjNQmjbsi8EFRnuMibGI4dLeD8ZGl2qLdpf/kz3xrU4LRvw66Svn/smQoFUo
 QICUuDDiFvlj/npZNit+J8I3B1Xm/R+Jwr7nxiH2S7TjPWryN3WBRwUB1u5FZyOmt1tKFJ/nS
 vSgzbIN6KDPRwCc+0rgqCsWR0DMnsg6qpJTeYISdpvXXSEKiD3i4ILLpAPiAsfgCKqVXCeY14
 uBW9Ca6FL3FVIFISQ72wpyQJoLBnxFYGfUMyEvEsjHK2ZrzY8zZXMlhQzmdbdpsfNJNXd6a/3
 JpcK21ITUoeFyw7L6ZuuJUBnCZvi/j6dz7KYZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:32 PM Daniel Palmer <daniel@0x0f.com> wrote:
> On Tue, 7 Sept 2021 at 23:12, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > I think the broken memory controller is still there so somehow I'd
> > > need to get the heavy barrier to work in arm64. I haven't yet worked
> > > out if that's even possible.
> >I think I missed that part of the discussion, or I forgot about it already.
> >What is the issue you are referring to here?
>
> Sorry. I should have put a bit more context. This is for the SSD268G
> not the original target of this series. But a similar situation.
> The SSD268G (according to the decompiled device tree) is the same
> hardware as the MSTAR_V7 chips but with a Cortex A53 instead of the
> Cortex A7.
> So it probably has the same memory controller as the MSTAR_V7 stuff
> and that memory controller is not coherent so it needs the kernel to
> make sure memory requests are flushed out to memory before DMA
> happens[0]. For arm I fixed that with the heavy mb callback. With
> arm64 I have no idea how to fix that.

Ok, got it. I do remember the Mstar SoCs having this problem. My feeling
is that this should be possible to implement on arm64 as well using
an erratum fixup with a configuration option, and possibly dynamic patching
to avoid the worst effects when the workaround is built into the kernel
but not needed.

Whether this is acceptable or not is up to the arm64 architecture maintainers
of course.

       Arnd

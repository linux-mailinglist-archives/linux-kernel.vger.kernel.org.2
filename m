Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060B40AE81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhINNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:03:43 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhINNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:03:42 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmyzH-1n9wgy4Ahr-00kBle for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021
 15:02:24 +0200
Received: by mail-wr1-f50.google.com with SMTP id t18so20131177wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:02:23 -0700 (PDT)
X-Gm-Message-State: AOAM533fqQzacpk+3M06+3bJvKijP7E4N7uiCsTrwCPfYQ+WoroDvGpS
        8/RksYp+imctGAkTrBcYsPsTnkYGoThvRX1lwv8=
X-Google-Smtp-Source: ABdhPJwm95UM5Q7Av+R9PlqLuMxx0U/oJySlVgb5nUIOOX/MOzSR3VFTVEUXiHX+MRSB+HYEGrwSl61hIAHxwKNWp3I=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr18133610wrv.369.1631624543694;
 Tue, 14 Sep 2021 06:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org> <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
 <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
 <20210914101327.47baun6mop3mc56j@gilmour> <c9b18cf8-d432-8636-52f5-a40a342135fe@kernel.org>
In-Reply-To: <c9b18cf8-d432-8636-52f5-a40a342135fe@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Sep 2021 15:02:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZBfTN-u1xtQx3TTFnangdyXc7B8wMtr51Mr6+aXvodA@mail.gmail.com>
Message-ID: <CAK8P3a3ZBfTN-u1xtQx3TTFnangdyXc7B8wMtr51Mr6+aXvodA@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f7u6EBj47ZlT/e8fzz7fBj9GGCTU65TiWvoxCczkll4V5LBg5nb
 gYmxvWn3E2+6j1m1wTCj68vA0lS1kfbsupiUm3E2VkGFVW5GXZ94Tn0mbOUbOm8TXujaJ9w
 PQvGlz9cF+w49c1AztfPHw4H0cucwJa2M+xcVMfjrKTvgP/3fB6T73rReuSEYt9jiPBDKR9
 FNbemJr2rChSydrQVh4DA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZiMCxseFrs=:q4vSce1f+OHRm3fWVo+aWW
 wklUP2xQmHx6iWUPcbYA06nI1GUhxEwsjBS+r4mLBGjuH+Za7QBJn0zgGnyrYJl+h7B1tK1l7
 n7rZAhI1/LQh2iNAsT6HXFE5jggLsKP4GqHGpN4pAOOeYnH4BP8l8Ako6fOHjUsOMEtqKlCD4
 oV/jpyekppijI9AcaW/8QWpKDY9wrdJiMDJvp7YGzsEExXKfVYcupRSMd4e5XZGDxdZtuj2h4
 GXJTUozGwIHnkPRlctklYnzDOBWFJf+fcs8ybMuhPpeKpIdvQqSWXhyU5tvpcQ7cNAQyLeM2U
 nc/CzzvskAxJ8bpFZS0aO/G7bRnj4OJCLOmGN9bhXIiMsUNcaRUYGCNMycS+dER+cNV7/eRdv
 xYSsOTUXBPrc2iR1Ivgw8FXEvJx2IENw6zG5+Fc7wzVUjNR+XFHmSPQTnRzTJytIGUq1AqGzp
 18hk/CdZACrplPcNVUGe+xU6qxN9M+7tTlE0p8WwJIc9Yv57qxZm2wEsZCmVahFEKQUw0H33m
 tOZS4YDAtPUhsUtgDlazo5hXR3iBwwkX3UHNGB+0GD3VfwGSXHpjEXx5J6LCD36Bj/s4CZDQC
 9UdI/2dknJvRMGGQn0qgbNHazZTHKM9EPGU8jm3lIq+6BnuuNBUB5GwY4L6VtKeTbHmniNV7R
 g9L3WgTaTrdmRbBMpG8zywTDSHxcq1tH5fdx326u+cLh4nBqINNDfgmbEXcC3BhM964D2vt7c
 Q0yNZYgpQlGVO7S7pD95DDsz4sS/j4LTIw3vi7wbPx+1ClHjXNgbXpua03zME/GwTFsjnt6a9
 bPenoz23NW8ctGnv67DqXW937gjZ71jn2517XdHe3Cyam8nFbllbGQpJMed3XBXGuQreY1a7h
 fI67zUitkzvlPeFSsigQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 2:11 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 14/09/2021 12:13, Maxime Ripard wrote:
> > On Tue, Sep 14, 2021 at 12:07:08PM +0200, Krzysztof Kozlowski wrote:
> >> On Tue, 14 Sept 2021 at 11:31, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> Some subsystem maintainers want drivers to be selected by the SoC
> >>> option, this is why you need the 'select SIFIVE_PLIC', but usually
> >>> the drivers are selectable with a 'depends on ARCH_SUNXI ||
> >>> COMPILE_TEST' and enabled in the defconfig.
> >>
> >> I would say selecting drivers is even more useful for distros and
> >> other downstream users. Especially in the ARM world where we have so
> >> many different SoCs - how could a distro person know which driver is
> >> necessary, important or useful? Having all main SoC drivers enabled
> >> when ARCH_SUNXI=y, helps distro a lot.
> >
> > Imply, maybe, but select is far too painful for everyone else.
>
> If we talk about UART driver, then sure - imply makes sense. But if we
> talk about core SoC components necessary for boot (e.g. timers, clocks,
> pinctrl), then select is appropriate. There is no point to enable
> ARCH_XXX without these core components.

Please never use 'imply', this is functionally the same as 'default', just
the wrong way around, like the infamous 'comefrom' instruction
in programming languages ;-)

I still prefer using defaults and defconfig files over 'select', but I can
see the use of select in some cases, as long as the symbol you
are selecting is not already user visible.

        Arnd

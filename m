Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33A240AB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhINKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhINKIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1404561159
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631614041;
        bh=Ik/HLIOub9MljzeBlj9WzGBM1qaqzGDYRzAzALcEBf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EESCAmiKJOFXDlf0cjh3Pt9Bf4IH8B1oF+P2To5IyihBuwrVd5uHP6CIdcMaOyAYq
         yPgMhDktoLsUaiQGZxeswuycykDrW/DDo5aUP06Wy4eo8DMMl/7QAGT7z97L10Lrjw
         qb/S/vdzYmona5dULjtZGA8b22IDHKzn4a6yo2rHWXUEP1822q35acraOYIgCJqcLg
         TodyyWdm3VLU77JRTkC6/042ZxmaO8I8NN1c3CIDYSWIZbrKaa8rhtPDx0JFIsiRAA
         rR1LF0EeAzdyF4/BZDD+TCuz1+ZSGT1QDp+9+H29SKmCI4Gbnw7lgk6AKYzfQ1roB7
         g47lhFmFI3uBA==
Received: by mail-pg1-f176.google.com with SMTP id r2so12210914pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:07:21 -0700 (PDT)
X-Gm-Message-State: AOAM530Sh+7mDy1BmL0t+qw5rBu8lR1WoYd5/mH1NneoSExkBg9DZp87
        etgu+g9nU2c5/YqEktWEr1ttMZYMjsVZhhpB/oc=
X-Google-Smtp-Source: ABdhPJx8wLgrCETgV5FCCkV03G8EWefJb0qDhmI+vFfJR48Z0saK2K+Y6DLCjdrZx7DsPvGh1O/UCwj/Efyf01dSQBM=
X-Received: by 2002:a62:ce0d:0:b0:438:71f1:4442 with SMTP id
 y13-20020a62ce0d000000b0043871f14442mr3980539pfg.21.1631614040608; Tue, 14
 Sep 2021 03:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour> <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org> <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
In-Reply-To: <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 14 Sep 2021 12:07:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
Message-ID: <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Maxime Ripard <maxime@cerno.tech>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 11:31, Arnd Bergmann <arnd@arndb.de> wrote:
> Some subsystem maintainers want drivers to be selected by the SoC
> option, this is why you need the 'select SIFIVE_PLIC', but usually
> the drivers are selectable with a 'depends on ARCH_SUNXI ||
> COMPILE_TEST' and enabled in the defconfig.

I would say selecting drivers is even more useful for distros and
other downstream users. Especially in the ARM world where we have so
many different SoCs - how could a distro person know which driver is
necessary, important or useful? Having all main SoC drivers enabled
when ARCH_SUNXI=y, helps distro a lot.

> If you want to get fancy, you can use something like:
>
> config RESET_SUNXI
>         bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>         default ARCH_SUNXI
>
> This will make an option that
>  - always enabled when the platform is built-in
>  - user selectable when compile-testing for any other platform
>  - always disabled otherwise

+1 for this pattern.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549BE44A7F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbhKIIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:00:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhKIIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:00:30 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MV5rK-1nBLJB1Yn8-00S5fo for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021
 08:57:43 +0100
Received: by mail-wr1-f49.google.com with SMTP id d3so31382054wrh.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 23:57:43 -0800 (PST)
X-Gm-Message-State: AOAM532VzhYvYc5gxysmOysTl6y1TkDJ8FoVAvLilCHuhdBj53+H0loa
        G1Uly/V7a2X+HqlFeE8L6fV8ETMdzspXjsf5Ri8=
X-Google-Smtp-Source: ABdhPJxOYX703uK6AXQHK5dh5jG7IAQN9VFUbVfnkw9tMVNR/Ayy1GnBPVJ0CkvgSbNoumTtH2lEYJvxHYFyV0+4bzA=
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr6937924wrx.71.1636444663024;
 Mon, 08 Nov 2021 23:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20211109060302.56362-1-julianbraha@gmail.com>
In-Reply-To: <20211109060302.56362-1-julianbraha@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Nov 2021 08:57:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3=LBTM=ZnoPyhGRRstdBy1iTMHEeV4C4+NDU8B_sbTEQ@mail.gmail.com>
Message-ID: <CAK8P3a3=LBTM=ZnoPyhGRRstdBy1iTMHEeV4C4+NDU8B_sbTEQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] ARM: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fazilyildiran@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DMEgb+/jz3kHpQk7k2eZZ98L8KRp5DUooTAUQ2s/aE3bBLX/tze
 96u4Qy3RxdsJlm2kyx3BA0oWH2mz3UEfx6fHVr3/J7t/FeQio2VdB3q24/udbNi3B/eeH8c
 X+kiBDP1diCydsdEnULhHhpP7dUUqACkJNb7N6lpPGqDLWnTc2LR2UKz2Il1B9CK7M+DrB4
 usqZ+5zN7DxQussKi/+xA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRZMSWbi1NU=:l8PEhCz0U38F0iLSHC5Tzb
 912xcS97PbMJ12iwlfeKF5l0dDhE6jtOqz1TtA3fV1iPyoN5X4JfMn3s8zhoGtEiHvdfUR4aN
 N3Uwl+5ElpKvViYk2ZpZ6Phg6/8+9cuj8wRvVLUVPdE5YxRLcn1nN3R1AVXja5JbZpt7vShtc
 F+clKPGQIww7Rxi/NPfBlcFH5NL4N/hFgZDcvy2j1+/KBovROMG5jydl+4mN0jVbXXXJVX8wS
 trluHBwqVpBlVBxqRbSEYoWWp//G8MWE+Q6nB6236CHcrKpMGCK34p2zd9Xuxzhj+/7YbFlOX
 TpuQU08Kjat8ZRV/l6FB+v3Jz1fGuMmI33jOwwaTvkYaO5xdzQZ2vhSTrEyhjozJHyT80xG66
 5nYmKcc6KOe9i5HlFxnOwarQRshSQWwddjBcTV7h+6+9exUBDv3TmwstrQgpmzBFxl4CzBu0O
 QCAIflFgLewuBWCst+ntMmYcpjq9MM39WW7a37I3cgd4z+yYocVDtwkwa9E96RbUbrd0wHaL+
 nnccOfwXzauBZ+XpzRLIuKbCJI/c1I8Si0eSryKfVHyCw6lWIs7Vbec8y6rvAgbpUGtKtPRdD
 t0Da9TF5dH9pLMPAoAmZaCjFRZR6EHhLijWpjRVPXpbGQ3RGr7UYrcjjvzq1Xqe2lsD6SjXhe
 rzWHMtd522o+dBHYLhiGji7rKCTCqwPS0Gb/+HOqOL4JJhIoqRDxxexWJCPM5koCpucA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 7:03 AM Julian Braha <julianbraha@gmail.com> wrote:
>
> When ARM is enabled, and BITREVERSE is disabled,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
>   Depends on [n]: BITREVERSE [=n]
>   Selected by [y]:
>   - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]
>
> This is because ARM selects HAVE_ARCH_BITREVERSE
> without selecting BITREVERSE, despite
> HAVE_ARCH_BITREVERSE depending on BITREVERSE.
>
> This unmet dependency bug was found by Kismet,
> a static analysis tool for Kconfig.

Looks good to me, please add it to the patch tracker[1].

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Please advise if this
> is not the appropriate solution.
>
> v2:
> Changed this fix to remove the dependency on BITREVERSE from
> HAVE_ARCH_BITREVERSE, since it isn't actually necessary.

This bit should go below the --- line. You can also add a Link: tag
pointing to v1 [2].

       Arnd

[1] https://www.armlinux.org.uk/developer/patches/info.php
[2] https://lore.kernel.org/linux-arm-kernel/20211029203110.8343-1-julianbraha@gmail.com/

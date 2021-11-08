Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F3447E69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhKHLF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:05:57 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhKHLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:05:56 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MSqbe-1nA03c49Uc-00UHud; Mon, 08 Nov 2021 12:03:11 +0100
Received: by mail-wr1-f45.google.com with SMTP id w29so14559493wra.12;
        Mon, 08 Nov 2021 03:03:10 -0800 (PST)
X-Gm-Message-State: AOAM532eDYCOSBAWCHrUZkB871X5ti5E9+qbuwwFWkn32J1KeVUqdYqT
        mWrs5INyP8z305x1yK72N2x9QN8zeyqcWDNUQKQ=
X-Google-Smtp-Source: ABdhPJy1erNX8fF7ulGvPd1TRxZV7x2ms9z1OT7kssRXLHNyHZBuyfkRsjeEk1P3lUSFJb32WfHLjmyqvlZVtzbrkHY=
X-Received: by 2002:adf:df89:: with SMTP id z9mr60460271wrl.336.1636369390566;
 Mon, 08 Nov 2021 03:03:10 -0800 (PST)
MIME-Version: 1.0
References: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Nov 2021 12:02:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-9u0wpNh5E--gMA_Qh0g9GvpL=SzL=278SqLeEp62cQ@mail.gmail.com>
Message-ID: <CAK8P3a1-9u0wpNh5E--gMA_Qh0g9GvpL=SzL=278SqLeEp62cQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add clock node and phandles for M10V platform
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cTnpR7Ea8geh6KC5sAHosJWU88s8ONzwgqd4huBgCzETNWKvV6I
 8ZgE64xECuUzFHBbILlFHg3f2ftiBOGDp4AO+lhiGq4fKpvdjwUIljtuiEaTLGZptS1HqQA
 w5IdDIzFfvmg6tnw2kf1iL4LxLuUKkGNkmBsrEobnxLLFN7Y+tHu7LRjHnySxX7YFER92SO
 0DXlm9OcCQ5iJ6EVcmQVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QaGgXqdfzss=:Hp3pUb2G1MgpfXp6WSlMJj
 Xn+sl13YwNE1Biora3cBmnXEi0WlDV00aT8UO4NR4z6dHKgqWmhNva64X1ysyFb65m7UbBT6r
 ixQAcdcqO9WGKT0fqN7v083OUaugSzveYQcK8L4xRXEU/NSn44SzEylg+eF2B36WQGid6yc8G
 33NYaj3MQbDuiEgT+wOvEqh40LRlJip0PtS0Odpr0wbWh14GlyV7aoGREr1SVrniR5dz1/Ax9
 t9B36NELPjfVBT6vC14l2+/qQPz/zpAQBkW35FLz3ItorKdO2BpHhdR2QeUGgZq6aEKpv6Wox
 lCx4XK3zXxxbC4nrmw7lwhZ6AhDRqTJbeiEjPrHEVaEDvn//MOZuFiMvU9zYEYBlDQ458LrJM
 kxEoiUZetPPhDhrob1Sa0sEwXbmFljRxVgBCV1i8qTUFHn6FqPdf01Ok6zqU101aP/DFUWAZY
 Oo//z6kpAdm7ho1hW39pl9eSAhdgqL5sbJnwUAkopHF7+nrp2YfEzX8LhQ3IyQ/B/pJFg6Kjr
 Iur2clCFGApNfWECK+FcVBqHQDaxf46K7eTHzw87O+qBokE+BE5NRj/M5ibfF7cQYLg69pOr4
 vX/s9Wliy4qN7x4+YgqRnk67AR5C8PdqLbhA5xZdBOpY098rh9DTlUO6MDGgtm86ajNWwH5RK
 jwZp05PuJdtr4zHxvpdNbMWRNT90G0XDMzIS3M4XsZ0DTm6yDMfGmETJMi09Gb/0c/g1dd4Zi
 cgdkeJX0x43xfi8T3SS69pjxoFVO4TiroDjoSWouGmWIJfb9XNXPxbRRLvlKk7aZSL2xo0IUY
 8LJibXuzk8QdDXAHDP3RzDy+8RO+5RI9VetCHP8wqQJoCvNxuE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 10:45 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This series add a clock node of Milbeaut driver and clock phandles
> to clock consumer nodes.

Thank you for the submission!

The patches look good to me, but I don't take non-bugfix changes
during the merge
window. If there are no other objections, please send them to
soc@kernel.org next
week, and I'll pick them up through patchwork for v5.17.

Can you also send a patch there to add yourself to the MAINTAINERS file?

      Arnd

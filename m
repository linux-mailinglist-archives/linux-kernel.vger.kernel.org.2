Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B103EBD90
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhHMUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:44:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhHMUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:44:11 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHG4c-1mJ3ra1TiS-00DHov; Fri, 13 Aug 2021 22:43:42 +0200
Received: by mail-wm1-f54.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso10511003wmq.3;
        Fri, 13 Aug 2021 13:43:42 -0700 (PDT)
X-Gm-Message-State: AOAM532q5U+A/fa+FgF3cfOIGK7uRaF/ixgMNazRWV0V9z41BYOpOSjH
        4B+aLwjIdlbB1BlQEye1oGzWGAEFEaDOsB+0qOg=
X-Google-Smtp-Source: ABdhPJwl2hbFF4zSYJjpxgH8sof1HQMAwDVUw2gQkq+zLsmWBDWM7SSxSZSBjZWCN0L1Zzg2Ae2KmGtEgC9aswK1kSs=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr4243876wmq.43.1628887421988;
 Fri, 13 Aug 2021 13:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com> <YRbDNInfG7caSr2r@robh.at.kernel.org>
In-Reply-To: <YRbDNInfG7caSr2r@robh.at.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Aug 2021 22:43:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QtpBq8i2_RhW=isLSNULc2z7DbjohZReMY+rhyXEbJA@mail.gmail.com>
Message-ID: <CAK8P3a0QtpBq8i2_RhW=isLSNULc2z7DbjohZReMY+rhyXEbJA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:b41h5jGw8dPfPW8R1ZC837Z4LbqEoQORnNycnEfL8fyvvXOjpRf
 6FDJ3hLhrrxqjPectcaVcsbsRGYn6r8YQfzVfZ0m8HnM5M8mFv5WnPa8hWVEdJLvqxQxfGe
 Ht48H/TIUKO7X3IJm0uO4FPx2ptCe8IhMjxuQNqELxGRaIYyxeePXoS0p61glWdGKpVaKg0
 PNUc6ym0fen4Aakfp2qsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qTDUN2Gd1ME=:OsrlnJ2PWoa6u31I1qUkmD
 IMJQZ1O8W/a5jwmsgpvbVdS7YWm6Fjb5rJew3mFs29BnD8YjxRZnxlgMlIl2rtV+2+pURW+nA
 qp0y2vixKhxndRBxxSRJGx508v0wVtejZkvstIzadG9G+Yy8g9ivOUT+jUin30ErCVGKXfptz
 OIFhz9TjbeyY7TzX3OBD9/oqDdbXQBuU/IQ83ECSApaKPlYmS7qTKYNQtm2cZCxeXERi+Tc/6
 VqmQOyIDE+XDGWeqK+3LqGNzRAVaSxvgP5M8Zfl7Kcr2l+ABg6MUuoV8SZ7lK0ys+dP8jZPSr
 sEbjGcw9WYqidNbss6odewcIlYvytMdPccpX+Ow7TZpzZd7AcD8Ltx6zdd0Erj+1w6wpireIW
 vu/yoIdcn5iS2DlPIbJulfMuegDhe7DuNHDGBU4otR6ym8QPRnqGlK6Jn/MeqV8v/6WXH6Oai
 PcXXPa8nXq862Qs+4boUwez/SL5W5f+sJbHRo88cTDPrQbMe5oRJmy3+Rl1a9wEb1T65Nt1LT
 FqeUt85AzL4NIWR+hOC3F9ptmrBxtjkt2yeNgNh+zJAvkMnSJEhhdbbVce7PgJ6prr8aS43Cr
 IQKf6kIBy4Kzg7YXGhZ/xttHbKjtCqiSPiEB+1xyzBy3Xh+SnvI8Ir2vyKxxGrx9XXa1MeBlD
 0QrklWKQ8Y9rhbX/PHZlgmA5RX5UIfK+lPBWpOhYy9GuJrTPLtQGzTG/ZGaIJqdovrcia/rAX
 fQdKKM/j2QS5u2idlE75IBuUSm8M8AZgSwPUuXdixUxmPCKT35zbq/YNJ9MMSYIwsNG69gcwv
 8URJRNVcJoWGp6Qguka5c6uq+RwdIJxzl4rzuHACjKq5QMzWokJqo6GrG7cZzNMOrN5ZYNQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 9:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 06 Aug 2021 10:26:35 +0200, Krzysztof Kozlowski wrote:
> > The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
> > file), is uncompilable and untestable.  It was added back in 2018.  No
> > user appeared since that time, so assume it won't be added.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  .../devicetree/bindings/arm/syna.txt          |   4 -
> >  arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
> >  2 files changed, 177 deletions(-)
> >  delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> >
>
> I assume Arnd/Olof will take this.
>
> Acked-by: Rob Herring <robh@kernel.org>

Sure, I can take that, but it would be nice to hear anything from Jisheng Zhang
about this.

I can see that the only two 64-bit Synaptics SoCs are as370 and bg4ct,
but both of them have apparently been replaced with newer versions that
never made it into the kernel: as371, as390, bg5ct, according to press
releases.

Jisheng, can you clarify whether you plan to complete the as370 support
or add the later SoCs?

       Arnd

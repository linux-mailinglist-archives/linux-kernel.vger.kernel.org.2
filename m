Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAD3F14E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhHSILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:11:21 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhHSILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:11:20 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MatZr-1mnUyn21db-00cQbx; Thu, 19 Aug 2021 10:10:42 +0200
Received: by mail-wr1-f48.google.com with SMTP id q11so7669101wrr.9;
        Thu, 19 Aug 2021 01:10:42 -0700 (PDT)
X-Gm-Message-State: AOAM532cIll+NgEDgnAbBXqpL0z119CirZt+o3tmGd+ylZ7eSfdBYUtx
        NddaINxn4qkF/mLxf4auj4rxtR4/mH8AOwhsDno=
X-Google-Smtp-Source: ABdhPJzjr1/SHbPD5njJZaSOkLUQ4aCm34IcHdRpLpWUm+jUI5kJXVJkW86n5fnIkU19iNTtvoF4FwCKOo0gHQPTRC4=
X-Received: by 2002:adf:a309:: with SMTP id c9mr2155130wrb.99.1629360642151;
 Thu, 19 Aug 2021 01:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com>
 <YRbDNInfG7caSr2r@robh.at.kernel.org> <CAK8P3a0QtpBq8i2_RhW=isLSNULc2z7DbjohZReMY+rhyXEbJA@mail.gmail.com>
 <20210819143735.5171af23@xhacker.debian>
In-Reply-To: <20210819143735.5171af23@xhacker.debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Aug 2021 10:10:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jk-iGC3UjB95A50hFxfJGaFxq8cjGm22aKZU7HVK-dg@mail.gmail.com>
Message-ID: <CAK8P3a3jk-iGC3UjB95A50hFxfJGaFxq8cjGm22aKZU7HVK-dg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iAd6iPM7Tny8u4TIegge0YDwx3e+GKxlV9R9ymALpzSFTlZZmua
 igsl+V/zIheg7aha36LwxXNfgYtqPeLwVryHOILe4LL8ydUyoS9iL90fOtOYmR2YZ/4l8Wn
 kxuK800/Mtp2RRG1NKFrQ8QyHpgmP3I3GSWqymcNQkvS6MAsutjCrTp3l7qTMUKivOv64US
 NLUDZ2zZ5ndYxf+++X4Uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Abxkg07Blfw=:NlzlCR+7Fuk+DzibjfAhDs
 5g0BVQ1uQgBFU2pXLPtTEwFxrWNYZYE3oO8bd2G6tO5iVcHjJv7UWemID5j2w5ybTjjh4O5jB
 nh/FTVg7SESMwpQWjKIJ/gfZz7sWUgv44zbM92iDvARjYfbZLz0UhWsa5wI7YwHWY483odRHU
 IQO5aXZp2n7ExWzWog6YnUEb05nKbuookcHRqbN6rgImU514itofH2WXBN95GuKp+7/RIxofr
 1Aelw+KdYog1IX+Rdc0HDh9HShLUswBonpGtllHa30MslrHEp8qBQWKotanGXO/A1jXo4tgHO
 2YCBW+73JWe/4dPaq3XfcZnoRi3dD6CGvo+gOcx+mx+MwJzrTp0LYVVbvQVrEgRuhsMoQI1h3
 SqfzrLa3/4rXT1aiKiXtDxG2AI+1dsbW3siN5qS09IrUauVBVYADTJW0vuzVXc7JS/K+glKBo
 Tm17Mk6WAQFveL9VbiqjK3PDcyE5cZDrORcUNCWP9BcChnByuoK+y3kEY0eQQjQqlXKThcYNd
 ib1sOa28YS7T0c6B+lfKOrnaeyay4hJpEnx2AV9o8mvsAkC57qhchm803D5QxEE1bUmaYJm9Q
 TqbZ/eOU/zkJxaRRgnROynegjP74xTtwZSrk8qU+Y1K+YZIbkb3Xl5ITLRbQCpH0q0sXErh1w
 w4MyCYtaulZMEFX5JC6AF1ewjx90EEA6BKqNTo1cNqpYXbPt3bAc1xxtMGVWgMG9RlkwJ1qmx
 y8PPm1MHvPTYvGvfXA/5mO9IK5IA3UFyVRHSxRBORg5WfytdgFM+SgyPG4Ct4D6yLZP5dmoEr
 XAFKamBXrBnlXTPd9m+ctVoVOnjKp/fsuzbW6G9+oawlrGGh2NIWM0AZu1nW4ETC0KhSKYR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 8:38 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 13 Aug 2021 22:43:26 +0200 Arnd Bergmann wrote:
> > On Fri, Aug 13, 2021 at 9:09 PM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, 06 Aug 2021 10:26:35 +0200, Krzysztof Kozlowski wrote:
> > > > The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
> > > > file), is uncompilable and untestable.  It was added back in 2018.  No
> > > > user appeared since that time, so assume it won't be added.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > > ---
> > > >  .../devicetree/bindings/arm/syna.txt          |   4 -
> > > >  arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
> > > >  2 files changed, 177 deletions(-)
> > > >  delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> > > >
> > >
> > > I assume Arnd/Olof will take this.
> > >
> > > Acked-by: Rob Herring <robh@kernel.org>
> >
> > Sure, I can take that, but it would be nice to hear anything from Jisheng Zhang
> > about this.
> >
> > I can see that the only two 64-bit Synaptics SoCs are as370 and bg4ct,
> > but both of them have apparently been replaced with newer versions that
> > never made it into the kernel: as371, as390, bg5ct, according to press
> > releases.
> >
> > Jisheng, can you clarify whether you plan to complete the as370 support
> > or add the later SoCs?
>
> Hi Arnd, Rob, Krzysztof
>
> Sorry for being late. I was on vocation in the past several days.
> As for this as370 removing, I think we'd better keep it. I planned
> to submit the as370-rdk board dts two years ago, but latter I focused
> on Synaptics SoCs related drivers support such as gpio, pcie, sdhci and
> so on. I will send a basic as370 rdk board dts. I'm also considering
> to mainline basic support for a new SoC.

Ok, sounds good. Let's keep it for now then. If you have the dts file at
hand, please send the patch to soc@kernel.org directly so I can still
apply it for 5.15 to enable it for build testing, even if it's still missing
functionality.

        Arnd

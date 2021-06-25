Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964AB3B48E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYSpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 14:45:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYSpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:45:41 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3suW-1lF1aJ0tbE-00zlsI; Fri, 25 Jun 2021 20:43:19 +0200
Received: by mail-wr1-f52.google.com with SMTP id m18so11617254wrv.2;
        Fri, 25 Jun 2021 11:43:19 -0700 (PDT)
X-Gm-Message-State: AOAM530m5TLzHZNPkEwTP8ApghGu7WLoOqZ8FvvjVHtz7n8yKZPmHw6n
        RhxTgQT9ZDY38J65QlH3yTeU7AMzjDVLK1zYL8w=
X-Google-Smtp-Source: ABdhPJwEXB6pH4EHQ72kI8pnEN58pZxj/e6S9sYcBbs1qDXwS2ssmZPovadGPW6KqNN5AXcIRA/EzxF4GTRTCN5h100=
X-Received: by 2002:a5d:5905:: with SMTP id v5mr13106064wrd.361.1624646598834;
 Fri, 25 Jun 2021 11:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210625095000.3358973-1-mnhagan88@gmail.com> <20210625095000.3358973-3-mnhagan88@gmail.com>
 <CAK8P3a3NAOgBa1j+Zsm6FwSm2ux49rFcnTEYJJsmSF8TggRnYA@mail.gmail.com>
 <bbf38c31-ed75-69d2-39ed-94f324b1f220@gmail.com> <21e895e9-0211-0c97-5e9e-781e6d2fe6dd@gmail.com>
In-Reply-To: <21e895e9-0211-0c97-5e9e-781e6d2fe6dd@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Jun 2021 20:40:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3vHOyFVnBTBpJ9_N8QPtb_dhU+itBXixrL3gjEuGpKkA@mail.gmail.com>
Message-ID: <CAK8P3a3vHOyFVnBTBpJ9_N8QPtb_dhU+itBXixrL3gjEuGpKkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: dts: NSP: Add DT files for Meraki MX64 series
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Matthew Hagan <mnhagan88@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Wwf001wfvj2NayxiGf2rtnUg6jjwTI76fEJgg6BbVYd8EX6Bu89
 oR7a/hkMSpIyk+MhHFAGY/Mk512mQcOhVPze3K/U49r8RbvIc6BCx2FiO2c3oXxtkXxyOfn
 WDe5WI7IWdOqw8+rjkKMLNWLqGBUCMNvFRcvjywt893URrUIwO0gLbb0efaw/u9cqsqdWeV
 PFhHp4gSflJPE9ArlXelw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZjQyzO/aP0=:13PJSEf0CNg7aKG35AZgBV
 4vemKE1HqUHPX8Cj+fil9wrsK6VpEZUWmwSi2aY43maSZZ+ugWBPIheER2YpAtI0Uu9sVm0ts
 jAiXE2cet0iN9meACkIaKDhDzT1vETPmZsmfWGCcQAW90ln1OBEtZEtUEeFuGqtdUO7G/jDUN
 uf4k7oPOCppPj+W/fnCq+W11hvWnXIIGs7vlbedkUntCAvr/ogZnnym6cuwhjfHbJgjEdSQlo
 s6RH7VQsGWryhGiKg5l1sVYYZDpOn9SxusyyYJ4CRcY0Boef6M66YuaaQJWSzzO/5qqHsXka4
 GILrMs0lOWWTalrkqlNemwO834my0bhWXSjG+R2MtFmglF1lnSY5UXqwaLr3kNDWQTT6RIP5S
 MZUcg5xHrZ43iPesOxO9IrCoyU5wxsp1fwi4d1QwnxQbedxsi/t84iOnsMOJY1gPnlB2DPbvh
 hiiFw5ezN/FDcLYWGRg7boBMxwS7E8NBqkpEPYqj4QGvlpa/E8Zj/E8+uUGiSU+GkQcWJ3FPd
 MfPLOqYXqXTYSUpKECVXg+j9Z3feN23+5k8z0yfZDalQiKNovULHPey8MmDoHDCyF8QAUV+EZ
 +xWUagkU/InVHLyr69MFsLXZTnZO6YivTR4izETxCeEH1PrBEPzQ1T2UmRIfD6DHVcCpSNwGi
 v2xU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 7:30 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 6/25/21 10:26 AM, Matthew Hagan wrote:
> > On 25/06/2021 10:59, Arnd Bergmann wrote:
> >
> > How about having separate bcm-nsp-ax and bcm-nsp-bx dtsi files with the
> > appropriate secondary-boot-reg and dma-coherent (or lack of)
> > properties, which then include bcm-nsp.dtsi. Thus we can also avoid use
> > of /delete-property/. Would this be preferable?

That sounds good to me.

> Is there any way that the Ax platforms could use a small shim between
> the boot loader and the kernel which could all of the necessary DT
> adaptation so the kernel only contains a single Device Tree source?
>
> Using something like this:
>
> https://github.com/zonque/pxa-impedance-matcher/
>
> could be useful.

I don't think that's necessary here, but I wouldn't object if someone
finds it useful and does the work. ;-)

> >> On the other hand, the /chosen, /aliases and  /memory nodes that you have
> >> in the .dtsi file should probably get moved into the .dts files, as these tend
> >> to be board specific settings, even if the examples you have are all
> >> the same.
> >
> > I did not come across any convention regarding this, though there are
> > plenty of cases where the /chosen, /aliases and /memory nodes are
> > defined in a .dtsi file and used by multiple similar boards. Also note
> > in this case /aliases is defined in bcm-nsp.dtsi, not by me. Would we
> > not prefer to avoid having 6x duplication?

We are not too consistent about this, and there are cases in which a
.dtsi file is used for a family of boards using different SoCs rather than
a particular SoC or SoC family.

In the bcm-nsp.dtsi example you mention, I would move the aliases into
the board files, mainly because there is no guarantee that each board
exposes both uarts and all three on-chip ethernet ports. Note that the
aliases are supposed to match whatever label you have on the board,
not what the numbers are in the chip.

      Arnd

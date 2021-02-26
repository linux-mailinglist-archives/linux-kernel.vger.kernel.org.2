Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F93326486
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBZPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBZPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:11:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5497C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:10:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jt13so15427306ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qob+x0v3PWoQeSjNHiZO+kB15xvcQ69XpXTQVJz2RPU=;
        b=a1MDEHM8s09DsnQbF02T997tp4oRe2O37ngvi+1wKL+1pfve0tWdfjpaxAYTPYjbQp
         Va2oSjrin0RnNf5eHoWp7n+V0DxLvLXzxan2yj7/Q2ZJU7RXgr5AmxKC73hwD0SsMOpC
         /kKpSGfnaWzC+f55rJmmjNCqG0jOtkaRZxnIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qob+x0v3PWoQeSjNHiZO+kB15xvcQ69XpXTQVJz2RPU=;
        b=VHkMfrz9K+CSj6yJ2E8C1X5ki3U3HNYiR9akrC4DosLm2ZkkYP7StdjvcRfytcR5RR
         5Kifq2FGm3V8vlENptCRqt9ydeye6ShyjyIbiMJYMc4A6H33AdAPGVHzx7Tg2+urDOgD
         D1O14Xc+d7sz1e+l/i/sVgTJ3WLk4Ei0QYDAoyG6ahXN5kU+BPdN7vKDuEd84zkI0X5T
         QHxY2a28FA8o6P+IFMe+7PafsFY2m5fr9hO+I3tleiVbWm+FH38KHp/jtWd0FTY24vT0
         qosKiTV1t0Z59+B/UjUCjNZJ9xK9E1tRYw7Ww3NschVKIrCblolm1UhV3tsFBpYOZWTr
         ubVQ==
X-Gm-Message-State: AOAM533MX2pP2wgT2vpzJc7tR9MSbXr4XBJSDAOi7uskLVWnM+RRT/Yh
        0hs1OSyqwV1IWpG3oUOcyp2FtlEde4xhtg74o7YfeQ==
X-Google-Smtp-Source: ABdhPJyoRqbRLP+Q6WlKYXMUH1kbTuEF+ZlC2okW0g37gPI8Gl8+y1kqX+nuWxY1JhpGJZkn81TY1UVsxXTQR5Sy/6s=
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr3911081ejj.522.1614352232483;
 Fri, 26 Feb 2021 07:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20201223191402.378560-1-jagan@amarulasolutions.com>
 <20201223191402.378560-3-jagan@amarulasolutions.com> <21398844-c334-f753-0fac-144a0cdc29dc@foss.st.com>
 <CAMty3ZBotTi2RwkKUpb+8KBOJ484hHzOV0p4J_dJ-fBVSDoMAg@mail.gmail.com> <cb9708b7-dfd2-04d3-a3d9-2479ab428f1a@foss.st.com>
In-Reply-To: <cb9708b7-dfd2-04d3-a3d9-2479ab428f1a@foss.st.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 26 Feb 2021 20:40:20 +0530
Message-ID: <CAMty3ZB7_Bi5pxJAtG21xnng4eTosP_taTa_gnVYZ503EAFnUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 SoM
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 8:39 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Jagan
>
> On 2/24/21 7:05 PM, Jagan Teki wrote:
> > On Mon, Jan 25, 2021 at 8:35 PM Alexandre TORGUE
> > <alexandre.torgue@foss.st.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/23/20 8:13 PM, Jagan Teki wrote:
> >>> MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> >>>
> >>> General features:
> >>> - STM32MP157AAC
> >>> - Up to 1GB DDR3L-800
> >>> - 512MB Nand flash
> >>> - I2S
> >>>
> >>> MicroGEA STM32MP1 needs to mount on top of Engicam MicroDev carrier
> >>> boards for creating complete platform solutions.
> >>>
> >>> Add support for it.
> >>>
> >>> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> >>> Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
> >>> Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> >>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >>> ---
> >>>    .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 147 ++++++++++++++++++
> >>>    1 file changed, 147 insertions(+)
> >>>    create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> >>>
> >>> diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> >>> new file mode 100644
> >>> index 000000000000..97d569107bfe
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> >>> @@ -0,0 +1,147 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >>> +/*
> >>> + * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
> >>> + * Copyright (c) 2020 Engicam srl
> >>> + * Copyright (c) 2020 Amarula Solutons(India)
> >>> + */
> >>> +
> >>
> >> If STM32MP157AAC is soldered onto this board, you should include SoC
> >> dtsi here and no into MicroDev 2.0 board. No ?
> >
> > No, it's an SoM dtsi. and it can be associated with the respective
> > carrier board and include files are attached in its dts.
> >
> > Please check the next patches on this series.
> Ok, I thought it was a mistake as you mentioned "- STM32MP157AAC" in
> your commit message.

Please check, v2 for this series. thanks!

Jagan.

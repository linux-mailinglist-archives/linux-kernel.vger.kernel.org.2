Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA734C74B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhC2IOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhC2IIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:08:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94DEC061574;
        Mon, 29 Mar 2021 01:08:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z136so11832730iof.10;
        Mon, 29 Mar 2021 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M90PtnBos3vQm4jCYdp24IMqWu4umlMBuWXWPsG5RUI=;
        b=XDcojEEvHw7VjId4QVIJ4x75QaQSNdQdx6b5ynGSdQ6rRtpfhVw3hYWVopCzz+i8Mx
         MawpBVFqghbwm+t0GQto3ccA5RVfnkV3zhieuKICgbyD6UJ6Sx3tu1S4gvu25AIypxJU
         IrKNadU9KlRCsAwt6Ko0ND6l2IDtAgziZ+pH8H/M12uTdgWUctXPf+is6ylHU5dG30LP
         23chMnymCz9holZnfdWVaE0K1NcDfitMSls/YRpfvS79iNgkcKeX0S4J4W7gluJR/eI9
         xKaXdVxCUx/E4UzDo7vvmkOvsu8ruOXJPNRblW96dd+8K8IFzs2tlrn/HjgncWfQh7J2
         gUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M90PtnBos3vQm4jCYdp24IMqWu4umlMBuWXWPsG5RUI=;
        b=m1HDQStjxW7EQeFiRMNnhtjdwUL44dPOybJN41wqkxGuaNstQpbJCsU1lu0UBvFogY
         S+V08stBE1UvMNLr8H4Kli4TAaYb5ogCTBM0IK3RZn/vHb2JyaSC7d6WQCg1A3impYW+
         n81vJWSWS4cYT5g7CFj8J0cGZ5NiFsBsAXepJaHf/iLQKt3p0KPgTWXCJQi+HxFJjTw8
         cs1eA2R0h159FoM8ZNb6hcxCWipPnhicVQKhLGg+LQY3W0KPch/s4UctPmTdxqg3aI+k
         AVh4ToXmOIE7EmPU7MVSRSXiwjeM/sxGh+UIZlxRI3PZ9P34bvsKC8eTzmtD0U3k/uTp
         582Q==
X-Gm-Message-State: AOAM531CK2DdF0+iAY//xvOvgNOaAcQ4ddFXDsJ9ANd3Sgmc5VBGNOVC
        9gwuUnsT/cvzj4UNxKsuW+ySc4ZcH5VkYn4oBnM=
X-Google-Smtp-Source: ABdhPJwf+nNTr4QHEViurBtr2d3/xvlbhnLb599B6ZVv54r8NPMEKvz7hwFVeFk/Dn/uBm2Zk+aTqvnqBv1DHzEi4u8=
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr18461754ioe.127.1617005312167;
 Mon, 29 Mar 2021 01:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
 <1615530274-31422-9-git-send-email-dillon.minfei@gmail.com> <eb2437ef-ecd2-e258-b77b-2fe9f70205f2@foss.st.com>
In-Reply-To: <eb2437ef-ecd2-e258-b77b-2fe9f70205f2@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 29 Mar 2021 16:07:56 +0800
Message-ID: <CAL9mu0KrT4S=NHULcJdztXZ=RvGnVA9s95pDGmadRBH=vnpO6g@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] pinctrl: stm32: Add STM32H750 MCU pinctrl support
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 4:00 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/12/21 7:24 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch adds STM32H750 pinctrl and GPIO support
> > since stm32h750 has the same pin alternate functions
> > with stm32h743, so just reuse the stm32h743's pinctrl
> > driver
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> > v2:
> > - add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
> >    have same pin alternate functions
> > - add STM32H750 to Kconfig description
> >
> >   drivers/pinctrl/stm32/Kconfig             | 2 +-
> >   drivers/pinctrl/stm32/pinctrl-stm32h743.c | 3 +++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
> > index f36f29113370..fb1ffc94c57f 100644
> > --- a/drivers/pinctrl/stm32/Kconfig
> > +++ b/drivers/pinctrl/stm32/Kconfig
> > @@ -35,7 +35,7 @@ config PINCTRL_STM32F769
> >       select PINCTRL_STM32
> >
> >   config PINCTRL_STM32H743
> > -     bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
> > +     bool "STMicroelectronics STM32H743/STM32H750 pin control" if COMPILE_TEST && !MACH_STM32H743
> >       depends on OF && HAS_IOMEM
> >       default MACH_STM32H743
> >       select PINCTRL_STM32
> > diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> > index ffe7b5271506..700206c7bc11 100644
> > --- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> > +++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> > @@ -1966,6 +1966,9 @@ static const struct of_device_id stm32h743_pctrl_match[] = {
> >               .compatible = "st,stm32h743-pinctrl",
> >               .data = &stm32h743_match_data,
> >       },
> > +     {       .compatible = "st,stm32h750-pinctrl",
> > +             .data = &stm32h743_match_data,
> > +     },
>
> If you use exactly the same driver (i.e. same ball out and AF mux) then
> you don't have to create a new compatible for that. Just use the same
> than h743.(so you don't have to factorize DT files).
Okay, yes they are the total same ball out and AF mux. I will delete
it in the next submission.
 Just a kindly reminder , the newest version of this patchset is [PATCH v6].

Thanks.
>
> Regards
> Alex
>
> >       { }
> >   };
> >
> >

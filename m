Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92C39E166
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFGQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFGQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:03:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E3C061766;
        Mon,  7 Jun 2021 09:01:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r198so23794745lff.11;
        Mon, 07 Jun 2021 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfTfNqfGgiJF7i6Kth2DAqp+9bynWd1MeZa/bRlf+HM=;
        b=TwTvF7ArgyQ4xqG4cH6oBzEOtyHOqZlkLzUV7qyyBkeUKA8/BDpvCvs+BmSYmyF9AV
         rRP8UMOc5+6I6gwvUgmcRlifEJ2h7Y8NNyOWBaOIWFg2ggzJbE9U+3CM5H4tbYr4fbtw
         FDqp6C4NLjH3zBrb0cRoaPbVkNEwMwiU+CHjNvCjQa9nga0iWLX0mfPEvJZ+/wxnfqLq
         9JzVWOAgy7CySe4OjVR9RzclBOZCvyIx3Q3Y+XC2+YwHsmhNPyfcGPcd/ovzd7RJSYC6
         c23CifDhStaIhHBniI/q9OpaRcz932OdGRLA8lfESrRPWOqbh8CqTanH2rusfrPAIyKD
         V4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfTfNqfGgiJF7i6Kth2DAqp+9bynWd1MeZa/bRlf+HM=;
        b=pwjFr7/oLrZNKDPaSsfZYE3lAqwnnvTAhvjl7l5K1FrJY2dlLpKJnjl3lAmIkax74y
         EQcQkK9wiiIazx/jIj4EsD025tlQCDWNR7FO+fBif2j9+w65uEqQYmS4k3if5FZ2GA9l
         M5rjWfjzFF9/yiRng/57tvP5tfFukvX7EOJhD+8sJD//xW9TanPs6Sq3qJc2C0KgzTg6
         1+EmRlIOJKq9Rl272xWBoCaserXIedN9LcLUhiZUR4HDWkn//i/DY/9qt6BYX6evszHn
         1EqsoVddj8jdogigos//I8PGfAtBtjqLFbre+Hcdl1/w+/d8OmB4nhAZB+e/UNnQ7m1W
         oZwA==
X-Gm-Message-State: AOAM530LSFOWeAqJCCopz4VIfLEq/v9ZqPnNeY9QnqEQpWGT912S/eP8
        IcV8VsRo1vG/MKhrW58ug+37NQS7RBa/zp/Thjw=
X-Google-Smtp-Source: ABdhPJz499SKsQIIbh4r2JtmI+ERb/ExBl8VzFeBie1M2ODzVoQQxX0viJ52D1FwF0Otp/1vaQTuOmNLaCrLjhf3DAY=
X-Received: by 2002:a05:6512:1184:: with SMTP id g4mr12508214lfr.553.1623081688934;
 Mon, 07 Jun 2021 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210607081727.4723-1-cnsztl@gmail.com> <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
 <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com> <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
In-Reply-To: <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Tue, 8 Jun 2021 00:01:17 +0800
Message-ID: <CAOP2_TiHwYhLVLOEx-Vgx6k3XmHgNsiyR8CqrWyABnP0AidMBg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Mon, Jun 7, 2021 at 6:26 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Chen-Yu,
>
> On 6/7/21 11:40 AM, Chen-Yu Tsai wrote:
> > On Mon, Jun 7, 2021 at 5:31 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >> Hi Tianling,
> >>
> >> On 6/7/21 10:17 AM, Tianling Shen wrote:
> >>> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> >>> stores the MAC address.
> >>>
> >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>> index cef4d18b599d..4a82f50a07c5 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>> @@ -68,6 +68,15 @@
> >>>       status = "disabled";
> >>>  };
> >>>
> >>> +&i2c2 {
> >>> +     eeprom@51 {
> >>> +             compatible = "microchip,24c02", "atmel,24c02";
> >>> +             reg = <0x51>;
> >>> +             pagesize = <16>;
> >>
> >>> +             read-only; /* This holds our MAC */
> >>
> >> The mainline dts files should be generic I think.
> >> Any comment about "use", partitions or write ability should be avoided.
> >> It's up the user.
> >
>
> > Per the datasheet for this specific EEPROM, the latter half (128 bytes)
> > is read-only in hardware by design though.
>
> The 24AA02XEXX is programmed at the factory with a
> globally unique node address stored in the upper half
> of the array and permanently write-protected. The
> remaining 1,024 bits are available for application use.
>

In my opinion, as this contains data programmed by the factory, would
it be okay to keep it read-only?

> Just a question...
>
>     nvmem-cells = <&mac_address>;
>     nvmem-cells-names = "mac-address";
>
> Which part does this point to?
>
> Can we use the lower part to store/rewrite this too?
>
> ===
>
> From at24.yaml:
>
>             items:
>               - pattern:
> "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$"
>               - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
>
> How does Microchip 24AA025E48 fit the regex?
> What compatible would you advise?

It seems that 24AA025E48 is a variant of 24MAC402 [1], and
`atmel,24c02` will be okay in this case.
1. https://lkml.org/lkml/2018/1/24/494

Thanks,
Tianling.

>
> ===
>
> Johan
>
> >
> > ChenYu
> >

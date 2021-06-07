Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8639DB18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhFGLWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhFGLWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:22:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F212B6101A;
        Mon,  7 Jun 2021 11:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623064856;
        bh=AZv8dRcvDlfgxFi4HYEke9KgpebnK89UUq/um94nbN0=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=oqzDrF2hZNR9kjbIq4MZiQDYmcBwsWn0H9CudxGHMIkHbvj5lOiBlkeqFIv/NzUxT
         4LKPyB6WEj41P4283ZZ547MIaAxBh74lxVcZ4Ky1cVS1OwKF6p0Iip0UlMToYrdoAO
         4rsEQ+dkMRMggbR4IuIQxx9CFa0LQa83iHyNBJqE2BBwRiD98O+WXjPAdto5ko+AgC
         lbXc+6eUjPqXalFKQz9sRKDx+eqW59YpuRxMbO71dDdyJkg2m4QT7VO/F3Q+dV2+ie
         CbUtLtwdCDq8h+Z9DbFMrYsB3t7FVtcCSdMo5tubvSH329sb9Z3E3h/xcCyN4Mc3rZ
         wWSA+GhY45xnw==
Received: by mail-lf1-f49.google.com with SMTP id a2so25615480lfc.9;
        Mon, 07 Jun 2021 04:20:55 -0700 (PDT)
X-Gm-Message-State: AOAM530nUdHjMUjkCwa7VBIhsY/vsrkMJpqbN53Nr7c+utzp/GgayNo1
        UGfSEFnCACx4ZwTPWHM00edfhBUCMSb900xSw/0=
X-Google-Smtp-Source: ABdhPJzY71JZF6OCcQXGna/ln5JgqcsET8OdgsNKLv4hl+KtPLOZJc/0bZyYSKEAt0WHeW1x2OpQzrWggB0eiapDmNk=
X-Received: by 2002:a19:f11e:: with SMTP id p30mr4920376lfh.496.1623064854255;
 Mon, 07 Jun 2021 04:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210607081727.4723-1-cnsztl@gmail.com> <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
 <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com> <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
In-Reply-To: <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 7 Jun 2021 19:20:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v67trVUJuSwLgsbDXHRKVhd5keWxs4V7u5NSs8jp5-asJw@mail.gmail.com>
Message-ID: <CAGb2v67trVUJuSwLgsbDXHRKVhd5keWxs4V7u5NSs8jp5-asJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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

Hi,

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
> Just a question...
>
>     nvmem-cells = <&mac_address>;
>     nvmem-cells-names = "mac-address";
>
> Which part does this point to?

In the eeprom node:

    mac_address: mac-address@fa {
            reg = <0xfa 0x6>;
    };

> Can we use the lower part to store/rewrite this too?

If you don't set it to read only, then you could rewrite the lower
portion. Writes to the upper portion would be ignored.

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

New regex: "^microchip,24aa025?e(48|64)$"


All that was what I had around in my tree.

ChenYu

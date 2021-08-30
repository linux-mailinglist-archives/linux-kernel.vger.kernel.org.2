Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1663FBCFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhH3TiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhH3TiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:38:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A96C061575;
        Mon, 30 Aug 2021 12:37:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u19so6595903edb.3;
        Mon, 30 Aug 2021 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTABDWDNLKg61M+R3vjb71MHbfemSFy2AY4zPlg2nE8=;
        b=bXr0Gort95NFKAp8VD/ml/V5CY8ZNac0oRXnVY1cowlNNobODHOf9Q0XPK7aaT0DjW
         8W2RbQj1Wvp+hIQiJt8IseE4/rdqjErLk6nXxYtNWhV+BYcTUpskIFQfq88hd1/VCRhC
         9Ztb0O9/Zm8SvSkxtjtZmGAYuuWa4VDPIzB8eIypxit4AmFVdH34RZaa2FeWqn5W6ERV
         Ebdrl627h+zc2GVqSWVFeoCbyxKKPCtz/rkNZyFPENOBI3UdGrXGa8plkc1h8SocErpV
         46tJnV6jsw0QLZ1jomda7K+zd3IZE+bfZ6fdvdSsA4YLJXFgl9IKJ2HwBeLzhRh2Z9Pp
         mbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTABDWDNLKg61M+R3vjb71MHbfemSFy2AY4zPlg2nE8=;
        b=cz5pnCg4Lza7mWcpk+8qs08Uz1Cnu5ZKk2nzhDXVDd4VWuCVh++2c2EatuCsEZORed
         +sRGcHK8KdTQWoL9z6JK6EI+cQ/dCzLnLPWD3RIlhDOmEb+IQblLsyxzrbWzyQC+iQ6h
         Y7liObDxy0HgNKaa9mWlK4dCVrSjvWSBr7HFkqmWUpUgMRVzSMNtMX7ElbgU1wLDQfzE
         WJ3YH5O/npqnGNXAS9UMam/zAgllB1N49+gZyag0s9OSc7G8LyrjZ+kbyDna92tWan7r
         EYc/54rWhI3Yg3AfLU3Fhn2eKr4Ur5MMbsrSHXbq6Z3JfV0jaGDOUm8/3k6X8v57EMzw
         x67w==
X-Gm-Message-State: AOAM533hG5zKM2MloZu0Sd8lZ3wDVURBaLZukQ5elFoiNzkeRu9hgKwy
        0LP47XWPAW57FBB+hJ3XyGiY06x4alK09sK03rm1C0ItMfg=
X-Google-Smtp-Source: ABdhPJy7qBuvqTVzY7sOAt7tXWrtZHlRPjJ+Pze/MoPqHbrn7gFn2XmnEqO3Omk3qalVhBFRXosf5B1OJ7USzraT1sY=
X-Received: by 2002:a05:6402:313c:: with SMTP id dd28mr25477809edb.179.1630352243401;
 Mon, 30 Aug 2021 12:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-2-linux.amoon@gmail.com>
 <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com>
In-Reply-To: <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 30 Aug 2021 21:37:12 +0200
Message-ID: <CAFBinCBeNMET2tvH0h6HF3dR+xBb59hifQyaoXigUs3UGkS+KQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Anand Moon <linux.amoon@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Aug 30, 2021 at 9:45 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 17/08/2021 06:15, Anand Moon wrote:
> > Add missing usb phy power node for usb node fix below warning.
> > P5V0 regulator supply input voltage range to USB host controller.
> > As described in the C1+ schematics, GPIO GPIOAO_5 is used to
> > enable input power to USB ports, set it to Active Low.
> >
> > [    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
> > [    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
> >               mode /soc/usb@c90c0000 failed
>
> First of all, DT is not here to fix boot message.
Anand mentioned elsewhere that this is a debug/info message

> Finally, I looked at the Odroid-C1 schematics and the GPIOAO.BIT5 is an input
> to the S805, and the PWREN signal is controlled by the USB Hub so this regulator
> should not be added at all.
I think there's a misunderstanding because there's two PWREN signals
with different meanings.
The PWREN signal for the USB host ports is hard-wired and not
connected to the SoC at all.
The PWREN signal for the Micro-USB port (which Anand is adding here)
is controlled by GPIOAO_5. odroid-c1+_rev0.4_20150615.pdf [0] shows it
as an input to "USB_OTG" on page 1. "USB_OTG" consists of a power
switch and the connector itself as shown on page 28.

Personally I think that the change from Anand itself is good.
If you feel otherwise then please speak up.
As I pointed out three smaller changes I am hoping that Anand will
re-send the updated patch anyways. At that point he can also add the
changes from your feedback.


Best regards,
Martin


[0] https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20150615.pdf

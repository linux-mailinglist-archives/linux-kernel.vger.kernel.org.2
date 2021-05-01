Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4E370696
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhEAJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 05:29:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65194C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 02:28:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so684372ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyGYqVikn3sRvr8oBxpMkevusdQYlEUroZdr1msedCw=;
        b=sPwxNQlVV9CppL4NWcVqlYriHNWEQ1jnrUky72n7dWeTrSjnoShtCz1UmjSjIXKeP1
         fiTOIlRGqn5mcAjAkwNN9/4E/vyAdhV4Vp/NpCFU2euSm4GMYStdi6jtNibwkV487KFy
         X9+cALwYZ6NToc/MYX7WyVi/4KJMmStpkuIjGqpY+/t610JLjww4dx6TTNBbZBNr3W76
         4Jqrg2qSHis/Sn7t7qc04lkCQv++qvC+5odOc5zbl+lwsjkyxY/UnIGHn2F+VhXcT/00
         MA31SzIymM8KGROsE1pA50qxsb7sMQoDT5A7LslAdzdR5CT4dHdN+Rp0aVJdyLkYIhPp
         Ot+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyGYqVikn3sRvr8oBxpMkevusdQYlEUroZdr1msedCw=;
        b=s1yCPShnQIZDSv9tiHnLtIrr7eMhi58jR0QNQO87LjN6UsP85GYu8ZFcHgahjAzA/U
         4BM1HBMMZlOTVlQuDcR6WNNKilD8jUd4xOudX2iBRP+eVmCUq4l4Ww+E7Vg5zhp+Ut96
         GM1F6ZbPqEIbwYxFyVxJMwfSg2TlW5nrxO+7r4yftjvbGWZinn/n8KVh3uRxIromGv5L
         U9PXP6devZscTwg+G1QEQDyQxxHSEWd0gCs1LdwdykFTeo8YzmWfjvvfMqB/oqGgn77i
         1JVhqLyJgLiJfH+uDTi9mGDEMfDaIGOaI6QfpuR9vM/86O37FP1Db5UbDV1E31q6n8oF
         dCqw==
X-Gm-Message-State: AOAM530fhWQTNZvJotkysl4Xv6ffhd6hpV6imTkz75hYdsMZUSZI2+QP
        qgg0XUECEBqWidQovJ5NR9lvRnRDCDTbViKSmQA=
X-Google-Smtp-Source: ABdhPJwL4T7Awvt9Npw1jmNY5GUe7UBmVuRvRtXR9P7lvQ1b3cJnmJdcuCfMyjJWCMPtCTNZY1uuTR5hVVqKhk1/37Y=
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr8119874ejc.2.1619861307057;
 Sat, 01 May 2021 02:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210429170404.3616111-1-narmstrong@baylibre.com>
 <20210429170404.3616111-4-narmstrong@baylibre.com> <CAFBinCDQeTU0ss=oNmjX78MPyNZmmCt-haojNNcQqkjJUmJYKQ@mail.gmail.com>
 <cafdf662-6f15-8e16-7752-5740f28b6682@baylibre.com>
In-Reply-To: <cafdf662-6f15-8e16-7752-5740f28b6682@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 1 May 2021 11:28:16 +0200
Message-ID: <CAFBinCDNhErxk3va=rMUpOoh8b7iNNqWJh6Ry_Y5sC5AxYLn2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Apr 30, 2021 at 10:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> +&ethmac {
> >> +       pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> >> +       pinctrl-names = "default";
> >> +       status = "okay";
> >> +       phy-mode = "rgmii";
> >> +       phy-handle = <&external_phy>;
> >> +       amlogic,tx-delay-ns = <2>;
> > I haven't checked their u-boot code but some of the newer Amlogic BSPs
> > seem to let the PHY add the TX delay (which is also what the netdev
> > maintainers recommend)
> > that can be achieved by setting:
> >   phy-mode = "rgmii-txid";
> > and deleting the "amlogic,tx-delay-ns" property
>
> Done, but what about when we use mainline U-boot here ?
I think it will work just fine if
- the PRG_ETH0/PRG_ETH1 register is programmed correctly (that's what
we have in dwmac-meson8b), which according to [0] is partially (RX
delay not being supported in u-boot yet) the case
- and the RTL8211F PHY driver can set the RX/TX delay on the PHY side,
which according to [1] it can

So I have not tried it but I think it should just work


Best regards,
Martin


[0] https://source.denx.de/u-boot/u-boot/-/blob/798424e8573a6b642a1bb507d41c1f73e6736e2e/drivers/net/dwmac_meson8b.c
[1] https://source.denx.de/u-boot/u-boot/-/blob/fa6539a3dcbf269121ca64084cff4c146fcdaf19/drivers/net/phy/realtek.c#L204

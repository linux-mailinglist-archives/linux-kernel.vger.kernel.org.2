Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AFD33D808
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhCPPsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Mar 2021 11:48:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51715 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbhCPPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:47:43 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMBv3-0006Lc-4n
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 15:47:41 +0000
Received: by mail-ed1-f71.google.com with SMTP id t27so17815913edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inY6i8A4Tqqf26IRTTPmHrEemCAIy4a8P6L1PcnGZLw=;
        b=KT+tVcVMJx2buYO3fugYOE2653gzdY+yMLGSI8ixWvmASscCoextV/Sogpe57931Qd
         hC21Dgwtr+6GCIvTa1qbPo8YeaFHajgjCRTnbz0CP7D17KTivj/mjWS2yA03Uy3hwZHJ
         zvjErEMh4YexLJgPDsBvdwPhK0zsLZE2F6oCsc8rGBuz0xhgIieOx4mEnyNAyT9R9yiy
         6heKpGMtF394AFFhO8htXKYjUc9KmoH3WRCw4GMd/0f6X1qCRs+F+Dp99e2o3JbcJhTp
         BJpe7wmdzY0kp2PP3DQa1KGiHIDfkS7cfv3fOny8Lt7a+jE3LQgvmXitUsKMAe6TRQdE
         FQiw==
X-Gm-Message-State: AOAM5301WQAAco1PBDsJEWnBd75Jr7ym7BtX99C0qqmac1CmpaXOJcVk
        E6wR8L3D0dW1YChjm5AJPvU9toq8dUdyD5jJnbXqQ+2mgXCPgiOMeI155W+o08QtqGPyuCviXkw
        3rq+jrjMRA4voi3P0P14N22cbK10qgYMHfxF/0Up4/m4tqLrK78DGfUKW0w==
X-Received: by 2002:aa7:cf14:: with SMTP id a20mr36699084edy.49.1615909660872;
        Tue, 16 Mar 2021 08:47:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuw/dJQo9rH0tFlvYp4nm03MBWw0FLDNdvROj1KnIALerZB4yUNuZjOR6eHwi+Wa1HgbEZ0IePzPZ4lEB2wsg=
X-Received: by 2002:aa7:cf14:: with SMTP id a20mr36699067edy.49.1615909660757;
 Tue, 16 Mar 2021 08:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210316075551.10259-1-krzysztof.kozlowski@canonical.com> <0e52e932-e5d7-8116-710a-50956caaf87c@gmail.com>
In-Reply-To: <0e52e932-e5d7-8116-710a-50956caaf87c@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Tue, 16 Mar 2021 16:47:29 +0100
Message-ID: <CA+Eumj5c2i30Xh2oBGeR5R_9JkPGiAXRGNYc4hKt9s8XuHjGdA@mail.gmail.com>
Subject: Re: [PATCH v2] phy: tegra: depend on COMMON_CLK to fix compile tests
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 at 16:43, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 16.03.2021 10:55, Krzysztof Kozlowski пишет:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > The Tegra USB PHY driver uses Common Clock Framework thus it cannot be
> > built on platforms without it (e.g. compile test on MIPS with RALINK and
> > SOC_RT305X):
> >
> >     /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
> >     phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Depend on COMMON_CLK always, not only for compile test.
> > ---
> >  drivers/usb/phy/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> > index 52eebcb88c1f..7500e77a7d01 100644
> > --- a/drivers/usb/phy/Kconfig
> > +++ b/drivers/usb/phy/Kconfig
> > @@ -163,6 +163,7 @@ config USB_MXS_PHY
> >  config USB_TEGRA_PHY
> >       tristate "NVIDIA Tegra USB PHY Driver"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> > +     depends on COMMON_CLK
> >       select USB_COMMON
> >       select USB_PHY
> >       select USB_ULPI
> >
>
> But if COMMON_CLK is disabled, then include/linux/clk.h provides a stub
> for clk_get_parent(), meaning that MIPS has its own COMMON_CLK, no?

Hi,

It depends on the platform. Not all of them implement every clk API,
so you can have failures:
https://lore.kernel.org/lkml/202102170017.MgPVy7aZ-lkp@intel.com/

Best regards,
Krzysztof

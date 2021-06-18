Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB753ACBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhFRNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhFRNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:19:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:17:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb32so7724095ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xe2YpkukwsI9XJ2VLSi+FEFdvQRSF1UaOoSGG+bZomM=;
        b=Mc2f2pnPIQcufzu0lHZhOm3iA+HWdT6VFLclBezA7WXxctT9yYLB4XWHvhP0h7+ZPV
         uopEX2SxAwI9yt35rCVCvWwww361AegD9Nw10Hy+FhV0AMO20QvdKiScRy28iHkLLsYV
         kl0JbOhq0TlkV4uPiACtcNjT91HhYjm818SGpdGeO9/qp6B0dGAmX8HSd2C/U0KDbldg
         A320+0O8Lhr5Ifx3Qv1ntPat1F1uT2eCtApVj1l9gyZxL4GzKPD+xbmv5+zHY3Bs2efD
         695PkunXhYHR51X50QKmXD6aAN315YQLVUj3afa60ANPI9E9DAlLShzwYMykOYDOyHio
         Ku+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xe2YpkukwsI9XJ2VLSi+FEFdvQRSF1UaOoSGG+bZomM=;
        b=LU8+CshSetpuUGMWpxKRf+QrHlhG6zWbWqpoKrp/8P8RFt7vusKPQ8Knr7J9XUClMf
         7b/nj4LdvRDh/KF/bWjItTftFGpPgrOI4ZIpTT/Zhbhc15bzD0nEMVhDBkGZQAF3U6U/
         39mqHVdXbQ/fkQBR0hc87eiY1BDXYZ/Kw+jJMzV0XE2ceSXYNKE5Bk/A+GnNWusEuK9f
         +uEGGWUUMHy7zHVOZhKSfyvrcqU74E5NaN9Ylsfg9qJVOv6I6hoVPvfMZXbIgsK9T8Hn
         b69tpJCXRv8noD0S2ZpNZS7Jm3c+duEs1PkYIPHeSVE6UTHobYA2u7jtHBEcgDx60/yl
         ujVA==
X-Gm-Message-State: AOAM530+uJgs+nmWyrsIuTiVj0QqS5NtJEUroz4cHEP7N0Xk6sBmThvR
        M1zh/vxZAnNGlGuNFueS8WwdTcGxY23/pKQ5dCo=
X-Google-Smtp-Source: ABdhPJwbkF3xpqpTv93ehYc9hAa6vnirG3fKe0UpaQmZbwEVzm6hODm2XBpQqJbfDfQrpr4kaOQe04vaKVMBM1pn1+8=
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr10852667ejc.108.1624022234610;
 Fri, 18 Jun 2021 06:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-3-linux.amoon@gmail.com>
 <CAFBinCAZn13-GpMw-b4=rd9zwwNCtvmv0Oq0BXt+1PTTQ+Gngw@mail.gmail.com>
In-Reply-To: <CAFBinCAZn13-GpMw-b4=rd9zwwNCtvmv0Oq0BXt+1PTTQ+Gngw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 18:47:03 +0530
Message-ID: <CANAwSgQ=LydfoWSAo-YPOBNHu_mwOMj+6dv0pm11k-ErGAsJ2w@mail.gmail.com>
Subject: Re: [RFCv1 2/8] phy: amlogic: meson8b-usb2: Use phy init callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, 18 Jun 2021 at 17:56, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:43 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Reorder the code for bulk clk_enable into .init callback function.
> Depending on whether changes are made to the dwc2 driver this is
> either fine or might cause some issues.
> My understanding is that drivers which are using a PHY should use the
> following code-flow:
> - phy_init
> - phy_power_on
> - phy_power_off
> - phy_exit
>
> dwc2's platform.c [0] however currently uses the following order:
> - phy_init
> - phy_power_on
> - (remaining ones omitted to keep this example short)
>
> So with this patch and the way dwc2 is currently implemented the
> phy_meson8b_usb2_power_on implementation might not work anymore.
> That is because the clocks are turned off and in this case all
> registers will read 0.
> You might be lucky that u-boot left the clocks enabled for your case -
> but in general I would not rely on this.
>
> In case of the phy-meson-gxl-usb2 PHY driver the ordering is different
> in the "consumer" driver (dwc3-meson-g12a.c).
> There the order is:
> - phy_init
> - phy_power_on
> - (remaining ones omitted to keep this example short)
>
> I don't know if the order in the dwc2 driver can be changed easily
> (without breaking other platforms).
> Until that dwc2 driver issue is resolved I suggest not applying this
> patch (even though in general I like the approach).
> The same thing also applies for patch #3 from this series (for
> implementing phy_ops.exit)
>
>
> Best regards,
> Martin
>
>
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc2/platform.c#L157

Ok got your point of view.
Thanks for your review comments.

Thanks
-Anand

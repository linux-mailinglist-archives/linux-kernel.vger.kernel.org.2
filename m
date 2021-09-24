Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2115416E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbhIXI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbhIXI5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:57:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC56C061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:56:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so37527155lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nucC4Uj9fJVb5i7ika51MrVjuU9L1cZ58hKW4COSfs0=;
        b=ZifWl6IBuejnQvj5NUQi9mbAMQRXxLvXAUVeVj0JtdwtZ1yoR4bgtWUyjnAK/NfimV
         zsTHM9Oxtq4zsxaXXQusEaPP/fyOB01VN7+rWJSroQyG+xGcxvjv5OMbI9QPz3cJQpz5
         XXs/msnMkNhJuyAUNl5FVc/cXcmI8+/83k1xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nucC4Uj9fJVb5i7ika51MrVjuU9L1cZ58hKW4COSfs0=;
        b=4gXSBxl3AHfGRCXWBf6oiA7C3jwG3+KrB8RwAvwisOrLiQ5UbEzzutwzCXFM/aTjke
         pwXQlDcAxm/WmzvufifjRZFz9/O7RpYfsAsGDZ1HVqR5EdNyK/VSUTPwtHQd19hMOCR9
         PxFMxlB+LgfuQ97gqxwmYZpXEFmp4zisD3tsr3Yj3MhFMJpteub4IYbFQ5bJ8fF6hBK+
         5CHjF+cjmb1CXheQlspKXq4KemJaPsFv3PZhTUBSfp2z2Q+5lSTSYAGvzYm6N1qhnS/x
         nQhLwl0/W+q9XZKCUdMZBcjzaMLd+OjfRY1SGfF996HWTyCABu+ZqF/7UC/UB2e8IbdM
         T0+Q==
X-Gm-Message-State: AOAM533FqF9W8s9QNjO3HGp+zABGlsOc67Yb1PYlmFZC8ofjPxEc7TAl
        dPw4spfKgDnH+X8HlDE9kq2Cj+Sl1COHu2g9rse4tg==
X-Google-Smtp-Source: ABdhPJzTyJNABZRhRQ0xhI+mzCIh0W3gHxvAozxJ7wQ2NzcOsXrNReK4oWoG+x7ejEM+082rbzdkEEt5NWU2yOOzl9k=
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr8426817lff.678.1632473763632;
 Fri, 24 Sep 2021 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210924080632.28410-1-zhiyong.tao@mediatek.com> <20210924080632.28410-5-zhiyong.tao@mediatek.com>
In-Reply-To: <20210924080632.28410-5-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Sep 2021 16:55:52 +0800
Message-ID: <CAGXv+5HXS29-QHhqQ1L7PCwLMBXWXixmSEkyiq-1t5s8zMvGkQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/5] pinctrl: mediatek: support rsel feature
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 4:07 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch supports rsel(resistance selection) feature for I2C pins.
> It provides more resistance selection solution in different ICs.
> It provides rsel define and si unit solution by identifying
> "mediatek,rsel_resistance_in_si_unit" property in pio dtsi node.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

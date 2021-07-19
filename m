Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA13CED46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380793AbhGSRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382399AbhGSRjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:20 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA3C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:59:30 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o19so7658880vsn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH1/eUIRJBS9qo5uiyGnwLYn2LP8i1GLm+MXIIPdtFA=;
        b=MMywfy/BjMCfuhOHJWVkR2S7MSpXQaD30pO0J48pVARLFONKSLegXecUraLMETriO6
         gbQzmBf42qO8Wk7GiQ0MQVadTMbn7lAFxheoEkJlR/VLviydY5NEVr+nuhP1sf+7Uq92
         lXlz42fSV5nmP5zspiturG6yOealg7ndxHdXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH1/eUIRJBS9qo5uiyGnwLYn2LP8i1GLm+MXIIPdtFA=;
        b=frf4otn0nJzDo4a4Prxq2piiza9tBfwb34dfx2HghBYDXyEUPa8pn/Hk1cVKcws4Fy
         OFqlD84OaDSvUMk5mvPjnJIh6w7ngR//dYWQK3xuq8SLnzMQT8dQVi+lRAF7XjqJ4Lg6
         xrY9KBOg/v0p+dSnfHBIIJYWK8M67DbY12DuuywNCnGlv+kkIcAXzJ8BuSqKWRki47GE
         Tp8tRNamlryEtLeNYie9+MFypWgs5rM8pO6GaSsdh754T8dMBUFlTFML3G7pKw7x0Zjt
         GOSduWaq7y8Gr1GEX6OPm6NQd+s033Rb6WGqv2+tiwDmfv/vQOqiYo4f5qAYq8VOCon+
         AiCg==
X-Gm-Message-State: AOAM533/WvFGnoVlDqltpGyjsWy3LSiW61ffi9AAHmoRQ6xY+HgPpUsB
        wqszADbRKy/JFLWVHMQzD88nis1S5BiPhg==
X-Google-Smtp-Source: ABdhPJxYjggGI2w6WAmUQ13d0xEyp77wLlLHtdqz1rC2i6xvbPSLAa4sBBZhjtLtRzH8oXZF/s2fyQ==
X-Received: by 2002:a67:fa84:: with SMTP id f4mr25171329vsq.59.1626718461965;
        Mon, 19 Jul 2021 11:14:21 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id t16sm2389534uao.0.2021.07.19.11.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:14:21 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id e9so9849625vsk.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:14:21 -0700 (PDT)
X-Received: by 2002:a05:6102:144:: with SMTP id a4mr24577620vsr.29.1626718055423;
 Mon, 19 Jul 2021 11:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210623184124.3504047-1-mka@chromium.org> <20210623114025.v13.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
 <YPWhIX06NxpjAfoH@google.com>
In-Reply-To: <YPWhIX06NxpjAfoH@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Jul 2021 11:07:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgAZqQ=MqUeJuozwakRMR8_iS=3kdi-AoB_6VbarhtBw@mail.gmail.com>
Message-ID: <CAD=FV=VgAZqQ=MqUeJuozwakRMR8_iS=3kdi-AoB_6VbarhtBw@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 19, 2021 at 8:58 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Will/Catalin,
>
> does this change looks good to you and could get an Acked-by?
>
> If so: would it be ok to land it through the USB tree with the
> rest of the series? It seems a conflict would be relatively
> unlikely.

Officially I don't think you really need an Ack for most changes to
this file. So says Will [1]:

> although there are a few things I really care about
> in defconfig (e.g. things like page size!), generally speaking we don't
> need to Ack everything that changes in there.

In case it helps, you can stick my Reviewed-by on there...

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20201208160029.GA6461@willie-the-truck

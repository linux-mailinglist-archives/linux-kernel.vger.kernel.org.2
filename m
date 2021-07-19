Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D944E3CED96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385805AbhGSTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385162AbhGSStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:49:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC83C061767
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:19:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v18-20020a17090ac912b0290173b9578f1cso542628pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=czmtwRWIEL9USU9LXlcL6o+bycuxLRk2GKwyT/fyPcg=;
        b=ljBs4KWzCjm4zhiz66qO+uOAVRewx3vmCLvhfPBYoX3G6cALUmPFUZCi23fvs+rfiS
         +xY2QXo6pcGinjPT8tD8U+CEKUlN8yw+reMKhsb3Q/bJvhvMjVv6dI5CyWzeWbMRcD7M
         RVhBWO6hdib6Sx/nEUev3e9jnMR48Idq+LVtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=czmtwRWIEL9USU9LXlcL6o+bycuxLRk2GKwyT/fyPcg=;
        b=NfMchn90GHKskDrRHe7Sag35fGyDQrzGRF5Q+e2mBVPhWroELdeI3alCsD4LLnHS/V
         u2+j0peZj9jt4PU2YczsMBmE5nYftdXaN4if6uDQKfbtBQVY6rYyWTLYnL0kRkbqgttO
         4Ai6QvYwNgWjmmbYnmaSUi2dWkJa14Yh0cTziozrXuI+VVn4y1Tp4VMPv1ltN5I1OAe+
         V385nn3zvaRwUS3GNsAkppBmF8fEE5jGi7VOORoXGRxyTq4oROUfdQH1SPyvpMdLYSfE
         /GbaD5TUMesN64cETsvMxHWo7t3QESNITrVFKZBXTN1Vxw3oVsSBPmiUB/I9MDJdJitC
         /KKw==
X-Gm-Message-State: AOAM530bWyetOW87j0DGIEaVpJ5Yd2oP7vqqfyG0dIMq6HRG86GQTkns
        RQwcRku7UHz1TMplsd1zdtIzWQ==
X-Google-Smtp-Source: ABdhPJx7AeivwoLtAHV4fefibHF+YZGZPzzfHvnQzS7pMkGJgJgdfwTOclScDtBNvtS8G+4aJAlqog==
X-Received: by 2002:a17:90a:6c03:: with SMTP id x3mr12239408pjj.195.1626722916814;
        Mon, 19 Jul 2021 12:28:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4d0:bf5f:b8cd:2d67])
        by smtp.gmail.com with UTF8SMTPSA id e16sm11260763pja.14.2021.07.19.12.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:28:36 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:28:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
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
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 4/7] arm64: defconfig: Explicitly enable
 USB_XHCI_PLATFORM
Message-ID: <YPXSYXNNQISTQ7T1@google.com>
References: <20210623184124.3504047-1-mka@chromium.org>
 <20210623114025.v13.4.Id45138610b749ff775186ac10b3d01c504ddf4f3@changeid>
 <YPWhIX06NxpjAfoH@google.com>
 <CAD=FV=VgAZqQ=MqUeJuozwakRMR8_iS=3kdi-AoB_6VbarhtBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VgAZqQ=MqUeJuozwakRMR8_iS=3kdi-AoB_6VbarhtBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:07:23AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 19, 2021 at 8:58 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Will/Catalin,
> >
> > does this change looks good to you and could get an Acked-by?
> >
> > If so: would it be ok to land it through the USB tree with the
> > rest of the series? It seems a conflict would be relatively
> > unlikely.
> 
> Officially I don't think you really need an Ack for most changes to
> this file. So says Will [1]:
> 
> > although there are a few things I really care about
> > in defconfig (e.g. things like page size!), generally speaking we don't
> > need to Ack everything that changes in there.

Good to know, thanks!

> In case it helps, you can stick my Reviewed-by on there...
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks

I figured the next step is actually a rebase due to a conflict in
v5.14-rc1, commit 8ae030c34dce ("arm64: defconfig: Enable renesas
usb xhci pci host controller") made changes in the same area of
the config.

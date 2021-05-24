Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67E38E6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhEXMxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhEXMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:53:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6CC061574;
        Mon, 24 May 2021 05:51:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j10so14261334edw.8;
        Mon, 24 May 2021 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dD9JUS/9clmQAwtTw0oy+Y0L6eGW7GOSlCzKvAfOcqI=;
        b=uXZObOQAWLi+UqUELweUTgzr0xS+D+JIv93PqQnNec9m1DWvK3ICqM51zXr3H1LNYr
         niW8fRxeIc6J8YtGGWrvJBOLrerpqW314Klei3EwcaLDhhac5I5dcMSMok8WaKoH2AuX
         LGVvbwYGNZEn2k/XNFTXFa6YWl2fdccjLZ9dLzgsUWMhoLktKRLUdGC0J5w+3U2SqgPv
         +BQhqksplDDFCbLkURCCWhxg5XeZez34ewqV9eMPcoh9HFkEr+tQ89VS2EPTjJA+PwvF
         hrDIBl/uE8oybSgvxlaOLY8vpWrfyxawVPh3gTz+4SfBcQoQ4nEVnOgrr0OvFjFgYyLH
         onjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dD9JUS/9clmQAwtTw0oy+Y0L6eGW7GOSlCzKvAfOcqI=;
        b=DWu3ZouAEljQMElL851rp7fbdWOZ4ltKLV1bNojK1XIOqqlg83Rt9Oth7mhq03YJ0e
         Q1DubIN/TmWkI/rZQom1vKtuCxefBB4EGJWVCENf7vs7d0AbT165nXP1StMoSUGyZLVN
         s7trQJRwLEZ7PUCXUJE+w7C46muEVmVgu8IM5RWvOhGLEKE/dk3X2yM0ndiDe1mnMPDG
         pjvGbJ7XlCum5ncRFylxZNo9xu2lzDqs3efx6mUQyNNleb3FcnhEORjlbrWI4FyXn8gd
         QUX+uYHuMOl2KZmmPCG4vpP6dAa4IQ0SdhqxvMEKOVvgAB5rScCYpdfHlEeA8y/JTWIo
         X0og==
X-Gm-Message-State: AOAM5307XPLKFJdU8S2zFwQpiyhR3SG4zy/WpBSDJ9bhUMSRQEiNT3uD
        lQTSHCLcmh65nTBkK+yXQXk=
X-Google-Smtp-Source: ABdhPJyMEkKmMiyUQ3uf21R2RgYMv75IOOJQ9W04QhJLUu7XPaq6mnxSqiA+tfBvgJn1FPWNjpSyNg==
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr25067694edc.362.1621860709805;
        Mon, 24 May 2021 05:51:49 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id u1sm9282891edv.91.2021.05.24.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:51:49 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 12/17] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Date:   Mon, 24 May 2021 14:51:47 +0200
Message-ID: <2348352.12aM7klthN@jernej-laptop>
In-Reply-To: <20210524115946.jwsasjbr3biyixhz@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com> <20210519104152.21119-13-andre.przywara@arm.com> <20210524115946.jwsasjbr3biyixhz@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 24. maj 2021 ob 13:59:46 CEST je Maxime Ripard napisal(a):
> Hi
> 
> On Wed, May 19, 2021 at 11:41:47AM +0100, Andre Przywara wrote:
> > At least the Allwinner H616 SoC requires a weird quirk to make most
> > USB PHYs work: Only port2 works out of the box, but all other ports
> > need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
> > RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
> > the PMU PHY control register needs to be cleared. For this register to
> > be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....
> > 
> > Instead of disguising this as some generic feature, do exactly that
> > in our PHY init:
> > If the quirk bit is set, and we initialise a PHY other than PHY2, ungate
> > this one special clock, and clear the SIDDQ bit. We can pull in the
> > other required clocks via the DT.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> What is this SIDDQ bit doing exactly?

If this is similar to Rockchip USB PHY, then this bit takes care for powering 
up/down analog parts of USB PHY:
https://elixir.bootlin.com/linux/latest/source/drivers/phy/rockchip/phy-rockchip-usb.c#L83

Best regards,
Jernej

> 
> I guess we could also expose this using a power-domain if it's relevant?
> 
> Maxime





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2286380CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhENP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhENP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:28:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CFC061574;
        Fri, 14 May 2021 08:27:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t15so7457010edr.11;
        Fri, 14 May 2021 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3brosy5XXCkmKkwn4l+AKR0pDfb4h3+yvaYa21wYq8=;
        b=mvupAA+p79dUWGrk5E9BhZLhvX9JvYDYdfPKI0wDBotNmCLqg3UFxsUrKQkKJqiY8S
         XhsJVW4vb1kD1hglJRcJzKssA5UudA7JhrLNQ70yXUK4P4dNVfNhXsyKC0nashJtSiwZ
         orl4sFrJASzL4RelDgUo65UasmHetoYz+MTm7rZzbxDsooDJ25IlZrMV4oru0CiIu91y
         5XSaX9kx2z5I0tlTHvbX+dikC1jfIQFiTiLHQSZ1UPlIAfmPlZBSGc/IxYepE/4l+o2L
         AMV6zGQOuc4Rr9IeLJ61y/xUYZV3gHWJZg7j1Q9Po+Gj1YWHfdXEj8coPnAq9LwhRmbF
         /LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3brosy5XXCkmKkwn4l+AKR0pDfb4h3+yvaYa21wYq8=;
        b=dJgC9Q7QtNLjy7e4cs6j9cyBX5CP5pgAsX5N5qlcA3yX+1npO96WyqtLGM/6+6aXCq
         oVoBKV0jMKioStzsf/CFUrBRxGEJbXwzq5xuKFF19isweaNwGlq4o17k0W6hccW8kI+a
         pT53eVQXTOaul2YMv2UGTaC0nhBAgayYQQiyrU3tMUyAisJKTwFcCd+6wprVSfUmLDXd
         SKTAUBTWR+tj6eqLPeLO/PRlvzuSQrzmRG4tlhJnl7j/Zox08vY/ZSAaO72EW2VNuE3S
         8DtTlD25DmKj2HijfWSU3hBNuEikJzycybpSy+vqdS/DQg7F2dOVFYFyiWEQt1soPNq5
         jFeg==
X-Gm-Message-State: AOAM530n4sJkaETlkk/d4qDbzl9KSi2mOj+0Gn646wzgpcnzWo8ivlgR
        gaRKk7cO3+AhFjmyT6ANe59ydMPayh04sBm/IwE=
X-Google-Smtp-Source: ABdhPJzxzvECOpWhrEYSAUed+9/+7dKEurVBbGT3SafR8RZsxzrkQZPj+cNf2hwM9Z2zBQsI6YC4+h9k5GCJ+ejBCoQ=
X-Received: by 2002:a05:6402:310a:: with SMTP id dc10mr56815244edb.38.1621006049041;
 Fri, 14 May 2021 08:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210406013344.124255-1-aford173@gmail.com> <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
 <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com> <VE1PR04MB668860A19062925162C40F3C89509@VE1PR04MB6688.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB668860A19062925162C40F3C89509@VE1PR04MB6688.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 14 May 2021 10:27:17 -0500
Message-ID: <CAHCN7xJ0xPJJaxMrzpZSGKjgh46bSEGgtsECd9ZqnpHKSCH9EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 9:57 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> On 5/11/21 22:49 Adam Ford <aford173@gmail.com> wrote:
>
> > > Compare PIO with DMA on UART, but not w/o this  'spba bus node ' patch?
> > >
> > > > In fact, if the DMA firmware isn't loaded, I often get transfer errors.
> > > UART use SDMA ROM firmware instead of RAM firmware, so it should work
> > > even without sdma RAM firmware loaded.  Still curious what really
> > > happen in your board without this patch.
> >
> > What I am seeing is that at times, the HCI UART loading before the DMA
> > firmware is loaded.
> >
> > [   10.582037] Bluetooth: HCI UART driver ver 2.3
> > [   10.586867] Bluetooth: HCI UART protocol H4 registered
> > [   10.593566] imx-sdma 30bd0000.dma-controller: sdma firmware not
> > ready!
> Seems you apply my patch set ' add ecspi ERR009165 for i.mx6/7 soc family'
> https://www.spinics.net/lists/linux-spi/msg26728.html

I did this on the 5.13-rc1 which appears to have this series applied.

> where 'sdma firmware not ready' added?
>
> > [   10.594548] Bluetooth: HCI UART protocol Broadcom registered
> > [   10.600108] imx-uart 30860000.serial: We cannot prepare for the RX slave
> > dma!
> Why not use ROM script for UART as mailine linux-next did (even the above patch set)?



> If so, I don't think you could such issue on your board. What script(peripheral types) you
> set in uart dts such as below is 4-- MCU domain UART-> IMX_DMATYPE_UART->app_2_mcu:
>
> dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;

I didn't change the DMA references from the default, and I didn't
check to verify whether they are right or not.

>
> >
> > When I get the above message, the bluetooth chip I have throws timeouts and
> > does not function.
> >
> > [   10.615090] imx-sdma 302c0000.dma-controller: loaded firmware 4.5
> >
> > Once the firmware is loaded, I can unload the HCI Uart driver and re-load
> > Bluetooth works again.
> >
> > Based on that, I've been having my system delay the loading of the Bluetooth
> > modules until after the firmware is loaded, but this tells me there is a
> > relationship between the DMA and UART.
> If you use ram script, of course you should use it after firmware loaded. Actually
> Spba bus in dts is only used for per_2_per script judging if the peripheral address
> could be accessed directly by SDMA over SPBA, if yes, set SDMA_WATERMARK_LEVEL_SP
> to let per_2_per script access peripheral over SPBA, otherwise, access peripheral by
> AIPS instead like ARM side did. Please check with below commit for more.
> Besides, per_2_per script is used for audio data sample rate convert between ASRC and
> various audio input. So audio peripherals include ASRC should be in register scope of
> 'spba-bus' . But with your patch, there are two 'spba-bus' device node in dts, so the first
> Spba-bus should contain audio peripheral, otherwise, 'of_find_compatible_node
> (NULL, NULL, "fsl,spba-bus")' may find the wrong one so that SDMA_WATERMARK_LEVEL_SP
> Never be set.

I don't pretend to understand the details of the dma driver, but I
attempted to make the patch match the address range of both spba
busses from the technical reference manual,so there should be an spba
bus for the audio peripherals and an spba bus for the serial
peripherals like UART and SPI.  I only named them spba1 and spba2
based on the memory ranges defined in the ref manual. Table 2-5 shows
SBPA1 is 3080_0000 and table 2-3 shows SPBA2 starts at 3000_0000 which
is what I believe I did in this patch.

>
> BTW, do you mean the above firmware load issue you met is gone if this patch applied?
> If yes, that really surprised me...

I wasn't trying to imply that adding the spba-bus fixes my Bluetooth
issue.  I was just stating there is some relationship between the DMA
and the UART and if the UART throws a DMA error, the Bluetooth will
fail too.  What I have been doing to ensure the order of operations is
to make the imx_sdma and the Bluetooth system as modules.  I tell my
sysfs to load the imx_sdma module first, then load the Bluetooth
modules.  When done in that order, I never see the DMA errors. With
UART baud rates at 3Mbps+, I wanted to make sure the DMA was
operational to help potentially reduce the A53 workload.

adam
>
> commit 8391ecf465ec5c8ccef547267df6d40beb8999a4
> Author: Shengjiu Wang <shengjiu.wang@freescale.com>
> Date:   Fri Jul 10 17:08:16 2015 +0800
>
>     dmaengine: imx-sdma: Add device to device support
>
>
>
>
>

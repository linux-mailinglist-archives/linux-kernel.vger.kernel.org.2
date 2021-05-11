Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3154837A9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEKOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhEKOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:49:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB3C061574;
        Tue, 11 May 2021 07:48:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j26so19538174edf.9;
        Tue, 11 May 2021 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnXg6Kh16FhklatDAvmNh/kvk7jA2VwWCKHJwBrPgEI=;
        b=KjBr6w4Svz3OfDzOH34kdTnM4yU4Tuh/vR+P/XX7L+oBcwVUto0HT4Xh0YYpjQDVsh
         rSADgtm6apdD9p1FwJ1uGRmh5Fl6jJMaLi/xQFQLVLgMNP4W40AIq6n30DnixAzmbtgH
         gxmmd8vwtEx0A396fOrXJ+BNxuMnuTUg+hOy/skPgLnGmf3QmXMsYMY2wPiR1+DLDVPJ
         ZspkCtDVCxti+//8LJih7IWM+bM0KB7eHFLwlzI5EPmcdfeRZbZR74nwNv39/tNbQlFw
         /oVhPn6FfetXSgnne2e2ufpjWR00bZO9SQmWayOeyRN9pX8D8pfPHyyGrwUPV5Y2LoW4
         4+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnXg6Kh16FhklatDAvmNh/kvk7jA2VwWCKHJwBrPgEI=;
        b=fXh54plrdieZitG1DmL+GaAQo+KEkL/LFGaDdczzARYhyLLKVLX1o8piiVk4k3TLgK
         f3pgkUVyU4wDCubnfSy9gDqAp6/BwYFP8hj0m6HcORzpQuzKi167QhV6E1lFe2GvkCX1
         lglwcQ/AKpxYtqrYbyl9Bl9DurL1gD2h8L94xAIk6bc1sD8HJiI2ksrJKD6WwMARyFUD
         HVYAt2PQBFcRLLCAmqDyR3zeDDGIL5IiGQBqpXT/3o587BNDYgl6C11Jssw8cInA6gzk
         A6Y+AUU7rx+Fw6590Scip1z0G/L5l77evET6RlMgF7uHboEpVJKH2uPir0DdxGSWJ43B
         Bf7w==
X-Gm-Message-State: AOAM5335NXGxOc4dTYj6+dl/pwr8/+EzT9NOSDibFPnpbN+n2kMVuGad
        xMj77MehCvnBa0xef0L+FxqXDtHa3F8TOkqfQEU=
X-Google-Smtp-Source: ABdhPJzQFyLz4ZFpSUNk38OWbNw2oSVem0pBtecySCljHXX+NjBW06/tp7bhL/h4Rqn+kDO2lkA1VKhl3Fp6Hd8G4iw=
X-Received: by 2002:a05:6402:310a:: with SMTP id dc10mr36794847edb.38.1620744529500;
 Tue, 11 May 2021 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210406013344.124255-1-aford173@gmail.com> <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com> <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 11 May 2021 09:48:38 -0500
Message-ID: <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
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

On Tue, May 11, 2021 at 7:20 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> On 2021/05/11 18:45 Adam Ford <aford173@gmail.com> wrote:
> > > Also may I ask if you have a real use case for this bus node?
> >
> > The reference manual shows the SPBA bus tells the DMA controller which
> > peripherals are associated with it.  Nearly all the i.MX boards use this.  The
> > boards I support have Bluetooth devices connected to a UART running high
> > speeds, and if the DMA driver isn't loaded, I can see a performance change.
> Compare PIO with DMA on UART, but not w/o this  'spba bus node ' patch?
>
> > In fact, if the DMA firmware isn't loaded, I often get transfer errors.
> UART use SDMA ROM firmware instead of RAM firmware, so it should work
> even without sdma RAM firmware loaded.  Still curious what really happen in
> your board without this patch.

What I am seeing is that at times, the HCI UART loading before the DMA
firmware is loaded.

[   10.582037] Bluetooth: HCI UART driver ver 2.3
[   10.586867] Bluetooth: HCI UART protocol H4 registered
[   10.593566] imx-sdma 30bd0000.dma-controller: sdma firmware not ready!
[   10.594548] Bluetooth: HCI UART protocol Broadcom registered
[   10.600108] imx-uart 30860000.serial: We cannot prepare for the RX slave dma!

When I get the above message, the bluetooth chip I have throws
timeouts and does not function.

[   10.615090] imx-sdma 302c0000.dma-controller: loaded firmware 4.5

Once the firmware is loaded, I can unload the HCI Uart driver and
re-load Bluetooth works again.

Based on that, I've been having my system delay the loading of the
Bluetooth modules until after the firmware is loaded, but this tells
me there is a relationship between the DMA and UART.

adam
>
>
>
>

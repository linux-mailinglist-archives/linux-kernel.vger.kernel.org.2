Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F85306AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhA1B7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:59:01 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40744 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhA1B6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:58:47 -0500
Received: by mail-lf1-f50.google.com with SMTP id v24so5489224lfr.7;
        Wed, 27 Jan 2021 17:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkjX79VSu7ANi8U/i08AlnqB5Gw1OOSgD3fDEXSZ3Ps=;
        b=Z0rd5QLWYMvmqUed/IeuPfED3zZmkY3JLM+Myb7JweDyP/81GAdiQLyzr6gmFDfyQR
         Gdoi3yGVXQYTkMFuc6BDD9QYBhAsATLDFP1NwqjwbsqNp+H2124isBwcL7l7DvbO2sc3
         6x1wUlaop2NIyen7qZ3/ICgeiH9SfRpLeK6UcC7sPmtWioHHygjNIMZ1ZxUvE96Pslzl
         bnD8xhiiIQAIlWdENbBP6A3dnI0BMFUEG0UAt9lZ8Zxw7zJHpZs+caDNDwQKC0dJ3kRd
         A2XNMfHq2LwPynE6sgFJqSNIJrvhzmftA5kZEm74wp8ys2mh7N4EL4UZzCSJuGc6mZPA
         BXoA==
X-Gm-Message-State: AOAM531u8FbEq7kU6466Zn3P3VhRLCEd80xYnFieuwa6hWGNT2OamiYl
        +U7R74gl5vrhnd93V4imyQb4BVk3Kd5Bow==
X-Google-Smtp-Source: ABdhPJzyYAs5oeq3ncblGZrKKonoYXGoMGPKhdJ2O2Mghhjm1R0gDoy2xphXaMKN3ApyKoH+QRoQoA==
X-Received: by 2002:ac2:5f05:: with SMTP id 5mr6614235lfq.127.1611799084324;
        Wed, 27 Jan 2021 17:58:04 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z5sm1043966lfe.64.2021.01.27.17.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 17:58:04 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f1so5522363lfu.3;
        Wed, 27 Jan 2021 17:58:04 -0800 (PST)
X-Received: by 2002:ac2:5293:: with SMTP id q19mr6209580lfm.303.1611799083861;
 Wed, 27 Jan 2021 17:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20210118055040.21910-1-samuel@sholland.org> <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
 <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org> <20210122104705.bo2x22ef56hdj26q@gilmour>
 <52b9c9bb-ff75-d1e6-e198-0d388d1c6d73@sholland.org> <20210125105626.fz75dxhi6f7jtcqm@gilmour>
In-Reply-To: <20210125105626.fz75dxhi6f7jtcqm@gilmour>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jan 2021 09:57:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ksNb+hvqMd6-9_TNoffgZ=-NgfX+gpFvT9kDnSrp0bw@mail.gmail.com>
Message-ID: <CAGb2v66ksNb+hvqMd6-9_TNoffgZ=-NgfX+gpFvT9kDnSrp0bw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 6:56 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sat, Jan 23, 2021 at 12:26:26AM -0600, Samuel Holland wrote:
> > On 1/22/21 4:47 AM, Maxime Ripard wrote:
> > > On Thu, Jan 21, 2021 at 07:33:54PM -0600, Samuel Holland wrote:
> > >> On 1/21/21 2:35 PM, Marc Zyngier wrote:
> > >>> On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
> > >>>> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
> > >>>> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
> > >>>> the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
> > >>>> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
> > >>>> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
> > >>>>
> > >>>> This series replaces the existing chained irqchip driver that could only
> > >>>> control the NMI, with a stacked irqchip driver that also provides wakeup
> > >>>> capability for those multiplexed SPI IRQs. The idea is to preconfigure
> > >>>> the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
> > >>>> as soon as it receives an IRQ. It can also decide how deep it can
> > >>>> suspend based on the enabled wakeup IRQs.
> > >>>>
> > >>>> [...]
> > >>>
> > >>> Applied to irq/irqchip-5.12, thanks!
> > >>>
> > >>> [01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
> > >>>         commit: ad6b47cdef760410311f41876b21eb0c6fda4717
> > >>> [02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
> > >>>         commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
> > >>> [03/10] irqchip/sun6i-r: Use a stacked irqchip driver
> > >>>         commit: 4e34614636b31747b190488240a95647c227021f
> > >>> [04/10] irqchip/sun6i-r: Add wakeup support
> > >>>         commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003
> > >>>
> > >>> Please route the dts patches via the soc tree. Also, I had to
> > >>> manually fix the first patch as it wouldn't apply on top of
> > >>> 5.11-rc4 (which tree has it been diffed against?). Please
> > >>> check that the resolution is correct.
> > >>
> > >> This series was based on sunxi/for-next, which contains commit
> > >> 752b0aac99c7 ("dt-bindings: irq: sun7i-nmi: Add binding documentation
> > >> for the V3s NMI")[1].
> > >
> > > I assume merging the DT bits alone would break things? If so, I guess we
> > > can wait for 5.12 to be released before merging it
> >
> > Patch 5 does not depend on the new driver, so it could be merged at any
> > time. Yes, the remaining patches would break things if merged without
> > the driver.
>
> I've applied patch 5 then, could you send the rest of the DT patches
> when 5.13-rc1 is out?

I've put them in a for-5.13-late branch and merged them into for-next.
This should get a bit of boot testing via KernelCI. Maybe we'll get to
sending a late pull request for 5.13, maybe not.

ChenYu

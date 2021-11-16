Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363EF453926
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhKPSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhKPSHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:07:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75BC061570;
        Tue, 16 Nov 2021 10:04:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so35206447eda.12;
        Tue, 16 Nov 2021 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S00cZYjJS5B2ipxZwFq4XXVl6pSa2hTsTbEl4vf8W8=;
        b=fyfMYhSC33bK5D2F1TX4Uk95i9s5yuxB0ijFmVFXXaLpSAPG/G88oFq4RRJBGplQoz
         vlXLh/BxmteywjbyfoBPfQBF4cshFtz9Bcukdf2myLT1HzRDDoUAR8KldrrTh/V9szol
         6H7lmnNrwU1WF+ejjjAWZJNPaNDUTkBctJf/mWzNmx18vBsOYrAujuzVmglipR9n+Meo
         NjwlYSCPt7Ee/MxUnRvFO5qK/HUARWcSiQKgzM4ghpqrt/g8SJ6um/joplvQ3rTrtkil
         aHbPJX+VHo1WEhWGoWnMJm+wu9gQqNIH8FFMuCb+M3xUcXzNRyFJJCyxewWRlFzbVH5c
         fJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S00cZYjJS5B2ipxZwFq4XXVl6pSa2hTsTbEl4vf8W8=;
        b=t1sSdYt0sfvB+NyHHFwbaVSd28ZFUdK0Cki0dK60BO68KynGyIBTXA9fqm15muZY2m
         QNkoPeb/qUz9s29zRpSGqywH9y9R99l8pXTZPpWvhs8Ri2ThvZilZbM5GtJawEMskGVF
         uujsKC8KFYjI4F4mjm9CDxXaKTKI5NxziIq3i6cF1w3SF/qXrxv4xBx00nEmmXehVXVM
         SIHHxSMfiWnvP6eay5xb8r/pOsUU2sFPB+luJ2Gr1FnDm2YdHLKB1IyCfHEn7y6sc5YO
         96nD6VHNSp3OnuIY20+VUYVehRWFReifDAWglfD3bTrpZzadQK+rpo6GPs1lsmwnB6Tz
         4NHQ==
X-Gm-Message-State: AOAM533p39+2qNcizxg0zWtoXTHnjINCBK8vMOtqUoC5x/e/SOT0KDlh
        IwFZ2WW8uYwp02I+1Uw47yLMenzWehWHMLxlDnI=
X-Google-Smtp-Source: ABdhPJy8ntBTwxCwIVdOUaYVsJaADTSztW9TgIFn+NMnDozLqErKNxV9XpelcPe8Axtota6BpT2YKGvzZWOuHSOpLRg=
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr9482571edd.296.1637085887127;
 Tue, 16 Nov 2021 10:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 16 Nov 2021 12:04:36 -0600
Message-ID: <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        ariel.dalessandro@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:57 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Nov 4, 2021 at 9:18 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> > different in others.  With the blk-ctrl driver for Mini in place,
> > this series expands the blk-ctrl driver to support the Nano which
> > opens the door for additional functions in the future.  As part of
> > this series, it also addresses some issues in the GPCv2 driver and
> > finally adds support for enabling USB and GPU.
> >
> > V3:  Fixes an the yaml example
> > V2:  Fixes the clock count in the blk-ctrl
> >
> > Adam Ford (9):
> >   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
> >   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
> >   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
> >   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
> >   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
> >   arm64: dts: imx8mn: add GPC node
> >   arm64: dts: imx8mn: put USB controller into power-domains
> >   arm64: dts: imx8mn: add DISP blk-ctrl
> >   arm64: dts: imx8mn: Enable GPU
> >
> >  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
> >  drivers/soc/imx/gpcv2.c                       |  26 +++++
> >  drivers/soc/imx/imx8m-blk-ctrl.c              |  75 ++++++++++++-
> >  include/dt-bindings/power/imx8mn-power.h      |   5 +
> >  5 files changed, 305 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> >
>
> Adam,
>
> Thanks for the patches. I'm not sure how best to test this but on an
> imx8mm-venice-gw7902 which has USB, but no display.
>
> I find that if DRM_ETNAVIV is enabled I hang at 'etnaviv etnaviv:
> bound 38000000.gpu (ops 0xffff800010964748)'.

Thanks for testing this.

Does your board send power to the GPU?  I recall someone somewhere
didn't power theirGPU, but I can't remember who and/or what board was
being discussed.

I'll run some more tests on the latest 5.16-rc1 to see if I can
replicate your issue.

adam
>
> If DRM_ETNAVIV is not enabled:
> - boots fine
> - usb works
> - soft reboot works (does not hang)

At least we have some progress.  :-)

adam
>
> Best regards,
>
> Tim

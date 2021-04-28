Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B536D25D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhD1GpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhD1GpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:45:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13001C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:44:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m12so3298328pgr.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=15uylzY/6G4QGzIetCjgcwa71pGsoemaoMMUbOf1OF8=;
        b=Rya3B8hVJWCqcQXCncB39QBMqTfyIiJg1ox5Ro+8u80KE6ueEIhfOrnhD64M8YYIGX
         kPwrWMni+mSOXWzsn+G0Q7w/3YG4SGS+fuN/uGJJ2RG0a5/TEDbwVMZy2Oxh49AesoTa
         6k7jr9D7VLmhurqHyJ4hYPoGyltOQRGPvVwtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=15uylzY/6G4QGzIetCjgcwa71pGsoemaoMMUbOf1OF8=;
        b=ZweAF2VBtPz2e0CsVPAGYmk3Lla8Qa6WbMUx92MkamqiMlEd+BmJTo3jmxOlCj/y8C
         KOtzUoYmqXWHyTI3IJl5vSXLbSlSkYkMgZhaQ950KBqYCeyrCihJQ6XpgX8A3TVTe004
         21AG/7FoxifOV7yfkHTeqxg8Qcke77gmE04kFCmzlQ4Zb0VYH/rwNEiFZwpPy40Xl/Va
         P7ZCsibxD+pFCAS9OIDwTmBUaWN9Y6sMMz4s678jHrT4D7T0qPlwXWzVNAJV1eUIxwTS
         o3TUnthdFvSV+xg/88e2WcOsS26Ux1h5RcKltn/+JMvd0TeZX6sM+P/bWfBbf/DcdULQ
         G51A==
X-Gm-Message-State: AOAM530vP/nLv13qGKi/XD8yg+rNM/m5d+mkpOZ2alDNkk1Q52ue7cSd
        bnmwcMJ4od6pzCzMG0G2ewWyBIb2LVXefvgdi7qquw==
X-Google-Smtp-Source: ABdhPJyy+OG4HCYkDm5Rra9kCy+bdP0DLqG38XpNmu1j3/4nOvQXGEeSdduJj8VENN8KoYgthEUkX2vNb7xIVNqw4DQ=
X-Received: by 2002:a63:8149:: with SMTP id t70mr5744917pgd.299.1619592269389;
 Tue, 27 Apr 2021 23:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210324104110.13383-1-chun-jie.chen@mediatek.com> <1617881329.6756.3.camel@mtksdccf07>
In-Reply-To: <1617881329.6756.3.camel@mtksdccf07>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 28 Apr 2021 14:44:18 +0800
Message-ID: <CAATdQgBkY0Gc+WpGkvf9CuRF_WpJTymzi+j2whQ13pfCoxBWmg@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 00/22] Mediatek MT8192 clock support
To:     20181221120906 created <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping again.

On Thu, Apr 8, 2021 at 7:29 PM 20181221120906 created
<chun-jie.chen@mediatek.com> wrote:
>
> On Wed, 2021-03-24 at 18:40 +0800, Chun-Jie Chen (=E9=99=B3=E6=B5=9A=E6=
=A1=80) wrote:
>
> Hi Maintainers,
>
> Gentle pin for this patch series.
>
> Thanks
>
> > reason for resending v7:
> > - add review history from series below
> > [1] https://urldefense.com/v3/__https://patchwork.kernel.org/project/li=
nux-mediatek/list/?series=3D405295__;!!CTRNKA9wMg0ARbw!yiC4Bd7Av9itRUTEQeBU=
WbH_wX08o2rIYTH0BJ_BljLXWzCPb2sYdGLjFLwWBXEY4iHa$
> >
> > change since v6:
> > - update from series below
> > [1] https://urldefense.com/v3/__https://patchwork.kernel.org/project/li=
nux-mediatek/list/?series=3D405295__;!!CTRNKA9wMg0ARbw!yiC4Bd7Av9itRUTEQeBU=
WbH_wX08o2rIYTH0BJ_BljLXWzCPb2sYdGLjFLwWBXEY4iHa$
> > - fix DT bindings fail
> > - fix checkpatch warning
> > - update mux ops without gate control
> >
> > change since v5:
> > - remove unused clocks by rolling Tinghan's patches[1][2] into series
> > [1] https://urldefense.com/v3/__https://patchwork.kernel.org/project/li=
nux-mediatek/list/?series=3D398781__;!!CTRNKA9wMg0ARbw!yiC4Bd7Av9itRUTEQeBU=
WbH_wX08o2rIYTH0BJ_BljLXWzCPb2sYdGLjFLwWBS6llsNi$
> > [2] https://urldefense.com/v3/__https://patchwork.kernel.org/project/li=
nux-mediatek/list/?series=3D405143__;!!CTRNKA9wMg0ARbw!yiC4Bd7Av9itRUTEQeBU=
WbH_wX08o2rIYTH0BJ_BljLXWzCPb2sYdGLjFLwWBfBntgEt$
> > - remove dts related patches from series
> >
> > change since v4:
> > - merge some subsystem into same driver
> > - add a generic probe function to reduce duplicated code
> >
> > changes since v3:
> > - add critical clocks
> > - split large patches into small ones
> >
> > changes since v2:
> > - update and split dt-binding documents by functionalities
> > - add error checking in probe() function
> > - fix incorrect clock relation and add critical clocks
> > - update license identifier and minor fix of coding style
> >
> > changes since v1:
> > - fix asymmetrical control of PLL
> > - have en_mask used as divider enable mask on all MediaTek SoC
> >
> > chun-jie.chen (22):
> >   dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c
> >     wrapper controller
> >   dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys
> >     controller
> >   dt-bindings: ARM: Mediatek: Add new document bindings of msdc
> >     controller
> >   dt-bindings: ARM: Mediatek: Add new document bindings of scp adsp
> >     controller
> >   dt-bindings: ARM: Mediatek: Document bindings of MT8192 clock
> >     controllers
> >   clk: mediatek: Add dt-bindings of MT8192 clocks
> >   clk: mediatek: Fix asymmetrical PLL enable and disable control
> >   clk: mediatek: Add configurable enable control to mtk_pll_data
> >   clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
> >   clk: mediatek: Add MT8192 basic clocks support
> >   clk: mediatek: Add MT8192 audio clock support
> >   clk: mediatek: Add MT8192 camsys clock support
> >   clk: mediatek: Add MT8192 imgsys clock support
> >   clk: mediatek: Add MT8192 imp i2c wrapper clock support
> >   clk: mediatek: Add MT8192 ipesys clock support
> >   clk: mediatek: Add MT8192 mdpsys clock support
> >   clk: mediatek: Add MT8192 mfgcfg clock support
> >   clk: mediatek: Add MT8192 mmsys clock support
> >   clk: mediatek: Add MT8192 msdc clock support
> >   clk: mediatek: Add MT8192 scp adsp clock support
> >   clk: mediatek: Add MT8192 vdecsys clock support
> >   clk: mediatek: Add MT8192 vencsys clock support
> >
> >  .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
> >  .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
> >  .../bindings/arm/mediatek/mediatek,camsys.txt |   22 +
> >  .../bindings/arm/mediatek/mediatek,imgsys.txt |    2 +
> >  .../arm/mediatek/mediatek,imp_iic_wrap.yaml   |   80 +
> >  .../arm/mediatek/mediatek,infracfg.txt        |    1 +
> >  .../bindings/arm/mediatek/mediatek,ipesys.txt |    1 +
> >  .../arm/mediatek/mediatek,mdpsys.yaml         |   40 +
> >  .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
> >  .../bindings/arm/mediatek/mediatek,msdc.yaml  |   48 +
> >  .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
> >  .../arm/mediatek/mediatek,scp-adsp.yaml       |   40 +
> >  .../arm/mediatek/mediatek,topckgen.txt        |    1 +
> >  .../arm/mediatek/mediatek,vdecsys.txt         |    8 +
> >  .../arm/mediatek/mediatek,vencsys.txt         |    1 +
> >  drivers/clk/mediatek/Kconfig                  |   80 +
> >  drivers/clk/mediatek/Makefile                 |   13 +
> >  drivers/clk/mediatek/clk-mt8192-aud.c         |  118 ++
> >  drivers/clk/mediatek/clk-mt8192-cam.c         |  107 ++
> >  drivers/clk/mediatek/clk-mt8192-img.c         |   70 +
> >  .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  119 ++
> >  drivers/clk/mediatek/clk-mt8192-ipe.c         |   57 +
> >  drivers/clk/mediatek/clk-mt8192-mdp.c         |   82 +
> >  drivers/clk/mediatek/clk-mt8192-mfg.c         |   50 +
> >  drivers/clk/mediatek/clk-mt8192-mm.c          |  108 ++
> >  drivers/clk/mediatek/clk-mt8192-msdc.c        |   85 ++
> >  drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |   50 +
> >  drivers/clk/mediatek/clk-mt8192-vdec.c        |   94 ++
> >  drivers/clk/mediatek/clk-mt8192-venc.c        |   53 +
> >  drivers/clk/mediatek/clk-mt8192.c             | 1326 +++++++++++++++++
> >  drivers/clk/mediatek/clk-mtk.c                |   23 +
> >  drivers/clk/mediatek/clk-mtk.h                |   28 +-
> >  drivers/clk/mediatek/clk-mux.c                |    9 +-
> >  drivers/clk/mediatek/clk-mux.h                |   18 +-
> >  drivers/clk/mediatek/clk-pll.c                |   31 +-
> >  include/dt-bindings/clock/mt8192-clk.h        |  585 ++++++++
> >  37 files changed, 3335 insertions(+), 20 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/medi=
atek,imp_iic_wrap.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/medi=
atek,mdpsys.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/medi=
atek,msdc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/medi=
atek,scp-adsp.yaml
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt8192.c
> >  create mode 100644 include/dt-bindings/clock/mt8192-clk.h
> >
> > --
> > 2.18.0
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo=
/linux-mediatek__;!!CTRNKA9wMg0ARbw!yiC4Bd7Av9itRUTEQeBUWbH_wX08o2rIYTH0BJ_=
BljLXWzCPb2sYdGLjFLwWBdxKKU1e$
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

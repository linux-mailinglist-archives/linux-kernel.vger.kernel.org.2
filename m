Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B436ABBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhDZFHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDZFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:07:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96483C061756
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:06:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id md17so873177pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhZaODxqN9w5BWIbem3PBfmTTnp3Tc+zpO8RECDcnck=;
        b=JVbpT3UXCl4pqh1lPbrs7oiW8zT93eZ10YNQbbi732zPA5ddUaFSBpnQBjws0z3ZAf
         w500yc2qElu3kuOHGiPUOnYr2khNF+CH71/XLgh+fdxxn+TbecChxCP5JFfv7ZIGGWzV
         l4mL+6ew4bouLKV/K6qlmcjl+hrE6E+PvBd78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhZaODxqN9w5BWIbem3PBfmTTnp3Tc+zpO8RECDcnck=;
        b=muNMxDQAV8DX3sTP23obt7HCgGGBA+SRHr6a+8aLJ0VsugNWe0odXjn87UxaTbQMfK
         Z79BgLpt0jdFm0FRSgZcunc1OSoRj+ooLdLb+iKs/F/Xv4CNMpVrKWPPp78EzsVeo1xO
         LLoJm8DebkYh2cxbb7d6e52RSOIHsB1zXyPczWwhHSXqxWV35+d+OCbXNLzLF3bRKGzI
         WSCp4KMp3yqmyAv0chisBBxt2B3Atq3y9feQRsfshy4GoY47TQ98gufgVlK0PqTQIoOv
         FCp9aEBAnmfipgJ+5sSdJrJLr5PsZn/hcI2J3uQSWcKL2Sb56gRN59Q8kQV50ohWCQs0
         wVYg==
X-Gm-Message-State: AOAM532dkwuzO2n7UGanHl+co2LNIOqWJF5nShlQjwpOyduwgzGnyrVP
        b1ox1RNT41fF9VCl3wMVw2gMd7WPeL0g7V2E7E0cLQ==
X-Google-Smtp-Source: ABdhPJwAtTkGkLEqNAMjhq9yXWrHFTQ7TYqELP+yZd5u+0rnLD3WlQPG20w5TjTBRPB4RHY/5Zns5fR//eXNedKWiXQ=
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr915936pjs.112.1619413593036;
 Sun, 25 Apr 2021 22:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210323113512.4980-1-chun-jie.chen@mediatek.com>
In-Reply-To: <20210323113512.4980-1-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 26 Apr 2021 13:06:22 +0800
Message-ID: <CAATdQgD8zGGsW0fDpba5Bf-Xv-DFAwuVSFpKgB33Qxy=5Ds5cg@mail.gmail.com>
Subject: Re: [PATCH v7 00/22] Mediatek MT8192 clock support
To:     "chun-jie.chen" <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 7:36 PM chun-jie.chen
<chun-jie.chen@mediatek.com> wrote:
>
> change since v6:
> - update from series below
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405295
> - fix DT bindings fail
> - fix checkpatch warning
> - update mux ops without gate control
>
> change since v5:
> - remove unused clocks by rolling Tinghan's patches[1][2] into series
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=398781
> [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405143
> - remove dts related patches from series
>
> change since v4:
> - merge some subsystem into same driver
> - add a generic probe function to reduce duplicated code
>
> changes since v3:
> - add critical clocks
> - split large patches into small ones
>
> changes since v2:
> - update and split dt-binding documents by functionalities
> - add error checking in probe() function
> - fix incorrect clock relation and add critical clocks
> - update license identifier and minor fix of coding style
>
> changes since v1:
> - fix asymmetrical control of PLL
> - have en_mask used as divider enable mask on all MediaTek SoC
>
> chun-jie.chen (22):
>   dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c
>     wrapper controller
>   dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys
>     controller
>   dt-bindings: ARM: Mediatek: Add new document bindings of msdc
>     controller
>   dt-bindings: ARM: Mediatek: Add new document bindings of scp adsp
>     controller
>   dt-bindings: ARM: Mediatek: Document bindings of MT8192 clock
>     controllers
>   clk: mediatek: Add dt-bindings of MT8192 clocks
>   clk: mediatek: Fix asymmetrical PLL enable and disable control
>   clk: mediatek: Add configurable enable control to mtk_pll_data
>   clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
>   clk: mediatek: Add MT8192 basic clocks support
>   clk: mediatek: Add MT8192 audio clock support
>   clk: mediatek: Add MT8192 camsys clock support
>   clk: mediatek: Add MT8192 imgsys clock support
>   clk: mediatek: Add MT8192 imp i2c wrapper clock support
>   clk: mediatek: Add MT8192 ipesys clock support
>   clk: mediatek: Add MT8192 mdpsys clock support
>   clk: mediatek: Add MT8192 mfgcfg clock support
>   clk: mediatek: Add MT8192 mmsys clock support
>   clk: mediatek: Add MT8192 msdc clock support
>   clk: mediatek: Add MT8192 scp adsp clock support
>   clk: mediatek: Add MT8192 vdecsys clock support
>   clk: mediatek: Add MT8192 vencsys clock support
>
>  .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt |   22 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt |    2 +
>  .../arm/mediatek/mediatek,imp_iic_wrap.yaml   |   80 +
>  .../arm/mediatek/mediatek,infracfg.txt        |    1 +
>  .../bindings/arm/mediatek/mediatek,ipesys.txt |    1 +
>  .../arm/mediatek/mediatek,mdpsys.yaml         |   40 +
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
>  .../bindings/arm/mediatek/mediatek,msdc.yaml  |   48 +
>  .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
>  .../arm/mediatek/mediatek,scp-adsp.yaml       |   40 +
>  .../arm/mediatek/mediatek,topckgen.txt        |    1 +
>  .../arm/mediatek/mediatek,vdecsys.txt         |    8 +
>  .../arm/mediatek/mediatek,vencsys.txt         |    1 +
>  drivers/clk/mediatek/Kconfig                  |   80 +
>  drivers/clk/mediatek/Makefile                 |   13 +
>  drivers/clk/mediatek/clk-mt8192-aud.c         |  118 ++
>  drivers/clk/mediatek/clk-mt8192-cam.c         |  107 ++
>  drivers/clk/mediatek/clk-mt8192-img.c         |   70 +
>  .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  119 ++
>  drivers/clk/mediatek/clk-mt8192-ipe.c         |   57 +
>  drivers/clk/mediatek/clk-mt8192-mdp.c         |   82 +
>  drivers/clk/mediatek/clk-mt8192-mfg.c         |   50 +
>  drivers/clk/mediatek/clk-mt8192-mm.c          |  108 ++
>  drivers/clk/mediatek/clk-mt8192-msdc.c        |   85 ++
>  drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |   50 +
>  drivers/clk/mediatek/clk-mt8192-vdec.c        |   94 ++
>  drivers/clk/mediatek/clk-mt8192-venc.c        |   53 +
>  drivers/clk/mediatek/clk-mt8192.c             | 1326 +++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.c                |   23 +
>  drivers/clk/mediatek/clk-mtk.h                |   28 +-
>  drivers/clk/mediatek/clk-mux.c                |    9 +-
>  drivers/clk/mediatek/clk-mux.h                |   18 +-
>  drivers/clk/mediatek/clk-pll.c                |   31 +-
>  include/dt-bindings/clock/mt8192-clk.h        |  585 ++++++++
>  37 files changed, 3335 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
>  create mode 100644 drivers/clk/mediatek/clk-mt8192.c
>  create mode 100644 include/dt-bindings/clock/mt8192-clk.h
>
> --
> 2.18.0
>

A gentle ping on this series.

Thanks!

>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

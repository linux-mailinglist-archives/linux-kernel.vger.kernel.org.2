Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA409379D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEKDTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:19:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C49C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:18:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l21so16848606iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkHDlYFluPki2ZdUn0/eNDhFO7FqUp9u17CiwZh22fI=;
        b=mTFWoS6vW84BXMZlAa+QisfevYOw9aQGHn03C7IpjFYVCHUvAFmLmfRnnKOMgnch6A
         F5tqeukS8/OV4hrfyHJcyO7fsYN/V9XaVD6Uf7xie0bG9KgBlDHH9bmSxm+HrNDvDgSB
         TMl+2Ng1YPohPWBnJyb7kB3XZJYx2xWNO85r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkHDlYFluPki2ZdUn0/eNDhFO7FqUp9u17CiwZh22fI=;
        b=PDCEmuheeIym4NugwWcLGiOvIoYGEX2MXk0B9ghp8vigk9rBQOGuDFgNhKqWWaGrzb
         mhb/1k/wPe4d0aloFRgX3J+2O25faa1yxbAJyLPyj+lVpWmO8CSmkLJyZhUXMD4QoAKo
         ft8C57OEkrKG5FvjSYTSbgMxKWZTj9Rh9mpHQlHxj+P8yciwhi258daOqzcHayYRGQBw
         snXQg1y2sGGSYenC97+Gde1l/J8EXwxKMtuMlz/YXnv61Ud/B7nqkstUnRkr3x/ifPwS
         2iVOjcOF0jaSultbP1IvWEcg7T/5vFIEhs+i4vZxNM7TjKLX/xlFmndHKRyk48S9vEeq
         ic8Q==
X-Gm-Message-State: AOAM532Upsh1OUbi2hdsMF0Y0nJXAKSt8wI23FpOOT1Fgr0BfynDrZKi
        9JtRWZ+FZXXPftiWduNCTG1MUyfThtQ94OEmtRLH6g==
X-Google-Smtp-Source: ABdhPJyrD8bDd6jE5FS8jaJSkAfnWnTZbGMj2SNEByq0yqDn2YByH4a4ZLSTNDq73en4LDotx14twU2BKaNZJ46rNQ8=
X-Received: by 2002:a5d:9694:: with SMTP id m20mr20648173ion.40.1620703101484;
 Mon, 10 May 2021 20:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210421090601.730744-1-hsinyi@chromium.org>
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 11 May 2021 11:17:55 +0800
Message-ID: <CAJMQK-jxUwoz_zP-PgoEhnjqxzFC965csj0tNjuTxUT7Rg7Cmg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Add several jacuzzi boards
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 5:06 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Add several jacuzzi follower devices: kappa, willo, burnet, kenzo, and
> fennel.
>

Hi Matthias,

Can you help pick this series? thanks.


> Change log:
> v2 -> v3:
>  - remove unused property in i2c2 in willow and burnet.
>  - add fennel.
>
> Hsin-Yi Wang (10):
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
>   dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-fennel
>   arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
>   arm64: dts: mt8183: Add kukui-jacuzzi-willow board
>   arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
>   arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
>   arm64: dts: mt8183: Add kukui-jacuzzi-fennel board
>
>  .../devicetree/bindings/arm/mediatek.yaml     | 29 +++++++++++-
>  arch/arm64/boot/dts/mediatek/Makefile         |  8 ++++
>  .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 30 +++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel-sku1.dts      | 44 +++++++++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel-sku6.dts      | 32 ++++++++++++++
>  .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 27 ++++++++++++
>  .../mt8183-kukui-jacuzzi-fennel14.dts         | 16 +++++++
>  .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   | 16 +++++++
>  .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   | 12 +++++
>  .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 ++++++
>  .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 +++++
>  .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 26 +++++++++++
>  .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  8 ++++
>  13 files changed, 271 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
>
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9907D37177C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhECPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhECPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:06:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF97C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 08:05:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f24so8353863ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=kkLHrS0ofkE+YRgADp77s8W+PKn0GKptcBr+B7OS3xA=;
        b=dSvcMix4NZkdXHKFvMmFcsvN8T+XeE4OhpbGEP9vYPvXYf+Wp0r5/hj4/TbToYCGbC
         JH4S19mCIJcLHiN9Wf++jtFjQW8B7LBqG3QVQDhH8VBDHpHoz6qWJwQZVxfHTR4vdwtO
         CCWkCYV6I1e7B2BClyWRuLi0P0RL//c5+7SsdLHtXMmc0MyYE+2b+Yud9HgTEOfZtnyo
         a5kf+mbUbaSr0Jd9mVLdWVKvIbj+wbhZOXCacSRAdwzUrlqOeMIduH0sXQJ82s+5oJ3T
         mOMcA+XTmE1a1O5d/xuF+2nMrBcOsm4vLvTuAxj2IrSzO57ATvc5znWOisq5iFmV5v/u
         pF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=kkLHrS0ofkE+YRgADp77s8W+PKn0GKptcBr+B7OS3xA=;
        b=Wpnz47wKcJEdeDaCSyjXnRXUnMX09pJb8c56uVpBmdVa/DnSSM4uMd59z4/82td3BL
         x0P9406FN+pAr211jqJClLKV+LfWsdudstMNgM2FNV7zuLZM0WNfXVkiLBExwzyw39+a
         VrW6RgR9zXE6Ni+6W4qqY6VPeTu0PQBNMNHYs38y4S7ELSFfBOJ1lYK4PjI6SLE5Ok1N
         2X/67Y+Fho10T+EvnsFVz3fYfB5R3VQbku7mo1/Mi4mbDrdvSMK18FgccmI3BqeIlmKv
         x6x76y9o435Y+9XoTBqxMqO8wMzssW3WEf07NtUrmVHIUQlDOMwyDlqEI1Lx6K2Fr3O/
         MkcQ==
X-Gm-Message-State: AOAM533te3/c+DfhiR3J8wdWXsG6hiK1WsYwo7U87oQO7huxLiT16G4t
        WLMoRdoIxGbEIqCGm4MNR6jPjzVBeeaB/93q
X-Google-Smtp-Source: ABdhPJwj8qmkT3Q16/vnKVoyTOiBJaX3gt9H3JD2BovwlpoOZV4hL7hxJcc2ZF6irUXO0VgADStxLQ==
X-Received: by 2002:a17:907:a076:: with SMTP id ia22mr17033044ejc.233.1620054312349;
        Mon, 03 May 2021 08:05:12 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id z7sm3534527edi.39.2021.05.03.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:05:11 -0700 (PDT)
References: <20210503145503.1477-1-linux.amoon@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCHv1 0/9] Added Audio and HDMI power domain for Amlogic SoC
In-reply-to: <20210503145503.1477-1-linux.amoon@gmail.com>
Message-ID: <1jsg336eoo.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 03 May 2021 17:05:11 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 03 May 2021 at 16:54, Anand Moon <linux.amoon@gmail.com> wrote:

> Patch series add Audio and Hdmi power domain for Amlogic SoC.
>
> Tested on GXBB - Odroid C2
>           SM1  - Odroid C4
>           G12B - Odroid N2
> -Anand
>

AFAIK, the audio power domain is a no-op on the g12/sm1. At least this
is what we've been told by AML. Unless this solves something, I don't
think it should be done at all.

> Anand Moon (9):
>   soc: amlogic: meson-ee-pwrc: Add audio power domain Meson g12a and
>     g12b SoCs
>   arm64: dts: amlogic: Add audio power domain for g12a and g12b
>   soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson g12a SoCs
>   arm64: dts: amlogic: Add hdmi power domain for g12a and g12b
>   soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson sm1 SoCs
>   arm64: dts: amlogic: Add audio power domain for sm1 SoC
>   arm64: dts: amlogic: Add hdmi power domain for sm1 sbc
>   soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson gxbb and gxl
>     SoCs
>   arm64: dts: amlogic: Add hdmi power domain for gxbb and gxl
>
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts    |  2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts      |  1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts  |  1 +
>  .../arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts |  1 +
>  arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts    |  1 +
>  .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi |  2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts |  1 +
>  arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi     |  1 +
>  .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi      |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  1 +
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts      |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi    |  1 +
>  .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts     |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts |  1 +
>  .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |  1 +
>  .../dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts  |  1 +
>  .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts     |  1 +
>  .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts |  1 +
>  .../arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  1 +
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi    |  2 ++
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts     |  2 ++
>  drivers/soc/amlogic/meson-ee-pwrc.c                  | 12 ++++++++++++
>  include/dt-bindings/power/meson-g12a-power.h         |  2 ++
>  include/dt-bindings/power/meson-gxbb-power.h         |  1 +
>  include/dt-bindings/power/meson-sm1-power.h          |  1 +
>  33 files changed, 50 insertions(+)


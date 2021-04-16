Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA33617F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 05:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhDPDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 23:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDPDEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:04:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC918C061574;
        Thu, 15 Apr 2021 20:03:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ef17so7140901qvb.0;
        Thu, 15 Apr 2021 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q26+v9m6OHwgu5yJO9W58aHk+91HmRzWJqWAxjmAjYg=;
        b=Eyr7g0DXodj0YWyiHAZQvIHMwU0PVbUa4XiJJaYRoMR1fz/x6N15b6AglJ/HyiI0Nw
         R53FNij7DbgHDMAwyiggIBuiiGvIobBsKLX9p/LP4Q190TKIKqJI3XntLvkiasHGB/GM
         OpjCvykQFFbeGC+W6jiisQeZIGpu6utfnPIcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q26+v9m6OHwgu5yJO9W58aHk+91HmRzWJqWAxjmAjYg=;
        b=Yeb2/US8ViunPtpdvfbhB3WLugvYu33DAwkDDtRI+f3lNsasadx3jLyTk8DzYkoesP
         5D7FsYsBHUH9h2SWuwGlXeTzoVKLqAPOI2Q/RrizWMDoFcMzntGNlWF8bJR9xTeKZw69
         NiPUWlBzaOpG0KgOi4TebImNERGsmGrcXMJs01vBa4xN/TqcKuB/tyiQi9Zi9799Ez3N
         K3MwyemytLEDquEUquHNsF2KMj+u57szWwo3OZENsgtxKYGV19FnjBQXQo2v4qTiZkZX
         YWHpzgtY9TQabqwwy26UbyhXMXouga1l4tjdgLUBFwhERoWnc5lQt+ps4sZwoZxs9J5y
         mziQ==
X-Gm-Message-State: AOAM53293J9lVLxVgJvhEOG/jm1banf0u2mHfCSG6LVF+5zC/Ls2YZiw
        LmFmW+cgFkbd7Bik+Wyl2gfd9LFfkCN4EjhU5fw=
X-Google-Smtp-Source: ABdhPJxsDfazEoAzmRD7FlKhlHPECMQcCoMQ1AW1TfMq+yhvzo+OtyjUw7EkrvsL1LWKEEylHKzYzXAlfCRCBWIHjNs=
X-Received: by 2002:a0c:eb06:: with SMTP id j6mr6422476qvp.10.1618542218062;
 Thu, 15 Apr 2021 20:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210316085932.2601-1-troy_lee@aspeedtech.com>
In-Reply-To: <20210316085932.2601-1-troy_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 16 Apr 2021 03:03:25 +0000
Message-ID: <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash layout and aspeed-ast2600-evb.dts
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     John Wang <wangzhiqiang.bj@bytedance.com>,
        =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>, leetroy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> openbmc-flash-layout-64.dtsi requires to resize the flash partition.
>
> The updated flash layout as follows:
> - u-boot: 896 KiB
> - u-boot-env: 128 KiB
> - kernel: 9MiB
> - rofs: 32 MiB
> - rwfs: 22 MiB

Changing the 64MB layout will break the systems that are already using
this layout. I'll get the Bytedance people to chime in, as theirs is
the only system using this layout so far.

John, Lei?

>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 32 +------------------
>  .../arm/boot/dts/openbmc-flash-layout-64.dtsi | 18 +++++------
>  2 files changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 89be13197780..2cfae9cfed3a 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -121,37 +121,7 @@ flash@0 {
>                 m25p,fast-read;
>                 label = "bmc";
>                 spi-max-frequency = <50000000>;
> -
> -               partitions {
> -                       compatible = "fixed-partitions";
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -
> -                       u-boot@0 {
> -                               reg = <0x0 0xe0000>; // 896KB
> -                               label = "u-boot";
> -                       };
> -
> -                       u-boot-env@e0000 {
> -                               reg = <0xe0000 0x20000>; // 128KB
> -                               label = "u-boot-env";
> -                       };
> -
> -                       kernel@100000 {
> -                               reg = <0x100000 0x900000>; // 9MB
> -                               label = "kernel";
> -                       };
> -
> -                       rofs@a00000 {
> -                               reg = <0xa00000 0x2000000>; // 32MB
> -                               label = "rofs";
> -                       };
> -
> -                       rwfs@6000000 {
> -                               reg = <0x2a00000 0x1600000>; // 22MB
> -                               label = "rwfs";
> -                       };
> -               };
> +#include "openbmc-flash-layout-64.dtsi"
>         };
>  };
>
> diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> index 91163867be34..31f59de5190b 100644
> --- a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> +++ b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> @@ -9,27 +9,27 @@ partitions {
>         #size-cells = <1>;
>
>         u-boot@0 {
> -               reg = <0x0 0x60000>; // 384KB
> +               reg = <0x0 0xe0000>; // 896KB
>                 label = "u-boot";
>         };
>
> -       u-boot-env@60000 {
> -               reg = <0x60000 0x20000>; // 128KB
> +       u-boot-env@e0000 {
> +               reg = <0xe0000 0x20000>; // 128KB
>                 label = "u-boot-env";
>         };
>
> -       kernel@80000 {
> -               reg = <0x80000 0x500000>; // 5MB
> +       kernel@100000 {
> +               reg = <0x100000 0x900000>; // 9MB
>                 label = "kernel";
>         };
>
> -       rofs@580000 {
> -               reg = <0x580000 0x2a80000>; // 42.5MB
> +       rofs@a00000 {
> +               reg = <0xa00000 0x2000000>; // 32MB
>                 label = "rofs";
>         };
>
> -       rwfs@3000000 {
> -               reg = <0x3000000 0x1000000>; // 16MB
> +       rwfs@6000000 {
> +               reg = <0x2a00000 0x1600000>; // 22MB
>                 label = "rwfs";
>         };
>  };
> --
> 2.25.1
>

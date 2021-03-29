Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206A34CF25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhC2LdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhC2Lcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:32:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE892C061756;
        Mon, 29 Mar 2021 04:32:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 184so15479776ljf.9;
        Mon, 29 Mar 2021 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wP4DyzXGEWscis2PnBMl856XQ/xuNm8C5c+x9Cchs3I=;
        b=nmIR2RhXBTEMdtnD9RfREZa6V3uiSn5LkEPrB6hCMiw8mkNXz+8kv+glbrrT5IvtmG
         i4jZO92YD6c6viuxIl6SU769YJKx03IHhjeJOAwi21QEVmsn0zmloWi3+UxJ848bNeWj
         RwjqyFNrsZO48jAwbAm6uOOliRI6qtcn7H9uCeDXRNRWyxAO9VyFYqpl8sYjY0vASpiS
         2cPdXWkU9fRmsM7w+IxvQ+xq5/TW7Ahi65WWPuiDDHlXCDPR1aJ5Ha5TDpQjigjH4NKA
         1zGwt7pamQqPEjmEHT4ZVMHhzBv0oAXQqHA2TcT9RtYz0RvgMLTBDzsqoK7ttFW+SSff
         LTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wP4DyzXGEWscis2PnBMl856XQ/xuNm8C5c+x9Cchs3I=;
        b=ll1STDS+mN4qhMEYE3N/jnxUmJrWKtYcrk/blJoioxSPFnPjWm0Zj1Bh/kUfOcwdLk
         UrLPcKJRJ6TW58w7dKflT5vUPI3oQ9bfF2uKaLEUKpdCOq+67TyYGy8uDyi1LLNSF5va
         U0nj352KtkMd/r81TnCT6zddX4r4B1eL15AuntKGnFpGnl9l4bRBA18xZqtmm8PxmAvF
         kYfeLEsRL66GKDiudohKhc0EawtczOwdrlj5YPbPUxn/D2utP56rhbVwbvVAbd4yZhCf
         Efhwvvax124XqDEIJPPKJkxkQoyBuWg7i7jgMZKC6/t362ifBTEfyisL01pW+4yuBrxc
         NJgQ==
X-Gm-Message-State: AOAM531Pi7LxXJ+etK/o4ckKkH02fo+ILRvmJNZyYqC8KQnT5+NnFRbf
        PsiKUl714ekP/8vnQSIOL+THIon+noQxJ4qHlJg=
X-Google-Smtp-Source: ABdhPJwtNl5H83+Ry/1rs3MY1ARJ4RbAgLiWuVAt7Sdn5uGrzBeW1ifiKPWUScU9z/wWKcKv0D7SApbzE0hZeN216Cc=
X-Received: by 2002:a2e:575c:: with SMTP id r28mr17631140ljd.347.1617017553361;
 Mon, 29 Mar 2021 04:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210329112819.64043-1-s.riedmueller@phytec.de>
In-Reply-To: <20210329112819.64043-1-s.riedmueller@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Mar 2021 08:32:21 -0300
Message-ID: <CAOMZO5AxkToaa3wFbx2KP6AyAnWVYKVsKOs-mgNMZLOzo3miuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable pinmuxing
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, Mar 29, 2021 at 8:28 AM Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:

> -               pinctrl_usbh1: usbh1grp {
> +               pinctrl_usbh1_vbus: usbh1vbusgrp {
>                         fsl,pins = <
> -                               MX6QDL_PAD_GPIO_0__USB_H1_PWR           0x80000000
> +                               MX6QDL_PAD_GPIO_0__GPIO1_IO00           0x80000000

While you are on it, could you please use avoid the usage of
0x80000000 and explicitly pass the default value instead?

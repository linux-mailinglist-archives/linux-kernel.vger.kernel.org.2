Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533BA3432BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCUNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:23:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04AC061574;
        Sun, 21 Mar 2021 06:23:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so17101416lfb.9;
        Sun, 21 Mar 2021 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoXPcNJyIBBvbFO7WEOJ0cHybrEQ/mDhidPm0MDTUJ4=;
        b=okWdTMpdySXUBMKdNyTfj/fL5sDY0SP5ObO4bucb5SW92ymAj/CqOGXzVE/7Ty8URP
         40YVVkI/9JgtSHrMoZ497VjFAs2Sqc6MNHAiRsFKqYXSnUp8sEpV0DUq2oThFoSfM7gM
         fmfRmYEexSkQbz5tgH8PrQcvKJ8xNhf01NOqrXhurILYDtS48SB+KerZrL8v9aa2K2Yi
         7dVsFBmAomczzQjCxrW+zald6S/Q5F2nCja4MRtktA3AVlxyV2ofEAvVuS5XBkjvN2vi
         B32H2PJUpgTR6yNWGB2ng56tdOtydUsyDf6FYbsHjSKGlrhtvjBJqaa+LEjcOkT2mKmr
         xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoXPcNJyIBBvbFO7WEOJ0cHybrEQ/mDhidPm0MDTUJ4=;
        b=b7NhajEFeRYZJn/kcqiD7YoqzNO2Driq2lK/XxvZqepXpVF+wJQJQqaMSEWtYXtBT3
         laRWDx7H3uT2aQDACQHqK3J4d/+4JNcVf4Tmx2uWFiF8Cp4NE0hQZPMhk4hDLTqLWDsJ
         UnLYOUGW/CFT9HfAxiuJD3zN/9W/hChUkbuFhoJ3BDtXASB1jmvSjrxoMlgx1VFle0St
         m/Tq1POBSTwuZ1LNrHhllnaDenwI5TOKkRG6k9WEU4tVRCJAj7RasjHhUk2XBMqtHcIW
         D0vBlYs9C2GWwbOgddzQb14i4Hm5jwAvgl2yZLQEoVc7TKF2UwFkonttX86V9DBS4Cg4
         Kw1A==
X-Gm-Message-State: AOAM531nExPyU2FrgTfBpJDT6yHXYvTe2gpVNOtPd1vO/1euz/1pAqkQ
        AdrAGO9PfAQwXn5WlItwO7fBDlVWa+8+RdM2BJM=
X-Google-Smtp-Source: ABdhPJxhUdAzvJyCQbPqkLqTvLEew3FUbNxf84wogqWI0nLxnAOfCI/8kVlHDEbLcAcfFyJt4iGRVImXtefqdpeQnv0=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr3986864lfu.443.1616332984963;
 Sun, 21 Mar 2021 06:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210319205041.15579-1-tharvey@gateworks.com> <20210319205041.15579-2-tharvey@gateworks.com>
In-Reply-To: <20210319205041.15579-2-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 21 Mar 2021 10:22:52 -0300
Message-ID: <CAOMZO5BwOqSqJ17c8hoDb_8+u12MDgY6W8ygpgJnGPwaf2HY_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx: Add i.mx8mm Gateworks gw7901 dts support
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Fri, Mar 19, 2021 at 5:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> The Gateworks GW7901 is an ARM based single board computer (SBC)
> featuring:
>  - i.MX8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - SPI FRAM
>  - Gateworks System Controller (GSC)
>  - Atmel ATECC Crypto Authentication
>  - USB 2.0
>  - Microchip GbE Switch
>  - Multiple multi-protocol RS232/RS485/RS422 Serial ports
>  - onboard 802.11ac WiFi / BT
>  - microSD socket
>  - miniPCIe socket with PCIe, USB 2.0 and dual SIM sockets
>  - Wide range DC power input
>  - 802.3at PoE
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

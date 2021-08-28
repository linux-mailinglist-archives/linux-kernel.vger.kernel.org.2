Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA43FA6B6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhH1QNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhH1QNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 12:13:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB36C061756;
        Sat, 28 Aug 2021 09:12:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n27so20839706eja.5;
        Sat, 28 Aug 2021 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zh8hDnqJsAxw2sHEwetCX3Pfnh6KEf01QqPdi2tUhVo=;
        b=RzA8y9BJgO9Uc7NUYFv1yBPc2LqFcxcEuXm/YpbKnSazwTnH19bzAHiMf+rRHnejRs
         ONzRH3t27wX6TPYw5W64WEQIEU97UxmudngkbhPJwT75ILTXUEJ/pQL0aIGNiAEhCFeE
         la8/WdCyHa+ZQtrYvf+tbL6cTTKZcGBMbgigbewRR0EYfBhC92tA5ucKp7JmAMDybg88
         C9c4hqttpyRx+ZrZ7F2U165S0IgvbnH4Vnt5Hm08QoEQL+eQKO8T20Wrd7hviDy8UZz4
         cmgPX2UyDU/00ZDgn41kLIzKP+mRy9OuDjnxbAzf0eGQ2cc0va9e1Ch7MnOIVqOiT8fW
         qMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zh8hDnqJsAxw2sHEwetCX3Pfnh6KEf01QqPdi2tUhVo=;
        b=CpfzUSA49tDhojlwaPsbxp0lYJKDj3mT7XUZlnMQDHZc1YRSu0U0RBOH4cz6O96DOf
         eDX5Nf69paNXdMhVqklmCrhAcNN//nYpnW4jUVoftIQUbwq6X8v/NYv7FbZStZJqGGHw
         pvKKKC0+rABbeephBSO7p9jep74imlG2PT3cCbHd1aUwIFDgGSsTPEmiaCsmrTqk4dJe
         Z3icwh7+4BrN2OeiEEPYpYrK9mUiXQXshU+deK9LF5qAfXQuCtGuVEbCm2lwE3WHSUsY
         K4/RUQXKT+oCws8rf5B2PkqoS8S2d6hTqllaeglH9LcagVbDWyOPdSg3kWf29ma8+JN7
         SjIw==
X-Gm-Message-State: AOAM530gPx5FRnBykDIyIiugHrtYkUIcq3Mh8PMT4qktSxVAgBjWl1+O
        2mHPFHF19GvBgUtoNUsxCOSp9nAGR+q0Rme7Mpm0kh1+pHA=
X-Google-Smtp-Source: ABdhPJzuWi0ooqB2IgoUF4B8mSjiCIWZFx/7h6qHkEI4+ez8LFyTUS0Fe2+VVJ2DtD4r8UXiNRS9uBlCMc4AJVFdNTw=
X-Received: by 2002:a17:906:4d01:: with SMTP id r1mr15800109eju.471.1630167130522;
 Sat, 28 Aug 2021 09:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <YScKYFWlYymgGw3l@anyang-linuxfactory-or-kr>
In-Reply-To: <YScKYFWlYymgGw3l@anyang-linuxfactory-or-kr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Aug 2021 18:11:59 +0200
Message-ID: <CAFBinCDLmmtKztpoj5xvhwdagrH_7nJK7qUA+LOg7CWB5eCFRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: sm1: add Ethernet PHY reset line for ODROID-C4/HC4
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for this patch!

my first suggestion is about the patch subject (first line):
arm64: dts: meson-sm1-odroid: add Ethernet PHY reset for ODROID-C4/HC4

This makes it match the pattern of the most recent commits there:
45d736ab17b4 arm64: dts: meson-sm1-odroid: add 5v regulator gpio
7881df513680 arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as
open source

On Thu, Aug 26, 2021 at 5:29 AM Dongjin Kim <tobetter@gmail.com> wrote:
>
> This patch is to fix an issue that the ethernet link doesn't come up
> when using ip link set down/up:
>    [   11.428114] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
>    [   14.428595] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
>    [   14.428610] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
>    [   14.428974] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>    [   14.711185] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed
>
> This fix has been referred two commits applied for ODROID-N2 (G12B).
>     commit 658e4129bb81 ("arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line")
>     commit 1c7412530d5d0 ("arm64: dts: meson: g12b: odroid-n2: fix PHY deassert timing requirements")
I am not 100% sure but I think you can just add two "Fixes: ..." tags here
That way this patch is also backported automatically

> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

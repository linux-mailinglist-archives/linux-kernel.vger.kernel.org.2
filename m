Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB13D1986
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhGUVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGUVUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:20:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31108C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:00:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q16so5426321lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNYKfEC2XgIe4P22hQdCPlxP6b32Wm75jWfz9vNASdQ=;
        b=VbIbeVYcEg9R6LFL4eV3LtCYv3emUrr9wD3eAaAJsesFot8I4PezL/2TyQVytBeu1z
         3kBq5J7cll3l1Mq+bJ/ZdCO753FDNK3SMsM+awtWSKtbBje9ooBCfmpnB+j8Sm46W0oc
         +waGBKGo88iimcDvth0i7wqnK6ffuQeZ33As5mv/F3Qx9XzkakFLeTPwdGEFKRhhV6NS
         z623kXPwxnEUPgNBFeN669f9EGajsUGRHJO3tS5PBwNweaNwp5qlFd1bhoq9Ing+deQU
         4zKeaTPpNlqKPSlhe5rX+ntjaN2dESY6YSjd/xNUVXu/SfME+edsH5aftk+82ZI+D8i4
         Haaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNYKfEC2XgIe4P22hQdCPlxP6b32Wm75jWfz9vNASdQ=;
        b=sIqT37gMg5ujGiO2PddVN/mZffqGSfRIONRmvPH4BlZoZ6wNG2WdWAYzlqi+XoS/ty
         qo0TKQ3LAT8gBHKNuYaVZ9gVBe9BMDLOgXE9RiWdX3NHxugFnPbyvm+LLMuU15Trsf/k
         Kc1cAPY/D5hNLhagXLykvGrWz9kWWWnlmrBTx6FabSvmnJqMMlLbB1PLY1Xv376FFV6X
         soSZ438dUalKUCT8DY2tz77U/0zxQm/A8xknNsA3DvBGR4QlpPibdcW/U0pM2UQ5uZFz
         jb+zwEn+KRE1g/wqvh2Bn1p0v+xBM+WX/GUNGldrr+yupVQYHgZCeFVAxicvpOwz4vMm
         vEbA==
X-Gm-Message-State: AOAM532zA3hM4jUp7cbIjk/cH7S9lVKcaH5/JtgliPdYKG5SWFUm61Ik
        Lcs2vW5SgxgLsNU3ru9dj9zCB9mkZOoEZVA3jHtmfpDcvQU=
X-Google-Smtp-Source: ABdhPJx+2GQAUDXqohhrQt5LdzTObCbGRun5lWTid9GN2w85MRs7dgJ2BbU422eqrTMM9/HF54kKi36PNk7WBD242sU=
X-Received: by 2002:a05:6512:3696:: with SMTP id d22mr27775866lfs.586.1626904834440;
 Wed, 21 Jul 2021 15:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210721211412.3537004-1-arnd@kernel.org>
In-Reply-To: <20210721211412.3537004-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Jul 2021 00:00:23 +0200
Message-ID: <CACRpkdZ3jWjPkVFYnizZ4CPHWsvS-gaGcUYZdp_4pi_BrZHjMQ@mail.gmail.com>
Subject: Re: [PATCH v2] [SUBMITTED 20210721] ARM: ixp4xx: fix compile-testing
 soc drivers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        SoC Team <soc@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:14 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Randconfig builds on the ixp4xx ethernet driver showed that the qmgr and
> npe drivers are not actually built even when compile testing is enabled:
>
> ERROR: modpost: "qmgr_stat_empty" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "qmgr_enable_irq" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "qmgr_set_irq" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "__qmgr_request_queue" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "npe_send_recv_message" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "npe_recv_message" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "npe_load_firmware" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "npe_running" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "qmgr_disable_irq" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
> ERROR: modpost: "qmgr_stat_below_low_watermark" [drivers/net/ethernet/xscale/ixp4xx_eth.ko] undefined!
>
> Fix it by always entering the drivers/soc/ixp4xx/ directory, and fix the
> resulting compile test failures by removing the #include statements
> that prevent building on most other platforms.
>
> Fixes: 7a6c9dbb36a4 ("soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX || COMPILE_TEST")
> Fixes: fcf2d8978cd5 ("ARM: ixp4xx: Move NPE and QMGR to drivers/soc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oh neat, thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

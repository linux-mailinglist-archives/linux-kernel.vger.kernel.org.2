Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EC41656A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhIWSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbhIWSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:51:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14735C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b15so29025817lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CBqcEeaNCIzEJmTkQKL3nnjymx6WgZloiotm1WXO5Q=;
        b=FZGhrTospEri7qgpD9SosYC6mllXRRt1rSBWvIvR7N6iRArrjJ4He4QebBVd+cajfD
         75fqVz58YQWNarvpFpkkshoUQ62pc/Xe8n6xbmSQJF9zUVNOeKhStA+uKX2UcVm7EVDX
         Oy2VDS9I5ojFOcoejlAFsjwE2gYhurBMeUudMpVhx8DYuubujSTOjpaah5SevSeFR9fd
         bJJulkeZTBrwxYSgMoUp91EPJgOSmZmRGChxEzA3RrYPVyj2xVvHy4uAlTZ+3HyF/FLQ
         DewTEnSJEiN4q72dr569yuFVpZzyGZvKSBiRcBIGcho9zS2k+bcHL8F0ipPMf7u9VYmx
         kEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CBqcEeaNCIzEJmTkQKL3nnjymx6WgZloiotm1WXO5Q=;
        b=WS0cxD6ZlBefa0FmW0wlJSCGotNEiyMxMtf5ppYUer4fIK1dxfKP7QnaqsA6uoUluW
         xOEO2ed6fFqldmKWpfm/27vMuVudEHHS7rCgZBfQ4xPkDvcy5sDCSzsoLYTvaSID3tHr
         ZFWnvc4sWzzzO0rkT8FdrRQAR5q81TfGN8vklTyntoEcSUTsva2+4pJjnqKDGLNR6Hpa
         P7VklFFe1LKfixq1fRhcA7TeRSkJggzB3Nx3Zr+JFAtgbDKeJAdmjJBVK+Wgg5N1R8wr
         QKeGPDfCmDB3RYhLl0XhGrvDugjFGB9w09TJkYMnvI+gXhQPYB4tlDMtsznDhFbmWyFE
         Barw==
X-Gm-Message-State: AOAM532jBQHe12ig/pZjFKPOjPwH+nKl6IUQ4TvbLDkErUXyEtC8OJVu
        OROQ4TgNNsn7xl9TeUFfq0UiAyUAquzPqJBIy7IsuQ==
X-Google-Smtp-Source: ABdhPJy/jBdtZppzF1VrwwZlD+f66NRxMptTHpqaUXWgpxUCUuKpfe5ziBVMZ1OUWRIIDczx8iHpuWgdHYKaXL61ooA=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr5554685lfb.71.1632423025387;
 Thu, 23 Sep 2021 11:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210917124803.22871-1-wenbin.mei@mediatek.com>
In-Reply-To: <20210917124803.22871-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:49 +0200
Message-ID: <CAPDyKFrtrY4qDU7nxynXuvyw32zkHcwMkmJJjftj7EzMcsD9Lg@mail.gmail.com>
Subject: Re: [RESEND v4 0/3] mmc: mediatek: Add HS400 online tuning support
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 14:48, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Change in v4:
> - split driver patch into a core patch and a mtk-sd patch
> - use mmc_get_ext_csd function
> - move mmc_get_ext_csd() to include/linux/mmc/host.h
> - modify some commit message.
>
> Change in v3:
> - add detail descripthion for hs400 dly3
>
> Change in v2:
> - remove the check "mmc_can_ext_csd"
> - change the hs400 tuning condition for "msdc_cmd_done" function and
> "msdc_cmd_next" function
> - use "-EIO" instead of "-ERANGE"
>
> Wenbin Mei (3):
>   dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
>   mmc: core: add tuning support for HS400 mode
>   mmc: mediatek: Add HS400 online tuning support
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 12 +++
>  drivers/mmc/core/mmc.c                        |  8 ++
>  drivers/mmc/core/mmc_ops.h                    |  1 -
>  drivers/mmc/host/mtk-sd.c                     | 79 ++++++++++++++++++-
>  include/linux/mmc/host.h                      |  4 +
>  5 files changed, 101 insertions(+), 3 deletions(-)
>
> --
> 2.25.1
>

Applied for next, thanks!

Kind regards
Uffe

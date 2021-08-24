Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B097E3F611E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhHXO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhHXO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:58:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s3so38144725ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rG93YVkIW3nqzotuTfLNvUeiSiCqHX1++Ll+NQk788g=;
        b=OWpEOfcC2ZdblqNGIk+5ozXFMkkK2JRZa9xrCDCemKi8RpZEzlwFqVdQSBg9Q2XPde
         wA2OKa+hdTLQXF6cql7XcS4d4e63bYA4D1tttax3LFxF0QWMvhefBDWXi+yIdAf8TNBp
         SWhVosTpFm4OhLHgkafwtiuqiaH3VqorTVCKkidowYOU8GhA80pZPyJeszOaErUWxUCm
         D9Bfe5LAy8swyDG9mCh6BqbEy6wSDEmD9cUh5PAArpUV955+It6XqVt3CY02YQslfsC/
         iHLaNlujbEYCQcAZLIplOZi/oseLe4yTwjxQL8sz6n2DAUzS7qk28MD6tkiNEBcl/xQL
         iiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rG93YVkIW3nqzotuTfLNvUeiSiCqHX1++Ll+NQk788g=;
        b=aLBU6u8Rlkp/hv9BLRb9hSoBMpOlvvhfWOjKsNreM2LdCCPH1bwkmKCERmOn9g8hwx
         UYRRmQwY7HMXLtOlxU6InspgC32KabT7GIdHEs1CbaCbA2O7mfy6J6az6kW1ZW5OMfQL
         sFXjX1fyuNuUWG4Sg+7DV9Ups8Y/C1lC2/zXWZjX+iPLDpboijRDB8v6ruTIpS6b0UA2
         upt6/ULPsC59XIfGc0nfk+26DWLSaObpw0+UxEAtKvwlZiSg4rgCwnKkbfe/ml7MwJBW
         m0Yizc/D4ZRJi3bV0r7rkffcbbWyTEAY5NwSJPgevIMUQkskPNccchPCbDyOuVWgW3ye
         BNdA==
X-Gm-Message-State: AOAM533HO+Cks9RFBgiSvKMpZFQzOh0/8RAmhftoiPJY1Vf7sA9f0KJx
        LklzMAeT8kH2xVLcj/T30dz1CVSRcBe94qYhHDr66A==
X-Google-Smtp-Source: ABdhPJx6Isd9vLbbCnGy+55W88MXIod8/ktiZreNMJurIqwpxYoSuJ5VA9J6ZrbE2RLDHVxsUN21K+QlYUAu8om/q9E=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr30421923ljn.364.1629817038379;
 Tue, 24 Aug 2021 07:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:42 +0200
Message-ID: <CAPDyKFrcBS2tf32H9+wsy7=TsHkaqtw0cZcSAgZc3XjnLzJ__w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: pwrseq: sd8787: add support wilc1000 devices
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 11:30, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Hi,
>
> This series adds support for WILC1000 devices on pwrseq-sd8787 driver.
> WILC1000 devices needs a minimum delay of 5ms b/w reset and power lines.
> Adapt the sd8787 driver for this by adding a new compatible for WILC1000
> devices and specify the delay on .data field of struct of_device_id.
>
> Thank you,
> Claudiu Beznea
>
> Changes in v3:
> - fixed dt binding compilation
>
> Changes in v2:
> - changed cover letter title (it was: mmc: pwrseq: sd8787: add support
>   for selectable)
> - use new compatible in pwrseq-sd8787 driver instead of adding a new
>   binding for specifying the delay; with this, the patch 1/1 from v1 is
>   not necessary
> - adapt patch 3/3 from this version with the new compatible
>
>
> Claudiu Beznea (3):
>   dt-bindings: pwrseq-sd8787: add binding for wilc1000
>   mmc: pwrseq: sd8787: add support for wilc1000
>   mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
>
> Eugen Hristev (1):
>   ARM: dts: at91: sama5d27_wlsom1: add wifi device
>
>  .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  4 +-
>  arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 71 +++++++++++++++++++
>  drivers/mmc/core/Kconfig                      |  2 +-
>  drivers/mmc/core/pwrseq_sd8787.c              | 11 ++-
>  4 files changed, 84 insertions(+), 4 deletions(-)
>

Applied patch1 -> patch3, thanks! I leave patch 4 for soc maintainers.

Kind regards
Uffe

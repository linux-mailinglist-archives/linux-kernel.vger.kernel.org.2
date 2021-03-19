Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D033420A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCSPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCSPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:12:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E55C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:12:54 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y18so3181144qky.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BQUhut8Gp1VWHsHKJM7zsud7F4iDdjVoej9IXbRRJM=;
        b=XJJWdJBS8J4vHFHbMM7M75TyFvEdbVC5kovBU53t0sfFbzyrtgCXNUzBHgFRaRrXsS
         ECY7LRG05zK+uZp3Cdlwwzvjpyx/4cLV45amfGsWdQhDiWMUzus+tU9OVadpNqabmpo4
         gzgxKOlDw1BPjL51o7a85ogpr7f0v/d3lmyMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BQUhut8Gp1VWHsHKJM7zsud7F4iDdjVoej9IXbRRJM=;
        b=uJ+xdD2nG9zcZbf0HxMrAuGvtxND/IKlio3vMGgDEfSFdV8gBRyD8vkGgqkucJ+S57
         hJA+BwQKFaZXFRYhkS0MeamXpamLERy3RrotSiG2BvM0X/zun0QVWnt0nhBLw/8O1Ftz
         pTJkQbI12lBuhmHEsbCAy02ckpu7V2MTybsyc9zwB+CZ3VOdR9I2CsYqum8h34NKGF6K
         DDubXqWfEZSnwJzqbWj55aRi6/fUU9Yek0OdIrXt8UTOXdKN73NrVhYEjzZDm78JEqwB
         WWJ44QJeUvQO+WfZYsAN/TD+g+WHPhauO4aYuoKKubnSS6M6iEj5TJIbqskHvk4KkSQz
         goMA==
X-Gm-Message-State: AOAM5312Q25VubhU6CylM70KsdFQuf3oi9NYG1bPr7rajFGSAj23uWyV
        bU1g57dFYEbbLU6LfpoX60pE8j0uAAYJUQ==
X-Google-Smtp-Source: ABdhPJxfbHmGNupISM3tFOoxcr98YlYi2auJiQafwrfSN4XSwFedN9V+sOfO7QtwLXGl+Gk1oMCemg==
X-Received: by 2002:a37:5943:: with SMTP id n64mr9988106qkb.127.1616166773775;
        Fri, 19 Mar 2021 08:12:53 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z89sm3891539qtd.5.2021.03.19.08.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 08:12:53 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id o83so6641036ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:12:52 -0700 (PDT)
X-Received: by 2002:a25:2654:: with SMTP id m81mr6982485ybm.405.1616166772505;
 Fri, 19 Mar 2021 08:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210316011516.1314686-1-mka@chromium.org> <20210315181509.v3.2.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
In-Reply-To: <20210315181509.v3.2.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Mar 2021 08:12:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxTuFSosYFcpvbTUMfrAkaLbg3QvqBwhrt4niVzDRN9w@mail.gmail.com>
Message-ID: <CAD=FV=XxTuFSosYFcpvbTUMfrAkaLbg3QvqBwhrt4niVzDRN9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7180: Add pompom rev3
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 15, 2021 at 6:15 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The only kernel visible change with respect to rev2 is that pompom
> rev3 changed the charger thermistor from a 47k to a 100k NTC to use
> a thermistor which is supported by the PM6150 ADC driver.
>
> Disable the charger thermal zone for pompom rev1 and rev2 to avoid
> the use of bogus temperature values from the unsupported thermistor.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v3:
> - don't add LOCK key
>
> Changes in v2:
> - moved keyboard definition to sc7180-trogdor-pompom.dtsi instead
>   of duplicating it, use cros-ec keyboard for rev1
> - squashed with 'arm64: dts: qcom: sc7180: pompom: Disable charger
>   thermal zone for rev1 and rev2'
>
>  arch/arm64/boot/dts/qcom/Makefile             |  2 +
>  .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 12 ++++++
>  .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts |  4 +-
>  .../dts/qcom/sc7180-trogdor-pompom-r2.dts     | 38 +++++--------------
>  .../dts/qcom/sc7180-trogdor-pompom-r3-lte.dts | 14 +++++++
>  .../dts/qcom/sc7180-trogdor-pompom-r3.dts     | 15 ++++++++
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  | 29 ++++++++++++++
>  7 files changed, 83 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index a81966d59cf7..11aa83ca798f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -49,6 +49,8 @@ dtb-$(CONFIG_ARCH_QCOM)       += sc7180-trogdor-pompom-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r2-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sdm630-sony-xperia-ganges-kirin.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> index e720e7bd0d70..7f87877408c5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> @@ -9,11 +9,23 @@
>
>  #include "sc7180-trogdor-pompom.dtsi"
>
> +/delete-node/ keyboard_controller;

So I just tried to compile your patch and I found that it doesn't
compile. :( The above needs to be:

/delete-node/ &keyboard_controller;

-Doug

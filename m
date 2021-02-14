Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6731AEB6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBNB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBNB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 20:59:45 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260DDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 17:59:00 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 30so1268333uac.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ixeWtkGZms2jqEPuipL0eImgJeTeZ0ddYDeZic7MgQ=;
        b=FncMT/GvGAc/EsdPfqvKoM9XNHSxs+pjuWH41t8zU5Kg0ah1J4kXkiQfKFmtCiwtNh
         aaZuIMeVc3qALvPLqyg1iedXNqMds7nnIHMAHaAHtmfWZVW+BPtKXnNL8Vz1XIfa6Abk
         56EQYlBSF42HXLn5XpStNIxJAknDvUZtB/D6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ixeWtkGZms2jqEPuipL0eImgJeTeZ0ddYDeZic7MgQ=;
        b=iMFSRqGSGgaLYWQR23rV1F2xLxYorYtJeq62e4+pQ/iHi29830dArRJCedtTvKYhCJ
         qlqLfh09ie3tlj87MbuPYv26zBUIePHIiMQI4K/iwbm1BkItpnLtrlm27sL6dkWej9nf
         jVw+iABv0FyrPpFIQLyp9enVPnrb+879tCabFAWoTxD3XaEhgTzEF0r674ZsVrRyrwkl
         oibrSMvyl99LLzof8lIAbfjgviQ+jzHQcZ92Wz25cYL+/dtZoH2VTM8Rak4rHuh8FayJ
         hwVrO+7kQSCtk+TBhVCPEu8f5mdGCEZqVUjOEIDVCF5e9I9nrrJoW7IQhUN9mkZGq61k
         kWDw==
X-Gm-Message-State: AOAM531dVoGCNLP1f37w/wKgusMD//2uentITZ5INZr/kw1BDRTmPQdD
        LsgI368SOwPELVWrrMcA8EgxKEwmLrZxKDla8Ybu+g==
X-Google-Smtp-Source: ABdhPJyoBmJ7jwKAGqVcrzAOq50zvV6KWZm+xllaqflJaAKZU8l5lkgyKY/T9PH8CRPdqVqIBQm9Ix+HOUvSzxYHOr8=
X-Received: by 2002:ab0:2e9b:: with SMTP id f27mr1582267uaa.74.1613267939297;
 Sat, 13 Feb 2021 17:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20210129093010.22909-1-michael.kao@mediatek.com> <20210129093010.22909-3-michael.kao@mediatek.com>
In-Reply-To: <20210129093010.22909-3-michael.kao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 14 Feb 2021 09:58:48 +0800
Message-ID: <CANMq1KA-a1RQ=85w=sxJP8PfVfovx6Tscsuxf_vZpFqdxGc0=g@mail.gmail.com>
Subject: Re: [v2,2/3] thermal: mediatek: Add LVTS drivers for SoC theraml zones
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 5:40 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC and register the maximum temperature
> of sensors and each sensor as a thermal zone.
>
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mediatek/Kconfig         |   10 +
>  drivers/thermal/mediatek/Makefile        |    1 +
>  drivers/thermal/mediatek/soc_temp_lvts.c | 1287 ++++++++++++++++++++++
>  drivers/thermal/mediatek/soc_temp_lvts.h |  312 ++++++
>  4 files changed, 1610 insertions(+)
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
>
> [snip]
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> index f75313ddce5e..16ce166e5916 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTK_SOC_THERMAL)  += soc_temp.o
> +obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)     += soc_temp_lvts.o
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
> new file mode 100644
> index 000000000000..b56c2cd3cb39
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.c
> @@ -0,0 +1,1287 @@
> [snip]
> +
> +static unsigned int lvts_temp_to_raw(struct formula_coeff *co, int temp)
> +{
> +       unsigned int msr_raw;
> +
> +       msr_raw = ((long long)((co->golden_temp * 500 + co->b - temp)) << 14)
> +               / (-1 * co->a);

This fails to build test on arm (32-bit):
ERROR: "__aeabi_ldivmod" [drivers/thermal/mediatek/soc_temp_lvts.ko] undefined!

Recommend using div_s64:
   msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14,
                     -1 * co->a);

> +
> +       return msr_raw;
> +}
> [snip]

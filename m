Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5782145FC64
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 04:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351860AbhK0DmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 22:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350844AbhK0DkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:40:24 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C0C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:23:44 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b192so7098727vkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ven33Yb2pguWuvssw/AGyslALQS0DpWB86lUymG/icY=;
        b=wdv7YIuPe1YgQn6DtbnGiFpQPssIsX84DeJlK1tcrFBdk/IroRaSui6KIjdOhAiC7o
         pXztHbc3tBaGc3WRn28tp9aSZy0vZLT8KqXjcfuvjbZ9X+SF/RW8CMndatjeNGwgvlM3
         K/oETGslseqBjq/6VNUbt6KqgNCjzxxtIfcDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ven33Yb2pguWuvssw/AGyslALQS0DpWB86lUymG/icY=;
        b=vx/hnv8LoP09EtuQm3vgRb1sGq9uNpM/907Gu8jeqUQ95MdlQX2gKocvUj2KfwLPXs
         ffMgbz8txPyP1DtiqQjnuKlOC9RdFAkxhmm4lxa7cfr8Oiupx3nri1UUsasC+vELAOJO
         bXDk4UCzvuy3lim8W/ha3/I/BNxexxnlVaQ3XpCitPKp82+Qpif1fSBgkbe8BZ7Z5dPT
         NVLyuPkrVISMwunDDMMfUCFKzDk5vbm+0tI7AarQIeV2qKmgyJGBD1/Gq4IeAYoA10DJ
         W0OVZGv+bMD+IP/HwjaLhXOAf5JK4ITq3VLwEz6vJMXq6Wr81/IVjrZcIgkc3Z2rHBOe
         myvQ==
X-Gm-Message-State: AOAM532/KgISP93EBSVuctV5+5gkx3wlasqTNNjlBG4VvYjYy/thEQ4H
        BZC7gaIpf185EF93A1IJ85tqcD9pgCWFMZdW1eIQL3B/Sss=
X-Google-Smtp-Source: ABdhPJzCmaPPPLCzCTjWtZ6aHeB7EX3WpyPaE0fVpTKNt9hdY0c+eBWZ14qEu91SHMtyRKaqQSCiwaeuslwmnCo1F18=
X-Received: by 2002:a05:6122:237:: with SMTP id e23mr19764905vko.41.1637979823919;
 Fri, 26 Nov 2021 18:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20211126202144.72936-1-romain.perier@gmail.com> <20211126202144.72936-5-romain.perier@gmail.com>
In-Reply-To: <20211126202144.72936-5-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 27 Nov 2021 11:23:33 +0900
Message-ID: <CAFr9PXm76vvUVVt8gfhfJwx3RcDUcuusZmY231euGr6RHo0CdQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: timer: Add Mstar MSC313e timer
 devicetree bindings documentation
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 27 Nov 2021 at 05:22, Romain Perier <romain.perier@gmail.com> wrote:
>
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e timer driver, found from MSC313e SoCs and newer.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/timer/mstar,msc313e-timer.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> new file mode 100644
> index 000000000000..f4d43e141dd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar MSC313e Timer Device Tree Bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mstar,msc313e-timer
> +      - mstar,ssd20xd-timer

I think s/mstar,ssd20xd-timer/sstar-ssd20xd-timer/ as the SSD201 and
SSD202D were never MStar parts.
The SigmaStar prefix is already in the vendor prefixes.

Cheers,

Daniel

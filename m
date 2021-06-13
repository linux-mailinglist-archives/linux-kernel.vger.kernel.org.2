Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF33A583A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFMMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:14:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B9C061574;
        Sun, 13 Jun 2021 05:12:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m18so11230200wrv.2;
        Sun, 13 Jun 2021 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=MSBzfhNHhCZmKOAtF+feGhoOQgIox8era17UjUTrjUE=;
        b=l2Z1PgZ3TRJ86BB4Fs7L1ANwas3gPy9RlFUkMaQBKOB+gn/9IYQrEoF4G/L6Ndaeb1
         GzGwJIvQtzlZfa0izIRGGfQBWm609L01TBKh17QvkTT9uAl9lmKBIauSsKllCrnCx3kV
         5cdvOMfVjhCw/7OH+3v+cUI1tRqTbYPLM4DYShDFC1U2nUriGp1caHofZDgbhbMKRGUJ
         vg1/kshURdPlBksQMkNYy5nQPH378E3TC3y/TyEK/vOH4YYc+Vx/3qQVZatGxq3K9zxN
         NBo8kJV0lJXyet4BVyjT18OUtYPBsYjSh1Nm5P4tEg/fwgGMLNEAOX8iKKkInEbVPVuF
         OMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MSBzfhNHhCZmKOAtF+feGhoOQgIox8era17UjUTrjUE=;
        b=mvfj6XqajempxwxTT/eiUOkvZ+W4Ana0OS0mIh59666nkTfYjetsk3S5hZQLV9fN32
         hyqUaK919Fpjpw0KiQbrWlgSX1HQIUje29McS0/svYSPDherdUYfU0W5c6dkW0kS2rXS
         k8mJg2GBvT5Ed9z6hEvPUkhVeucQwzd+GUmfAuJ239KF5vI0KX3NbGqOMDtKxxwPiRgf
         zDkkNY0B3sLDMFAfPODvI+/CzTV+kzVc7o1foSomQ/uTHO6fN5tm81XhwAuDWx32Po5t
         ZVcPtAL/VUmiXJfZj2TrNqbCroHVqkl3uQEpkAHykBhFuYffTA2S2ECnrSjbydXKZRYl
         0vyw==
X-Gm-Message-State: AOAM533H8WKpy8MR7vLFyQPmwK7HFSqD0msjfMWkwMW4fldrFT8pw+/F
        tWAkR0AuxyutR26AIJ6jXo0=
X-Google-Smtp-Source: ABdhPJzdsWlJYmHLVODebMS58JP6dspsTQK9rBvzCp8jXQPWPraySMRIFTEHeE+dz3xiXhHRJhSZXQ==
X-Received: by 2002:a5d:6d8d:: with SMTP id l13mr13753573wrs.304.1623586373945;
        Sun, 13 Jun 2021 05:12:53 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id r7sm22167353wma.9.2021.06.13.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 05:12:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] ARM: dts: NSP: Add DT files for Meraki MX64 series
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210613101658.3242777-1-mnhagan88@gmail.com>
 <20210613101658.3242777-3-mnhagan88@gmail.com>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <c7dc1a7f-40ed-2b32-f581-fb5793003e91@gmail.com>
Date:   Sun, 13 Jun 2021 13:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210613101658.3242777-3-mnhagan88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2021 11:16, Matthew Hagan wrote:

> MX64 & MX64W Hardware info:
>   - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
>   - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
>   - Storage: 1 GB (Micron MT29F8G08ABACA)
>   - Networking: BCM58625 internal switch (5x 1GbE ports)
>   - USB: 1x USB2.0
>   - Serial: Internal header
>   - WLAN(MX64W only): 2x Broadcom BCM43520KMLG on the PCI bus
>
> This patch adds the Meraki MX64 series-specific bindings. Since some
> devices make use of the older A0 SoC, changes need to be made to
> accommodate this case, including removal of coherency options and
> modification to the secondary-boot-reg.
>
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   4 +
>  .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 165 ++++++++++++++++++
>  .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  45 +++++
>  arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  15 ++
>  .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  55 ++++++
>  arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  23 +++
>  6 files changed, 307 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64.dts
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f8f09c5066e7..83560b05f797 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,6 +154,10 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
>  	bcm958525xmc.dtb \
>  	bcm958622hr.dtb \
>  	bcm958623hr.dtb \
> +	bcm958625-meraki-mx64.dtb \
> +	bcm958625-meraki-mx64-a0.dtb \
> +	bcm958625-meraki-mx64w.dtb \
> +	bcm958625-meraki-mx64w-a0.dtb \
>  	bcm958625hr.dtb \
>  	bcm988312hr.dtb \
>  	bcm958625k.dtb
> diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
> new file mode 100644
> index 000000000000..107c2167a113
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Device Tree Bindings for Cisco Meraki MX64 series (Kingpin).
> + *
> + * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
> + */
> +
> +#include "bcm958625-meraki-mx6x-common.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>

dt-bindings/input/input.h should be included in
bcm958625-mx6x-common.dtsi.

dt-bindings/leds/common.h is already included in
bcm958625-mx6x-common.dtsi and isn't required here.

Likewise in bcm958625-meraki-alamo.dtsi

I will hold off on submitting a v4 until the preparatory SoC patches
are sorted out.

Matthew


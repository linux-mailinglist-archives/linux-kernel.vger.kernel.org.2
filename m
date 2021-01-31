Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE031309BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhAaL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhAaKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:21:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0741C061573;
        Sun, 31 Jan 2021 02:21:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so13391391wrz.0;
        Sun, 31 Jan 2021 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g8e7+IJJry5ny+3pA/iVnQ5hZYuQzqxO8UwbPl1sF6k=;
        b=uISmYW4cB2a/3p6z1TPp4zZVg4Hr//iGb00364AQPqf8jL6GkthW002NYr0AD8MsEQ
         P1Mwxq+eHWWM/UCfbNxjeRnW+yK8Cp6KjzpT66z75F6R1qlvpohUtxTZ9AdshzZOEDXy
         I0No8V52sYyHoq2dB6BfmQ5uRIXY/gQz7Ud/artaNt7ei4RX4c8xdBO8fBzyuUMN5UfE
         LLKeWiBNXovr8T9nSr6P89yC1hs3QM8AoFGu3OhHo7U1QAyJMGV6Vkma3Lz8SLpiqVbx
         fSu7rQm4I06VVMx+WgaFkol/BZT1EuZ4VwAc4FmZJVe2u2MsexmzLqm57P+4rm0A/W6M
         c5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8e7+IJJry5ny+3pA/iVnQ5hZYuQzqxO8UwbPl1sF6k=;
        b=OwpwO+Trlt9ueS8sbwu3KLEl0j8iQB/rklR0ZBnJ5tq6Ujg3hAdtlumTpWZu70v7CU
         E6p4b+r3fx0vpGdX0Heyj5f+K9nSwbZuWDbAnwvWXnxYYvtPPzGuWJ4ymgc2DTjr4W7K
         A0OSdFVPLUlxU80vw0JXUAZrn53Fr/mW/1H1IaCXjKVE3fAkwT2/8TJc9sm41wdFKgfJ
         27kriz9tco3EOOmfDiTUjVuY3PXAEiikJsTUT/QxlBgzUnq6i13BF6Qwpr8/UMyYep3S
         a0LKWodOjW+RTC2egckI0SRoQDFgft+qIZZozsv1JqRFIIqqvXW3sZn86aJtvyKMPXjT
         gohA==
X-Gm-Message-State: AOAM530I9ZFVS21jDHAM5OwkqErHggVpvYaYGLbzaEOb5QbEzT1cJv/4
        Rk4QglaVnmHnImg1jmCaM2QIoAIpNuctmQ==
X-Google-Smtp-Source: ABdhPJw8AazA4dxzRWLp2hwNT9TVd86eAppyF8eO5n7HsRtja3vraobaj5/cUyeO5FbqGWkUCNktsg==
X-Received: by 2002:a5d:4f84:: with SMTP id d4mr12839163wru.374.1612088468880;
        Sun, 31 Jan 2021 02:21:08 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id h14sm5128844wmq.39.2021.01.31.02.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 02:21:08 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add MT8167 power domains
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201209133238.384030-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7f6159e1-7bcb-45f4-9764-10d2cd6b4910@gmail.com>
Date:   Sun, 31 Jan 2021 11:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201209133238.384030-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2020 14:32, Fabien Parent wrote:
> Add power domains dt-bindings for MT8167.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Both patches applied to v5.11-next/soc

Thanks!

> ---
> This patch was made on top of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.10-next/soc
> 
> v3:
> 	* Remove MT8167_POWER_DOMAIN_DISP since it was an alias for MT8167_POWER_DOMAIN_MM
> v2:
> 	* Implement on top of new SCPSYS PM domains driver
> 
>  .../power/mediatek,power-controller.yaml        |  2 ++
>  include/dt-bindings/power/mt8167-power.h        | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8167-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index fd12bafe3548..ad6db377f943 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -23,6 +23,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - mediatek,mt8167-power-controller
>        - mediatek,mt8173-power-controller
>        - mediatek,mt8183-power-controller
>        - mediatek,mt8192-power-controller
> @@ -59,6 +60,7 @@ patternProperties:
>        reg:
>          description: |
>            Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
>                "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> diff --git a/include/dt-bindings/power/mt8167-power.h b/include/dt-bindings/power/mt8167-power.h
> new file mode 100644
> index 000000000000..c8ec9983a4bc
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8167-power.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8167_POWER_H
> +#define _DT_BINDINGS_POWER_MT8167_POWER_H
> +
> +#define MT8167_POWER_DOMAIN_MM		0
> +#define MT8167_POWER_DOMAIN_VDEC	1
> +#define MT8167_POWER_DOMAIN_ISP		2
> +#define MT8167_POWER_DOMAIN_CONN	3
> +#define MT8167_POWER_DOMAIN_MFG_ASYNC	4
> +#define MT8167_POWER_DOMAIN_MFG_2D	5
> +#define MT8167_POWER_DOMAIN_MFG		6
> +
> +#endif /* _DT_BINDINGS_POWER_MT8167_POWER_H */
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1938425280
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhJGMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:07:36 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44990 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbhJGMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:07:35 -0400
Received: by mail-oi1-f175.google.com with SMTP id y207so5521838oia.11;
        Thu, 07 Oct 2021 05:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hzJFD9sphiC3TMOrWvmRyZB23LNjrFexhFogsT1/1mA=;
        b=xZtCx9ZvvC7F47R22yuvI8MQsfCQTbytdS8U7kCn71Pcxt+ra86gob7ujDqQQUQDBK
         Jr0JIKnVFvP1S30MszwAunB9XnWBdUvH+dLuDaTmBwRLvK3RhXXP/Ga6HCDwBruAi7UX
         3iMa4MJfA2rCNSRZ1D1FL4wFvyuGFhiYMw6dZoLji2vNVvkAUTu5XoVhpAZS0juS2Zke
         4kYjoVFrhSxNaL9a1x50SeL/Wnmhv8xKA4jIWX0pTxSAxpLpa90uz0YAInE/VRtGdm+5
         XnNlrJ9IYd61NP0hP3GFIzQdBKzi2p/Hb7ohRmE9cHLRhMjNX5ls8ClZyPWfaMbWuR0i
         pNxA==
X-Gm-Message-State: AOAM530Uh8ShuPk1TF47e6bRMjg2c7y2/A+reXZR1gUtfz6HsfEzjJP8
        XfyrRQtyIgps8lDUTAjliA==
X-Google-Smtp-Source: ABdhPJw9o2pj552FafT4KjVB3daTmAbpQfS0yh5dFgZ+ghTcm2MIJEWHU2B3zKI3V9c5FFIhO/OyrQ==
X-Received: by 2002:aca:6283:: with SMTP id w125mr11720753oib.133.1633608340920;
        Thu, 07 Oct 2021 05:05:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l13sm3786690otp.32.2021.10.07.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:05:40 -0700 (PDT)
Received: (nullmailer pid 121525 invoked by uid 1000);
        Thu, 07 Oct 2021 12:05:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        m.purski@samsung.com, devicetree@vger.kernel.org
In-Reply-To: <20211006152158.601856-1-angelogioacchino.delregno@collabora.com>
References: <20211006152158.601856-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: display/bridge: sil,sii9234: Convert to YAML binding
Date:   Thu, 07 Oct 2021 07:05:36 -0500
Message-Id: <1633608336.205912.121524.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 17:21:58 +0200, AngeloGioacchino Del Regno wrote:
> Convert the Silicon Image SiI9234 HDMI/MHL bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/display/bridge/sii9234.txt       |  49 --------
>  .../bindings/display/bridge/sil,sii9234.yaml  | 110 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii9234.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9234.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1537190


hdmi-bridge@39: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos4412-i9300.dt.yaml
	arch/arm/boot/dts/exynos4412-i9305.dt.yaml
	arch/arm/boot/dts/exynos4412-n710x.dt.yaml
	arch/arm/boot/dts/exynos4412-trats2.dt.yaml

hdmi-bridge@39: 'ports' is a required property
	arch/arm/boot/dts/exynos4412-i9300.dt.yaml
	arch/arm/boot/dts/exynos4412-i9305.dt.yaml
	arch/arm/boot/dts/exynos4412-n710x.dt.yaml
	arch/arm/boot/dts/exynos4412-trats2.dt.yaml


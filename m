Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC543251B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhJRRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:34:58 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41492 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhJRRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:34:53 -0400
Received: by mail-ot1-f50.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so737582ote.8;
        Mon, 18 Oct 2021 10:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=RHy3ZoTJ5ER11Swn75LpbiD1h4u7AequpZ+0XI4U4+w=;
        b=mVg6JxP+gug6ZEiCKwXAr2llagvkk7JT3itss2qouh/3SlF6awayG2SubxZU3M5dHu
         nmCb3MzFsJ/V/1oVLcHA4ydqeFMnH+0jU8S4JTrhOkGHVn/DKhkU0263dfBkUrcGl7sM
         6J2FwdVkDK7AhatvX8cZsGs4aRrpigx7vNx2oRrP7fnhsAgkLY06pcVMjYIZqUiLC/yT
         rb5+UfiJyJv7PPtsXYXtVYuvs7HrrQDvWfQug0cdxqxMGYAVZ1PNZ5Or2k3B9ODn9JdJ
         93rOKlAk1VHYg+LiiQaWbZg05+cCC3iLt2zF+ym+eXdNFQQQFleME7Q5wB5Ql8SVtbOE
         R6TQ==
X-Gm-Message-State: AOAM5308vHH4l/7mWm2cNM2RQwNQUKwLEKWL9tK4iqVwWvyvXwwJAVQe
        IYjU0EUFNTNaxURm1iCfBA==
X-Google-Smtp-Source: ABdhPJzfQ44Eru9QB7/gzKIkq4F5Lwz75ZrkkyfLU9Xtzn7rDzu9ppJs/+xdULly0x2mhJkpvhriBA==
X-Received: by 2002:a05:6830:1f27:: with SMTP id e7mr1020556oth.234.1634578361786;
        Mon, 18 Oct 2021 10:32:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m23sm2584303oom.34.2021.10.18.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:32:41 -0700 (PDT)
Received: (nullmailer pid 2612843 invoked by uid 1000);
        Mon, 18 Oct 2021 17:32:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org
In-Reply-To: <20211018115111.14096-1-tinghan.shen@mediatek.com>
References: <20211018115111.14096-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mfd: change naming of mediatek rpmsg property
Date:   Mon, 18 Oct 2021 12:32:38 -0500
Message-Id: <1634578358.531021.2612842.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 19:51:11 +0800, Tinghan Shen wrote:
> Change from "mtk,rpmsg-name" to "mediatek,rpmsg-name" to sync with the
> vendor name defined in vendor-prefixes.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1542563


cros_ec: 'mtk,rpmsg-name' does not match any of the regexes: '^extcon[0-9]*$', '^i2c-tunnel[0-9]*$', '^regulator@[0-9]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml


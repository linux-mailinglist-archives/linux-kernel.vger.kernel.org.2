Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7F4233D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhJEWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:48:07 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44694 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbhJEWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:48:02 -0400
Received: by mail-oo1-f53.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so262893oos.11;
        Tue, 05 Oct 2021 15:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=z05iAxjrVVtJJ74Uea+D+Nd3+xgMuNb36MMScUa9l6s=;
        b=i50p6ZOzB1F2vhVPJjRH3r0IW0/VF73sRZbtYhc/5/8PAhwYmLr6yllUEHeRNeFhaj
         IQSI56niyl+AoTM3rNbdG0+PTChMafGSC74oERPulNj3ZbXkFihA9VZvNpipb/zBnur+
         KNT2fG2x28Vi6nxnqiUSNxmJdI8D7zuIxUHxwrhN8ynTg4i6AL9nQVvRIBR6B4loHKm/
         r8KkOlWmslUNGo2lrjf+b7nkZZHh8ZAErjhYzUiehRpG2tu26gJzKwrb5ppigjuedUgE
         d2DzUVtkkZN+guacVqlhvMkZqepur+fpudwPLLN0nvMCBGU40V3ba45aIgOtanUbpwpV
         YuoA==
X-Gm-Message-State: AOAM533s5GjHwZyJBC8GV7cLzmGVCHPx+zwPCPmVTUv3+MoM8PqEmka1
        hSMfCq79y/yBFM8xtnPmcw==
X-Google-Smtp-Source: ABdhPJx76djZVqB0ioneDeAM81Uh6K9ykIIZGHIxMbOnpc1TdPJPUZs3JKxyO2ZilAWRhpHzhp3t9w==
X-Received: by 2002:a4a:a9ce:: with SMTP id h14mr15431532oon.89.1633473970735;
        Tue, 05 Oct 2021 15:46:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm356605otu.53.2021.10.05.15.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 15:46:10 -0700 (PDT)
Received: (nullmailer pid 106812 invoked by uid 1000);
        Tue, 05 Oct 2021 22:45:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20211005152453.89330-3-amelie.delaunay@foss.st.com>
References: <20211005152453.89330-1-amelie.delaunay@foss.st.com> <20211005152453.89330-3-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: phy-stm32-usbphyc: add optional phy tuning properties
Date:   Tue, 05 Oct 2021 17:45:59 -0500
Message-Id: <1633473959.465401.106809.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 17:24:52 +0200, Amelie Delaunay wrote:
> This patch adds the description of new optional phy tuning properties
> for usbphyc phy sub nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - st,phy-tuning property removed
> - tuning properties are now put directly in each child node
> - tuning properties are no more free form text and their name reworked
> ---
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1536730


usbphyc@5a006000: usb-phy@0: 'phy-supply' is a required property
	arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dt.yaml
	arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dt.yaml
	arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dt.yaml
	arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dt.yaml
	arch/arm/boot/dts/stm32mp157c-lxa-mc1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-odyssey.dt.yaml

usbphyc@5a006000: usb-phy@1: 'phy-supply' is a required property
	arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-ctouch2.dt.yaml
	arch/arm/boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dt.yaml
	arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0.dt.yaml
	arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dt.yaml
	arch/arm/boot/dts/stm32mp157c-lxa-mc1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-odyssey.dt.yaml


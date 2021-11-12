Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3939F44EDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhKLUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:13:36 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36749 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhKLUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:13:35 -0500
Received: by mail-oi1-f169.google.com with SMTP id q124so19966828oig.3;
        Fri, 12 Nov 2021 12:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WhJ/EjNNePoaOZvGJkmcFbg7yvTKkxsOk56AmN7Y+s=;
        b=njbpoUrqm9KWlB0H/GFAIsCQZAO/7rpP6Cb8VEESGVmZ8ExTQYflc1R2oOWxWu45H6
         bse2CXLQagyWmz4KzIwU6lDgJe65IovkXQ0gATgR3H5bYLUy1y5ylo549lvfOVaFMPJc
         kku5INa1HqKnxtbVVXe754qOqqKtPrS9sONgZqJoL1fc8I8LIuXu8IXbUk/zhIxdPOxy
         pG7ctfxpzdcJAzUyVqlFMd7g8/iLXm7H3Ot0GCXEaK7snPEMRl7T1S1qDoOkR/tnmBDW
         57nUFWz+5W2Fi8m4T79f1RfclVQyzU/5vLoUDrwbi+GPTHb9xG+/lYpAxK2kImYQS7sf
         PYLA==
X-Gm-Message-State: AOAM530BZXkKK/pNxJUGRC/uNtDCABSy6r/X7O9hFeIz/YDkHwp27XTA
        chjkGfnn8Bu+QY11Fv8nQrmgWfaa0w==
X-Google-Smtp-Source: ABdhPJz5m+fIBjpw5F5peYuJ09KQImnLYi9vaCrFoMWMk0nUKJK3nt3vBV8Ay7r+mVs5n1Db2c5vBQ==
X-Received: by 2002:a05:6808:120e:: with SMTP id a14mr28430803oil.122.1636747843746;
        Fri, 12 Nov 2021 12:10:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t5sm1221415ool.10.2021.11.12.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:10:43 -0800 (PST)
Received: (nullmailer pid 3287649 invoked by uid 1000);
        Fri, 12 Nov 2021 20:10:42 -0000
Date:   Fri, 12 Nov 2021 14:10:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        tiwai@suse.com, yc.hung@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, broonie@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mediatek: mt8195: add model property
Message-ID: <YY7KQi6KN4KzVvh1@robh.at.kernel.org>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103100040.11933-3-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021 18:00:38 +0800, Trevor Wu wrote:
> This patch adds the description of model property used to specify card
> name from dts.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml           | 4 ++++
>  .../bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml           | 4 ++++
>  2 files changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

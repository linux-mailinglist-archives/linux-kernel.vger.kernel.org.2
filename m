Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9995034F3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhC3WDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:03:11 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38509 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhC3WDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:03:04 -0400
Received: by mail-ot1-f45.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so17028654otk.5;
        Tue, 30 Mar 2021 15:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJpdze/YBc9sInrzv3wWDWKmQfQKODZsyxGBfKEmBhg=;
        b=OLiExuCUToCOn7wTnvEpL7dE4ZCCaWIErQXCx/Ps6YzHYNTamvsutibkZzU89FgOSY
         C97Q1BAZkESuZLt+D5yPqvCiXjF5V5CSr7hSQeMIOrd/yPFA4ARCcQWOSDHMn8YX4aCN
         Qnu0T/Xcww5Ag6+z6K0np/LpFeLmK88sXWUsDfzbpPNdHgStAsdj6baml03AVxSjrtz+
         KfxK3YDpAVXR5X72toIMaekrgYQk5vmJ7vxBJIGfBIe/oqzDWioS4CRQQatdOHHvTGeQ
         ER1Uifoo1SPu5Ob0dGTyYZ5FijAcTxO0uQ4mDwN21ERDb6t/VVsZzrxHp31iXH0yQJjb
         xlew==
X-Gm-Message-State: AOAM530NpuY4h5AhZZEsHnjVsSxNnYaeMzESsNhOzK5AC4eCCQEVhfpH
        uvfM3/EUQojgl8B7IGpo6w==
X-Google-Smtp-Source: ABdhPJyG0w+WJQJfpVr6Rdgy+U2B7ANI7OefcZrkENG6O0W6w8R85knK4/AD9sg4ymn6in2J//sG8g==
X-Received: by 2002:a9d:3a4a:: with SMTP id j68mr72619otc.4.1617141784250;
        Tue, 30 Mar 2021 15:03:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm31395otf.37.2021.03.30.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:03:03 -0700 (PDT)
Received: (nullmailer pid 793329 invoked by uid 1000);
        Tue, 30 Mar 2021 22:03:02 -0000
Date:   Tue, 30 Mar 2021 17:03:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-imx8mp: Use the correct name
 for child node "snps, dwc3"
Message-ID: <20210330220302.GA793280@robh.at.kernel.org>
References: <20210329072714.2135-1-thunder.leizhen@huawei.com>
 <20210329072714.2135-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329072714.2135-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 15:27:13 +0800, Zhen Lei wrote:
> File snps,dwc3.yaml describes the schema of Synopsys DesignWare USB3
> Controller, it directly or indirectly contains "$ref: usb.yaml". So the
> node name of "snps,dwc3" must start with "usb". Otherwise, the following
> warning will be displayed:
> 
> Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.example.dt.yaml: \
> dwc3@38100000: $nodename:0: 'dwc3@38100000' does not match '^usb(@.*)?'
>         From schema: Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> 
> In addition, replace "type: object" with "$ref: snps,dwc3.yaml#". Ensure
> that all properties of the child node comply with snps,dwc3.yaml.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619864003B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349825AbhICQyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:54:47 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:35445 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhICQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:54:45 -0400
Received: by mail-oo1-f47.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so1697071oon.2;
        Fri, 03 Sep 2021 09:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=enSj79vcN/Dm/uZSTTzwATzvAMHwNRMrauYA74ENvEY=;
        b=P9E2USX8axZ6QB0k9Ee942kbDTQDd887nPsXwoieqrFQmfFFCbTbQkFYLmjoeQayCM
         cBa2oXHN2M4yjtDf63MISggyAPpk1P1SUc30nix+mlVH39m+B4+duMGCBSazCeaKuU6M
         yIFNaETLoFNGc6Lod/zilkFkBY62o6gWe7I7VzszAH0CQQFhCDJHUJp74tbZLXuEuvhi
         R5aPBiec0s+J9upZHPixOiJ6TCN2MLPfQC/+ROO/SWLjZIOC9oltgQaRcWlpYWLovqFp
         NSunCYHddsYouaAlGLSIBEQdiObMER4XY20wjzAVBCjJyf1MduyPetbKPdX+Ta2hKln5
         fwWQ==
X-Gm-Message-State: AOAM532E0Y3LswzT8uDMpVO1ES10WRu7cpTlD4+VJNLFj94ctU5RHa4H
        0JmLTs8KLharZOlINoQ3Qw==
X-Google-Smtp-Source: ABdhPJyRTE/hdWaUnfQdRbuMAMJswUwR6XT/DIJppmGP66ppiqdiMz1FHfSfkortQtFWdbOgrBbIUw==
X-Received: by 2002:a05:6820:235:: with SMTP id j21mr3734079oob.75.1630688025383;
        Fri, 03 Sep 2021 09:53:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v186sm1148174oig.52.2021.09.03.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:53:44 -0700 (PDT)
Received: (nullmailer pid 3085928 invoked by uid 1000);
        Fri, 03 Sep 2021 16:53:43 -0000
Date:   Fri, 3 Sep 2021 11:53:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, devicetree@vger.kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peter.ujfalusi@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks
 documentation
Message-ID: <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903145340.225511-3-daniel.baluta@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 05:53:40PM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> DSP node on the Linux kernel side must also take care of enabling
> DAI/DMA related clocks.
> 
> By design we choose to manage DAI/DMA clocks from the kernel side because of
> the architecture of some i.MX8 boards.
> 
> Clocks are handled by a special M4 core which runs a special firmware
> called SCFW (System Controler firmware).
> 
> This communicates with A cores running Linux via a special Messaging
> Unit and implements a custom API which is already implemented by the
> Linux kernel i.MX clocks implementation.
> 
> Note that these clocks are optional. We can use the DSP without them.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 7afc9f2be13a..1453668c0194 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -24,16 +24,49 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: ipg clock
>        - description: ocram clock
>        - description: core clock
> +      - description: esai0 core clock for accessing registers
> +      - description: esai0 baud clock
> +      - description: esai0 system clock
> +      - description: esai0 spba clock required when ESAI is placed in slave mode
> +      - description: SAI1 bus clock
> +      - description: SAI1 master clock 0
> +      - description: SAI1 master clock 1
> +      - description: SAI1 master clock 2
> +      - description: SAI1 master clock 3
> +      - description: SAI3 bus clock
> +      - description: SAI3 master clock 0
> +      - description: SAI3 master clock 1
> +      - description: SAI3 master clock 2
> +      - description: SAI3 master clock 3
> +      - description: SDMA3 root clock used for accessing registers

Sigh, I just rejected this kind of thing for the other i.MX8 DSP 
binding[1].

Add a reference to the h/w block and then get the clocks (and other 
resources) from there.

Rob

[1] https://lore.kernel.org/linux-devicetree/YTDq%2FkWFPLHUnHMN@robh.at.kernel.org/

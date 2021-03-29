Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0753534D250
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhC2OYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:24:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44866 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhC2OYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:24:05 -0400
Received: by mail-ot1-f49.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso12404215oti.11;
        Mon, 29 Mar 2021 07:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7cbBvFM0u5OOnkRup8d3vCsO5p4xHsXrVbhJ/10pY0w=;
        b=F69CHwuNTaGVZ1Dr3unTAKI/xVf/tpgPmTiTcowqdjfzbhxLw7BzPBmnBwVMoV3CJ2
         3Qa/FzATCL1xy8xteNorRqw7H+XsfWFGnHvh3nfX+YUoRz8UDrL2DNcuPlq3twz3ZvfJ
         +kg19s7M9rO9bxmt7uOoiRz16ZQh79CGenAz+OqIWKY9iC1kzLIgn6R2M/jm1U7xs2D3
         /mT3OWX1iwJ8ZSsyUv47j2nYFvS16RwS+brsXH0Obkz1VrPxErYo0/xmRKpCAt4sfo7E
         Ssz54uNbXTWVagSfHLtlRePjEyvynUfuSbaVuF6jNcjZfIzZzP0sws5qeMtf+m+J4nUy
         FcmA==
X-Gm-Message-State: AOAM532EfY91w+hYdkq+nHefXOputm/v1+zjnDJKmUrEZ9VcTjdp+CgB
        KAfc0hL3OQJ/7DdDwcwaypqcrY/bsA==
X-Google-Smtp-Source: ABdhPJyf+sxdZg6l+rP9zu3h8+b7BWR69/FryoT+K89LgslfDxApt6g8N/GPYaZYTup2PKBl9h9+jQ==
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr22715211otq.34.1617027844013;
        Mon, 29 Mar 2021 07:24:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r2sm4368294otk.55.2021.03.29.07.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:24:02 -0700 (PDT)
Received: (nullmailer pid 2512548 invoked by uid 1000);
        Mon, 29 Mar 2021 14:24:00 -0000
Date:   Mon, 29 Mar 2021 09:24:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     marcel.ziswiler@toradex.com, robh+dt@kernel.org, airlied@linux.ie,
        tzimmermann@suse.de, guido.gunther@puri.sm,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        laurentiu.palcu@oss.nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/6] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Message-ID: <20210329142400.GA2512413@robh.at.kernel.org>
References: <1616997446-8783-1-git-send-email-victor.liu@nxp.com>
 <1616997446-8783-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616997446-8783-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 13:57:23 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Prefetch Resolve Channel.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v8->v9:
> * Reference 'interrupts-extended' schema instead of 'interrupts' to require
>   an additional interrupt(r_rtram_stall) because the reference manual does
>   mention it, though the driver doesn't get/use it for now.
>   Reference 'interrupt-names' schema to define the two interrupt names -
>   'dpr_wrap' and 'r_rtram_stall'.
> * Drop Rob's R-b tag, as review is needed.
> 
> v7->v8:
> * No change.
> 
> v6->v7:
> * No change.
> 
> v5->v6:
> * No change.
> 
> v4->v5:
> * No change.
> 
> v3->v4:
> * Improve compatible property by using enum instead of oneOf+const. (Rob)
> * Add Rob's R-b tag.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Use new dt binding way to add clocks in the example.
> 
>  .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

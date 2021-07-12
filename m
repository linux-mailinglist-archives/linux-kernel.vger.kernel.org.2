Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C03C633E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhGLTLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:11:04 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42757 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbhGLTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:11:03 -0400
Received: by mail-il1-f180.google.com with SMTP id h3so20619019ilc.9;
        Mon, 12 Jul 2021 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2M7YIyDRp1gENoSHGUY9aVt9+1qD2EsTC5NJBCX37X4=;
        b=Rm2NzDb39uiyGiT6lUy5ggbar3Eswv2VGWhxQ6ofj5f0WVyaEMbfxkKtaGju+qYc6P
         0NhrbQvHNvjEBvq0wl8YSO1p4b7MGklrgb7ttzi7SXOu3LOPGd6pwqolojUapiXA4ftX
         d06Iomps353DigqY/Eqg3P7f/Vz1cyO0kXjSj5sKzE/3UmXunFVEPAof+4pqPedHsmcj
         BxnC01D5WYY9vi+jVxPWmYRfpNS4bSs4xMu/xrbCN4vNa4VDloorBpIpQoErgShtD98f
         /iDL1JnS61M3TPETKk5vXgZZzZSU36+0brEDj/fXhongoH0/qiNT90fM/fmP5MuLI5+w
         h9kA==
X-Gm-Message-State: AOAM531m30ZcE3zNuU8caGva3KuIfj6CdLohp7qktbUdpu99aedeb0iD
        dIVTYpe7MVdmxc/6GGnInw==
X-Google-Smtp-Source: ABdhPJzKmT63VhWHvz6Gt43Hgf8rHhxkjEEh2GltWkhFJXhb3gzkCEwmig2tRpvP0B47gIT7hB+v+Q==
X-Received: by 2002:a92:6e07:: with SMTP id j7mr235895ilc.71.1626116893425;
        Mon, 12 Jul 2021 12:08:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g1sm8170313ile.35.2021.07.12.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:08:12 -0700 (PDT)
Received: (nullmailer pid 2311680 invoked by uid 1000);
        Mon, 12 Jul 2021 19:08:09 -0000
Date:   Mon, 12 Jul 2021 13:08:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: usb: mtu3: add optional property
 to disable usb2 ports
Message-ID: <20210712190809.GA2310371@robh.at.kernel.org>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
 <1624008558-16949-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624008558-16949-3-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 05:29:07PM +0800, Chunfeng Yun wrote:
> Add support to disable specific usb2 host ports, it's useful when
> a usb2 port is disabled on some platforms, but enabled on others for
> the same SoC, another case is that the different package may support
> different number of ports.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index 2cac7a87ce36..3e6f2750f48d 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -166,6 +166,12 @@ properties:
>      description: The mask to disable u3ports, bit0 for u3port0,
>        bit1 for u3port1, ... etc
>  
> +  mediatek,u2p-dis-msk:

Just spell out 'mask'.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The mask to disable u2ports, bit0 for u2port0,
> +      bit1 for u2port1, ... etc; but can't disable u2port0 if dual role mode
> +      is enabled, so will be skipped in this case.
> +
>  # Required child node when support dual-role
>  patternProperties:
>    "^usb@[0-9a-f]+$":
> -- 
> 2.18.0
> 
> 

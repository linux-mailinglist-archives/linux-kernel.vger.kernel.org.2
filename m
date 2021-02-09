Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E05315AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhBJAPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:15:39 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46827 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhBIUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:57 -0500
Received: by mail-oi1-f172.google.com with SMTP id k25so20881927oik.13;
        Tue, 09 Feb 2021 12:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2s5+gI5RkcmBiEkvRs0kblor0zn4pUAbODGQq2QGc9Y=;
        b=ZIDgEFpQhkd71A2e27EuAc9lM1c4bodiJQRKN7vucGRyw2NEVkKa/DAH7tqex8kdw4
         NbacxMeaizZdLm7asrMkA7B9n3TJGRf7u+mb73moZM5zJgBvcbwa4YZzsvdIzLNv5qa8
         dVvIU79cyPHMunWR2LgS8AjUrGuJb0HARUHZUoaaZGYACok2KXoANl7hY1iCIcXgPQTq
         M4gky4n4j9jWshuasrbSG4AXDyBTjs6CqCihbHoAnn1qwmQlsfbACUwyUJE5RDpZMA20
         0vLmabviV9vw6Lnqk315/jBu/yfzfByzkqDMW0mNC488IUeu8/EUydJrPKYB18w4XBas
         RlOA==
X-Gm-Message-State: AOAM531bOoSrHjAF8CGrr0dzACs6UCyLU7GBX45rTZeSyeDaIvxMWrpE
        eKi3e9QnkF6ASjOZ5VZn4Q==
X-Google-Smtp-Source: ABdhPJxcbTWoPyqVdl4qZFD5NZhVbO2hWAT36p59UdrslscD+BpxXnlxEZlbWI5rCtc/8MHFmM/O3A==
X-Received: by 2002:aca:2102:: with SMTP id 2mr3811202oiz.80.1612903574974;
        Tue, 09 Feb 2021 12:46:14 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm795351oij.48.2021.02.09.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:46:13 -0800 (PST)
Received: (nullmailer pid 146771 invoked by uid 1000);
        Tue, 09 Feb 2021 20:46:11 -0000
Date:   Tue, 9 Feb 2021 14:46:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH next v3 02/16] dt-bindings: usb: mediatek: fix yamllint
 check warning
Message-ID: <20210209204611.GA143456@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-2-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:00:02PM +0800, Chunfeng Yun wrote:
> Fix warning: "too many spaces inside brackets"
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml          | 2 +-
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml    | 6 +++---
>  Documentation/devicetree/bindings/usb/mediatek,musb.yaml    | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 38b1fe18aa79..a3817f3af59d 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -139,7 +139,7 @@ patternProperties:
>      description: The hard wired USB devices.
>  
>  dependencies:
> -  wakeup-source: [ 'mediatek,syscon-wakeup' ]
> +  wakeup-source: ['mediatek,syscon-wakeup']

We allow either 0 or 1 space, so this should be fine. Confused...

>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index f5c04b9d2de9..66d78f534722 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -172,9 +172,9 @@ patternProperties:
>        example if the host mode is enabled.
>  
>  dependencies:
> -  connector: [ 'usb-role-switch' ]
> -  port: [ 'usb-role-switch' ]
> -  wakeup-source: [ 'mediatek,syscon-wakeup' ]
> +  connector: ['usb-role-switch']
> +  port: ['usb-role-switch']
> +  wakeup-source: ['mediatek,syscon-wakeup']
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> index 790efe8b6274..a515c9f30b96 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> @@ -66,8 +66,8 @@ properties:
>      type: object
>  
>  dependencies:
> -  usb-role-switch: [ 'connector' ]
> -  connector: [ 'usb-role-switch' ]
> +  usb-role-switch: ['connector']
> +  connector: ['usb-role-switch']
>  
>  required:
>    - compatible
> -- 
> 2.18.0

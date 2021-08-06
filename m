Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A03E3077
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbhHFUnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:43:40 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:42778 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhHFUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:43:39 -0400
Received: by mail-io1-f43.google.com with SMTP id h1so13829891iol.9;
        Fri, 06 Aug 2021 13:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85KYKrivONUxgMBoJUEhliU3kHWvhvn/JV7RSsVVnI4=;
        b=PfNgM1CjmZvbJh0ADTlCLhtSqzTCD8euq+pSnMQpK5lMw4VRBaHEkKtFOsAPNNhjfb
         I+cpd8C/SEkRmLBfrdq8rbefDFcKvYaLmDaXW/lWCq3+rKHXlACzq8KwgPJ5aeRytpJP
         EDYbymxr8r0N4fl6ymjic+5OlvyQ/Xn4Y6pTDeIYfmzbO4nu1ArFzvu1u/+65m39rZ5w
         xtAwIelz19VA2wzwvDXapkDuftXNzqs8RDN0o97nW52qHU/V5RCvPM8DwjYsB8AnhwSP
         8uGczceKTyyS/69/u83OCBmGsnpquzOkig/067g65ivvYp84HcvZ2Sb01AXCt1YhcqQg
         Bq3w==
X-Gm-Message-State: AOAM532j/pERC9/A3oSCuxXc/JHpokcxXAzZ6vtpbbEuGK2N19GK3FS6
        ZMRnjJio7OizI9AqhAv/cw==
X-Google-Smtp-Source: ABdhPJxjS2d6CDMmPdtPpkPsLbJ7cOc+rjjAk8K5YHLGu0WjzWd9rNma7ebUcLrn4Jb8r09ZzkTN4w==
X-Received: by 2002:a92:de09:: with SMTP id x9mr130637ilm.284.1628282602559;
        Fri, 06 Aug 2021 13:43:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f16sm5253453ilc.53.2021.08.06.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:43:22 -0700 (PDT)
Received: (nullmailer pid 1762401 invoked by uid 1000);
        Fri, 06 Aug 2021 20:43:20 -0000
Date:   Fri, 6 Aug 2021 14:43:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 03/11] dt-bindings: usb: mtk-xhci: add compatible for
 mt8195
Message-ID: <YQ2e6AGFi7beqp6Q@robh.at.kernel.org>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
 <1627635002-24521-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627635002-24521-3-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:49:54PM +0800, Chunfeng Yun wrote:
> There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
> exclude IP0) have a wrong default SOF/ITP interval which is
> calculated from the frame counter clock 24Mhz by default, but
> in fact, the frame counter clock is 48Mhz, so we should set
> the accurate interval according to 48Mhz. Here add a new compatible
> for MT8195, it's also supported in driver. But the first controller
> (IP0) has no such issue, we prefer to use generic compatible,
> e.g. mt8192's compatible.

That only works until you find some 8195 bug common to all instances. 
Can't you read the clock frequency?

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 61a0e550b5d6..753e043e5327 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -31,6 +31,7 @@ properties:
>            - mediatek,mt8173-xhci
>            - mediatek,mt8183-xhci
>            - mediatek,mt8192-xhci
> +          - mediatek,mt8195-xhci
>        - const: mediatek,mtk-xhci
>  
>    reg:
> -- 
> 2.18.0
> 
> 

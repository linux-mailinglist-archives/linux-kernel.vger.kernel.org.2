Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840DD3DAB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhG2Srg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:47:36 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:39775 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhG2Srd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:47:33 -0400
Received: by mail-io1-f43.google.com with SMTP id f6so2588914ioc.6;
        Thu, 29 Jul 2021 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXUaHWb17rRBkscs+X15u2vWI6zx0AERlWO1TvqsfQc=;
        b=JL0rh8i5Y5sImQZ6iM96zuDl3axB8M0hoF8dmH4bYPBmCx9HBIWdWIRjXOZHbzQImd
         aJ94x/SkrI7iTCslZ4GDvQ/mD7EIjAh27C5bNhVoGWvj5DBDqR+WUfbFW0lLiIIiDXuk
         Bxpp1ThyVMCMpzAWjpy+yDXimPRwlWq5KDhkk13JBng954SNCog80Krf307laUleLXDM
         dbfQOrC8t6EcmIoso1gwX8Jr2QpdT+RHZ5uFIUZC/k0lViMlNLKFNufgD+x3IutFFv3X
         Cbgq9iXSQ327MoghRHLPzWTv3hKfAP3ZWbb6VO9/UltdEjt4OOyKRLDxM+QqSSrNTZgH
         DRUw==
X-Gm-Message-State: AOAM530HTJ+DxSB8t564cfEBwatEOsPX6YcQWlLMUCnJw4o6ZgbvdSpA
        4g13ev+dTpq24p+Bb6Xl7w==
X-Google-Smtp-Source: ABdhPJxrnJg4IzjTnLhlQ9yzS4rXMgXt/nFaInSKZq/xQrOFCtioJPpHOFZEvJJQ7W8QIrOPD03zxQ==
X-Received: by 2002:a05:6602:58b:: with SMTP id v11mr5235906iox.70.1627584449501;
        Thu, 29 Jul 2021 11:47:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v18sm2322404iln.49.2021.07.29.11.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:47:28 -0700 (PDT)
Received: (nullmailer pid 671440 invoked by uid 1000);
        Thu, 29 Jul 2021 18:47:27 -0000
Date:   Thu, 29 Jul 2021 12:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: Extend patternProperties to
 optionally indicate bit position
Message-ID: <YQL3v5bSGG7Hof93@robh.at.kernel.org>
References: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1626661864-15473-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626661864-15473-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:31:03AM +0900, Kunihiko Hayashi wrote:
> Allow to extend expression of sub nodes to optionally indicate bit
> position. This extension is needed to distinguish between different bit
> positions in the same address.
> 
> For example, there are two nvmem nodes starting with bit 4 and bit 0
> at the same address 0x54. In this case, it can be expressed as follows.
> 
>     trim@54,4 {
>         reg = <0x54 1>;
>         bits = <4 2>;
>     };
>     trim@54,0 {
>         reg = <0x54 1>;
>         bits = <0 4>;
>     };
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2..9dfe196 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -40,7 +40,7 @@ properties:
>      maxItems: 1
>  
>  patternProperties:
> -  "^.*@[0-9a-f]+$":
> +  "^.*@[0-9a-f]+(,[0-9]+)?$":

The bit offset should be hex. But I think the max would be 7 as we can 
assume 'reg' starts at a byte boundary.

I'll fix up when applying.

Rob

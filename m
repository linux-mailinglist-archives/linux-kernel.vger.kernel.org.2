Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593F135CA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbhDLP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:59:31 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40698 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhDLP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:59:30 -0400
Received: by mail-ot1-f44.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so13236093otb.7;
        Mon, 12 Apr 2021 08:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8mqQNMejN8r3XNzqzZUQEDV1TBSvz3m0F5gnKEmk2Q=;
        b=FjgWdnL7vAZdtwNfqMa6qJjQtSrvtVhTMvBz4zDrzHL9Sh9Xt9hIuVfFQl3dslPM63
         XCzKYGStvbNEXhcCZVz5RbFfL6UW9YIVc3c4kBYdeJktt51VsLu7cDrBlgstgTlLq6bU
         rpfXEuAfLviQuYad1WY6dEO10iT1PKPP7zw5LFoWbacjg5w1tUVS0bIxC7kYsfIY/2FA
         P3YnnfnVJPFyVAb+Usc1NGSHoFHXTfIyyK3JeTC3U910SCSztzNa3+fgxmXaTJviHIqT
         LgjEaqfYrvzJwhiEGLkr1EHxP19dUHa8mYFXWQvEXNDOd+5bDI5ZYVfVKzpNoaLzeYid
         iA/Q==
X-Gm-Message-State: AOAM53137qFjawe3SWq4fzczk/k+kQaG4B+/2WYQo06KSPZSJN26Pvkh
        Z83Q+k79SLVjEo4lwBRiOg==
X-Google-Smtp-Source: ABdhPJwP31fm7+UhlgtmiR5A5n5kQN+n3htgVpyOrqH3ry24ejd5rjWkE9SZqRHNPzuYBXMKB0w44Q==
X-Received: by 2002:a05:6830:149:: with SMTP id j9mr24866361otp.66.1618243151906;
        Mon, 12 Apr 2021 08:59:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm1191222oiw.27.2021.04.12.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:59:11 -0700 (PDT)
Received: (nullmailer pid 3967470 invoked by uid 1000);
        Mon, 12 Apr 2021 15:59:10 -0000
Date:   Mon, 12 Apr 2021 10:59:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nina Wu <nina-cm.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
Subject: Re: [PATCH v3 1/7] dt-bindings: devapc: Add 'vio-idx-num' field to
 support mt8192
Message-ID: <20210412155910.GA3966290@robh.at.kernel.org>
References: <1617956377-4075-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617956377-4075-1-git-send-email-nina-cm.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 04:19:31PM +0800, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> For new ICs, there are multiple devapc HWs for different subsys.
> We add a field 'vio-idx-num' in DT to indicate the number of
> devices controlled by each devapc.
> To be backward compatible with old ICs which have only one devapc
> HW, this field is not required. The 'vio-idx-num' info will be set
> in compatible data instead.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> index 31e4d3c..909e524 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -20,11 +20,17 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-devapc
> +      - mediatek,mt8192-devapc
>  
>    reg:
>      description: The base address of devapc register bank
>      maxItems: 1
>  
> +  mediatek,vio-idx-num:
> +    description: The number of the devices controlled by devapc
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1

A uint32 is always 1 item, so drop. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
>    interrupts:
>      description: A single interrupt specifier
>      maxItems: 1
> -- 
> 2.6.4
> 

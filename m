Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0F40FB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhIQPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhIQPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:13:27 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24BC061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:12:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso13285923otp.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbpkK3MKWhoicNomq4vZswgf8W9C6ZPEXdT4IuLeAN0=;
        b=tPA9DSkPfjRU158Maapz60FNNSZmq0GLX+2Q1HSIUa8gHmKQfo2PxxNzrbwcf4EIBz
         FtxMUA87nFBkLBIQ7WfusK8x+wamF/BFOoJS0xT6ZcY+k6q88LXViEYSqrljM7ln8e9/
         proV7MjGX1pyPwDv5y6ErlMMjfZU0wCWjQXAdsu0an9Gbxg/DqIx0TxX3bOPOFkWbZtw
         nvYUQtUki/v83A9U1toQvo/Z2ptyf429kvn84v7q2TGWiXGM/l+waAfFXMJ4SkpueD/L
         3HXLQPt+QikzMv7CCthdzr7A00omUIBd+3W979a6jvYxvdEdfg85UG2LH5Ek0ZmwTbxG
         Oa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbpkK3MKWhoicNomq4vZswgf8W9C6ZPEXdT4IuLeAN0=;
        b=wk6ZTfBn1t1KKOFRiKSWKPRDa/FdFW4KDYlD4bW5LFEiUMux/kOPrnXNLW4jfDPQAF
         J8Z7B9U3irL0h4CCl3kqNPIFdjmFvh1aXx+UV7sVvFEjjLtajOl2Poxr4MoCFpnvGu2J
         F8XR6zI3eO/RCPiH0D+SpAPQR54XKECu0Si9/gCN/Sf9WRFypfZn8XhUjXX0MW5AZou4
         isHYgEtVmvEZCjgKULEh6KpfX73m2MaVUdehNZ4hSPzYXTsvIA1UEi8lBktSCCspJzrZ
         HmdoPu/QqvVJauOJjWMuIkD317rxHOq3NUU4L6gG1qxPNFb7r3n2Iou3MkzcvNq7roFS
         Wsxg==
X-Gm-Message-State: AOAM530pgnjcwgiZXq6PWxNjvcqvPjBuPoCaOwggkgIW341vJgegM88X
        OC/uhlVJE9BVrqeL4/8FSGYF1Q==
X-Google-Smtp-Source: ABdhPJzXQBFkdOea9/dxNT0X+/pbnPjluuH5FejB9i1Rtzyvjuum48zbXlO5HMCj+dwC4CWzaDIWKQ==
X-Received: by 2002:a05:6830:1b6f:: with SMTP id d15mr9708181ote.158.1631891524489;
        Fri, 17 Sep 2021 08:12:04 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bi41sm1501939oib.54.2021.09.17.08.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:12:04 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:12:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
Cc:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] dt-bindings: hwlock: omap: Remove board-specific
 compatible from DT example
Message-ID: <YUSwQL6nblBEsqvD@yoga>
References: <20210917094740.18891-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917094740.18891-1-sinthu.raja@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Sep 04:47 CDT 2021, Sinthu Raja wrote:

> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The example includes a board-specific compatible property, this is
> wrong as the example should be board agnostic. Replace the same with a
> generic soc node.
> 

I do think your fix is correct in that it results in a proper tree, but
the examples are not supposed to describe the node in a fully described
DT tree, but rather just show an example of the particular binding.

I therefor think that it would be appropriate to reduce that second
example to just:

spinlock@30e00000 {
  compatible = "ti,am654-hwspinlock";
  reg = <0x30e00000 0x1000>;
  #hwlock-cells = <1>;
};

Because the rest has nothing to do with this binding.

That said, this example is now the same example as the first one, just
with different compatible, so I think we should drop the entire second
example instead.


PS. While we're doing that, we should also remove the "hwspinlock: "
label from the first example.

Regards,
Bjorn

> Fixes: d8db9dc34871 ("dt-bindings: hwlock: omap: Convert binding to YAML")
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> This patch was triggered by discussions in [1].
> 
> When applying the patch, if you could provide an immutable tag for the
> bindings, it would help line things up for new platforms to be added for
> us. See [2] for the context
> 
> [1] https://lore.kernel.org/all/20210818074030.1877-1-sinthu.raja@ti.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210125141642.4yybjnklk3qsqjdy@steersman/
> 
>  .../devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml        | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> index ae1b37dbee75..d56dc1bebdc6 100644
> --- a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> @@ -47,10 +47,8 @@ examples:
>      };
>  
>    - |
> -    / {
> +    soc {
>          /* K3 AM65x SoCs */
> -        model = "Texas Instruments K3 AM654 SoC";
> -        compatible = "ti,am654-evm", "ti,am654";
>          #address-cells = <2>;
>          #size-cells = <2>;
>  
> -- 
> 2.32.0
> 

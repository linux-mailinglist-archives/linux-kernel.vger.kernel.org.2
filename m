Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D48543E9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJ1VIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:08:40 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37551 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1VIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:08:39 -0400
Received: by mail-ot1-f43.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so2203112ott.4;
        Thu, 28 Oct 2021 14:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XVJUVap2P2gJYg9l9WG2NRtaweuMCWN0cL5et2AKLdc=;
        b=o46pccM+3COvV+5bhSyKAJSN/DWf2KYMCYWKnVhYMZPjcYhSCHjFZ6jAGQs0XpBXWJ
         AEs1G3eLMsGpeoALL0uZamcRN5MFTu4l05QKl7Mk3XuixygYYGgS2oISl5Z8PJWOBLPX
         g3/CHoP0ysdfqrO8goKyWGejC1aPrX3QxpR7paaJuw/JgASrawlSYFHzo9d5HKvvVhGy
         RoNLT/L02SiLeQgINHCIO/60WfatCFyBu4nLPq9M6VMguoCPPhvUuNWErEYr48HYmWhg
         tNJXGvGJQyK/SkTD5Go4G0z9yh5zjGUEmJTL0u8GaAZWh13YoZqvwPE7w0m1FlyOlTfb
         fhxg==
X-Gm-Message-State: AOAM531tLIzQ0VTpDWUUbcx6aM96L00I/SQCN6KuGRkHQ1KqxuG/OXeH
        EiN4Vyh/TJfzV+W8zh9Nbg==
X-Google-Smtp-Source: ABdhPJyBV3+cZWbdNnRHQFL+cNC1z1UxQlGAIb7M72PaNSUVhnWK7bXddQkGanWJR+yAYheXgKckgA==
X-Received: by 2002:a05:6830:2a8c:: with SMTP id s12mr5588441otu.322.1635455171291;
        Thu, 28 Oct 2021 14:06:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m7sm1286502oiw.49.2021.10.28.14.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:06:10 -0700 (PDT)
Received: (nullmailer pid 585631 invoked by uid 1000);
        Thu, 28 Oct 2021 21:06:09 -0000
Date:   Thu, 28 Oct 2021 16:06:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/8] dt-bindings: phy: uniphier-pcie: Add bindings for
 NX1 SoC
Message-ID: <YXsQwXj/ySV78+d6@robh.at.kernel.org>
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634687888-23900-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634687888-23900-4-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 08:58:03 +0900, Kunihiko Hayashi wrote:
> Update PCIe-PHY binding document for UniPhier NX1 SoC. Add a compatible
> string for the SoC to the document.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243AD37ED75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384630AbhELUZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:25:09 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40570 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385262AbhELUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:07:54 -0400
Received: by mail-ot1-f47.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so11527574otq.7;
        Wed, 12 May 2021 13:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cU36NcYiaevsm5YlhwbHu9nUioXD99KMHMa6mXtBEzU=;
        b=FTCRDCCJgRMMuV6AE3ub1dMbTxY3upINxTMhfMth5dRSO3WSn7Kc5p9UNS9POAnxq3
         ptnThgw0bHrk15S7V/zUlMlJAoM81ip2Fy0PEY6+vJx6Kj3imUb46TEB8K4lzordgZr5
         YE2twd5PrRn8uW0uPN50A2n4GGf//wDVy0Vt2ZsGcdsyMKFFBNb6aFiMET5ABtIn2Deu
         GHbjsWnGhDtRyb+NQBfQA0R4rTqVAB9ifsaU7M6/R/UWYSZsmIvE3tpe7sYo85p+gn85
         Y7JQ+z99lLXnTCt46zhKmRJDjjbfOGRXJqgwZOSzgt0C86wwll4ModgeuRUzGqJX2q8F
         8+JQ==
X-Gm-Message-State: AOAM532v7Ytx7c3qxdWg6sXKwLaD0VNJPHPwXV0siXb70Zg1N0UznMZ/
        3N4Mi4/9kviUy3yVLBFjLw==
X-Google-Smtp-Source: ABdhPJxphN0GtiN334k/QK1IpY2uMD31NqkpC+sYSNf2GEWM4vRsewoEDUE8VzouS6MEFbjCrNHvLA==
X-Received: by 2002:a05:6830:1e70:: with SMTP id m16mr25022703otr.340.1620850004228;
        Wed, 12 May 2021 13:06:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r19sm229021ooj.5.2021.05.12.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:43 -0700 (PDT)
Received: (nullmailer pid 2230906 invoked by uid 1000);
        Tue, 11 May 2021 16:27:11 -0000
Date:   Tue, 11 May 2021 11:27:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: memory: tegra20: emc: Convert to schema
Message-ID: <20210511162711.GA2230846@robh.at.kernel.org>
References: <20210510212320.3255-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510212320.3255-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 00:23:20 +0300, Dmitry Osipenko wrote:
> Convert Tegra20 External Memory Controller binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v4: - Doesn't have duplicated properties by making use of $defs/$ref,
>       which was suggested by Rob Herring in a review comment to v3.
> 
> v3: - Fixed dt_binding_check warning about the missing reg property.
> 
>     - Became a standalone patch since other v2 patches were applied.
> 
>  .../memory-controllers/nvidia,tegra20-emc.txt | 130 ----------
>  .../nvidia,tegra20-emc.yaml                   | 230 ++++++++++++++++++
>  2 files changed, 230 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> 

Applied, thanks!

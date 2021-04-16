Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58BE362869
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhDPTNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:13:25 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41978 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhDPTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:13:21 -0400
Received: by mail-oi1-f180.google.com with SMTP id r186so1113555oif.8;
        Fri, 16 Apr 2021 12:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNjkbun/XYfHCNxGgq9zHxG/GMby9cLqXNMucsqMB1w=;
        b=TmbNKGiJYCTTEpGWhsMRe9TW/qy0paCIVp94CjBt5rwfjFMhJxgDQk3YLKi9WN9+T3
         D/XtGPK5si7qqQrnufRzaNtT02NqmCP0+maB8hPQqDZnApqHPFsdR4meWKCnopF3GnRQ
         8j7YeSrkHFKwdyQcCfTQAzS13omveaqDBxcZkM6Qu7qChuGjXNuifWwtauRxvstBjRjd
         M97isnLiMJGGH0LYpVfihhIK3DyJ/hIbNqQCiDzUX3CNkXyvsRawnJzAh6CHVgGwgajD
         O+WLrl1cE2vKH6Q9YGKP9FSBoA88qfsl/i0271rdGSFsCcdhKLA1lXAK0L+us65TGM+w
         /ucg==
X-Gm-Message-State: AOAM530G8eu4c0D60UU/S/hA3hueinS1mJ5UyAwb3mgYvC5YPiTrk1Xt
        rY9XgSizU4KsZWdoOTtgbg==
X-Google-Smtp-Source: ABdhPJxgh6O5W1jlb8bKCqeMgP6WIAUMETr3Uer8iH7Yq2NSXt9VKsmR9WjIZMIRYZ2jxU7aSlU0WA==
X-Received: by 2002:aca:4442:: with SMTP id r63mr7533105oia.102.1618600376326;
        Fri, 16 Apr 2021 12:12:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h17sm1498246otj.38.2021.04.16.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:12:55 -0700 (PDT)
Received: (nullmailer pid 3779654 invoked by uid 1000);
        Fri, 16 Apr 2021 19:12:54 -0000
Date:   Fri, 16 Apr 2021 14:12:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s-anna@ti.com, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V3] dt-bindings: mailbox: ti, secure-proxy: Convert to
 json schema
Message-ID: <20210416191254.GA3779553@robh.at.kernel.org>
References: <20210416005953.17147-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416005953.17147-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 19:59:53 -0500, Nishanth Menon wrote:
> Convert the ti,secure-proxy to yaml for better checks and documentation.
> Differences being mostly in the examples:
> - Dropped the example usage of mailbox client, it is better done in
>   tisci node definition.
> - Switched reg usage for address-cells and size-cells 1 - aligned with
>   schema checks as well.
> - included header in example for a buildable example.
> 
> While at this, lets make sure to support upto 100 rx threads even though
> typically upto 1 threads is practically in use.
> 
> NOTE: The following checkpatch warning is generated since we do include the header
> in the example, but this is a false positive warning.
>   WARNING: DT binding docs and includes should be a separate patch. See:
>   Documentation/devicetree/bindings/submitting-patches.rst
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes since v2:
>  - Subject line rewording to indicate json schema rather than yaml
>  - Review comment: Dropped "-" in interrupt-names pattern so that it will match all
>    entries
>  - Minor commit message formatting changes
> 
> V2: https://lore.kernel.org/linux-arm-kernel/20210413224535.30910-1-nm@ti.com/
> V1: https://lore.kernel.org/linux-arm-kernel/20210413171230.5872-1-nm@ti.com/
> 
>  .../bindings/mailbox/ti,secure-proxy.txt      | 50 ------------
>  .../bindings/mailbox/ti,secure-proxy.yaml     | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

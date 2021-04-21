Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC9367531
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhDUWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:33:33 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44557 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDUWdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:33:32 -0400
Received: by mail-ot1-f47.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so14432315otp.11;
        Wed, 21 Apr 2021 15:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpOmUUExdbFkJ4kS32EEaVe5t2M7xJq+mg38SoSOiuc=;
        b=MvGAF9Yw4vv/goAq1/jWapJlrh8VKUmT27WNJCxzGZ3gpU4hmudaY9iClAMFlmz0mt
         eeQI4ceH1Lt+Eko1zkq8USmEPUCjTPNNi6ThzopRmGdQA1JIYxl1zDroAGJL0ubidgnB
         f3EB3Bo/HZ+BhqG5pVXf1Ko5mKI9EetMqoy2mqt2wglOKYi4qEO0O69l7wPe487IPJjR
         XbZGxwSU6RlJjgKblS0Wus12ZUBhr7hGczQo0acdFymNZ5zBzSxzBMsbux4l3pSVyiJ7
         AQOU1vuyJuiQoDD9X0B6eZhet4IBpv5DXz2s0fn6I5VQ7KQUb/1RL0FkHTAPWVGQFP4j
         9KQQ==
X-Gm-Message-State: AOAM533j9L/odNW5DEymTKtH96ToHEynnHt0fTDXGAQl5+1+x/bIIgBf
        HAF5NO7iP1J8VbkcNPAKjGzDyN9Nmg==
X-Google-Smtp-Source: ABdhPJyBpK5+T8amA19Lhb4J6/XazxnG/kEaaOGHTBdikqQyXjrOfxT7tQdjc1b1ReGEgRYjsQZF+Q==
X-Received: by 2002:a9d:a2a:: with SMTP id 39mr299856otg.371.1619044376711;
        Wed, 21 Apr 2021 15:32:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm209136oob.12.2021.04.21.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:32:55 -0700 (PDT)
Received: (nullmailer pid 1735222 invoked by uid 1000);
        Wed, 21 Apr 2021 22:32:54 -0000
Date:   Wed, 21 Apr 2021 17:32:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Convert ti,sci-reset to json
 schema
Message-ID: <20210421223254.GA1734415@robh.at.kernel.org>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416063721.20538-2-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:37:18AM -0500, Nishanth Menon wrote:
> Convert the ti,sci-reset to json schema for better checks and documentation.
> 
> Differences being:
>  - Drop consumer example as they are documented in the corresponding
>    bindings themselves.
>  - Drop phandle description for reset consumer or cell definition as it is
>    redundant.
> 
> NOTE: we do have false positive checkpatch warning with this patch:
> "DT binding docs and includes should be a separate patch"
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/reset/ti,sci-reset.txt           | 62 -------------------
>  .../bindings/reset/ti,sci-reset.yaml          | 51 +++++++++++++++
>  2 files changed, 51 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml

Reviewed-by: Rob Herring <robh@kernel.org>


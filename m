Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AED367506
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbhDUWNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:13:12 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46662 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhDUWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:13:09 -0400
Received: by mail-ot1-f48.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso38427611otb.13;
        Wed, 21 Apr 2021 15:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vfZ85qaNRDwLWK6paIlumo1fUktvseuhhjpTPIiObQ=;
        b=kiNCDVfMII2MvtKxqSi0z+sxjnz4Nt5i4PlPLhrNlXLNkDNsUJOJJ0jdstFn06/rZv
         tPlngEoQp3JvkMo0GE2Ux3qCwGyeV6YFvpiltKmLQ8sHih5bO2HNW8zu+BGLdMPI1ZIt
         SAUTiWd0rU9Ga83XB1Susd9lvRtfpptiKOJJZNklzVQQ/7PsdAJhiSdqDCMX6miLoniR
         UbgBUXY2QqzZrC06lEtWkkwoUfyy/c8YqMmuGHq85j2ldmdeoaHM2ak9ulL6oysyaNiM
         q9BBtmKXfpax++ibL1eXa3/NCZHdEOCsJdCTZjlmCWzcQk2KTEFyEmb+leVZnYUJkdd7
         q1gw==
X-Gm-Message-State: AOAM532+U4/Msl+SAN1HgZDhvyfsCUxMGJbQSZvvH79Bwbz6lhRP5mu+
        YbDYQfSHvSk5Bsk9op4BLA==
X-Google-Smtp-Source: ABdhPJw6ztIYw2u9aV58Nwci+XDmx1pHvvuUJfxXD65mDFjOzNkizDKgyLgUCDTJ1Z0zh+WzGKPBuQ==
X-Received: by 2002:a9d:7583:: with SMTP id s3mr241540otk.367.1619043155325;
        Wed, 21 Apr 2021 15:12:35 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v81sm151880oie.13.2021.04.21.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:12:34 -0700 (PDT)
Received: (nullmailer pid 1708485 invoked by uid 1000);
        Wed, 21 Apr 2021 22:12:33 -0000
Date:   Wed, 21 Apr 2021 17:12:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] dt-bindings: soc/arm: Convert pending ti,sci*
 bindings to json format
Message-ID: <20210421221233.GA1705110@robh.at.kernel.org>
References: <20210416063721.20538-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416063721.20538-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:37:17AM -0500, Nishanth Menon wrote:
> Hi,
> 
> I understand that the following series belong to various maintainers,
> but, it is a bit better reviewed as a single series for
> cohesiveness.

They need to go in together as patch 4 depends on the others.

> 
> There are also dts fixups that this series exposes, which is good, but
> I chose to hold them back for now pending binding review at least. The
> complete series is available in [1] if folks are curious.
> 
> Nishanth Menon (4):
>   dt-bindings: reset: Convert ti,sci-reset to json schema
>   dt-bindings: clock: Convert ti,sci-clk to json schema
>   dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
>   dt-bindings: arm: keystone: Convert ti,sci to json schema
> 
>  .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
>  .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
>  .../devicetree/bindings/clock/ti,sci-clk.txt  |  36 -----
>  .../devicetree/bindings/clock/ti,sci-clk.yaml |  52 +++++++
>  .../bindings/reset/ti,sci-reset.txt           |  62 ---------
>  .../bindings/reset/ti,sci-reset.yaml          |  51 +++++++
>  .../bindings/soc/ti/sci-pm-domain.txt         |  65 ---------
>  .../bindings/soc/ti/sci-pm-domain.yaml        |  59 ++++++++
>  8 files changed, 291 insertions(+), 249 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> 
> [1] https://github.com/nmenon/linux-2.6-playground/commits/yaml/tisci
> 
> Regards,
> Nishanth Menon
> -- 
> 2.31.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B365402E50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbhIGSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:25:12 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33515 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345718AbhIGSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:25:11 -0400
Received: by mail-oi1-f176.google.com with SMTP id n27so130335oij.0;
        Tue, 07 Sep 2021 11:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOZK9HeA+f0nYZagIgOWI8O/YEDsHND1iSu6Vm2M6zo=;
        b=OgvJU11awLrdjnveE6Gb7X656kRwpeNZgKrS9kyb7yd7gnmwlbyWpbfUBiTadplzYo
         cQM7ywDfyKfHzSxrSc9iWmkEe4Q2rtFsaOImtmOremrh+adzOWZ89m5/BQOUryQS0Ok4
         KoPRj9kPNA95H5WYk4Kj4E5SUsCIvxB/fjhPYkjVrn0s8CQNrF/VPlDsWMnL7VXjRXXo
         aCobFuT+I9RpSBkG3paxMV2O1lWGBKcHM8UkRI1W700ICdi0kFMaL6D8ltH6CSwinv/U
         3qqKuKfTjgAffVgaWtcxcx2I9uQLr3Xhvswjlv/1sssj4hyzR5JRV5YsOWizx5R/jImX
         9n6Q==
X-Gm-Message-State: AOAM531wekn1ptULlpUzKxhNTSVInEEjGMxo4+ZFuWH/dU6QqIpksmL9
        2OFTxq7EUyuUjBQSAs4ong==
X-Google-Smtp-Source: ABdhPJw1Y3//Zx0P1mMOmsULYvzFYUu7GalyTb4h9oIPkCO2x1L/4EQOA9uVJOLSIthZWYgwmeJVpw==
X-Received: by 2002:aca:f143:: with SMTP id p64mr4047412oih.161.1631039044112;
        Tue, 07 Sep 2021 11:24:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l4sm2513988oth.4.2021.09.07.11.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:24:03 -0700 (PDT)
Received: (nullmailer pid 99324 invoked by uid 1000);
        Tue, 07 Sep 2021 18:24:02 -0000
Date:   Tue, 7 Sep 2021 13:24:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     will@kernel.org, mark.rutland@arm.com, sgoutham@marvell.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: perf: Add YAML schemas for Marvell
 CN10K LLC-TAD pmu bindings
Message-ID: <YTeuQvMoFOeY0FeJ@robh.at.kernel.org>
References: <20210901150105.18863-1-bbudiredla@marvell.com>
 <20210901150105.18863-3-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901150105.18863-3-bbudiredla@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 08:31:05PM +0530, Bhaskara Budiredla wrote:
> Add device tree bindings for Last-level-cache Tag-and-data
> (LLC-TAD) unit PMU for Marvell CN10K SoCs.
> 
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-tad.yaml      | 60 +++++++++++++++++++

marvell,cn10k-tad-pmu.yaml

>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
> new file mode 100644
> index 000000000000..18e9499f2df8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell-cn10k-tad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell CN10K LLC-TAD performance monitor
> +
> +maintainers:
> +  - Bhaskara Budiredla <bbudiredla@marvell.com>
> +
> +description: |
> +  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
> +  shared on-chip last level cache (LLC). The tad pmu measures the
> +  performance of last-level cache. Each tad pmu supports up to eight
> +  counters.
> +
> +  The DT setup comprises of number of tad blocks, the sizes of pmu
> +  regions, tad blocks and overall base address of the HW.
> +
> +properties:
> +  compatible:
> +    const: marvell,cn10k-tad-pmu
> +

> +  tad-cnt:
> +    maxItems: 1
> +
> +  tad-page-size:
> +    maxItems: 1
> +
> +  tad-pmu-page-size:
> +    maxItems: 1

These all need vendor prefix, a type, description, and any constraints.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - tad-cnt
> +  - tad-page-size
> +  - tad-pmu-page-size
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    tad {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        tad_pmu@80000000 {

pmu@...

> +            compatible = "marvell,cn10k-tad-pmu";
> +            tad-cnt = <1>;
> +            tad-page-size = <0x1000>;
> +            tad-pmu-page-size = <0x1000>;
> +            reg = <0x87e2 0x80000000 0x0 0x1000>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> 

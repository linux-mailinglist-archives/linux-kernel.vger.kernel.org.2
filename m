Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D833C8B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhGNT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:27:42 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:38804 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGNT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:27:41 -0400
Received: by mail-il1-f182.google.com with SMTP id e2so2712739ilu.5;
        Wed, 14 Jul 2021 12:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMCl4enjhuB3fuRr8/IBxvkVXV7SxWxUKUby5uTH5Xc=;
        b=uJUp4I6eiT6J1qnjXsluToirt02QL3Rt2sL2oLylLdpbBTPS8pVSvwDx4yKbl/7fD1
         t7mOGQW2TOGP8C7/bwuY/tcK5dX+ZfhVSB/26OwnHo3tMS+trnBnbmg6+pHwGRMQZRey
         zbmrU9ztWnVB2QWgHxQkufpIw27HpfmqU7NnQ+LAWOM0KQMBUEY9zpOMFTIDbzJuemdE
         uLeRax561kYBkiTsVsILNxI3txlIEHLP11zFvR9vFW6g1BF7ZG4gdHYU/Ir8b2Tarrkk
         2l49eH53HBthwIOThJPSYVDrJFkwnpo7Ucc/3OOQLm15uDT/7AdrryDk2FWJNCmvoZQ4
         qfMw==
X-Gm-Message-State: AOAM531vLQWutqlpuTSysgNVQlUm6lY4J3ErnO49E1bm3Su8v3PVOIM1
        /AAP2/Q5sNfftNqoYyPXvg==
X-Google-Smtp-Source: ABdhPJxx/lWHdgSnhYaFflo1SOn/Jir7KsTvgQNUtgzciyIUUp9cSdIFeuhiCCHNZzE033cBZRE0EQ==
X-Received: by 2002:a05:6e02:12a4:: with SMTP id f4mr7753336ilr.102.1626290689492;
        Wed, 14 Jul 2021 12:24:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r1sm1281833ilt.37.2021.07.14.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:24:48 -0700 (PDT)
Received: (nullmailer pid 3065460 invoked by uid 1000);
        Wed, 14 Jul 2021 19:24:47 -0000
Date:   Wed, 14 Jul 2021 13:24:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: clock: Add DT bindings for SMU of
 Toshiba Visconti TMPV770x SoC
Message-ID: <20210714192447.GA3059664@robh.at.kernel.org>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-4-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624034337.282386-4-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:43:36PM +0900, Nobuhiro Iwamatsu wrote:
> Add device tree bindings for SMU (System Management Unit) controller of
> Toshiba Visconti TMPV770x SoC series.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../clock/toshiba,tmpv770x-pismu.yaml         | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> new file mode 100644
> index 000000000000..18fdf4f2831b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pismu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 TMPV770x SMU controller Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description:
> +  Toshia Visconti5 SMU (System Management Unit) which supports the clock
> +  and resets on TMPV770x.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tmpv7708-pismu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1

Is there a connection to the PLLs? What are the clock inputs?

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pismu: pismu@24200000 {

clock-controller@...

> +            compatible = "toshiba,tmpv7708-pismu";
> +            reg = <0 0x24200000 0 0x2140>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +        };
> +    };
> +...
> -- 
> 2.32.0
> 
> 

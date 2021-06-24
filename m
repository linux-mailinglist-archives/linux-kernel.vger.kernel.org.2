Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC33B36C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhFXTXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:23:36 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:33291 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:23:35 -0400
Received: by mail-il1-f175.google.com with SMTP id z1so7509999ils.0;
        Thu, 24 Jun 2021 12:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58wH1F55laM3Siizt+/xkUTgmVNr4NpcGQlAWE+BiOc=;
        b=SZ6ShpsiHh+JWGv0jToZKI70tXvegmuPHbIZblxpeQ4TeedJiNZvlraHI/H1zCXg+M
         cnGeI7iRjUZQxx18AgMSRB8DPPMWF9ViPYX6rK4hXUoSK75/3ZXnUKyGtKCl5vXebA3U
         16g+SGED6YxY/XMBTWWT0Uj2FlgeKkCO6UWAWxzB3IrdSMN+yGw7xpNn2bUZ+Vlbacse
         o9bAsUu4JX0TDceU3mp+G2XMGLoFyLSVJVOUBoUpdqvW29LwqeFWOoODXTBfRnCoIYl7
         8odAUvIw7dvy1U7eVumcP8B4+CI11KRgdMc3DgCDy4uboEEF7fu6DfftRDTTNj38+nhM
         1nCA==
X-Gm-Message-State: AOAM5319NECul1i8rtSV2dcR6PSoW2nj6YmljO3LBtFvFNi+tUSXVTJ/
        C4TriCqOLed/JO8FSQRgPQ==
X-Google-Smtp-Source: ABdhPJzXPVo9MVv4SXGFiOsFIlOQNNq0I1CtjwMhlHsZP2/+RncCDBIp9W2bP478YeEBOcsbSAPU3g==
X-Received: by 2002:a92:d6d2:: with SMTP id z18mr2147763ilp.159.1624562474916;
        Thu, 24 Jun 2021 12:21:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l11sm2300833ilo.77.2021.06.24.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:21:14 -0700 (PDT)
Received: (nullmailer pid 1839767 invoked by uid 1000);
        Thu, 24 Jun 2021 19:21:10 -0000
Date:   Thu, 24 Jun 2021 13:21:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: power: convert
 rockchip-io-domain.txt to YAML
Message-ID: <20210624192110.GA1822193@robh.at.kernel.org>
References: <20210611143821.13057-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611143821.13057-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:38:19PM +0200, Johan Jonker wrote:
> Current dts files with 'io-domains' nodes are manually verified.
> In order to automate this process rockchip-io-domain.txt has to be
> converted to YAML.
> 
> Changed:
>   Add supply properties for:
>     rockchip,rk3328-io-voltage-domain
>     rockchip,rv1108-io-voltage-domain
>     rockchip,rv1108-pmu-io-voltage-domain
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Due to the lack of a rv1108 TRM changes
> to grf.yaml or rv1108.dtsi not verified.
> 
> ---
> 
> Note for rob+dt:
> 
> The driver is located in:
> drivers/soc/rockchip/io-domain.c
> 
> The document is located in:
> Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
> 
> Is that still OK or should we move to:
> /Documentation/devicetree/bindings/soc/rockchip/rockchip-io-domain.yaml

I think the current location is fine. Vendor directories cause other 
vendors to not look in them.

> 
> ===
> 
> This document is not able to correctly check for bogus properties.
> Adding more [additionalProperties: false] to [then:] gives warnings like this:
> ('status', 'compatible', '$nodename' were unexpected)
> Is there a way to do that in one document?

Drop the *-supply and use 'unevaluatedProperties: false' at the top 
level. 'unevaluatedProperties' can see into if/then schema. That doesn't 
do anything yet as unevaluatedProperties support isn't implemented yet 
(but there's finally some work taking place, so soon).

Otherwise, pretty much looks fine to me. Some of the grf.yaml changes 
should perhaps be a separate commit.

> ---
>  .../bindings/power/rockchip-io-domain.txt          | 135 ---------
>  .../bindings/power/rockchip-io-domain.yaml         | 307 +++++++++++++++++++++
>  .../devicetree/bindings/soc/rockchip/grf.yaml      |  18 +-
>  3 files changed, 319 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

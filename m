Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCD3DABF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhG2TlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:41:04 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36556 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhG2TlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:41:02 -0400
Received: by mail-io1-f51.google.com with SMTP id f11so8579551ioj.3;
        Thu, 29 Jul 2021 12:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kztw78/jXg2hf/CyMNwWfX/ncqxALp6u1e6vETqnLdU=;
        b=FA7L6gsR4eJIQj4FXw/8M9SZUE9uwjwEH92ZsJdaxoZwkCkUCP5n3lWIDbqnC9ca6D
         bBhvcMjbNjhJNbRtZeuF1UePFZcXprxabKhZpg4LjFEx5zY3Z9UbH7UWJMKRw7eodrg2
         35+22bVDwdX0LBwVtkvykIo2UE2nc6owFzLijI6xh6OZThEKj4q7JgXHTUXCoYDMdpMm
         wxmU/X4znIQifYnbE7JahoMinhLv+GSavSMpPqBdADk73/ZsC9Q2pOjqDY+srLFjMiyO
         +u51h0lTC9L2IqmbIhEP8X09NCDWkq2ik2pIigkBcmBvfhJn7s71xasjHXoKfUVXDx37
         6JUg==
X-Gm-Message-State: AOAM532JSHYkIyHLoMH/5NvHdADMe4lkwhkxGP2DIsKjAZFMR9kMOexq
        Fe6tMkM4FKG39EX2jIX+NA==
X-Google-Smtp-Source: ABdhPJzIVRf+gAVMUl64m8dXWBCq0G9wCa0iC978OPczf390Etby7wsLD+SajNyYhLSrUn4gJBYKjA==
X-Received: by 2002:a5e:961a:: with SMTP id a26mr5363089ioq.90.1627587657959;
        Thu, 29 Jul 2021 12:40:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f16sm2397616ilc.53.2021.07.29.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:40:57 -0700 (PDT)
Received: (nullmailer pid 754683 invoked by uid 1000);
        Thu, 29 Jul 2021 19:40:55 -0000
Date:   Thu, 29 Jul 2021 13:40:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     kenchappa.demakkanavar@intel.com
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dinguyen@kernel.org, furong.zhou@intel.com,
        kris.pan@linux.intel.com, kris.pan@intel.com,
        mgross@linux.intel.com, mark.gross@intel.com
Subject: Re: [PATCH V2 2/3] dt-bindings: arm: Add Thunder Bay bindings
Message-ID: <YQMER155dEYk3ets@robh.at.kernel.org>
References: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
 <1626758569-27176-3-git-send-email-kenchappa.demakkanavar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626758569-27176-3-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:52:48AM +0530, kenchappa.demakkanavar@intel.com wrote:
> From: "Pan, Kris" <kris.pan@intel.com>

Kris Pan <kris.pan@intel.com>

> 
> Document Intel Movidius SoC code-named Thunder Bay, along with the
> Thunder Bay Full and Prime configuration board.
> 
> Add maintainers for the new Intel Movidius SoC code-named Thunder Bay.
> 
> Signed-off-by: Pan, Kris <kris.pan@intel.com>
> Signed-off-by: Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>

"First name last name" here too.

> ---
>  .../devicetree/bindings/arm/intel,thunderbay.yaml   | 21 +++++++++++++++++++++
>  MAINTAINERS                                         |  5 +++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> new file mode 100644
> index 0000000..2b9d5f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/intel,thunderbay.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thunder Bay platform device tree bindings
> +
> +maintainers:
> +  - Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>

ditto

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - intel,thunderbay
> +      - const: intel,thunderbay

Not valid to have duplicate strings.

Like everyone else, you need $nodename schema here to define this is 
for the root node.

> +
> +additionalProperties: true
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 503fd21..041f9a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1992,6 +1992,11 @@ S:	Maintained
>  F:	arch/arm/mach-pxa/stargate2.c
>  F:	drivers/pcmcia/pxa2xx_stargate2.c
>  
> +ARM/INTEL THUNDERBAY ARCHITECTURE
> +M:	Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> +
>  ARM/INTEL XSC3 (MANZANO) ARM CORE
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.7.4
> 
> 

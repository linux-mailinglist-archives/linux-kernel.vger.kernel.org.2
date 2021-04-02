Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1549352EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhDBSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhDBSEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C47861103;
        Fri,  2 Apr 2021 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617386654;
        bh=kFNql03iRJYWFFqCOpmJeMMhSwVZGro/bynT35/QM7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhfIqSv9ITyDPO8D/gVwv1tf48FBxjioByYJt+Ln6wAreHnm8sNKJ73WUwvKShrhM
         Drl4OfahXF53Dhe+fsRyJSUJceNSw+Id9vMmmQ8nTyxLpye3bJISmcEfoORt3MyL6G
         QJPiKZDBajUT1N7UwNzKz9tNE4kIVwol0zHrJrdSrnEnLdfUzIrbaQjw+pbcos7XOO
         4dKe4oQje+7TkDwAFzULs5h5Cw7g3Xje+SYnxcMeS5ip3Oh8wEEwrU8pFf6pVe8I2W
         lbX3/1yiFUJmqPUyi6dLVksyJnytuTi13SbJkvugJrCy7nKzeJ6WWmt2UEKpFCdCk0
         q63exufmS2fMw==
Date:   Fri, 2 Apr 2021 23:34:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210402180407.GA31906@thinkpad>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:48:17PM +0300, Cristian Ciocaltea wrote:
> Add devicetree binding for the Actions Semi Owl socinfo driver.
> 

Devicetree binding shouldn't be added for a driver instead for an IP or hw.

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  .../bindings/soc/actions/owl-socinfo.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> new file mode 100644
> index 000000000000..01e4a8b4f5ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoC info module
> +
> +maintainers:
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  Actions Semi Owl SoC info module provides access to various information
> +  about the S500, S700 and S900 SoC variants, such as serial number or id.
> +

S700/S900 are not yet confirmed, so please avoid them.

> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - actions,s500-soc
> +          - actions,s700-soc
> +          - actions,s900-soc
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - actions,s500-soc
> +          - actions,s700-soc
> +          - actions,s900-soc
> +      - const: simple-bus
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +        compatible = "roseapplepi,roseapplepi", "actions,s500";
> +        model = "Roseapple Pi";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        soc {
> +            compatible = "actions,s500-soc", "simple-bus";

No. This shouldn't fall under /soc. I think you should added a separate
compatible for the reserved memory itself and add a corresponding socinfo
driver under drivers/soc.

This way it is obvious that the information is contained in a memory region and
a driver is used for parsing that.

Thanks,
Mani

> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +        };
> +    };
> +
> +...
> -- 
> 2.31.1
> 

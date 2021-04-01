Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6419351847
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhDARoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhDARiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:12 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0DC031175;
        Thu,  1 Apr 2021 10:07:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n8so2431650oie.10;
        Thu, 01 Apr 2021 10:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIoD1sqZzx73JWXZ5LfoSVqAfKupbAVCJdJdm3CE5F8=;
        b=dJ8OYQgakJVDr9rEMy2nBzQGcu7W7o0aHrEKClaSTia2FK4/4NqM+0AsrAeW+z201x
         eyROb9x/m0CB5YoL/B+MT6FHvPu/PN0aX0JU6CHjohKqLzXZosVkAT3lmxCtNtjcFZC7
         pitoDmSgBpZXmwvH/Mw0sviccvqLGVqaIwnLx9pKgXBgx8Wm4qAiciNlHyvCoLWzcrib
         d1jriWFNVuJV/9mikUfkWnq0/TZAU8r3j8MqqVEyIYBCDJKMf04dt20xUQsby0baCGkj
         8k98rRePjZtafldHkgvgj0cnwYT3m667MkRJ6BWG6tS3l2ylFQEEywzNEYSyDVssG+xj
         SfMw==
X-Gm-Message-State: AOAM5333Cpua+ucVT6YZNe6FkxHyVUvNJrWo034oA4MvR+zeFVIHboZH
        Wo3xqELurWD6ct6XjXkIoQ==
X-Google-Smtp-Source: ABdhPJw2tthmlm9qoNnSw4eeN8+rkSiRKaShVkLC0HF+AgZyqkVjnFYUU+osAFeTS6t5LGKOREzh5g==
X-Received: by 2002:aca:b645:: with SMTP id g66mr6539604oif.64.1617296826773;
        Thu, 01 Apr 2021 10:07:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u2sm1147627oic.28.2021.04.01.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:07:05 -0700 (PDT)
Received: (nullmailer pid 619798 invoked by uid 1000);
        Thu, 01 Apr 2021 17:07:04 -0000
Date:   Thu, 1 Apr 2021 12:07:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reserved-memory: Add Owl SoC serial
 number binding
Message-ID: <20210401170704.GA610119@robh.at.kernel.org>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:48:16PM +0300, Cristian Ciocaltea wrote:
> Add devicetree binding for the Actions Semi Owl SoC serial number
> reserved-memory range.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  .../actions,owl-soc-serial.yaml               | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> new file mode 100644
> index 000000000000..41b71f47ee6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/actions,owl-soc-serial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl reserved-memory for SoC serial number
> +
> +maintainers:
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  Provide access to the memory region where the two parts of the Actions
> +  Semi Owl SoC serial number (low & high) can be read from. This information
> +  is provided by the bootloader, hence expose it under /reserved-memory node.
> +
> +  Please refer to reserved-memory.txt in this directory for common binding
> +  part and usage.
> +
> +  This is currently supported only on the S500 SoC variant.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: actions,owl-soc-serial
> +      - items:
> +          - enum:
> +              - actions,s500-soc-serial
> +          - const: actions,owl-soc-serial
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        soc_serial: soc-serial@800 {
> +            compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
> +            reg = <0x800 0x8>;

You end up wasting a whole page of memory for 8 bytes. It may be better 
to copy this to a DT property ('serial-number' is already a defined root 
property).

Rob

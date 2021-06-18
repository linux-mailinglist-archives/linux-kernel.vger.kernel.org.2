Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9553AD409
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhFRVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:01:21 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:45712 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhFRVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:01:17 -0400
Received: by mail-oo1-f46.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso2762839ooc.12;
        Fri, 18 Jun 2021 13:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76JjBaFOs8XeFwkQumYYTotqdSD0iY3Jk+mamDats6I=;
        b=rg13wRoUgYKz5LN59qj3n3r4SjVTpcURRE/NHv6kiWmnbU1e15vEaRS4t0+IxDZmM8
         kHuTQKfQLIvlYvtroWP/06RzQ7uBwOCOGDbu25ASBP0nuPhyvBAvoIUIIDE9U9vgf6lV
         65AkepJJD6b0Fx2uwXvvfuDhAmOyhu++BgZAlgGZpnWvBRn4p9wPk+u3/ylKnAU/ttaN
         YQtYpfZFjX0xFgIucwt86Nm4YFtq8f2+a4rE2AdzkP1GrmdaUKvZ6sUAtiU7iCvUUIjq
         LDr+RGxymlVC5boEW09DRxaM2SEDOcLFeTz+YTeugcpiLvQ3nm4ddSNddpM5HHYdDKS8
         MJlg==
X-Gm-Message-State: AOAM532CKmKrVDEB7ybmlLEAhvB0v9I0JJ75DMXcl70D2fwTubGerD4K
        GXX5gk3O4fGbRBTF3SRlOQ==
X-Google-Smtp-Source: ABdhPJxmfLlxz/llujMeCumfwFlO/KWNpPGO3bKJiCmtsy3H5QBM6cSNvDTiLtPitEUOHWIBQttHyg==
X-Received: by 2002:a05:6820:315:: with SMTP id l21mr10619914ooe.32.1624049947423;
        Fri, 18 Jun 2021 13:59:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 79sm2274193otc.34.2021.06.18.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:59:06 -0700 (PDT)
Received: (nullmailer pid 2863981 invoked by uid 1000);
        Fri, 18 Jun 2021 20:59:02 -0000
Date:   Fri, 18 Jun 2021 14:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 2/3] dt-bindings: nvmem: document
 nvmem-cells-parser-name property
Message-ID: <20210618205902.GA2852098@robh.at.kernel.org>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-3-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608190327.22071-3-vadym.kochan@plvision.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:03:26PM +0300, Vadym Kochan wrote:
> Describe new "nvmem-cells-parser-name" which is used to bind registered
> parser with nvmem device.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2b6e92..36c6361d0605 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -39,6 +39,11 @@ properties:
>        when it's driven low (logical '0') to allow writing.
>      maxItems: 1
>  
> +  nvmem-cells-parser-name:
> +    description:
> +      Name of the registered parser to parse and register the cells.
> +    maxItems: 1

I think this should be a 'compatible' string. We already have something 
along that line with:

Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

Rob

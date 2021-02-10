Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3031712A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhBJUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:19:55 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39880 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhBJUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:19:24 -0500
Received: by mail-ot1-f53.google.com with SMTP id d7so3051145otq.6;
        Wed, 10 Feb 2021 12:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h41qDLzBBrR16Efq3/F/iDABghaBilvwRHFXLq+Yn9s=;
        b=JBMf/CAF+jB+FbeZV/dHBI7FG18mo3CpAbifK2g79FMj14IQjpRubkvfd3D6Ck6pX1
         PXFwjpPVX8vdUcyV3QEpJdap1B2F9Nw7H+qJP2p1KGTsX5Rn7jMagBaf56R+LovMWZ9s
         0FW+BgIpPlwaUKDbuBCfXV8XsCz5ohqhcYK+d0pVnsp9saWm9zhyDyWqJeKWDn8jV0mB
         zjd2hebQa8mKqZQOPCeVU9QxN2F4aeAWJulbcip0HQYFHMNyAWnLXZB40xSGdugryMQm
         VGAQJE1nZRBOcOTZqODD9VMr+ByF8e8fI9Clmra34/qmMRWyglvHo16znM/jAAS9AxNd
         ykpw==
X-Gm-Message-State: AOAM532p1+n3biv264tYtl9LNeZDuBOxTMNBjqm4VtWRqhKvK2UQfau5
        0Vf5FSAZnA0OGO3emev58w==
X-Google-Smtp-Source: ABdhPJyz5kpX+mNnEdlZwoQGZYpWUggvB3mg6nhCt6reKhCwU9w/y3ionZv0xhHlbmBIxN4oG7++Zg==
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr3532802otr.78.1612988322998;
        Wed, 10 Feb 2021 12:18:42 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q7sm682448oif.1.2021.02.10.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:18:42 -0800 (PST)
Received: (nullmailer pid 2689654 invoked by uid 1000);
        Wed, 10 Feb 2021 20:18:41 -0000
Date:   Wed, 10 Feb 2021 14:18:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: clk: versaclock5: Add optional load
 capacitance property
Message-ID: <20210210201841.GA2688439@robh.at.kernel.org>
References: <20210207185140.3653350-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207185140.3653350-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 12:51:38PM -0600, Adam Ford wrote:
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Since XTAL1 and XTAL2 will set to the same value,
> update the binding to support a single property called
> xtal-load-femtofarads.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  No Change
> V2:  No Change
> 
> A couple people suggested that I not use the $ref, but without it,
> the bindings check failed with errors.
> 
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> index 2ac1131fd922..c268debe5b8d 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -59,6 +59,12 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  idt,xtal-load-femtofarads:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type with standard unit suffix.

> +    minimum: 9000
> +    maximum: 22760
> +    description: Optional load capacitor for XTAL1 and XTAL2
> +
>  patternProperties:
>    "^OUT[1-4]$":
>      type: object
> -- 
> 2.25.1
> 

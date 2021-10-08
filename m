Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5F426C56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhJHOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJHOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:07:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DCC061570;
        Fri,  8 Oct 2021 07:05:37 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g15-20020a9d128f000000b0054e3d55dd81so6687229otg.12;
        Fri, 08 Oct 2021 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8cmniGBVN2PezeljEbDSbJUvW2F5mbVKylcUXP/x7w=;
        b=iG7tVZn2+bYvwKFyxomcWVADB9zRlDQjYaGD9UzpSpCMqCuK7+wYzy+dEiOQDtV0a8
         1RrVilgcTat4Z911VWl3O0tJRfpWvF7xHwmuwhHZoqWJncqnTfjDskC3wtKSObeZ3PYA
         Y8/DgSEyQHyWcp74LeqPnvSUv+bN69j3G+odLM8vPmg5KdDu3uTnICWgqDdaGnV2ECxI
         RRdHymYHs5XTs4ptFhfVMdmgm1YGkSuLRM055x/dL3+YNqsoHltvnsagrBh1Gb2b3a5T
         6lyGpG2fcbOa/v8psniFp1+DTRl7Jb8hPUf0/9BopdPI3y7vD/NCQoGO/qThsK/orpOu
         83sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+8cmniGBVN2PezeljEbDSbJUvW2F5mbVKylcUXP/x7w=;
        b=cpjzUjejxoyk1B4/eWcSjxiHxg4pNScXgjLgReFs9p6f9MK6zkLfBiI8xrur+H9xQ/
         nmk9bA0Kf9i4DwFCLjOyxrlv7gXOyxPH5k9JFFDCpAAFX0vJ/t6PvggQkgxLNBSgr6BH
         F9Kp91cjTlLFUuE2VkkOrsEcRvIMWTLWKO1z5RQtydQ09SkPlp5GmPPlLlqSQnvSgBZQ
         /K37H/YOOTGkJCuT6bDI7WEyts294Diw43NStyc1NmqQp4Ti6tDDld2jNBrShM/SVm+S
         7/i9VSDEhNy5WYHZ7pS906Df2WvrltZPxioADJAY8F6Msq1156eyASyxCLSHV9jvJ0h5
         ErlQ==
X-Gm-Message-State: AOAM532nha+C6eyoaf74uoKI+JhaovJbiKqDVyQpztQLpAkQlBGfL9M1
        eEKUOeRPQSx+JvbqZqm3VFQ=
X-Google-Smtp-Source: ABdhPJyc4aEce/oZYp2+1eG/MuQb/NZigkdhWbVH6kMKwDM9WHMi7k6KDBmo7i0NLZvSMAyLDp9SfA==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr8631537otk.348.1633701936488;
        Fri, 08 Oct 2021 07:05:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z83sm642787oiz.41.2021.10.08.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:05:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:05:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] dt-bindings: hwmon/pmbus: Add ti,lm25066
 power-management IC
Message-ID: <20211008140534.GA1806215@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-9-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-9-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:42AM -0700, Zev Weiss wrote:
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/pmbus/ti,lm25066.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
> new file mode 100644
> index 000000000000..da8292bc32f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm25066.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: National Semiconductor/Texas Instruments LM250x6/LM506x power-management ICs
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +description: |
> +  The LM25066 family of power-management ICs (a.k.a. hot-swap
> +  controllers or eFuses in various contexts) are PMBus devices that
> +  offer temperature, current, voltage, and power monitoring.
> +
> +  Datasheet: https://www.ti.com/lit/ds/symlink/lm25066.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lm25056
> +      - ti,lm25066
> +      - ti,lm5064
> +      - ti,lm5066
> +      - ti,lm5066i
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt (sense) resistor value in micro-Ohms
> +    default: 1000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@40 {
> +            compatible = "ti,lm25066";
> +            reg = <0x40>;
> +            shunt-resistor-micro-ohms = <675>;
> +        };
> +    };

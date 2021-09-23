Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6123F41672B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbhIWVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:12:53 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39532 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbhIWVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:12:52 -0400
Received: by mail-ot1-f45.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so10400055ota.6;
        Thu, 23 Sep 2021 14:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kk2pWIp+ZoWPPzM2mCzEpeKek3uLHU+wVdCODnRG/3s=;
        b=rk12b3FgMfSeHGqAXYWSdqKP4Vtshpr/S0SWN0suYsjEKxUxQvSXsFWamUk/nskPk1
         gG67BMtbPixHWyQzxUwnPR9jbNPDCMMRvXY6FHSHXlaQfP6Kg9pZNKK0WZrwg1tQpCjR
         PWHUYx8FWW7+mbJBrlRsVvdBz6rVobjmJd2zynjp0VyhD7IkJrguQTjXbuf29Z73w/E0
         f9qHmUh5RGcGWj5vJ0EwyFBg+uvBftTL2hEbLdZ8QTLm1dig9Po6G+hQS4El84CQmXfS
         wnOxdhgY3J/oLYUGCf210fHrJn5XU2xPmXL6qDi/X2G7Jf5QFWyxnRFIK8E4hJvmWdiw
         d4pQ==
X-Gm-Message-State: AOAM530P0GruAJ1MP/zecnM86vL1ygBkCasulYOh8blXRSwKK5UaU36Y
        LzzUywiEYL7RblUmPIIJcfTpGHTMyg==
X-Google-Smtp-Source: ABdhPJwEk6UYHxJutkDB2d7g5wDFFS5qCPolOoSlY4R6tgoeX1XA06QFRPtyZHZMo83BaeFgO3LF/A==
X-Received: by 2002:a9d:1902:: with SMTP id j2mr736469ota.34.1632431480130;
        Thu, 23 Sep 2021 14:11:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm1333988otg.69.2021.09.23.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:11:19 -0700 (PDT)
Received: (nullmailer pid 3530309 invoked by uid 1000);
        Thu, 23 Sep 2021 21:11:18 -0000
Date:   Thu, 23 Sep 2021 16:11:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: lm90: do not require VCC
 supply
Message-ID: <YUztdj3R95c1E1ZY@robh.at.kernel.org>
References: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
 <20210920181913.338772-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181913.338772-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:19:13 +0200, Krzysztof Kozlowski wrote:
> The LM90-like sensors usually need VCC supply, however this can be
> hard-wired to the board main supply (like in SiFive HiFive Unmatched
> RISC-V board).  Original bindings made VCC supply as required but in
> practice several other boards skipped it.  Make it optional.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/hwmon/national,lm90.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

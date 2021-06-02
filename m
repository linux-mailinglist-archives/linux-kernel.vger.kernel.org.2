Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79448398893
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFBLud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFBLud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:50:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2CC061574;
        Wed,  2 Jun 2021 04:48:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h9so2359784oih.4;
        Wed, 02 Jun 2021 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mdeITsS7rFsL0KmD3LwvfOupZFEKnebrPYRqWSo8EYY=;
        b=TkuVlpqpW7YxoKhDCJa2weJkHDN0c+Dl73LgAfx+KS7+TTH+dloFnmBjdhVRCLe7ag
         V5pq9kEs35ilkHxFpS5mRgXG+gRSl/Rh9KGTgno9UZPhus8CoiT+d0ZLI6JUmaqMdc9x
         2WVA6H8B39JI1S9c6cAssyekCfNNmtF+Z706hblR5BFtRH96yh6QiJC0FkwTH6suMmBe
         /ObLDmv1k5ChS1iUTTjXSIrDPQqcuYKd3ohIaBtXdslug0K2V7Arn8YS17U4NuzBd4VF
         ysfw4cXnrtqGgLCGbmhU1ZG60wMSfa5zA4ukRRJtmWdF89Q933Id/hVEfk9p1TUGEa3V
         PDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mdeITsS7rFsL0KmD3LwvfOupZFEKnebrPYRqWSo8EYY=;
        b=WptNaxT+j8TtPeVGVxnKFFO4jdQ7K8goz7hhVdzcx/bycbfM8GM0fzZ44V9mWpuCqX
         FstzxHAnT99QyCG7Jj4rrCswZgT/TWm4y9sepHdAW3cPxF17PK/vJPpneub1PwCy0hqe
         We2HB0AV7FURZAtrb6TVt2uBdShm7jam/vHw2r16tfkNjFeoEoZoemQPiIj7fJIOuzq7
         55AMxRd/y6u8xLFE4jT+kJP3pOQNbE9E5IutoI2H8dMm/1sURVRBKZiqg3j5w0aYwpx2
         rkxjLV0Hf27D2RGL+FCD7VmsytOmuw77UgKFoXeepygW4LKy8P9Ezc2jtBC/RwuRY2Jd
         cllw==
X-Gm-Message-State: AOAM531NzIeApoCcr1VO/qQ1l6nwPk6tqEm9pOQtUpkbcm68muyrvd9x
        G9BqFEfPof1eaIFUsZwkE93cPwmAjOw=
X-Google-Smtp-Source: ABdhPJxHG2Vxf5qW8qsT/Bc8VZ+tpAnZcZzTKhjKrFHkKKNY/BuPC1Z5gDHyxVCHCBDlasAeSnc9Jw==
X-Received: by 2002:a54:4d03:: with SMTP id v3mr20215973oix.22.1622634528689;
        Wed, 02 Jun 2021 04:48:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k14sm1833341ooi.21.2021.06.02.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:48:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 04:48:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Fix typo in TI ADS7828 bindings
Message-ID: <20210602114846.GA2900211@roeck-us.net>
References: <20210531134655.720462-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531134655.720462-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:46:55PM +0900, Nobuhiro Iwamatsu wrote:
> Fix typo in example for DT binding, changed from 'comatible'
> to 'compatible'.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> index 33ee575bb09da1..926be9a29044b2 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> @@ -49,7 +49,7 @@ examples:
>          #size-cells = <0>;
>  
>          adc@48 {
> -            comatible = "ti,ads7828";
> +            compatible = "ti,ads7828";
>              reg = <0x48>;
>              vref-supply = <&vref>;
>              ti,differential-input;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D314169CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhIXCGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbhIXCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:06:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28219C061574;
        Thu, 23 Sep 2021 19:05:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so11171608otq.7;
        Thu, 23 Sep 2021 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3nWufSPgRiPeZY0QCnGO26qPGXji5ABtNdRDlOiJGHU=;
        b=UTMRcLaICXNGafgVxacVYnASZpkPLEYvemZLwiXVrOhVQXDnGmFmU3YFQUP991HUNw
         /r9Gn8YnfYuPkKwH2p39FUVHj/MamnEjQqURPHRiUyRDSGNKKPV9Je/awpeZmB4Ebzz3
         hLgVFMwRBUB4KNHcO0GLGEcMxJ3fNIKA21EzTqbF17mP0Kk4tNVFtDjK5FqtepJEaqt5
         Rdggb3g5y+SavMdT7AMKUjzCaQWlWPvx2Ne+m0IGrtO2N9DQLZ1SOvhdpeUTwYuo0sd/
         gyMjagGDIkqUw+PFvYRCvTMoa96d4vN0eDtmtPmopN7VlbAjNi+nEBvCqjS8vmiAhsga
         8lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3nWufSPgRiPeZY0QCnGO26qPGXji5ABtNdRDlOiJGHU=;
        b=3W3NGAv4i0FsMKcFNs69P3Njuvgo+tzsgFcp/7v7zdUcwF9DhoeRZkeEZbrQud23EI
         6EoROlWMdMpDYpokJBVkGz747fQstSgwMRcOopKfkaERA8qSRhvclpBKF9yRmmeVul2a
         U+1fJFNU2h9+s2JaoWeCFCv7mRwskmbytl8kDAu5WiqdFH3ZATkBEBC7JEbIQ+Ybawez
         SsRooZ/BZjYmRitiX/xUiGspuBYJc7iBN/lw45hs+8LBhJ2jxmXOCxog90EmPTip+nG+
         lTPRHI6TIreG42XLWjjA0b7KCbH+ZxWq/ZRb3dlBY0BM+HrLnBkVkaw+rxqCNhFK48dI
         yS0Q==
X-Gm-Message-State: AOAM531NeLWnc8gy2/jzdTrAuJ0mFF6lXcHZGwHU3eyYFofPiXrmj03K
        JJ9DA3G7oKMg+0ve2RE7Vyw=
X-Google-Smtp-Source: ABdhPJwsb1301gpFowJEo+IQOfiPwL3Ge/YHLI2klXyJBjYgrDqVkFxgSAMpEI9AHigHe3tc0AMFkQ==
X-Received: by 2002:a05:6830:2a10:: with SMTP id y16mr1686405otu.37.1632449103511;
        Thu, 23 Sep 2021 19:05:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm1745541otj.10.2021.09.23.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:05:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:05:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: hwmon: lm75: remove gmt,g751 from
 trivial devices
Message-ID: <20210924020501.GA3031808@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:10PM +0200, Krzysztof Kozlowski wrote:
> gmt,g751 is covered by LM75 sensor bindings.  This fixes warning:
> 
>   arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml: temperature-sensor@48:
>     '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 183ee0da22c6..1bbfa98a85d8 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -109,8 +109,6 @@ properties:
>            - mps,mp2888
>              # Monolithic Power Systems Inc. multi-phase controller mp2975
>            - mps,mp2975
> -            # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> -          - gmt,g751
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38064 Voltage Regulator

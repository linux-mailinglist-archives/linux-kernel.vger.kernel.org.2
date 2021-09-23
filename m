Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5F41673E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbhIWVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:14:53 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35332 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbhIWVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:14:50 -0400
Received: by mail-oi1-f178.google.com with SMTP id r26so11624942oij.2;
        Thu, 23 Sep 2021 14:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbpMRFpmtwPDLFU9JB/X9U4azoAkdhznsPamt5AwcYA=;
        b=v0dzp+GrFHhBCcZlM1RmPWizmWCKTiK9E8U27By7yx/r3JYaNtV5TVkinUxWbYKAXW
         Fk9Hunvf9CWt6n7DiUL8L4D08hQzLI+/+ArUsAdVGppogOvTuMD+kW1keEoT1Mi1K5En
         yhPhppncsltxEBVw45Cg9kvLAFm2ULg4aOUOrcpZgjRu19kcdFfj0RQ0qKZWIaRXTPS9
         hdBB5iMLSHOc8NGhP/PXE0KvQoQl/FVZTtPwZCnsrtrOuaB8stFMCn18ckzi22dTzS/v
         tTo40fIr5mtM6SMsOjVxtCPXBiV2QS96HZCrmlpNQsGHpHh7nYXifrBM4jkxfsXGc1w3
         DMnQ==
X-Gm-Message-State: AOAM532RK5VyH49H8O6p8qGFMPztW9UjC+0C0ZAN45lh4IZUWGBz5WQ5
        R+nzTBEEfm4IXpO01ei/Rg==
X-Google-Smtp-Source: ABdhPJyhHQJ+HOGau4BGUwcwlAOeDYv++JzbU5rqa66qc9VA6X+ZwzE70m34o8PcbFZqkJKvTY8FKg==
X-Received: by 2002:a05:6808:46:: with SMTP id v6mr5311339oic.72.1632431598504;
        Thu, 23 Sep 2021 14:13:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v16sm1608524oiv.23.2021.09.23.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:13:17 -0700 (PDT)
Received: (nullmailer pid 3533551 invoked by uid 1000);
        Thu, 23 Sep 2021 21:13:17 -0000
Date:   Thu, 23 Sep 2021 16:13:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: hwmon: lm75: remove gmt,g751 from
 trivial devices
Message-ID: <YUzt7QwbMWN9zDZ8@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:21:10 +0200, Krzysztof Kozlowski wrote:
> gmt,g751 is covered by LM75 sensor bindings.  This fixes warning:
> 
>   arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml: temperature-sensor@48:
>     '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

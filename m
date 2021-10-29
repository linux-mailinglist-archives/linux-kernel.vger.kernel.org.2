Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2143F44D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJ2BOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhJ2BOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:14:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C47C061570;
        Thu, 28 Oct 2021 18:12:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h20so7739940qko.13;
        Thu, 28 Oct 2021 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2GWSE2vqiNhDefNWS8cNhWdDf/xglYO5/nICF4WS494=;
        b=Bg6CFFvpWJJ2Qn+kDej49ZN+zzOGyMADxuDlLBDDFyCB2cYzvRi2QZpKrzbL5FvzAU
         disQmgu93BP85V7aulyVQJwA9D+7UbtFMKSZaKlV470v+X6IKH+f+DBTXA0LO3a1fVmV
         6CrWfgleVmRoecJpIneAhSJvbRfoOZk0wf3HhbEwF8QEO536y/Br7h2kiTcEYuocHVM0
         siRQlmxXQsEJsFFZcSfXeMkACMbQQt9g1mN9TqdJAl7wFGpTckrr/DyC8PyIg0mO1lB7
         YXx+oqgetD+LwtPc3Vuu9JcoWMVr6AGIGOyqzvWowT0ghvacMFTQPi4ls1A2szuUOkAZ
         koRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GWSE2vqiNhDefNWS8cNhWdDf/xglYO5/nICF4WS494=;
        b=gYOiAIDOGn5hw+/b1VGZw2X5/hvubM1wC0XFeF/MT7eSBMbbXmBMVznOPU48ApBP1v
         gfn8D4kMHwXqznF4PvAz+BDXyHVY2RCRkjAlA/2qm9uJQl3OT9FpHmMZydJWZ1V3COkS
         QDRlF7Cud4GhGWFkbbNjW9d0WpSrmpXXRFsIMRe4/2+gsVMBDc7PCFYFwYkJT72jFa+g
         t32SnzPeFgjH7dAW0SxrQDv9jONir0k2vOD3mP+LqbpUAYyh6THzCWBbx4hcracwSEo/
         x/eKasVI/7VFYq4kZGT+M9MoAAAteZ6Utg3W4CsLWna7SoiO9rNA2IY1i2sowjQM9nUH
         ln1g==
X-Gm-Message-State: AOAM533NCXFIsTScJWs25y0etaoIzCW2YhkuF0aCFW8tXGTTQC6JsEOM
        OSUbwu6KZBTFuOTI9iXQmHRhtmo5x9k=
X-Google-Smtp-Source: ABdhPJxvYORR2ePZUZ0lo1s7OC52uZAwCIqDzU4KVkK98OtQPJnXovcH4HQUyXhBs1D/M/vYSQQyrQ==
X-Received: by 2002:a05:620a:254e:: with SMTP id s14mr6641217qko.364.1635469933599;
        Thu, 28 Oct 2021 18:12:13 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g19sm3394426qtg.78.2021.10.28.18.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 18:12:13 -0700 (PDT)
Subject: Re: [PATCH v2] of/unittest: Disable new dtc
 node_name_vs_property_name and interrupt_map warnings
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20211028130423.4025578-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ab53d658-aeec-7606-3089-3b1e8b299138@gmail.com>
Date:   Thu, 28 Oct 2021 20:12:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028130423.4025578-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/28/21 8:04 AM, Rob Herring wrote:
> The unittest dtbs have various intentional errors which cause warnings.
> With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
> some new checks: node_name_vs_property_name and interrupt_map warnings.
> These warnings are also generated for static_base_1.dtb, so add
> DTC_FLAGS for it.
> 
> Note that the interrupt_map warnings only appear once interrupt_provider
> warning is re-enabled globally.
> 
> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
> 
> Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/unittest-data/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index a5d2d9254b2c..fbded24c608c 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
>  DTC_FLAGS_testcases += -@
>  
>  # suppress warnings about intentional errors
> -DTC_FLAGS_testcases += -Wno-interrupts_property
> +DTC_FLAGS_testcases += -Wno-interrupts_property \
> +	-Wno-node_name_vs_property_name \
> +	-Wno-interrupt_map
>  
>  # Apply overlays statically with fdtoverlay.  This is a build time test that
>  # the overlays can be applied successfully by fdtoverlay.  This does not
> @@ -82,6 +84,10 @@ apply_static_overlay_1 := overlay_0.dtbo \
>  
>  apply_static_overlay_2 := overlay.dtbo
>  
> +DTC_FLAGS_static_base_1 += -Wno-interrupts_property \
> +	-Wno-node_name_vs_property_name \
> +	-Wno-interrupt_map
> +
>  static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
>  static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
>  
> 

Thanks for splitting the DTC_FLAGS into per file values.

I dug into the unittest code that uses the dts node that causes the
interrupt map warning and do not see any reason not to fix the dts
so that the warning will not occur, instead of masking it with
the DTC_FLAGS.  I just now submitted a patch to fix the .dtsi at

  https://lore.kernel.org/all/20211029005802.2047081-1-frowand.list@gmail.com/

-Frank

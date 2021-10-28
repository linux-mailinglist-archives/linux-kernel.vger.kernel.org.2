Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A743D7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhJ1AHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:07:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD329C061570;
        Wed, 27 Oct 2021 17:05:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bl14so4213883qkb.4;
        Wed, 27 Oct 2021 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y7UgbqXfGQTuON1FkJoN0C/+54lWp+M8elVKbKesD3M=;
        b=mDUVHXpmYXoJx2ddZx0CcEzr7PtL0a4mtrORL49PwZvrhMfNn17Waa6QiLxSRdQqRg
         A4qe/S8522kYsPO96exItLrlx7c8ISvhRAFHwaxxDDqzoPQRE+iLjft5LXJR237kAKJc
         zEmI60Pw8P6M62zSE13WodJ4M6zCkt9mYNZSFIB7ILvtf77wdpFBmaQBuaZ73as3WobN
         B8ePcf7jkZ9K460tku4btgfQUBYzYgGnuTW2aY2Pm04YgbWds6ROE3zz4SNokis0hhSv
         vVtnQVjBh4Mh3Gs7MruCVaMvqPOf8wX2xaN5HtVQUE7VQj+FLN32+kwedKwRWH9YW28H
         I/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7UgbqXfGQTuON1FkJoN0C/+54lWp+M8elVKbKesD3M=;
        b=rff3gHiDMK/9mGqs4G6XLfU3r/h/0A7d16jX1gVa8I7KFA0DkzhmVGKrydntI9NK6N
         9QwzugeOqQdStLL+MR7FdDys71EmRui3FdlEeEprSbVRwCXtjlgpUG4lmGPHLfQUJoLp
         0B5jV4FjXT2R1UDXwsdTkXu5EqV++2VmSbCHaDcdGHTrqdOKhcX8P5mCRHPjyYVEPqA3
         trkipJfl5YVrZnxtB855Gb1IfMBLICXIjxi8ByuFHpl5c2SqHJ8Vw/jILQ8gzBAZcG1N
         9OQ+XsLMpyx5mohNDf3yzLE4Y1B+LsaJJa/i9njlddPVzke0c5tGly9vETOoraX17Uge
         w+Og==
X-Gm-Message-State: AOAM532on+Dmyv1aGnO+0Ilng3wmzhsHWnrSkNO7vhy05wfbCdKyItdZ
        PXU3DDm0xndDzgebt2iYPmM=
X-Google-Smtp-Source: ABdhPJz+kqsvLz9OGU2ngkb3rqJBAqSk0PQi48I7IPt5PhD/pQpK59BP3rZsMDJM89pAFLpOv7Cnfw==
X-Received: by 2002:a05:620a:c42:: with SMTP id u2mr833004qki.115.1635379523848;
        Wed, 27 Oct 2021 17:05:23 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id v17sm963463qkl.123.2021.10.27.17.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 17:05:23 -0700 (PDT)
Subject: Re: [PATCH] of/unittest: Disable new dtc node_name_vs_property_name
 and interrupt_map warnings
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20211026225527.3460520-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <361311a6-5818-6fc8-56d9-1a0ab8eaa74b@gmail.com>
Date:   Wed, 27 Oct 2021 19:05:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026225527.3460520-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 5:55 PM, Rob Herring wrote:
> The unittest dtbs have various intentional errors which cause warnings.
> With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
> some new checks: node_name_vs_property_name and interrupt_map warnings.
> 
> These warnings are also generated for static_base_1.dtb, so let's just
> disable the problematic warnings for all unittest dtbs instead of just
> testcases.dtb.
> 
> Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/unittest-data/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index a5d2d9254b2c..7e1a25ad4e5c 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
>  DTC_FLAGS_testcases += -@
>  
>  # suppress warnings about intentional errors
> -DTC_FLAGS_testcases += -Wno-interrupts_property
> +DTC_FLAGS += -Wno-interrupts_property \
> +	-Wno-node_name_vs_property_name \
> +	-Wno-interrupt_map
>  
>  # Apply overlays statically with fdtoverlay.  This is a build time test that
>  # the overlays can be applied successfully by fdtoverlay.  This does not
> 

Before applying this commit, I am not seeing the warning that -Wno-interrupt_map
suppresses.  I've tried with (1) CONFIG_OF_DYNAMIC and (2) with both
CONFIG_OF_DYNAMIC and CONFIG_OF_OVERLAY, and I don't see the warning.

Where are you seeing the interrupt_map warning?

I would prefer not changing from DTC_FLAGS_testcases to DTC_FLAGS because
the suppresses the warning for all unittest .dts files, not just the two
that lead to the node_name_vs_property_name warning. These two cases can
be covered with DTC_FLAGS_testcases and DTC_FLAGS_static_test_1.

-Frank

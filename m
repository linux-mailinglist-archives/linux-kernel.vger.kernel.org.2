Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6977934DF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhC3DYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhC3DX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:23:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88487C061765
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:23:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i3so15127795oik.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJ+II/5N1Hvyz6uuWXUQ+m2jul22u5rdFG3d3xmYGQ8=;
        b=XZ+lX/K9m/+z8BBmBTImdTLIfNIzicQmjr8dApFMHb34CaUpGb+6UaShh/SsxI8NMV
         wy7NjhxmVtzhIFO1S7zFnavjcN9SOIa0DrRY75lCrqO8QKOI37fA6M8pwsbOeoRryyPX
         cfbNpSAaErtz6Hw1KJzd5RsjFHW56cnetudVdLeQXyrFKQ+gsoCZhdjHhllX8QjhFJyJ
         ToJMwGn1k0R1CI4TfQepIQYuIyloIZR7td0va/lJMndsgJ+w88BePemr6NbL02O/lgBw
         YjdvQ2+ZtdOgRxY8wInf4vVEMvqqJ7j7dfJnqcShb/ECNnOlHzzocuhE588fspEYpuFr
         h4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJ+II/5N1Hvyz6uuWXUQ+m2jul22u5rdFG3d3xmYGQ8=;
        b=Ih9NFWa3jn7tCtNKdzGKON3T8hicZ8lL0ui2OzxRD6udDvHeFKwwH5Pns91MWBMr+0
         IuwPSZt9zpnuwzXhTFqL9ji9NgkCuVKfofYVVhAOxI02uIHKTqCfmAy/i+ZAnm8miRT3
         nsAxAYsN7/R4GSKyRF4svP8l0LHnfE0rzirrFgSW8g/FaW2W1oxn3c8ImbV4NR+jU1MC
         0FZmWNEwEOpSm0ZWPapZQCkD1NgW8xEEEinAPS3Iwd5OZOMfBAqAaIPe6uS0b/cE3K+y
         Z+KPg/WhiNDONzJuG2LrJzAVt+2xHNVxus54koBdb+Jhbsdw9q75PNGPsstayNIF0yqO
         9U9w==
X-Gm-Message-State: AOAM532IV4ulT82fTVAYWnqt9ZqEizFyzdaPvNw/3cuTH9ieqGdHc7VM
        ts2CQm1S38yBeRr3MNWmf8XNHQ==
X-Google-Smtp-Source: ABdhPJxSeYNl2vFSLyTptFO+41Pe1NYsTjHnY8kt49eeWG8rQvjgKMnfTIdXVMS4Fynhf0gv023U8g==
X-Received: by 2002:aca:db85:: with SMTP id s127mr1639701oig.142.1617074635948;
        Mon, 29 Mar 2021 20:23:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w2sm4196653oov.23.2021.03.29.20.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 20:23:55 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:23:53 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: msm8996: Mark the GPU's SMMU as an
 adreno one.
Message-ID: <YGKZybLYu5xQW9Yn@builder.lan>
References: <20210326231303.3071950-1-eric@anholt.net>
 <20210326231303.3071950-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326231303.3071950-2-eric@anholt.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Mar 18:13 CDT 2021, Eric Anholt wrote:

> This enables the adreno-specific SMMU path that sets HUPCF so
> (user-managed) page faults don't wedge the GPU.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Will, can you pick this together with the driver patch? (So that they
land in order)

Regards,
Bjorn

> ---
> 
> We've been seeing a flaky test per day or so in Mesa CI where the
> kernel gets wedged after an iommu fault turns into CP errors.  With
> this patch, the CI isn't throwing the string of CP errors on the
> faults in any of the ~10 jobs I've run so far.
> 
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 6de136e3add9..432b87ec9c5e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1127,7 +1127,7 @@ cci_i2c1: i2c-bus@1 {
>  		};
>  
>  		adreno_smmu: iommu@b40000 {
> -			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,msm8996-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>  			reg = <0x00b40000 0x10000>;
>  
>  			#global-interrupts = <1>;
> -- 
> 2.31.0
> 

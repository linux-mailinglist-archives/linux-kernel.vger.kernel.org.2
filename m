Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879153A8D50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhFPAUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFPAUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:20:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F5CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:18:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c13so507440oib.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63XBS3tQ7Co8IrZoouPuxpj9SbqIb0rD307q2lD5BGg=;
        b=gVPQH6wQp1cuwJ/lRGAtVaQ+BAeUMRmFyYReDDWEfgxSC0srG325MbdXV04ySQBk38
         gRdoDGeGv10GUUz3aMmmzbXqiqAvu57R8tE0nTMfuGYIhxf4PE55M9Nl2rEG+KqWa6Nv
         hpQmKxQ4JRhGIZGCXAkxN1JQ40RqYK8O+Y0DLyd+sG/DBH6UqMUxQxvyGaDHLdh+AnvS
         uBmM4MFxTXqUnAXOq8CNLlvXvjXHj6QMU1/SuYAhc+1CFPrc/C1kyfQLX6XRykiD2C7k
         qSz8v1/BBCVWDixkT423SABosi0cYlF+m16SQdXWAVTZBFUq5pk5ga2Zazde5SwSnYmQ
         jN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63XBS3tQ7Co8IrZoouPuxpj9SbqIb0rD307q2lD5BGg=;
        b=RhNtrkxDdANv4Hma6/h5ufHPRI9vGMpnCj4PodCXS8gY5qktQkVG+fdxuKPJPAmYOs
         Iu40cjaXCVnE03GAmA/tPc/+RuO+j6H3i86V467bX9KZ8L6zh/FTJBICmuCi2zOZTbgx
         pJJcJaBoLzpfXlNdDWTeDpb81dHppLFnUNXFtE6JkX44MiHehpMy2A2W8hIdZowYf4V2
         uUyEuAuak1xXkPOdSOr7wBH+JbP+9lRvSGGBEmGbJXYcqHJVrwkpyYURk7lP/27sBGHV
         RUgvElwdASnKGVSx9aH47r6kP5fp/iTbcadt8dnhMo+86sPUgs+nDgWi2QJeF3X3dAGB
         DDhA==
X-Gm-Message-State: AOAM530E9R2w2S64Gfm93icl4DiAU1lxh9KIBd+FxY3nzBgf5KA51PLR
        c8wu69jlss91TD9Q/nZ+ksRNeQ==
X-Google-Smtp-Source: ABdhPJxWsCBp9R9M15ML/sKHyAcMtDeD0qkcLzckEWxSibHmiMatarC6OjHS0ENeOJV7IRUxL1x5Fg==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr1141281oic.123.1623802706929;
        Tue, 15 Jun 2021 17:18:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm112195ooh.39.2021.06.15.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 17:18:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 19:18:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350-mtp: Use mdt files for
 firmware
Message-ID: <YMlDUNVdSHK50UMO@builder.lan>
References: <20210615081124.3209637-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615081124.3209637-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Jun 03:11 CDT 2021, Vinod Koul wrote:

> As discussed in [1], we should keep one of the file formats for firmware
> and not change.
> 
> So to simplify we chose to use mdt for firmware file. This would enable
> folks to work with upstream linux-firmware as well as downstream
> firmwares.
> 
> So switch it for SM8350 which is a new platform, so switch can be done
> safely.
> 
> [1]: http://lore.kernel.org/r/CALAqxLXn6wFBAxRkThxWg5RvTuFEX80kHPt8BVja1CpAB-qzGA@mail.gmail.com
> 

As mentioned elsewhere, we used to run exclusively with mdt + bNN files
- as that's what we typically get with Android - and I kept receiving
reports about people missing individual bNN files, or managing to
upgrade some but not all of the files etc. Some of these errors tells
you which file you're missing, others just tells you that the hashes
didn't match whatever was loaded.

As such, the move to .mbn files has saved us quite a bit of head ache.


That said, the code doesn't care about the suffix per say, it starts
loading the firmware and detects if it's a combined file or not. So you
can simply copy or symlink the .mdt to match the given .mbn path.

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Changes in v2:
>  - Add more details about the switch in changelog
> 
>  arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> index 93740444dd1e..d859305f1f75 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> @@ -40,7 +40,7 @@ vph_pwr: vph-pwr-regulator {
>  
>  &adsp {
>  	status = "okay";
> -	firmware-name = "qcom/sm8350/adsp.mbn";
> +	irmware-name = "qcom/sm8350/adsp.mdt";

And you're already doing something "non-standard" if your MTP has
adsp.mdt in this path :)

Regards,
Bjorn

>  };
>  
>  &apps_rsc {
> @@ -278,12 +278,12 @@ vreg_l13c_3p0: ldo13 {
>  
>  &cdsp {
>  	status = "okay";
> -	firmware-name = "qcom/sm8350/cdsp.mbn";
> +	firmware-name = "qcom/sm8350/cdsp.mdt";
>  };
>  
>  &mpss {
>  	status = "okay";
> -	firmware-name = "qcom/sm8350/modem.mbn";
> +	firmware-name = "qcom/sm8350/modem.mdt";
>  };
>  
>  &qupv3_id_1 {
> @@ -292,7 +292,7 @@ &qupv3_id_1 {
>  
>  &slpi {
>  	status = "okay";
> -	firmware-name = "qcom/sm8350/slpi.mbn";
> +	firmware-name = "qcom/sm8350/slpi.mdt";
>  };
>  
>  &tlmm {
> -- 
> 2.31.1
> 

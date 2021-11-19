Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4C4568BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhKSDtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhKSDtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:49:14 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C1C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:46:13 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so14735669otm.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QDGlhur1LDp0iQ8sP29bfWWG+u0wWLEJ+COS9QVuvVE=;
        b=thIfDa7PhWhV/3oolCrulY9cXjvaOE6S2AhUYeqhI66+jVv5x1bVZHRU945I+1lGis
         EyslYZGHQcnUfPPRo5aVhUAS+lyWt1++6X0LKD4foRZkPeiKE5H2n6ReIcH+9F8qm5mE
         yscn1CImaGeNrEDy8slxCENMvFtuss4PwAvZFXVMhEo0GZqsERFKfNUEpdT/HCpm1W70
         bHwUlU+wvvNF66vtPgM0ThKR7dhXQAw7jcd3OSAZT+sWhGjldFy7nTLAKK5Q9FXPq7oq
         sQb33Js4aMRXpn7sN2dPEyoWlx1lqVcVsKRvpKdCLN3JhHfPQP68nTmq+K/iGVVn36ji
         Mgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QDGlhur1LDp0iQ8sP29bfWWG+u0wWLEJ+COS9QVuvVE=;
        b=7EFKpEt+H8PG23NIIlj133bbyPQqHtzlzzOzyGvkjYcWpNDO3Z2fo/HftlQ8M69+TZ
         akdJj5j8a+Pgcb2Dlpq1Yay0vAQBm2rDvAULId13/dkoaj90UPwuVBztDsywWKOPVlUl
         3tT1Oga9WsLJgJZCj6BTz8rf5RUETmgSMUeSHIfr6SoUiV6eM5tRsMs+N3UnIwkBIkiB
         q+nAkAu4vGI4Xo2Lz2cAbCp+g8lttRfrefIIwwuX+VfHTJXBODvT5A8azWXNgMgckUAc
         CNu54sq338UOrw91xOivPQ/0ffwxOQ5XgbeHk/7d4Et0R3aewtLBn2GFbYdkz+8dVzg/
         /k2Q==
X-Gm-Message-State: AOAM533DBe2oIiNq/PsoDdLptbOwPkp/EqJ951ldYB6KJ2VkJ8SYau7h
        Xk7iI3McqP6GlMCm+r3JQLEnQQ==
X-Google-Smtp-Source: ABdhPJzOq6kDagn/oW90r+TR0sRyaFL2ocMMx6o4Tc7KUvUsSpFDASk+Hxv7TSkWayCsKUwwK+KPqg==
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr1973300otq.337.1637293571470;
        Thu, 18 Nov 2021 19:46:11 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b22sm432549oib.41.2021.11.18.19.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:46:11 -0800 (PST)
Date:   Thu, 18 Nov 2021 21:46:06 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Katherine Perez <kaperez@linux.microsoft.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH 2/2] arm64: dts: sm8350: fix tlmm base address
Message-ID: <YZcd/lFm8HgQ8SLs@builder.lan>
References: <20211116235045.3748572-1-kaperez@linux.microsoft.com>
 <20211116235045.3748572-3-kaperez@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116235045.3748572-3-kaperez@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Nov 17:50 CST 2021, Katherine Perez wrote:

> TLMM controller base address is incorrect and will hang on some platforms.
> Fix by giving the correct address.
> 
> Signed-off-by: Katherine Perez <kaperez@linux.microsoft.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index d134280e2939..624d294612d8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -960,9 +960,9 @@ spmi_bus: spmi@c440000 {
>  			#interrupt-cells = <4>;
>  		};
>  
> -		tlmm: pinctrl@f100000 {
> +		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sm8350-tlmm";
> -			reg = <0 0x0f100000 0 0x300000>;
> +			reg = <0 0x0f000000 0 0x300000>;

There's a group of register blocks related to TLMM starting at
0x0f000000 and then there's the register block that is relevant to the
OS that starts at 0x0f100000.

Downstream uses the group, while upstream describes only the hardware
block that's relevant to the OS. Unfortunately it seems that the shift
was missed for the UFS and SDC pins as the driver was upstreamed.

So I recently submitted this patch, which I expect would help you:
https://lore.kernel.org/all/20211104170835.1993686-1-bjorn.andersson@linaro.org/

Please let me know if that's not sufficient, or if I'm missed something
in my analysis.

Regards,
Bjorn

>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -- 
> 2.31.1
> 

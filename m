Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA593D0878
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhGUFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhGUFEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:04:24 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67AC061768
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:44:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y66so1729856oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OZ+eKXyM6tJgPfiMyzHLbhC2Gq2GeuohG8n3p1aQmww=;
        b=a3ltlIFw3PDaPGWCtUL30D2NpHapO5Ew/TlfmUCEZKmzpGNEwGkbUPHe6vnMTnS3T3
         SRzQtCjriEnnevgAxqb6+5turJkmn7YkBhK9zRjTD10ejpbCW4Giv3aLNrQHV/3PwCQv
         cjwUI5lGJC+bixz1gLOaXL3vtrin4B8En2Xq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OZ+eKXyM6tJgPfiMyzHLbhC2Gq2GeuohG8n3p1aQmww=;
        b=EEczo05bm8lUvbbKkKajLAIp6oTTdvCzqCOrVGRId3NVf8/msD9XWUzEhwcP4dyyMT
         RlG4kv1t5K6z+OUFxbtAUUD/fSm/2sLXhUqpX34so7XGM9rRGTDEX54Ko3R+fN2xO1bZ
         RFbyJ/B4n8Qj06uWo5KHw0aMoRXeRBZjnauT3Tou+OLOKGjUZQB0a+72swbGVHi0ja3l
         3w7m+ernEMRDuh+4j1Jb5k+sDctTmTsifv30MkT8rZ0gDRt+FJv4pjcnT33nRc9E17HE
         8x3bvRSpxr6DOnSnJXYpaRNgFo7mlErylEkNMEAIIMAo+5stn1dr2FABWMzbVsx4Jn7k
         H+pA==
X-Gm-Message-State: AOAM5332YXxDoQ7y7mNBZvbVBfcV30akWZ8auB7iYgff0w0eFLeR2T+7
        F2P6oa67RWs92NWhmVq8PLpNqEK8WAYLrldSmO5Yag==
X-Google-Smtp-Source: ABdhPJyGZbF5q862hBiaxTRq3Av5De0RIunb58CNjCEgt4NMQAmb8EQUvqsGkvMKuQY34ShS7h5O9N404r3ozTEhOl8=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr4804173oiu.19.1626846298050;
 Tue, 20 Jul 2021 22:44:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 05:44:57 +0000
MIME-Version: 1.0
In-Reply-To: <1626775980-28637-9-git-send-email-sibis@codeaurora.org>
References: <1626775980-28637-1-git-send-email-sibis@codeaurora.org> <1626775980-28637-9-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 05:44:57 +0000
Message-ID: <CAE-0n50HwmuYWnqs9TYJYEoB=-BV8Bbz+AMUUy5t9dtN1jSsjA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: sc7280: Add nodes to boot modem
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org,
        saiprakash.ranjan@codeaurora.org, will@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-20 03:12:58)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 5ed7a511bfc9..3fb6a6ef39f8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1219,6 +1224,21 @@
>                         };
>                 };
>
> +               imem@146aa000 {

is sram a more appropriate node name here? Is imem a generic node name
in DT spec?

> +                       compatible = "syscon", "simple-mfd";
> +                       reg = <0 0x146aa000 0 0x2000>;
> +
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0 0x0 0 0x146aa000 0 0x2000>;
> +
> +                       pil-reloc@94c {
> +                               compatible = "qcom,pil-reloc-info";
> +                               reg = <0 0x94c 0 0xc8>;
> +                       };
> +               };
> +

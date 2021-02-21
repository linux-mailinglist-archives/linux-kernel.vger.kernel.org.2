Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07042320CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBUSmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBUSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 10:39:35 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id g1so45844463ljj.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NhYOZbgBpd4mjAxZCaWZK1LAzWuXyFM8/hnnTWXx6so=;
        b=WcE3YfpuwsaIbUWi+3p8vcZMWVlvLG227eL4urxfnk+0rSx5+Mrftg1MiOpgzYY/xO
         yVNA92s1myyzTf5DE/UetWToGByOlpbmWjxyEuF2L9h6NiTO0po/EZRBtENCYvamLDok
         shZJZoPIrYBX8fRG4N9dxLVhj4/ULftnMzFP3QAHLxDcn2tzhAHKD1DnhBF1UJdPfaZy
         KAkA2Q9PdwApPyLYr6z2SZuVi5sRumkkfdX/5Xfezt6MfbBEIYwoYfxfXML0amY0zh4G
         c35VmcX/LZjtdCEP8f+Pq0caFbfBlEqG0rb1AYlGk8AR/uqOkTsavlkWJ7fAUN2YJZt1
         yYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NhYOZbgBpd4mjAxZCaWZK1LAzWuXyFM8/hnnTWXx6so=;
        b=CE7WqXxVT0sdis6zferCrcOyaFxdvu2jP12KLGYs6NmkqEH31MNyc/hRh6qZjgxC+v
         hHbEdyemKRUcRGnuTiAfB2FTW7J1RHNLosriODkq3T7yDuQ06wbQmWNy67G/3ERneCfl
         OxjRXhqiraMaSNud0SfouWe+k2bLuE4iweoBEL90l9V/t+BESZsMkvW8qguuZjrZ99fo
         /FThI6qEVFqcSBgjstV99Eb5lAwqgWp6/HvN3XWlURJZK6LE7JiQque97gUhZ6hX0XGm
         Sv0uIcfVaWG4W+ez6A/2qqLCCigGIDpkoBW2TpJzBWaN4awhZHg3G25LVXt1Z/QDE6f+
         swpQ==
X-Gm-Message-State: AOAM531QRFGjnJkMxBEqMTnNG9Lg4pReOy3rr0rIG9HkqViDPjdSv9qW
        e9KTO5BvGUtIQ8yv6mLbh8B82A==
X-Google-Smtp-Source: ABdhPJyuvHfzWnYWyJihn2ndFwj/qnblDirw0I0KTUo8pRXKmboqktGnHYLVV42qAQ9YNDaJlfxDEA==
X-Received: by 2002:ac2:5f6c:: with SMTP id c12mr9185267lfc.316.1613932773820;
        Sun, 21 Feb 2021 10:39:33 -0800 (PST)
Received: from [192.168.118.216] ([85.249.43.69])
        by smtp.gmail.com with ESMTPSA id y17sm971708lfh.221.2021.02.21.10.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 10:39:33 -0800 (PST)
Subject: Re: [PATCH v5 21/22] arm64: dts: sdm845-db845c: Configure regulators
 for camss node
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, todor.too@gmail.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20210217112122.424236-1-robert.foss@linaro.org>
 <20210217112122.424236-22-robert.foss@linaro.org>
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
Message-ID: <b033d21a-72bb-6965-2d62-6e7d67113f06@linaro.org>
Date:   Sun, 21 Feb 2021 21:39:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217112122.424236-22-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thank you for your patch!

Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>

Thanks,
Andrey

On 17.02.2021 14:21, Robert Foss wrote:
> Add regulator to camss device tree node.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index a943b3f353ce..5842ab65789c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1106,6 +1106,10 @@ &cci {
>   	status = "okay";
>   };
>   
> +&camss {
> +	vdda-supply = <&vreg_l1a_0p875>;
> +};
> +
>   &cci_i2c0 {
>   	camera@10 {
>   		compatible = "ovti,ov8856";
> 

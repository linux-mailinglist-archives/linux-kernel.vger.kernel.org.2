Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53D426BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbhJHNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJHNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:32:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:30:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so29877544wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eWnofJKTw3p+IAgBaEr8PkiopgGt7liFG5ipUcC8kn0=;
        b=XCP8wRM6WC6kWj4jqeiaBCPCZSYH6Y5FZpO45POxcDTWC6P0OQ3mnNDnxwDmwDGeEk
         qGKo5+NoJBzO6LZZhguLhDRWmr2N9J3pb1LvGC8IafUaNZsYhB4HCvZXedPni4KxuduP
         vz1DtCN4xeSjS72cO5w1dNp5NBc3WporCMrUjYqOP/x/4p1fTH6q7CHJ6sx95To914FQ
         koeINiwhOTAIAh6GfqJN21qeMUdXODvz+FRNW4mgBpwni3ATu5K/0Sbai430GgVhSY94
         YfQG0wqsmgsf4dZnDxec2KSNp8tkabS6NFaX3lf0nYyct4OuCJsH5/oZBFkUygxJP3se
         1E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eWnofJKTw3p+IAgBaEr8PkiopgGt7liFG5ipUcC8kn0=;
        b=Phhu9dxcToKF27BnAGorOjyY/jQK/dhEm5q6UbSsMYfqilADWxmXXBkFlI14gcUnBn
         rQOoIHKWYf7+/7RLvCK4yooTqvMhe4VUDpb8jv6lBHyuIEljEgZlE8H4FaM6MgTbwR0p
         7Dx7377Q33JGFGP2iq/VeokzyEWH0/PzwxAVc1e7Apbm28jjy4f3iCMcb07eFaKDTVjY
         akEYUiEXjOglmfj/NzivOX3Bgsn35OGk8Zm+d/9TPLIoI05WQS8Wuuz3YktFUdxNrqWt
         JiHy11Ak9DGdMKC3x7ab+bRdonLKxjBIZ5PxgunYz0LztDczDgPdP2TYVlPajY1Bdmpx
         LVeA==
X-Gm-Message-State: AOAM5314EQA06RX4ozvGTaiM6fwWBcxrUwBcYJgOb1yYrdyMGQ8ByHxI
        lUdxZxHThIDOh1yQVt5tm6MkOM5d0dmzkw==
X-Google-Smtp-Source: ABdhPJzIjKNZ1rSMhSEcxRkODlks31QNmegAmTud3n4Eu4NCeT3rFGTI37iSKmKut3kHkHoDEmtfvQ==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr4231026wrc.82.1633699814521;
        Fri, 08 Oct 2021 06:30:14 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:a3ab:352d:6c22:15bc? ([2001:861:44c0:66c0:a3ab:352d:6c22:15bc])
        by smtp.gmail.com with ESMTPSA id 143sm12479484wma.37.2021.10.08.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 06:30:14 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-sm1-odroid: add cec nodes
To:     Dmitry Shmidt <dimitrysh@google.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007180130.805401-1-dimitrysh@google.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <34f1111e-a5f0-b04e-f8cf-f015d729d236@baylibre.com>
Date:   Fri, 8 Oct 2021 15:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007180130.805401-1-dimitrysh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/10/2021 20:01, Dmitry Shmidt wrote:
> Enable CEC in same way it is done for other meson odroid devices
> 
> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index fd0ad85c165b..7eed4849233d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -225,6 +225,20 @@ &arb {
>  	status = "okay";
>  };
>  
> +&cec_AO {
> +	pinctrl-0 = <&cec_ao_a_h_pins>;
> +	pinctrl-names = "default";
> +	status = "disabled";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&cecb_AO {
> +	pinctrl-0 = <&cec_ao_b_h_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
>  &clkc_audio {
>  	status = "okay";
>  };
> 

Thanks,

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil

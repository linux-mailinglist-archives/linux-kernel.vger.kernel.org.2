Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6043A0E77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhFIIHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbhFIIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:06:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2CC061574;
        Wed,  9 Jun 2021 01:04:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y7so19752812wrh.7;
        Wed, 09 Jun 2021 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wT8jMSk2fM+J5ZgJXdeEUVeym5jcaNbFNA2ciIih7RE=;
        b=A27j6cFCvfhUIj11imB2Akrk6OKq23vnyfFbaKwRxt7bQbCFXu3ONVex1OxuB48nS1
         WAAxkXD+5Rib7zFJUcb6aPan0ger24D7KZj64lfeEUyq2kCGw+PGBmDiudUT89zvsMon
         cQRNGqmRstXpQ3ZCP1UjljPNYjJmTmEBhhNpoE4wWp2plVWvaZYDs2ZIfcHh4G9r6kyp
         rg2IgjrtjTOAs2Zkak59Y7JkHrnsE1jPgeOb9loXi1DPoAmhpwV0Ew4+ytUi2GWJX8hQ
         CemkpkRArAcmfh1tZV4Jz+P6GmCDX8chxD3BWasEbZSlQDXurmfnk51EUheGnbo18VwX
         meFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wT8jMSk2fM+J5ZgJXdeEUVeym5jcaNbFNA2ciIih7RE=;
        b=mUNRcecFOYNaFW7qMaR77Rio+r20QPpQ/fBegdNxZN/gYGI4YouKElIghVPo4tR1nY
         RyDqy66PRTXozLbPkMKx6BeaPJCPmfG+hSW0N+tGYugE0WtjDTyDkdwZw3Rz9JPswChS
         No5cwJh4O5Dl1ErgLRSBTZgjfR33JivdZ821jpxi48s5OIBi6IXqHsgJJiWRsdYtTIH9
         YMQhfxFlv1JT2swqbbcpAZbh6LckddzXhfEu+ByQAhPizRHn4gK7J9EDF6miVrcZiCYd
         BsCQFGkqYwrvhXAd1Oa+OSA4MeLXrLAh2exiGsRRJ/cdFv1WydHFnEimj4u6GgsRVV2o
         NbNg==
X-Gm-Message-State: AOAM532zFn/RsTvyvcVY1cfka9Kx3Yh9jgMipBRH1bRVMf7tRWI9GC6G
        l6auWalwntosYJD8wgQ8aXNzwRAFVnU=
X-Google-Smtp-Source: ABdhPJxcdlRhjCnbcVbYr9xZ88zmOBBIJbICZY/xUibynL/tQ9TAgojkqsgCpCOSigZQ9JvuSnMpQQ==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr26967217wry.267.1623225873633;
        Wed, 09 Jun 2021 01:04:33 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id o3sm16695687wrc.0.2021.06.09.01.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:04:33 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8183: add cbas node under cros_ec
To:     Ikjoon Jang <ikjn@chromium.org>, linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20210609032554.2443675-1-ikjn@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6fa5d766-83ab-737a-f081-e21d989c14dd@gmail.com>
Date:   Wed, 9 Jun 2021 10:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609032554.2443675-1-ikjn@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 05:25, Ikjoon Jang wrote:
> Add a 'cbas' device node for supporting tablet mode switch in
> kukui devices.
> 
> Kukui platforms with detacheable base have an additional input
> device under cros-ec, which reports SW_TABLET_MODE regarding
> its base state (e.g. base flipped or detached).
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied to v5.13-next/dts64

Thanks!

> 
> ---
> Resend this as a spin-off, other patches for dt-binding and
> hid driver were applied.
> 
> Link: https://lore.kernel.org/r/20210514122051.266169-1-ikjn@chromium.org/
> Link: https://lore.kernel.org/r/20210415032958.740233-1-ikjn@chromium.org/
> 
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcfa3370..1512605a438e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
>  			compatible = "google,extcon-usbc-cros-ec";
>  			google,usb-port-id = <0>;
>  		};
> +
> +		cbas {
> +			compatible = "google,cros-cbas";
> +		};
>  	};
>  };
>  
> 

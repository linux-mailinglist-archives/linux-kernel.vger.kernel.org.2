Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E245D34EC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhC3PYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhC3PXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:23:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:23:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so10547682wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Amo0CjIod/3nZW+Fivc6j6ZuIk/uID3Z1EgHGr+VW0I=;
        b=Dj3+PMH8gySOY8WCvX+EJGbMwFjwagH9iYfuJJKBPiLzVyqgxt4MJlgqtA+uUPmJ2S
         xTRZ8Q7TWQSNoZlLrDwJIdbnXjCHMh5ABR53hZcUezXBQmISi47zkVM3rva4qPk5MRQ3
         u6oFKtpxKwiqCZteVdl+TVkAc3Z96Fd8y2ksZufva0jTbM/+UlWSGh90UugnW2H8iy9r
         CjcJPkbC/7AWvS13svxK+VmD27U6yazigtWby0MKWv4xrO7GwyJmNYTJztpMUyqHGw+k
         mejMFzM2a17b0a0wQULPY6MleVmyqYqHy4iz1WsrD97qqXDGWHPfj1f0T7e9HtuA4hWW
         Vmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Amo0CjIod/3nZW+Fivc6j6ZuIk/uID3Z1EgHGr+VW0I=;
        b=NUFskXGZjd7ttxIN/Cqlpdyd/sE16NwyUBOfonraQKpILvx6xJ/RmdRwsFqdaKA7vz
         yytT1m0r2hFftKwBx9/91VPzllZ0h+wuXAKMsZC7UTgzpVoZ2/vV4jCQm2Hi2D/52eDT
         4LVUmu8ogw4+l4ozfnVTgtSV0seWWlNz/9fx2q946YSs6nAajGr/56uKs98kX7u0DKY8
         SF0TOREqtdrhHz8jr2vULyPb3MiLnAFRwfmVitZF1bmddbu1pN2Ah1eAcDlpnHsOC0Zv
         U7EHQDDdCE4rRjCA0Zl6uKJgYmPQ+Rd+C+aWkAl6MypoOfeTk6kLDwv/YThBWW0r/2nX
         TVlQ==
X-Gm-Message-State: AOAM533BWxtfCNkRRBdVsff9nCCWAsmaA1JZOuI3UhzeCD3v5WcEr3co
        gjhhQI4MTo1BTbdUZdLS4qjAXg==
X-Google-Smtp-Source: ABdhPJyHyjk1MlCCVtUroZ6z6Nq6EKCHEfiXpJZjOlXKBCwLGx/H5fL0c40xiOAQWr4LFFaxMopyhQ==
X-Received: by 2002:a1c:a916:: with SMTP id s22mr4713674wme.82.1617117818884;
        Tue, 30 Mar 2021 08:23:38 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2d11:7929:c1dd:292? ([2a01:e0a:90c:e290:2d11:7929:c1dd:292])
        by smtp.gmail.com with ESMTPSA id k24sm4130955wmr.48.2021.03.30.08.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:23:38 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: dts: meson: add saradc node to ODROID N2/N2+
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hyeonki Hong <hhk7734@gmail.com>
References: <20210329161256.31171-1-christianshewitt@gmail.com>
 <20210329161256.31171-3-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <94a092ba-78b6-4aa8-9bea-d3bb1f1a9d69@baylibre.com>
Date:   Tue, 30 Mar 2021 17:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329161256.31171-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/03/2021 18:12, Christian Hewitt wrote:
> From: Hyeonki Hong <hhk7734@gmail.com>
> 
> Add the meson saradc node to the ODROID N2/N2+ common dtsi.

Not sure why this is needed, does it fix something ?

Neil

> 
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index 2f8d574c30c0..139c12cf9f66 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -508,6 +508,10 @@
>  	status = "okay";
>  };
>  
> +&saradc {
> +	status = "okay";
> +};
> +
>  /* SD card */
>  &sd_emmc_b {
>  	status = "okay";
> 


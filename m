Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C43A5DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhFNH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:59:22 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54103 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhFNH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:59:21 -0400
Received: by mail-wm1-f42.google.com with SMTP id b205so6840936wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YFtSuQv3LCHTkS9qZQYFvwMGwlgP6Ey1HHzA5wPOVqw=;
        b=XTJBTHThLVkVDyD9nRfrWfd6LXp2sdF+Q2BHknVacC7qynJjJkOy+iCkBlLSPJiJA6
         yqUMUho+a9imaUkHYDgA1B+c7pFGGbNrseZ1tdsz2sK1au8q4fWu5jyGFBKbABGQpcfF
         RYicjiaY1ykjV7hLClUIK0kJra547cBd+2SLZp/8YOZasMli+O/tSvqiTkmTVMHNafMp
         Xy+iDVKUalW7NNCYlFOzM2OfXaxxLRUlnnqWXRVuX9C0xde/I/Y01IhS2bE4SG1abamj
         tKQLuLXH5qaNYRjUlDoslz30z1V3SujV1R9K1bP3lKOzCn+5aiM0SJFFGZpAcqZE7+lq
         KAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YFtSuQv3LCHTkS9qZQYFvwMGwlgP6Ey1HHzA5wPOVqw=;
        b=hWpTZpAv5ZAfU9hF4A8WAnQblAq6keOALnt+Klm786pPt+Ow02Din+aLv79dVMSTZL
         nBahdoDyO/4cVpls4tmnYCtU1qOmeBpw36eLCzo0dFqUSwfJ0Shk+7x+bR/cw0Njqnw+
         VsWkQze9jN+oHgt3kPMvqByh+/ZsBlLWqQ0Xw0bi+q0iGLeJtsj2IZUQBni0KwMwqHkd
         Q+3FeQtChJ0D2kW7phICVebC7WtbhTh18luF4pPuii3HmS0DsQSLcXyHuKux+rmbOnhA
         VXz08dStQx0a3Ci7UWH4N2mLGOBUBt7KEKyVmvLaTWnP1vKY9IARJsC4JZVTgQE+XWz0
         +/5w==
X-Gm-Message-State: AOAM532ihAKUNiJW8y7CF9YU0GZJSY6HnZJ3v2YpVxBpsTcN0ODwo9Pn
        TEZyJLVmMyISuI8ILNKD6f6gvA==
X-Google-Smtp-Source: ABdhPJwXiCFSQ5nXOlDH3D+m1LZ6V9tiBVDzD62PR4ZSSay1CB+Y6o4yT9bRqZBZXyOCThu5gRjhKw==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr32297464wme.129.1623657362889;
        Mon, 14 Jun 2021 00:56:02 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:71f0:4862:1742:37fd? ([2a01:e0a:90c:e290:71f0:4862:1742:37fd])
        by smtp.gmail.com with ESMTPSA id u12sm15793274wrr.40.2021.06.14.00.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 00:56:02 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: meson: Set the fifo-size of uart_A to 128 bytes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com
References: <20210604170844.2201229-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <0e3b8d5b-756b-fefe-fbd3-8a786d7344ac@baylibre.com>
Date:   Mon, 14 Jun 2021 09:56:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604170844.2201229-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 19:08, Martin Blumenstingl wrote:
> The first UART controller in the "Everything-Else" power domain is
> called uart_A. Unlike all other UARTs (which use a 64 byte fifo-size in
> hardware) uart_A has a fifo-size of 128 bytes. This UART controller is
> typically used for Bluetooth HCI.
> The fifo-size of 128 bytes is valid from all SoCs from Meson6 (or
> possibly even earlier) all the way up to the latest 64-bit ones.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index 8bae6ed0abb2..bd0e864964e9 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -50,6 +50,7 @@ uart_A: serial@84c0 {
>  				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
>  				reg = <0x84c0 0x18>;
>  				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +				fifo-size = <128>;
>  				status = "disabled";
>  			};
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

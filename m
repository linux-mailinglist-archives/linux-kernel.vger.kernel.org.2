Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8964A38B09D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhETN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbhETN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:57:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:55:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so17811840wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWzw33PkspV7y4yyaFnbDMAVw/W4YT9sq/Y05RvYpbo=;
        b=X9mlvAcF46/y2PCKyoQeXtctw2ARdhTu1su5ycYVMJp5rGCp45ujrZLreinTsXGGKq
         e9V2clmjfdgj3CVEclGVLCgx2iVJp+JRrIEoUfHPfU4/jRkzg59tlXgjNDLZ7pezTlHa
         nANuEju0hmFvkNwEul4yTfjvZJoxBE3j7xHfB6h/Aj5dAeuHKKe2Avye1hR7rynWNXv/
         q2L2FzZHlv/ZsTRKUMuHhwhrAf/KTgKzgDNKDwOHxS/sd/vrPIqo3AOSu/NfPm+ML3XR
         6Gh1DZaoTzpLOLrbom3YaHirJLTrkSYunLhznDaCeDpVD7BzzPwj59TtdOTn4qRGBquE
         NuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iWzw33PkspV7y4yyaFnbDMAVw/W4YT9sq/Y05RvYpbo=;
        b=YVcwOMop8C1Q7prasuS43yzeLcqTSwYuBFPVTHFA2Xzc8JTZUAEi/WLCfHSLGApfKT
         oWtkkrXf6M1wEn8A4IJG9jiU6U8Y/5FmxTDTqFfkEV/ohEdiTjj4XsqSOTDQyUQhg1xN
         fTUrMksWliMo/7ThbEsvPzdh/VciMAtSVFePXyFWZj7XQaSXpp9034Y6Jlxz8VlVgZxe
         /OmyFa0B4ChbEsAdwb8WFAndrYkyR002BRL2BgTbf81mSiW3Agj7DViy+F45fIdBkvtz
         kK9PoswO5qB9+ymIAcQKgdutA22KoNrGYDLq8BYjDuuIuzgGOVUBjmrBuWLh3KC+/rdr
         7YXA==
X-Gm-Message-State: AOAM533kmOY0BZ2pZ81ncAqNkxK+2EL3ZBEo09veQ/QbM1uVBNKPhqa7
        40rLshJLaRGyD8Ga5RK3hQTnoA==
X-Google-Smtp-Source: ABdhPJw2HGwGgozEkBz9pJr9jphqMHa+rt/tIRCmlyL5OLiPES8jbFSqi9biISOa/iKtTrQrMUJB3Q==
X-Received: by 2002:adf:db42:: with SMTP id f2mr4467026wrj.5.1621518937629;
        Thu, 20 May 2021 06:55:37 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d88a:b479:b222:83bb? ([2a01:e0a:90c:e290:d88a:b479:b222:83bb])
        by smtp.gmail.com with ESMTPSA id v20sm2910528wmj.15.2021.05.20.06.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:55:36 -0700 (PDT)
Subject: Re: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize
 property
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
Date:   Thu, 20 May 2021 15:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 18/05/2021 09:58, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> This adds a property in the bindings, reads the property from the driver and updates
> the DT with the new property.
> 
> Changes since v2:
> - removed spurious blank line from bindings
> 
> Changes since v1:
> - switched to a more generic "fifo-size"
> 
> Neil Armstrong (3):
>   dt-bindings: serial: amlogic,meson-uart: add fifo-size property
>   tty: serial: meson: retrieve port FIFO size from DT
>   arm64: dts: meson: set 128bytes FIFO size on uart A
> 
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
>  drivers/tty/serial/meson_uart.c                              | 5 ++++-
>  5 files changed, 12 insertions(+), 1 deletion(-)
> 

Could you apply patches 1 & 2 ?

Thanks,
Neil

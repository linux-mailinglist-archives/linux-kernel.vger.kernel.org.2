Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA930A6CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBALqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBALqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:46:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B1C06174A;
        Mon,  1 Feb 2021 03:45:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f16so12363690wmq.5;
        Mon, 01 Feb 2021 03:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LTeob63vsmUobXodqAiG8SpUrpS7C8Uwp52f74LCJJg=;
        b=jUu/9QXaLfBlcx+CWhhnlNjanILpEbvu51VrRb8r/IgseXxg8nfWo26Yk4VZzUQSG+
         zNzBW5aT9qBfENRRyTBCHjCbpQv2xoD9emBMD6Z6LB32epHyhZd3v08a1ahO2fIc7Z5I
         cw2yW52UbhU+GzghNd4kGEl8xqbbwWZ8HCyADMlKFz0w+oETTs3gRllw6NQkCBqmnkKg
         2zXyu/gMoAONlCFSdI55iIZGfFlkpEZbVxejaJ/QaUb2EcZ1BkyKcdzOku9k22KYBFmm
         SprXDDg2yD+5d6tYTevrAoeROYTyKKmFueSJy6HsZ9O0meDge5nDOqOFgSqwmJnC7qHD
         eciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LTeob63vsmUobXodqAiG8SpUrpS7C8Uwp52f74LCJJg=;
        b=tw1Vd8yePO9eY2wBe042iIFSf7M6iVtboGhe0I3gJtsflSf0AIVIYl60lJsPIkma34
         OctMJ71EolBG5h4iEOMcNsNUjV4mjEU/E9ZRX2wCemX/4SCHVFbxt2I+Z6ysJYHIT1rO
         p/X6k7+gNEZddfD7A5Jva7Psle7dbeTs5ORZ9POpR6fqDNruubYfQbXmYL74IwmEsMP6
         bDPs1YcSDA3PQInyN3Hvjd5N0ZrzQlmdaEEF5df8dndGg5NR+WM0eV17lrDdNX8BKlV2
         fVa+Bdz/U5UOkeDN8fl4h7/RuHat78x9/oAocTFE/mczU0X1QXNln/zydQ60/fDccq/V
         y/Ug==
X-Gm-Message-State: AOAM530mRvDBwn5YUuHKctYADm5kewSQtKXIX2qXKnZTr5m0yVz/GHBK
        gvAXPC8Hi+Xe3q79sENG6VJOr5wA6MulFUva
X-Google-Smtp-Source: ABdhPJw6h2jWNnS4CMbNkwoBh5AfdOqqkEXCADAuVE+E1t5Yd3scYb5jIl9WCOkFDGBgnEYEW6K80w==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr14939397wmb.14.1612179921358;
        Mon, 01 Feb 2021 03:45:21 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id b18sm26360198wrm.57.2021.02.01.03.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:45:20 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: evb: Add domain supply for
 mfg
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210201093049.87285-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7c76c776-5bd5-d35f-1003-8b1741555ac4@gmail.com>
Date:   Mon, 1 Feb 2021 12:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201093049.87285-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 10:30, Hsin-Yi Wang wrote:
> Add domain supply node for mt8183-evb
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Queued in v5.12-tmp/dts64

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 3249c959f76fc..edff1e03e6fee 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -352,6 +352,10 @@ pins_pwm {
>  	};
>  };
>  
> +&mfg {
> +	domain-supply = <&mt6358_vgpu_reg>;
> +};
> +
>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi_pins_0>;
> 

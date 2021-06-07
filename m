Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF839D866
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFGJRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:17:37 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:33604 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:17:33 -0400
Received: by mail-ej1-f51.google.com with SMTP id g20so25538329ejt.0;
        Mon, 07 Jun 2021 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZrq5VlhmQW6JZmMPrVakR8M/Jz/bAVYPXpHBFjrH1c=;
        b=KLn0ZlNqWao86EIujuLqufe3OtsEytKF0ws/B3wc3/r7n3np7VmGBbtKzL47joK9cC
         DPxaG75RV5SEQARuDIlNwRb2azNgabL9fbK890DZu2A2bpgyBCS0L1/JqQVbBDSqjPRI
         mEPPkB0MsUv3koqXOXp0hq7dSZARqaJ6//+uxLvfEIJErcQ6ua+Cp54rfNOZrqroLQSc
         gK73DjWJriG2Vpjv2DPaUymgpmJH5SkHboVw3C8E+scOFq+DS+p2PdoP20SMeoqGNh7j
         81uAGcyJTM5jMRevo01ap3EaAGIoj7qngHGu5IQLKtGMCtUgqV9OmhxIcEUTRbk6mvWf
         a0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZrq5VlhmQW6JZmMPrVakR8M/Jz/bAVYPXpHBFjrH1c=;
        b=rN7Yt2Wc3QBHdRRKRQVivnYnyPykVpWdy0BcSFvM5cJ1MMF32bnHrhEB8Tl2msksy1
         MCErahdR7IVVVAFcWONKBEDlyKnPMYkDfqDCTgk+fJwUR/Hq3xEXnDaNp5YbI1zdqALR
         P8cVK9/Npmv2QXaWlCm7wSuCf4CutALwfIhhlgf+e1Z5FwjS4uiW+TEhSbMk1+OFlrx+
         gMey4gcsN6oRdahVF3MdLT752fQSFXz4va9hbomsr1kBU6XyKA+ztpHcrIswKKCq6b4l
         JHSrYyWmmLQ88oMcJArU/6wd8mKfWSTnEpPGCqWeNZogpx7b7SYS+YAjKk+R5NgOksuJ
         nMFA==
X-Gm-Message-State: AOAM531nIzq0sJL+AowTKZfjatVO86Sai/WZbP7X4S8gy/zbOrDxAsGs
        8+ETOcV4wuoM7AvGK1nAfeYmVVjDoS/QEg==
X-Google-Smtp-Source: ABdhPJzXK2A9L9nkflnok98q7PG7rX1Tcr7XYduvR8sIGZiKEBv2cHiQo0Pymrmm8SJyMG5RlEkWxw==
X-Received: by 2002:a17:906:f8d0:: with SMTP id lh16mr17075823ejb.331.1623057265308;
        Mon, 07 Jun 2021 02:14:25 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id gx28sm6320117ejc.107.2021.06.07.02.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:14:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210607081727.4723-1-cnsztl@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
Date:   Mon, 7 Jun 2021 11:14:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607081727.4723-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianling,

On 6/7/21 10:17 AM, Tianling Shen wrote:
> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> stores the MAC address.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> index cef4d18b599d..4a82f50a07c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> @@ -68,6 +68,15 @@
>  	status = "disabled";
>  };
>  
> +&i2c2 {
> +	eeprom@51 {
> +		compatible = "microchip,24c02", "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;

> +		read-only; /* This holds our MAC */

The mainline dts files should be generic I think.
Any comment about "use", partitions or write ability should be avoided.
It's up the user.

Johan

> +	};
> +};
> +
>  &i2c4 {
>  	status = "disabled";
>  };
> 

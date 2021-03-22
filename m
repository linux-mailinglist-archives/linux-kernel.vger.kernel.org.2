Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA14D343C24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCVIyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:54:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BBC061574;
        Mon, 22 Mar 2021 01:54:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x28so19979571lfu.6;
        Mon, 22 Mar 2021 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIJXqSZ5zt8gv47j0NQUG8EXZyVECUtsZ+x0h0P65ao=;
        b=ta7MBBiE/qUyUJE7jspyyUViw+CCcxKRPPdFPeMzIpbpqNsJ2bjzk+Q0+xz5Kc0etM
         2Q5Ka2JTFUfM8hydry+zjhZrDyWF09dKQ1haYngnKGdw250Ak5vr5J8mwdxP7aXcQIRx
         oR3Q/0uWz0yONuG2blXN9G9FYRU7aXumSUaIAtXdvYwOU60jFe4YCni1WjWsMWTfpdK/
         vMuT8NZYptppq2i9uCPef+axhsIXmEKcrx/Rn8373Wbcg3PC2HOpF8N/znAy6FaguF2h
         2YA7wOO9DT022R5W1hlEXg8DzDLlOGgMHBRhq1WNRnjkbqSOf8uwoK0rOvpsAAp21VhQ
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AIJXqSZ5zt8gv47j0NQUG8EXZyVECUtsZ+x0h0P65ao=;
        b=nHG+Lc7OU3K2ykEIHGVz4QS2urwuJ7AuFq4Ge6DbCpRgam1R9UWg/9PTL6ByUwOmZo
         i6Ye3lqdq+uUWDhqwmrchlygBGd5US43mLAsOnRPLUqtHMdR1AN0o93WOFQ3l/svJb9x
         RsKDrQxHh5xByStffb6w6ch0JK+BLuIgFCOOh1bbZSeYaQGg6G5wjpAh+y1SCzviGdmw
         c/duv7snQF1xNW9htWmT58phLDUUfu4ttXI5PTdUxlEEDf9RdwkQguOCbTSKuWI5oUkY
         huPXkiR8nuE+dnXPVDR8EIfI5T3/D41DY8NWeD7d6CqRaG3mNj/KuEapxLyMJhmuMUkF
         cNoA==
X-Gm-Message-State: AOAM53017ny6dgBDptlj5Yd7NzVwH0LHU9BvNPw36i511HYv48O2+Mb6
        D3IM15m/67q8HQXmy3Bxm5c=
X-Google-Smtp-Source: ABdhPJxrDY7mwUos4IEbQFk1RZIScP8k8HR4cpBJ7iKUklgyJNZ7zTbSCe9TmX11GGO811SaFrg1Cw==
X-Received: by 2002:ac2:4826:: with SMTP id 6mr8493824lft.629.1616403269242;
        Mon, 22 Mar 2021 01:54:29 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.79.3])
        by smtp.gmail.com with ESMTPSA id h24sm1865264ljg.77.2021.03.22.01.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:54:28 -0700 (PDT)
Subject: Re: [PATCH 06/13] usb: xhci-mtk: support ip-sleep wakeup for MT8183
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
 <1616382832-28450-6-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <0e660a28-d66f-a23e-3fad-8fa37b6df1b1@gmail.com>
Date:   Mon, 22 Mar 2021 11:54:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616382832-28450-6-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22.03.2021 6:13, Chunfeng Yun wrote:

> Add support ip-sleep wakeup for MT8183, it's similar to MT8173,
              ^ for

> and it's also a specific one, but not follow IPM rule.

    Following?

> Due to the index 2 already used by many DTS, it's better to keep
> it unchanged for backward compatible, treat specific ones without

    Compatibility.

> following IPM rule as revision 1.x, meanwhile reserve 3~10 for
> later revision that follows the IPM rule.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 09f2ddbfe8b9..8ba1f914cb75 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -57,12 +57,19 @@
>   #define CTRL_U2_FORCE_PLL_STB	BIT(28)
>   
>   /* usb remote wakeup registers in syscon */
> +
>   /* mt8173 etc */
>   #define PERI_WK_CTRL1	0x4
>   #define WC1_IS_C(x)	(((x) & 0xf) << 26)  /* cycle debounce */
>   #define WC1_IS_EN	BIT(25)
>   #define WC1_IS_P	BIT(6)  /* polarity for ip sleep */
>   
> +/* mt8183 */
> +#define PERI_WK_CTRL0	0x0
> +#define WC0_IS_C(x)	(((x) & 0xf) << 28)  /* cycle debounce */
> +#define WC0_IS_P	BIT(12)	/* polarity */
> +#define WC0_IS_EN	BIT(6)
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -71,6 +78,7 @@
>   enum ssusb_uwk_vers {
>   	SSUSB_UWK_V1 = 1,
>   	SSUSB_UWK_V2,
> +	SSUSB_UWK_V11 = 11,	/* specific revision 1.1 */

    SSUSB_UWK_V1_1, maybe?

[...]

MBR, Sergei

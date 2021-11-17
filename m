Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB7454A23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbhKQPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbhKQPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:42:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58446C061570;
        Wed, 17 Nov 2021 07:39:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so2464112wmz.2;
        Wed, 17 Nov 2021 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AuJQYHplLClloH34kEvglpfeOlJKdLUFL/faIlnURqs=;
        b=QFpzzjG2UpBSWHUyfseU0Y3i3+rS/0FUnXv8ZUH+iNTzAW9gISyuCz9WmHgP1QenyM
         hEsUZ5IIvWEwr89kK3BSurRix+yYdgF7rsilPtO43ZaXJPw9kq95OK5LGfq8JTm8FgDh
         6URuV8ZQweV7PTpPCCOjZszm82Z6BtQTapxpRKwim2Z/zD6+6WDJbnsItmVLAX+/gZ9v
         1sSIG9ax/YBAI0UR1Xn425LsSNOo9GhO508FkdnCTsm8bt7ODoGXFSUDEwgHwjJgw1jE
         vdG94jXeSmyPNdxqEMr28+7w/5xUjSYwCrpmVMfDIt6jLelpUSCJRr+LecdN78R993s7
         vT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AuJQYHplLClloH34kEvglpfeOlJKdLUFL/faIlnURqs=;
        b=KiGh/5zAhbvtuBPfQPYGLGXYU/wgGirbhPPa35yo2vblxGwXzjpgRz3jpCAE9bU1ln
         xnpQpmaN7OFMK4TNsU5g03MvZdWBB2MaQ+aXnDTCRxwPG4/OL/veCMePfB8nU/02zSoO
         mRdOXu6V+QBGV3AR2cY7TssgkEfsgH+227NdR+gG6X1YV7Vqcwl/pYtMRX+3fmjFujJi
         AFFYqHMD2o3GuAcsvmZgiSQkeqxppDD5Mq/Y61VKbhJyz+vNikPAjWU/GE45B5I8qGDD
         nc0lxu01nI7Uhj52QtDQ0jzpT4SrcTNMCvkH7TUK7Aoyt+cQIgXUcSwVpwPmGQz2rgLn
         lwNw==
X-Gm-Message-State: AOAM533R/LRoCoQ+vYux9htQyzOJuww+UVGqxhysX+lUjJNsNXqYvllo
        wNIx2888ooQRr0em+l+d1Q4=
X-Google-Smtp-Source: ABdhPJxt436RYGl1PlAoi3XeorePlbRfnavbllNp8/73UeAo6VoKeGKr4Dm912w/JIxVDxO3qD/40g==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr651161wmz.145.1637163581900;
        Wed, 17 Nov 2021 07:39:41 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id c4sm220035wrr.37.2021.11.17.07.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:39:41 -0800 (PST)
Message-ID: <138878d2-e346-931b-69ee-54277fa5647b@gmail.com>
Date:   Wed, 17 Nov 2021 16:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] usb: xhci-mtk: add support ip-sleep wakeup for mt8195
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
 <20211102060049.1843-2-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211102060049.1843-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2021 07:00, Chunfeng Yun wrote:
> Add support ip-sleep wakeup for mt8195, it's a specific revision for
> each USB controller, and not following IPM rule.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/usb/host/xhci-mtk.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index c53f6f276d5c..63f4b6984667 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -95,6 +95,19 @@
>   #define WC0_SSUSB0_CDEN		BIT(6)
>   #define WC0_IS_SPM_EN		BIT(1)
>   
> +/* mt8195 */
> +#define PERI_WK_CTRL0_8195	0x04
> +#define WC0_IS_P_95		BIT(30)	/* polarity */
> +#define WC0_IS_C_95(x)		((u32)(((x) & 0x7) << 27))
> +#define WC0_IS_EN_P3_95		BIT(26)
> +#define WC0_IS_EN_P2_95		BIT(25)
> +#define WC0_IS_EN_P1_95		BIT(24)
> +
> +#define PERI_WK_CTRL1_8195	0x20
> +#define WC1_IS_C_95(x)		((u32)(((x) & 0xf) << 28))
> +#define WC1_IS_P_95		BIT(12)
> +#define WC1_IS_EN_P0_95		BIT(6)
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -105,6 +118,10 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V2,
>   	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
>   	SSUSB_UWK_V1_2,		/* specific revision 1.2 */
> +	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
> +	SSUSB_UWK_V1_4,		/* mt8195 IP1 */
> +	SSUSB_UWK_V1_5,		/* mt8195 IP2 */
> +	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
>   };
>   
>   /*
> @@ -307,6 +324,26 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
>   		msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
>   		val = enable ? msk : 0;
>   		break;
> +	case SSUSB_UWK_V1_3:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL1_8195;
> +		msk = WC1_IS_EN_P0_95 | WC1_IS_C_95(0xf) | WC1_IS_P_95;
> +		val = enable ? (WC1_IS_EN_P0_95 | WC1_IS_C_95(0x1)) : 0;
> +		break;
> +	case SSUSB_UWK_V1_4:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
> +		msk = WC0_IS_EN_P1_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
> +		val = enable ? (WC0_IS_EN_P1_95 | WC0_IS_C_95(0x1)) : 0;
> +		break;
> +	case SSUSB_UWK_V1_5:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
> +		msk = WC0_IS_EN_P2_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
> +		val = enable ? (WC0_IS_EN_P2_95 | WC0_IS_C_95(0x1)) : 0;
> +		break;
> +	case SSUSB_UWK_V1_6:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
> +		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
> +		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
> +		break;
>   	case SSUSB_UWK_V2:
>   		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFB343C33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCVI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCVI6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:58:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B2C061574;
        Mon, 22 Mar 2021 01:58:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x28so19997722lfu.6;
        Mon, 22 Mar 2021 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PczL/i8DI0v6bV5Bqb7xK3jB9Ud2bBghp0p1H6uE45k=;
        b=Zzfgfbhjr6omMPasXx7EptNOXKHhyfoa79NSlCDRNvUiypFULzvxaoJj1ZBJ9jInwB
         vCm7/FAI/cNI9KxvCdyTNNQp48vS1A6koufQSCC1Xgk6/z7JvES1gxayZ1nbsrMd/BwB
         y/7DPt3s3w6PfMWgfbzHxfqx85U2GXiMgmSinIMlKRUwuewILIrfBaRfD4Odv3Jensjt
         vAU8RqYi3x/nTtRTyRyRwiAMoYHicuOU3AvZtXTA6fPaFhcnK5uZbi2iwymjTmKy46QR
         L01FJWiIRYfWI4KYIvVEUyytFx/SEFm6UgcAnKCbEzpDMxUR379ZVkud7UoroUwO5ion
         O5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PczL/i8DI0v6bV5Bqb7xK3jB9Ud2bBghp0p1H6uE45k=;
        b=pLQcF6QAGup6tkyVUL7ZYqva/mz14doDjptpAD6/rJ2qwpsaGXB/VtKAmnwB/0m/sS
         2yxYUcJd9IqVHY6eHY/qFscMtfVKDjAvFpn2dnA9rYmwmoHB/6NSKBB/pvpKsAuw5MJz
         s2z81hkV/+WPDQgx5rYevISLJubOaW0HsCogxB3cXJP0k6wgC1DVjhjJDkwq2LjmaD2+
         A0ztVICjlPICkWlIzcmFhLeMsS86oHFyuyO/4KCbJ9FmsqA2OM/uHSoGCw/fUyp3soWg
         yX8OyGVS5FR5XVbiCrFExOPWEs4Zngo87/NwjJlglQdR1/eWBAS5HsUVVhBuM1CobN3k
         GBvw==
X-Gm-Message-State: AOAM530zny0VuDLMehtFqxRDvQUqdWXrIW1R7b3xBfOoqkX5woJCs2C+
        k6jMClTE6aTcBB5qjfBnLFo=
X-Google-Smtp-Source: ABdhPJwkYZ8LlbYbzeHnceTbtbYUvqyReoc5EvZh4NuqQ8PKASe1h6Vo0Di4YEMIEm0AlcBM7ZoV8A==
X-Received: by 2002:ac2:5933:: with SMTP id v19mr8182977lfi.405.1616403526211;
        Mon, 22 Mar 2021 01:58:46 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.79.3])
        by smtp.gmail.com with ESMTPSA id k30sm1792377ljc.140.2021.03.22.01.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:58:45 -0700 (PDT)
Subject: Re: [PATCH 07/13] usb: xhci-mtk: add support ip-sleep wakeup for
 mT8192
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
 <1616382832-28450-7-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <f9d14506-5db5-8f97-e3d0-5956cc17dadd@gmail.com>
Date:   Mon, 22 Mar 2021 11:58:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616382832-28450-7-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2021 6:13, Chunfeng Yun wrote:

> Add support ip-sleep wakeup for mT8192, it's a specific revision,
              ^ for

> and not follow IPM rule.

    Following?

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 8ba1f914cb75..1bfa28c9b5a2 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -70,6 +70,10 @@
>   #define WC0_IS_P	BIT(12)	/* polarity */
>   #define WC0_IS_EN	BIT(6)
>   
> +/* mt8192 */
> +#define WC0_SSUSB0_CDEN		BIT(6)
> +#define WC0_IS_SPM_EN		BIT(1)
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -79,6 +83,7 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V1 = 1,
>   	SSUSB_UWK_V2,
>   	SSUSB_UWK_V11 = 11,	/* specific revision 1.1 */
> +	SSUSB_UWK_V12,		/* specific revision 1.2 */

    SSUSB_UWK_V1_2, maybe?

[...]

MBR, Sergei

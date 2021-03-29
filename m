Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF434D1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhC2NrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC2NrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A75C061574;
        Mon, 29 Mar 2021 06:47:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so12942885wra.2;
        Mon, 29 Mar 2021 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SHJw7ynIQtYIZDtMTZai6BlbSyO8G1iEaclbkW3WeUg=;
        b=G2BVrmBVNZY16wcuSi4vnzeW9Uul920d03c5stRAVuxf7lP5tEwLjbE/a3srGBSuuI
         0MttY+ZbQzBLxbRnZbfYKt6+3XsGgfbMF6lEUJvThX7+JvPpXF2U8Iz3FAqUwDgYQIbH
         P1KScBlbPg+nFXIExIDLBDNhyPQN/h0EQ/9KqnudsYe1442h+zgKxT3LYUJj/faPcB3u
         ebmCa7PobB7SS8bGVRxafgLD4pQ+kT00G3b7Isdoquq41HEXCi0Eyn3VxVgTmBcTJT/B
         e6kTs3q2zEsY6ad7CrXVXV2Ha5UCTdRtmk4MwcU5zA3eXOIhmZD3LhiYVa8TUyXaewQj
         5oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHJw7ynIQtYIZDtMTZai6BlbSyO8G1iEaclbkW3WeUg=;
        b=hXy7NxJdHTdjIHuM1YT941xyMwCj+kRWOMqh3NZY19FdbY1rX2SurPZc6NV4Wi6zIj
         4Ciph7mR53z0NpGo4Vxcl3ggUEaFMNolutCUvMAnESxDEkitPRzdvMIVLoobwdAfuzgN
         V8tLR2JfW0eVJYTjz0mVZKUzr5dnKpx9ZVeLQDS9eZBnNf8NI2AlaVEqJAlfB7HHSNlM
         HzkI0+qe4IMrIJu9r8fb/fhEI+gUAQYBA2IuWOFBJtJC5O+WFKhExKps+LssiTCfEG1r
         zFGDlFO94D7yzidqYtkdaR1l2RidFJidJ7dhCMZCEHOqTYsWW3XSOQ6Eeyit8FfaV8o9
         5u9g==
X-Gm-Message-State: AOAM530fz2xXqK+zEH+mPykQvZbfraXQuWSDTLbykIcXLkeiiLgabVeE
        pwwKQ9IT+467r69R5DfBYqFBWPzNkeleiQ==
X-Google-Smtp-Source: ABdhPJwy/xjxdAl7xDrzQk1wBSWQTvD30dAXW+9quVKShEdRejctfFXc6fCqm2PcwXBcDw7iQwDc9Q==
X-Received: by 2002:a5d:4bcc:: with SMTP id l12mr29016522wrt.343.1617025625889;
        Mon, 29 Mar 2021 06:47:05 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id q19sm24533172wmc.44.2021.03.29.06.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:47:05 -0700 (PDT)
Subject: Re: [PATCH v5 09/13] arm64: dts: mediatek: mt7622: harmonize node
 names and compatibles
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
 <20210316092232.9806-9-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5febd2dd-5bed-3eb1-c2be-63cc588eae41@gmail.com>
Date:   Mon, 29 Mar 2021 15:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316092232.9806-9-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 10:22, Chunfeng Yun wrote:
> This is used to fix dtbs_check warning
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied now to v5.12-next/dts64

> ---
> v2~v5: no changes
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 7c6d871538a6..890a942ec608 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -742,8 +742,8 @@
>  		status = "disabled";
>  	};
>  
> -	u3phy: usb-phy@1a0c4000 {
> -		compatible = "mediatek,mt7622-u3phy",
> +	u3phy: t-phy@1a0c4000 {
> +		compatible = "mediatek,mt7622-tphy",
>  			     "mediatek,generic-tphy-v1";
>  		reg = <0 0x1a0c4000 0 0x700>;
>  		#address-cells = <2>;
> @@ -877,8 +877,9 @@
>  		status = "disabled";
>  	};
>  
> -	sata_phy: sata-phy@1a243000 {
> -		compatible = "mediatek,generic-tphy-v1";
> +	sata_phy: t-phy@1a243000 {
> +		compatible = "mediatek,mt7622-tphy",
> +			     "mediatek,generic-tphy-v1";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6734CED4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhC2LZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhC2LYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:24:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAFC061574;
        Mon, 29 Mar 2021 04:24:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so6434441wmq.1;
        Mon, 29 Mar 2021 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e1a+kwffYzcMpQSHQ60B4gj/nqd34pu7XrkW9Q/Wixk=;
        b=JMaGuu1/1AzbM8khYOCfsDA83fsN5lLMMQFTORmksRJjFb3rHTdeYvFJlZQUUbKzZ0
         9We3OPZGsM2B6oIDjrodT/7NDDBtos84rwVAXbbeCCoWPVcQeAo07JzZCnOuKrlrk51Y
         Had8K4Zw2SfS6OQ4nh8t4o14ILF14kr1oowJlxzldlNGqpC3fI3UniJBXwCz7YZr2hFk
         +7c5jUfZ1OPfFAPZ8NW2m2NMnBoVrep5HBCeqX5WGgpiCixDDobOlUCL0/BK3xJOt9+V
         cantxZWUwthSRe1tW7x0e7kJHLqWOsv5u/Qt37HKR02juAAzdUycyVAwfbtmBcb48hdO
         EGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e1a+kwffYzcMpQSHQ60B4gj/nqd34pu7XrkW9Q/Wixk=;
        b=EmAKrxMdgu/F19mAbzsjP6h4CawX/mZeRPLR2B1823aH9e3/uytygt/eJeBxM5VNcl
         K4ynPgGGmueON+DDequple8/rx6noXDMughL2Q7aQnG69y02AT7DPOd+aTxjvOfPAiop
         KaMMeVw3cRko2gThzxlKy5Z/xNc61SlWOjlBi5XJPHKAksEjvGiD620SbozyVttVUZ8/
         uq2nqb7zyZ0RezLD0rdxW1nOtUGNtTbU2ZHCc0gvI3LCOoGTt4ase9N23jFY1SB4kVIj
         eQdzITUxySwbteIaHdYSyDNRefCjl863plIGWVeyFmXqRhYaVayp20REoSnJ+vrWnSp/
         jS3w==
X-Gm-Message-State: AOAM531QqDmz2FkNLF/00afYo8dS+5PCa/bQY/Rl16upvnBTm9nw2Fwu
        t11RGwwVeyZh43iaFNFSe4inrwvOEh/zmQ==
X-Google-Smtp-Source: ABdhPJxO5uaGZe0cOQbx0p1x8BvQjis31yBV3+DstmIQFPcMrOOWCSYX7J5Kah/aMmyTwI9nQ1zaQw==
X-Received: by 2002:a05:600c:3790:: with SMTP id o16mr24435924wmr.110.1617017063717;
        Mon, 29 Mar 2021 04:24:23 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id b65sm24516037wmh.4.2021.03.29.04.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:24:23 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] arm64: dts: mt8183: update wakeup register
 offset
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
 <1616482975-17841-13-git-send-email-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a11c871f-4bfc-c069-b413-7fb6cd203b6f@gmail.com>
Date:   Mon, 29 Mar 2021 13:24:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616482975-17841-13-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2021 08:02, Chunfeng Yun wrote:
> Use wakeup control register offset exactly, and update revision
> number
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: modify revision format
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 80519a145f13..9ea84d636556 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -874,7 +874,7 @@
>  			clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
>  				 <&infracfg CLK_INFRA_USB>;
>  			clock-names = "sys_ck", "ref_ck";
> -			mediatek,syscon-wakeup = <&pericfg 0x400 0>;
> +			mediatek,syscon-wakeup = <&pericfg 0x420 101>;

applied to v5.12-next/dts64

Thanks

>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> 

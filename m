Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E432406554
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhIJBnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhIJBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:43:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902BCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EEsL2Ua4JKiBuEtvP+hN91RNOSRfb0BEIz1GBTlyL28=; b=ItvbIjG6CBNfdQX20OGwAIjjxx
        RvMBUGZLltEmI5/xFRrZtp02xj9k8eABgFWVpySMvJLzl557ZvX9vzl8mZr2mKY79eAgFZid4q8JK
        7PUkgC0AWTe6edEUtui4BYJ80jx7xwibUVw09I6JPyLQWFLTQo9UifWIGoUy1avaejg628TwCCU0+
        1+s0N4nqu/Oz4H/xJ/58P/UGZKf4RiPF2QbVbszSAz1W44glpt4BWt4c8rty6G8DvEYSXHJMptwwg
        qYQZWG0K6vo/AGO+Yh8rYBlPZPVTILTEp+zcs9cUbgODlj6s2tuFW63NTB/k+FiX6AwKzNWBpSXJW
        p2zNcDRw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOVYL-00BXZP-9T; Fri, 10 Sep 2021 01:42:05 +0000
Subject: Re: [PATCH] ASoC: mediatek: add required config dependency
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, wenst@chromium.org,
        bicycle.tsai@mediatek.com, jiaxin.yu@mediatek.com,
        shane.chien@mediatek.com
References: <20210909065533.2114-1-trevor.wu@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46bf2061-7a00-c6f0-d2e9-5605b13f1c3f@infradead.org>
Date:   Thu, 9 Sep 2021 18:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909065533.2114-1-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 11:55 PM, Trevor Wu wrote:
> Because SND_SOC_MT8195 depends on COMPILE_TEST, it's possible to build
> MT8195 driver in many different config combinations.
> Add all dependent config for SND_SOC_MT8195 in case some errors happen
> when COMPILE_TEST is enabled.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
>   sound/soc/mediatek/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 5a2f4667d50b..81ad2dcee9eb 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config SND_SOC_MEDIATEK
>   	tristate
> +	select REGMAP_MMIO
>   
>   config SND_SOC_MT2701
>   	tristate "ASoC support for Mediatek MT2701 chip"
> @@ -188,7 +189,9 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
>   config SND_SOC_MT8195
>   	tristate "ASoC support for Mediatek MT8195 chip"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on COMMON_CLK
>   	select SND_SOC_MEDIATEK
> +	select MFD_SYSCON if SND_SOC_MT6359
>   	help
>   	  This adds ASoC platform driver support for Mediatek MT8195 chip
>   	  that can be used with other codecs.
> 


-- 
~Randy


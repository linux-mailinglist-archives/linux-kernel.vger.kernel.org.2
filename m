Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77706415B03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhIWJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239965AbhIWJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632389613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XltoywlcP0qDE+72KoAOrDLftsmJK5LttN10ijTFiP4=;
        b=LOU19na9v76m+sfJ+uaNKkyeMNbiWMVWPSNsEzkbmR8ZRSBaJeJU40NsZMSUW3U/v/Z3RP
        wI0Hq5JIjygSl6u7TR5ijy1qbrPo3jyfRplE/uP1Eh0Of30NUbC5s14ZqO2d5dQdEJYFrM
        zP26k52PIBlRE2DPo53Seplaex6d6KU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-e6o9OE4dOb6j_cp7iY89iA-1; Thu, 23 Sep 2021 05:33:32 -0400
X-MC-Unique: e6o9OE4dOb6j_cp7iY89iA-1
Received: by mail-lf1-f71.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso5581924lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XltoywlcP0qDE+72KoAOrDLftsmJK5LttN10ijTFiP4=;
        b=t17hlDEBtgEykJ9byRl9HNV83ExyrP25zL+aKk+R3DWPwAPBWkDAxnNutUyhdVKnbI
         xjgSoSnUNGUTisvZfzN2hi/XN2xdn/PKDW/QzWw+evGZFgI8rs63xdqKNkHSLpZN3Dih
         HA5BQNFSgUY/wfZldLaIqUrUanlxDm8yN94c3L+84Z9F71PZ1oaCXbmvLdjNcJDP8Z7Y
         KFB0D4Th1IIwgQL8sq4iGt2zVVjmcfVVGT9WCe2gTawqz7RIPYs1tqdjjyhVJmhwD9+A
         gHjtwcfIklr7va4UETw9nhIoT0WAezgAL2/pedz4kE/Am8+RNxa8kmcCB/J9sM2NvAtc
         lH0Q==
X-Gm-Message-State: AOAM532mHB/2Z9ubA13NHuM9U3ryZeUmGNVvpKjuwZYDUe7jDkddddW8
        UHCFz2DF3ngJnjcRkrpUbDNHwuzl5RhXzIlRhKT6bGyrWcecbZ2dYoS8cShu7/mL0PcrHp0XT1J
        PC+T8sxHcH/+pxWW5lKksF1v5
X-Received: by 2002:a05:6512:3989:: with SMTP id j9mr3201273lfu.213.1632389610668;
        Thu, 23 Sep 2021 02:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytKnMM39tB7JQK3L+zYwqfi6+x3sfWqUxD/CHcooucnpp+0N9Ur94gTROEtpkmjTbbBGBwxg==
X-Received: by 2002:a05:6512:3989:: with SMTP id j9mr3201243lfu.213.1632389610330;
        Thu, 23 Sep 2021 02:33:30 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id l9sm172205ljg.44.2021.09.23.02.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 02:33:29 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        hawk@kernel.org, ilias.apalodimas@linaro.org,
        jonathan.lemon@gmail.com, alobakin@pm.me, willemb@google.com,
        cong.wang@bytedance.com, pabeni@redhat.com, haokexin@gmail.com,
        nogikh@google.com, elver@google.com, memxor@gmail.com,
        edumazet@google.com, alexander.duyck@gmail.com, dsahern@gmail.com
Subject: Re: [PATCH net-next 1/7] page_pool: disable dma mapping support for
 32-bit arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <20210922094131.15625-1-linyunsheng@huawei.com>
 <20210922094131.15625-2-linyunsheng@huawei.com>
Message-ID: <0ffa15a1-742d-a05d-3ea6-04ff25be6a29@redhat.com>
Date:   Thu, 23 Sep 2021 11:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922094131.15625-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/2021 11.41, Yunsheng Lin wrote:
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1a6978427d6c..a65bd7972e37 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -49,6 +49,12 @@ static int page_pool_init(struct page_pool *pool,
>   	 * which is the XDP_TX use-case.
>   	 */
>   	if (pool->p.flags & PP_FLAG_DMA_MAP) {
> +		/* DMA-mapping is not supported on 32-bit systems with
> +		 * 64-bit DMA mapping.
> +		 */
> +		if (sizeof(dma_addr_t) > sizeof(unsigned long))
> +			return -EINVAL;

As I said before, can we please use another error than EINVAL.
We should give drivers a chance/ability to detect this error, and e.g. 
fallback to doing DMA mappings inside driver instead.

I suggest using EOPNOTSUPP 95 (Operation not supported).

-Jesper


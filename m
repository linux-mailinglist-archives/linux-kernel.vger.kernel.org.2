Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D040B59C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhINRJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhINRJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:09:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:08:16 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y144so97878qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d9SzK4pBoaf11lP96SjVpjf29pHlYDeVwg9n+E1Drc4=;
        b=QtkWU/EmWLfrq260BxNf0mGiuYZUZUYyoD0xPuezViRZ4mF/XCnK/tGHLl6uCuwm/l
         OEBXW3WMwE0A/G6QfVBdQklqm6ber7gQIzEoSN3yJBWkAmnQxly90HsctdXmmytbzMHF
         L3KoPTc+Mr9B9ig4OIUiOkfFqAQvWzvACCR/8Z5Ak8G8u2ih5jz8qYrxjV6ZrPlHV7nH
         BwsNYjdiDWP5SUb4oj+pil2/1n683Q+0Hj+me82nhkYlYutM9n9fdJneQXyogDsqvWYR
         fK3GeRs3REIVRpVxC3R5+Vhr/DO39JCqMeN/rHxtTsQw1cI5NFDsb8Hd8MuoOdbh+67y
         eXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d9SzK4pBoaf11lP96SjVpjf29pHlYDeVwg9n+E1Drc4=;
        b=ygNYBjmM9qIhutnZo/NzZ8apsc9tEHjK45zXBUI/22BpjRjHDth+PJmuNBZzqC9+Kz
         zFQJ5Cev3/Uw/F1A2aHcBzk3xk+NMJChSDukSWzlF2uhkt/cDujkfA9/1Wd9+lPBk9R1
         acoJmSY02amiYexBXEji9IH24DioqmiimkJE5IhCSGW00xBXruK/1PJlf1lLdzVsfgfM
         PM4RTNDGKJN3eZYa6Ql6H96fG1HgWl0KVwsndwmr4kWLdjJK/RE0gvAtVPaDOgwLH2YT
         YsPDYFhIWiviDbrhjHt92ToYflOVBlaLFfgJao3EE2WUcUYkq70F5/rJvcr6/d5CW1+i
         anKQ==
X-Gm-Message-State: AOAM530Gj6opDD0rdGsxN63XN8rVsf5nFRitxKzreWggDqzvEH8E9we/
        wtB2mOK7Iul6ZFVJhYCjUHMSiv4zlWfi
X-Google-Smtp-Source: ABdhPJxLVtFRYIDvR4qJehRmv7dzyozIgYmkFOFqnGnr6OykjMd+avsbggpblmz9NAJNvd4rGy/Okw==
X-Received: by 2002:a05:620a:916:: with SMTP id v22mr6042305qkv.338.1631639295927;
        Tue, 14 Sep 2021 10:08:15 -0700 (PDT)
Received: from [10.28.133.11] ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id r23sm6405377qtp.60.2021.09.14.10.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:08:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
To:     Chen Huang <chenhuang5@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210913121956.1776656-1-chenhuang5@huawei.com>
 <20210913121956.1776656-2-chenhuang5@huawei.com>
From:   Darius Rad <darius@bluespec.com>
Message-ID: <84697744-f51e-8aaf-d1d3-d063f99b7790@bluespec.com>
Date:   Tue, 14 Sep 2021 13:08:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913121956.1776656-2-chenhuang5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 8:19 AM, Chen Huang wrote:
> The RISCV ISA can perform efficient unaligned memory accesses
> in hardware. This patch selects HAVE_EFFICIENT_UNALIGNED_ACCESS
> for that.
> 

Not all implementations do, so it seems like this is not appropriate.

> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index aac669a6c3d8..6e70bf50b02a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -81,6 +81,7 @@ config RISCV
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_EBPF_JIT if MMU
> +	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_GCC_PLUGINS
> 

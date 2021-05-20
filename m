Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4438B0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbhETOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhETOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:06:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36438C061344
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:02:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i17so17776422wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cz0/1ZOfO54oR2U6DPLhE6s49BLA+WlRGKus2Uz7Bfs=;
        b=A4kzq6aK3MU8PNd4Cy6MM9AtUaEz7OChC7pxTVn+dWRwks8+8dKRxsEzgY98KKjuPG
         +DgjsXh5+lw/0IGFjmLkyukjDNCijkCsePiO8AWP1Alz+H9xHlN+pkFYCd+h/lP4Sldw
         NslR9lRh+Lg3OQ5/J1Heyj81CUIsGZ//OEfNc2bvMi64tio1ZZyQl9BeSJHDCr3KG3kK
         qYGlM8ctm4ckmirs53vsz2zB+BOoK201eGbj52PCASR9Iz5Ht0KVkxZr7UJjCZxqBUnv
         NJJlu5TaaV0UTFg2uOkfQFi5/9IYV55JKZwcJAGowg96Z4m3C6uImI3qdGAiJBwfSMll
         aFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cz0/1ZOfO54oR2U6DPLhE6s49BLA+WlRGKus2Uz7Bfs=;
        b=BCVAv/PQXRgHFD6lP4YArfZ4N622wHdxEfTVSusFNFuGlZol2+8bD+WZBeOrYKwX5G
         uIdtP5UQTlWPRTo9aqTGtBzq+tN++dEXYvVNbV2tLAUv8xci7RPV7qGAymRQSQtdG2tT
         5Y1Oq88Iryb99mRvErI+XbnTdSlmy3sq/iAsrziU7JeP38P4BKIILcQ86MARmSulUzPc
         Jhvi6IVtkPKDYLL4BwGRdDjoyBxfLTN/PkCLPB1hUnZ3oVP5f5K97Oz7kiUndLnVnecp
         CBhtBMDeXzSIDzs2OOvYdLk2GdZZV04geggjpRvewLxbrnsDlZmAVsEUMRNIlFM8f3ge
         pTOw==
X-Gm-Message-State: AOAM5322l0FAAWCiLdSVlw5i+0CCXpZNNo9RVa84/9AJxEI4Awag2OK/
        CRsRVivJCbPlz5FvetHaEG4LyBMBzAhkbGHI
X-Google-Smtp-Source: ABdhPJwydengR9TjNPw+zXzBcINPg6RpLDjSqmmkEqNHkwp9baP1lWqBIluKFtAJTmEU5jo689Wc7w==
X-Received: by 2002:a5d:4b89:: with SMTP id b9mr4472110wrt.238.1621519362300;
        Thu, 20 May 2021 07:02:42 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d88a:b479:b222:83bb? ([2a01:e0a:90c:e290:d88a:b479:b222:83bb])
        by smtp.gmail.com with ESMTPSA id s5sm3260428wrw.95.2021.05.20.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 07:02:41 -0700 (PDT)
Subject: Re: [PATCH] clk: meson: g12a: fix gp0 and hifi ranges
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210429090325.60970-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <df839588-1ff2-2d7f-4364-2b0d8942d6ef@baylibre.com>
Date:   Thu, 20 May 2021 16:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429090325.60970-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 11:03, Jerome Brunet wrote:
> While some SoC samples are able to lock with a PLL factor of 55, others
> samples can't. ATM, a minimum of 60 appears to work on all the samples
> I have tried.
> 
> Even with 60, it sometimes takes a long time for the PLL to eventually
> lock. The documentation says that the minimum rate of these PLLs DCO
> should be 3GHz, a factor of 125. Let's use that to be on the safe side.
> 
> With factor range changed, the PLL seems to lock quickly (enough) so far.
> It is still unclear if the range was the only reason for the delay.
> 
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index b080359b4645..a805bac93c11 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -1603,7 +1603,7 @@ static struct clk_regmap g12b_cpub_clk_trace = {
>  };
>  
>  static const struct pll_mult_range g12a_gp0_pll_mult_range = {
> -	.min = 55,
> +	.min = 125,
>  	.max = 255,
>  };
>  
> 


Sorry for bothering with the DSI stuff, I'll fix this when we are ready to upstream DSI support for G12A.

I had this patch for a while in my integration branches, so:
Acked-by: Neil Armstrong <narmstrong@baylibre.com>


Neil

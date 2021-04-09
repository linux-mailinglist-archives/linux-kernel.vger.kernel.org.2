Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C53595C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhDIGr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:47:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52854 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhDIGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:47:53 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1396lOaH013190;
        Fri, 9 Apr 2021 15:47:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1396lOaH013190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617950845;
        bh=3qlAPQ+Wex7yCtbxYfgxiJvo2zY3a2uhCaoULi7lupU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iqGtWaRY/N04oOQyWJA7bSLK7HDW/FC5VF20BuMgJ0Yyz6DkLDNHKFD2MhVmpmZY2
         wYhRiZ8GR1M3FpWxnxNsr5PBGJx66A0wPY+kjB+AtlrajjaSLiKHXPtU8C6n/bMuRX
         NgvN744mTsvR/hEWm3Tm1CunxaGm9F/C1Fc802U0bxDqYjwAska/rWgcz41mDHPGXl
         XTDV+uz2MbefCe3t/N6Q5KWBOQzKs4n9A7deG2m5im71GlGHb7gwS8u52ADIiQdpkq
         86a8XfPMTOMtYFxMnFq4EJ9rm+02rQGCeSRYNZ78Q+oRsK/8HlumKtiu18HAbWBqx4
         6wQeFOXszQXEA==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id g10so2260173plt.8;
        Thu, 08 Apr 2021 23:47:25 -0700 (PDT)
X-Gm-Message-State: AOAM531rkqYVGMZ/9VI67hqGLVcmKbOIByr7Y8B4uKN7WAE3QWdkdIyl
        4Hic3j65fZ98yikYikRShnTTUIMW44kuLotT6Qg=
X-Google-Smtp-Source: ABdhPJy9fFjnUC0a7uXsLzObtUuTxt83kTVyYgo+75uamccOxStRHsnBhz/UJNqTdyxhx6Am4H0+e9/oAwwpEEoVDuQ=
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id
 a9-20020a170902b589b02900e62875aa4cmr11554274pls.71.1617950844298; Thu, 08
 Apr 2021 23:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210407152457.497346-1-colin.king@canonical.com>
In-Reply-To: <20210407152457.497346-1-colin.king@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Apr 2021 15:46:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+JTg5QYYbYqCm+m11X7CF_ZWyYRA4eAtqeTEuHRqoyw@mail.gmail.com>
Message-ID: <CAK7LNAT+JTg5QYYbYqCm+m11X7CF_ZWyYRA4eAtqeTEuHRqoyw@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: Fix potential infinite loop
To:     Colin King <colin.king@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 12:25 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The for-loop iterates with a u8 loop counter i and compares this
> with the loop upper limit of num_parents that is an int type.
> There is a potential infinite loop if num_parents is larger than
> the u8 loop counter. Fix this by making the loop counter the same
> type as num_parents.
>
> Addresses-Coverity: ("Infinite loop")
> Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/uniphier/clk-uniphier-mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
> index 462c84321b2d..ce219e0d2a85 100644
> --- a/drivers/clk/uniphier/clk-uniphier-mux.c
> +++ b/drivers/clk/uniphier/clk-uniphier-mux.c
> @@ -34,7 +34,7 @@ static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
>         int num_parents = clk_hw_get_num_parents(hw);
>         int ret;
>         unsigned int val;
> -       u8 i;
> +       int i;
>
>         ret = regmap_read(mux->regmap, mux->reg, &val);
>         if (ret)
> --
> 2.30.2
>

clk_hw_get_num_parents() returns 'unsigned int', so
I think 'num_parents' should also have been 'unsigned int'.

Maybe, the loop counter 'i' also should be 'unsigned int' then?


-- 
Best Regards
Masahiro Yamada

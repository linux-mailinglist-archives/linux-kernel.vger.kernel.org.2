Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728EB35A5C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhDIS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:29:45 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57815 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhDIS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:29:43 -0400
X-Greylist: delayed 42111 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 14:29:42 EDT
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 139ISwmU005372;
        Sat, 10 Apr 2021 03:28:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 139ISwmU005372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617992938;
        bh=eCHNQxRkz9e15GI5IVdo8WG8vYYPK2jIVucpCRZPvu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wzeCXPVluHCxg3fnohDIUPMXIbzAl1lSWdH+uBypkjqRP1UyjlZ1nKguyxvXBPTdy
         jpdyo3IP10LqjEpvElHHuwzPCbBCq2JNSlgriAFo+utDfUPEONKvZVmDe2Gor5e3A5
         LO+j6mSgWfGxJRmLYELLmBGH7r9lJsy0nWgZyyIr4Uii7Q0R4WW9TFG5HNfY3ySjcR
         ggvVHC8/dEvKlkFisOWsa0n7V5UNn4OGOYSpVh3Qi3PHJ9Y9lofBNvg2noE4/YDHZA
         IcrNv3RN+WAStMxsM2tXmoTxgBRig8uEK67oIYclPL+d2jjCewjt9/eq/9dGgHBp1K
         XcHNOb58ioXYA==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id a85so4346499pfa.0;
        Fri, 09 Apr 2021 11:28:58 -0700 (PDT)
X-Gm-Message-State: AOAM533OjuZ1v87lAJuPySo2F6t/h6YrzK/eYO8ZAs5n9q9yxeYQxfS8
        wClQ0QK0a68DB3ti1ttcsL9qMY2QlZRSwtdZst8=
X-Google-Smtp-Source: ABdhPJx+7CPnY7PSLGsEDahPM2MF01RlsoL9wBaM+MVI/s46yFs+CWjOlD0LDR4VTzqRmJfqkVv6VqDDhNTTx2NFltg=
X-Received: by 2002:aa7:956d:0:b029:1f1:5ba6:2a58 with SMTP id
 x13-20020aa7956d0000b02901f15ba62a58mr13742848pfq.63.1617992937777; Fri, 09
 Apr 2021 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210409090104.629722-1-colin.king@canonical.com> <20210409090104.629722-2-colin.king@canonical.com>
In-Reply-To: <20210409090104.629722-2-colin.king@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Apr 2021 03:28:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=cFxQ3Z3GPdQfwB8DBLDbY9Oxm+yK9cjz116HZ8OKAw@mail.gmail.com>
Message-ID: <CAK7LNAS=cFxQ3Z3GPdQfwB8DBLDbY9Oxm+yK9cjz116HZ8OKAw@mail.gmail.com>
Subject: Re: [PATCH][V2] clk: uniphier: Fix potential infinite loop
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

On Fri, Apr 9, 2021 at 6:01 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The for-loop iterates with a u8 loop counter i and compares this
> with the loop upper limit of num_parents that is an int type.
> There is a potential infinite loop if num_parents is larger than
> the u8 loop counter. Fix this by making the loop counter the same
> type as num_parents.  Also make num_parents an unsigned int to
> match the return type of the call to clk_hw_get_num_parents.
>
> Addresses-Coverity: ("Infinite loop")
> Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>
> V2: Make num_parents an unsigned int to match return type of
>     clk_hw_get_num_parents().

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




> ---
>  drivers/clk/uniphier/clk-uniphier-mux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
> index 462c84321b2d..1998e9d4cfc0 100644
> --- a/drivers/clk/uniphier/clk-uniphier-mux.c
> +++ b/drivers/clk/uniphier/clk-uniphier-mux.c
> @@ -31,10 +31,10 @@ static int uniphier_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
>  {
>         struct uniphier_clk_mux *mux = to_uniphier_clk_mux(hw);
> -       int num_parents = clk_hw_get_num_parents(hw);
> +       unsigned int num_parents = clk_hw_get_num_parents(hw);
>         int ret;
>         unsigned int val;
> -       u8 i;
> +       unsigned int i;
>
>         ret = regmap_read(mux->regmap, mux->reg, &val);
>         if (ret)
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A142638B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhJHEI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhJHEI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:08:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA3C061570;
        Thu,  7 Oct 2021 21:06:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l7so8315340qkk.0;
        Thu, 07 Oct 2021 21:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eds1uKx1Ta5DIgZrwVZW1E2H1xAGnnprww4nAjoMuNQ=;
        b=dlxZ9E3DAndf1Jqf8u0SNq4IM9Fla/Nx7F/iQBSELEt4VFk+RFvloUmkPDkfmjc58D
         3UQc9tyFQW0YB7xO4Pfj+HjUmV9XxcL3FcS/DwfU/hmnuTWzVahdJELXeBizW2mKxe2Y
         UsyuVCbTrBju0Z5WvrNkH8+uE8cq7IsBKTcoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eds1uKx1Ta5DIgZrwVZW1E2H1xAGnnprww4nAjoMuNQ=;
        b=1kKbSsAS5qvS76ay7jMbBILAIGmT68Zlhd1rCJ7kOEO9qjaRUEVqlPt31YcPHKtFmz
         gRyJNOJal8D9WeuZOGpUogGaFDl4iAnr+vCdq9J6om+Ld3vrkHEWVhxop0nLlHDhXj3o
         V6CoXa1S4V8o0jhrYoJN78b94S3qRN8G24gR/44ycpnP+roujOP4MfE2jjCLDbbqR4SO
         oGuBtcAS/O9Ot9rjEK92LEYyPUt7chSghnGOT7SbX/ldwBHVPlwOEo0VtSWXtvmHTPWB
         z3aV+pbttyQ8irhbG76cCR6cwEZCBq2h5NwTwUQkJfhKooiz3lgfocUfmeyvqIFpVkS0
         /vQw==
X-Gm-Message-State: AOAM530q1xDb6K9BvV+lfDRyh+bftiwAJYbFHiPY8JXuIrd019bA5vvF
        YbGGz1gvzvf/udmyEecu/5N9MjCHkGqh12ypEaA=
X-Google-Smtp-Source: ABdhPJznu3ABv7RSdONxccQX/UUI7JIPeuqQhrIpLva+yjYPqtgvaVYDTZueHVAJ+OjiXiqpnVjb/5rpZAT3le1my0s=
X-Received: by 2002:a05:620a:5fd:: with SMTP id z29mr1034088qkg.36.1633665991538;
 Thu, 07 Oct 2021 21:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Oct 2021 04:06:19 +0000
Message-ID: <CACPK8Xct9rWEu40XHWjo_uY9P7dJ=U5LBM+O3KjmjNL+9yD5QQ@mail.gmail.com>
Subject: Re: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sept 2021 at 02:24, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>

A few notes on process:

> v2 -> v3: change else than if to directly else if
> v1 -> v2: add Fixes commit hash

As this is normally information for reviewers to know what you've
changed since the last version, we normally put this below the --- in
the patch, which means it is not included in the commit message.

Also we put a space between the PATCH and v3 in the subject. If you
use the tools, it will generate this for you:

git format-patch -v3 -1 --to=...

>
> AST2600 HPLL calculate formula [SCU200]
> HPLL Numerator(M): have fixed value depend on SCU strap.
> M = SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]

I recommend adding to the commit message the text from my first review:

From the datasheet:

CPU frequency selection
000 1.2GHz
001 1.6GHz
010 1.2GHz
011 1.6GHz
100 800MHz
101 800MHz
110 800MHz
111 800MHz

So when the system is running at 800MHz or 1.6GHz, the value for the
numerator (m) in SCU204 is incorrect, and must be overridden.

>
> if SCU500[10] = 1, M=0x5F.
> else if SCU500[10]=0 & SCU500[8]=1, M=0xBF.
> others (SCU510[10]=0 and SCU510[8]=0)
> depend on SCU200[12:0] (default 0x8F) register setting.
>
> HPLL Denumerator (N) =  SCU200[18:13] (default 0x2)
> HPLL Divider (P)         =      SCU200[22:19] (default 0x0)
>
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 085d0a18b2b6..d30188355aaf 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -169,6 +169,32 @@ static const struct clk_div_table ast2600_div_table[] = {
>  };
>
>  /* For hpll/dpll/epll/mpll */
> +static struct clk_hw *ast2600_calc_hpll(const char *name, u32 val)
> +{
> +       unsigned int mult, div;
> +       u32 hwstrap = readl(scu_g6_base + ASPEED_G6_STRAP1);
> +
> +       if (val & BIT(24)) {
> +               /* Pass through mode */
> +               mult = div = 1;
> +       } else {
> +               /* F = 25Mhz * [(M + 2) / (n + 1)] / (p + 1) */
> +               u32 m = val  & 0x1fff;
> +               u32 n = (val >> 13) & 0x3f;
> +               u32 p = (val >> 19) & 0xf;
> +

Add a comment:

/* If the CPU is running at 800Mhz. */

> +               if (hwstrap & BIT(10))
> +                       m = 0x5F;

/* If the CPU is running at 1600Mhz. */

> +               else if (hwstrap & BIT(8))
> +                       m = 0xBF;


Or you could copy what I suggested in the first patch, and write it
like this, which I think is clear:

ff (hwstrap & BIT(10)) {
    /* CPU running at 800MHz */
   m = 95;
} else if (hwstrap & BIT(10)) {
    /* CPU running at 1.6GHz */
  m  = 191;
} else {
   /* CPU running at 1.2Ghz */
  m = val  & 0x1fff;
}

Please send a v4 with some more comments so we don't need to go back
to the datasheet each time we read this code. Feel free to cut/paste
my suggestion and use it as-is.

Cheers,

Joel

> +
> +               mult = (m + 1) / (n + 1);
> +               div = (p + 1);
> +       }
> +       return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> +                       mult, div);
> +};
> +
>  static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
>  {
>         unsigned int mult, div;
> @@ -716,7 +742,7 @@ static void __init aspeed_g6_cc(struct regmap *map)
>          * and we assume that it is enabled
>          */
>         regmap_read(map, ASPEED_HPLL_PARAM, &val);
> -       aspeed_g6_clk_data->hws[ASPEED_CLK_HPLL] = ast2600_calc_pll("hpll", val);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_HPLL] = ast2600_calc_hpll("hpll", val);
>
>         regmap_read(map, ASPEED_MPLL_PARAM, &val);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_MPLL] = ast2600_calc_pll("mpll", val);
> --
> 2.17.1
>

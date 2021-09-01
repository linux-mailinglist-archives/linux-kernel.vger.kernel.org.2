Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44453FD3FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbhIAGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbhIAGuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:50:35 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B6C061575;
        Tue, 31 Aug 2021 23:49:39 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id hu2so882302qvb.7;
        Tue, 31 Aug 2021 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF2QUGYNk/UkD1ZQTsUHUtqi9ZtfUDLmy6FQwJ9Xq1o=;
        b=Er5kOJRjZ//96PoyyS48kWbV0WRypYwiEPc8M2ZSEYpkxNBD6jhYTjE3t6VGJdjDpy
         qCk6XdUVMMVFBKgSXxy8kUuPvzMGCdXbRVndHNWrYW3feaAnh7pKTs6toAFEVAi/902J
         Pyl5K3lLacBJXEq9O0GYgn3yqIdL3QCn+yPwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF2QUGYNk/UkD1ZQTsUHUtqi9ZtfUDLmy6FQwJ9Xq1o=;
        b=mY89sZL5e/xXQUSnLYcTt8qpaj3TY1s+m6SgYltWN+ooiePAFVAZ8uykrrkN7S8hz5
         xN5WxinKgCNlIqqcxd/Za+uU7M0iJmVT9VBcuPN9gVf3efefIaTOy545zhoQPFcye+k3
         NK9fpHed2WOS47WUTKn88QulWqgSN74l8Lt+q6vKKlS0J0GErp4JMpO+mFgx3fJEd/NO
         hpvJjgd+35My8nmf1jaCKgjVngcWu022EAswPzTqIPp+OA0S2q07Dg59tz9ObEkx04na
         cgl/e0iXNu/+nF9lHwQj42XJ6LZnm1ogRDTQpCQ5VrjtlzdOPwWyAWs17ZcoevP+I+s9
         7AwQ==
X-Gm-Message-State: AOAM531Nh2YKlb4jXjwUgzlUFBN8bBDW2MYvZTUZWWpOg+E0Ycd/IeCr
        I44TzgACvvrM3BWlPA58xKMm0jdmAy3hJsgGgcM+sHYbH+4=
X-Google-Smtp-Source: ABdhPJzGigC7rHVX87sCAatw+9KiuQQpWlXPGNhIPObeVyKiNC6aVhtwUPdTrb0W0hgtHeP199ticfi4INaBpJIenLs=
X-Received: by 2002:a0c:b356:: with SMTP id a22mr33128034qvf.7.1630478978567;
 Tue, 31 Aug 2021 23:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com> <20210818080518.9491-2-ryan_chen@aspeedtech.com>
In-Reply-To: <20210818080518.9491-2-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Sep 2021 06:49:26 +0000
Message-ID: <CACPK8XfrR-m6HOx5VOQ1-AVf0r9-0BKsr019D7T6y9Qd4qL9gA@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     BMC-SW <bmc-sw@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ryan,

Thanks for the patch. I have some questions about it below.

On Wed, 18 Aug 2021 at 08:05, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> AST2600 HPLL calculate formula [SCU200]
> HPLL Numerator(M): have fixed value depend on SCU strap.
> M = SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]

I see from the datasheet:

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
numerator (m) in SCU204 is incorrect, and must be overridden?

> if SCU500[10] = 1, M=0x5F.
> else if SCU500[10]=0 & SCU500[8]=1, M=0xBF.
> others (SCU510[10]=0 and SCU510[8]=0)
> depend on SCU200[12:0] (default 0x8F) register setting.
>
> HPLL Denumerator (N) =  SCU200[18:13] (default 0x2)
> HPLL Divider (P)         =      SCU200[22:19] (default 0x0)

Is this the case for all revisions of the soc, from A0 through to A3?

Do you have a datasheet update that captures this information?

When you resend, please add a fixes line as follows, as this code has
been present since we introduced the driver:

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 085d0a18b2b6..5d8c46bcf237 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -169,6 +169,33 @@ static const struct clk_div_table ast2600_div_table[] = {
>  };
>
>  /* For hpll/dpll/epll/mpll */

This comment needs to stay with ast2600_calc_pll, and just drop hpll
from the list.

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
> +               if (hwstrap & BIT(10))

So this is testing if the CPU is running at 800Mhz.

> +                       m = 0x5F;
> +               else {
> +                       if (hwstrap & BIT(8))

And this is testing if the CPU is running at 1.6GHz.

I would write it like this:

u32 m;

if (hwstrap & BIT(10)) {
    /* CPU running at 800MHz */
   m = 95;
} else if (hwstrap & BIT(10)) {
    /* CPU running at 1.6GHz */
  m  = 191;
} else {
   /* CPU running at 1.2Ghz */
  m = val  & 0x1fff;
}

Cheers,

Joel

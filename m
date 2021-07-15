Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1933C9A68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhGOIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhGOIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:22:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F6C06175F;
        Thu, 15 Jul 2021 01:19:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso3501671pjp.5;
        Thu, 15 Jul 2021 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1r2M9qlATX1/79jz2l+ymskeoXA9h+PcZ2ca6/n34o=;
        b=jtgMOGkqqw+vOJ+t3+o3wTS+9Z1k34ju3mvZxn/7HxptmbXYo6xcg2QlTpwajGlDAY
         FJkqGOzWEsaqGcT+yELG8R0oqZLrqAxZ29tfgk0dfmUm/tBYQclFDuXmNZM4ILIVO1Jc
         e3oDGXGjEXq7SJ5igFusO/AJ7vK00Tg54CBPGoUP1bwh1HthlNNQPsUTC/bsyhiViUy1
         kn0SIKkcCA930T0Ad6XwqhxS8GBtuZ4vJQzsSoL6G8FuolDx/+StFxKzkzXZbWws1YY3
         flEA9JCqYo710jMKWSSKAo53VJaxzAY+ZJnCzx5AnszC5r0Rbnt0joRJVKEFZsilLrsI
         LpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1r2M9qlATX1/79jz2l+ymskeoXA9h+PcZ2ca6/n34o=;
        b=rDN8nkfCdATTlj1au9XwXGCrgDMg+njKL8TUlRYnSIMqVIpKRpTMSAN2Q0zHIy7EbA
         YZC7nttxP4/vR1y2SRn5/zvTS7B9Abmk2fbQpENajTyWs/5fL/B17t1pTwb+G/Gvm7fy
         vTtseKLTVg/SIm6MRYts8RW0ahhIqQP9tmMd7N1j/9Yu4RKaUKyGTT6Wgg9gCOIAJM1E
         S0ryUyPDwfztDJlZMapKqQkdcD4EmqmXsxtQgkoJ16jNxvizPa8fnrxQp3wHkQSswkc1
         Hc+AXo1P1aowOtY4xia8kzNvx2VXgUOnAb+oI5qz4SEk6KNcP80UpT7NRPCK6hwQi5en
         tnSg==
X-Gm-Message-State: AOAM530KARH67U4u/kJnxoxEbYcK8X9LWHzv0k5kwpdBa5xSxeIl/LTY
        w72cHrI0dxKUxnUXH4BRlr85Fnky+kFsPm02v9c=
X-Google-Smtp-Source: ABdhPJyLs62FEQsWmboMufwHaDM87ewRCz7YqxGw6FoE9mG97+g+11egQHlwwH5gHoZyuVrpIQFss5f6PkHLcOx6g24=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr4153360pjb.181.1626337189528;
 Thu, 15 Jul 2021 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210714064129.1321277-1-victor.liu@nxp.com> <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
 <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com> <YO6+nkzDlNM/KJio@smile.fi.intel.com>
 <YO7AcaHyB8js9FJg@smile.fi.intel.com> <0ae047e216298e6239e39ec40a2d545ac07a7406.camel@nxp.com>
 <CAHp75VfHuBJAYqms0tx_y3qjFfJJ_ynCOkbeYchBY0CvDJBp=Q@mail.gmail.com> <CAHp75VfFx4eDF484QKXgB=rhu3AptnDvX+2C+qd+U_3atfjnjQ@mail.gmail.com>
In-Reply-To: <CAHp75VfFx4eDF484QKXgB=rhu3AptnDvX+2C+qd+U_3atfjnjQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 11:19:13 +0300
Message-ID: <CAHp75VchZmbd4BquLGnCAfvNVE-8dRoUULnWUFTJjNAiLnHHBA@mail.gmail.com>
Subject: Re: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed
 over to rational_best_approximation()
To:     Liu Ying <victor.liu@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Mauro (below Q about sphinx and docs)

On Thu, Jul 15, 2021 at 11:14 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jul 15, 2021 at 11:02 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> Now I realize one more item which is missed in the big picture.
> When we have overflowed the denominator (n) and shifted the values, we
> are expecting that the caller will check the rate and use another
> 2^scale (see (6) below) prescaler if needed to drop frequency to the
> needed values. The first few users of this were the drivers of the IPs
> which have an additional prescaler themselves. I dunno if there is any
> flag in CCF to show that the set frequency is 2^scale higher than
> asked.
>
> It means if
>
>         r_o / r_u >> N_lim (5)
>
> we will get m and n *saturated* without this snipped, while with it
> they will be much much better with a nuance that resulting frequency
> is shifted left by
>
>         scale = ln2(r_o/r_u) - nlim (6)
>
> scale bits.

I think I have at some point to introduce a documentation and explain
all this from the thread there.

Mauro, is sphinx capable of producing TeX formulas?

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EABD3617D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhDPCy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:54:29 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:33135 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhDPCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:54:27 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 13G2rj5v020114;
        Fri, 16 Apr 2021 11:53:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 13G2rj5v020114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618541625;
        bh=C3o2fuGogysZj6JUvfMYyt2JuWyfL7NiiLTCUac1I+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eonCGiJQHsqpZ/iYfUV6r6YN4izdBpsXxeIWZewDQj+SgmwL66MGogDS/0R8HX2TI
         uqle9ZeL/Luag8A7Jf/+ae5slrDcOZiq9kId4oPQ2Ckklykl/Di4ZAyLIudBcAZV9O
         kQs4NbltQxQzG1ym0cPTIIORZuwETzHzgQReiE0wZjI4f6d/lGSPM72idliwRpcXQC
         atM6SOmnp8kqIOmhSA1Ol7biYW0P9dCX2PR4xUUkFpPQ1wT9ttzavICvOKySP6+hKu
         zZ6j3IxAnWfTjAa5wjbjh7YkRK2g5fVgYotFhrWvtDveEXJUMOHSWXPoGxwy0ztptf
         U6GnkrKNg6cMA==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id b17so18262094pgh.7;
        Thu, 15 Apr 2021 19:53:45 -0700 (PDT)
X-Gm-Message-State: AOAM533OqOBJ+KKL1TLWlq23fMsmMMlA8f+GOPGwFhRF0GQW8yfK9LBv
        bRrF01VOrnAK85T8WEDCnyGaRGXGWDZ6LakK5a8=
X-Google-Smtp-Source: ABdhPJye0T0Zqs/E4nSVHtl6qDvrTFn2swAHtiCk0RlhR0STxhUMS97/R14pGv5lOTA2CMcjQdgANBZlVex2nBHNDJA=
X-Received: by 2002:a05:6a00:2303:b029:249:b91e:72f0 with SMTP id
 h3-20020a056a002303b0290249b91e72f0mr5935536pfh.80.1618541624454; Thu, 15 Apr
 2021 19:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210407152457.497346-1-colin.king@canonical.com>
 <CAK7LNAT+JTg5QYYbYqCm+m11X7CF_ZWyYRA4eAtqeTEuHRqoyw@mail.gmail.com> <20210415181850.GD6021@kadam>
In-Reply-To: <20210415181850.GD6021@kadam>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 16 Apr 2021 11:53:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATySocPRr4BdaKr5_GZ=G4tQYgPQEDe0piiTS_qiWawkA@mail.gmail.com>
Message-ID: <CAK7LNATySocPRr4BdaKr5_GZ=G4tQYgPQEDe0piiTS_qiWawkA@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: Fix potential infinite loop
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 3:19 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Apr 09, 2021 at 03:46:47PM +0900, Masahiro Yamada wrote:
> > On Thu, Apr 8, 2021 at 12:25 AM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > The for-loop iterates with a u8 loop counter i and compares this
> > > with the loop upper limit of num_parents that is an int type.
> > > There is a potential infinite loop if num_parents is larger than
> > > the u8 loop counter. Fix this by making the loop counter the same
> > > type as num_parents.
> > >
> > > Addresses-Coverity: ("Infinite loop")
> > > Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/clk/uniphier/clk-uniphier-mux.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
> > > index 462c84321b2d..ce219e0d2a85 100644
> > > --- a/drivers/clk/uniphier/clk-uniphier-mux.c
> > > +++ b/drivers/clk/uniphier/clk-uniphier-mux.c
> > > @@ -34,7 +34,7 @@ static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
> > >         int num_parents = clk_hw_get_num_parents(hw);
> > >         int ret;
> > >         unsigned int val;
> > > -       u8 i;
> > > +       int i;
> > >
> > >         ret = regmap_read(mux->regmap, mux->reg, &val);
> > >         if (ret)
> > > --
> > > 2.30.2
> > >
> >
> > clk_hw_get_num_parents() returns 'unsigned int', so
> > I think 'num_parents' should also have been 'unsigned int'.
> >
> > Maybe, the loop counter 'i' also should be 'unsigned int' then?
>
> The clk_hw_get_num_parents() function returns 0-255 so the original code
> works fine.

True.  clk->core->num_parents is u8,
but it is not clear just by looking at the
prototype of clk_hw_get_num_parents().

At least, it is not clear enough for tools,
and actually Coverity raised a flag.


Personally, I prefer 'unsigned int' (or 'int')
when I count the number of something.
Historically, the clk subsystem uses u8,
(maybe to save memory??), and there exists
distortion.

For example, the return type of
uniphier_clk_mux_get_parent() is u8,
but it actually returns -EINVAL for error cases.

So, u8 is not wide enough, in my opinion.



>
> It should basically always be "int i;"  That's the safest assumption.
> There are other case where it has to be size_t but in those cases I
> think people should call the list iterator something else instead of "i"
> like "size_t pg_idx;".
>
> Making everthing u32 causes more bugs than it prevents.  Signedness bugs
> with comparing to zero, type promotion bugs, or subtraction bugs where
> subtracting wraps to a high value.  It's rare to loop more than INT_MAX
> times in the kernel.  When we do need to count about 2 million then
> we're probably not going to stop counting at 4 million, we're going to
> go to 10 million or higher so size_t is more appropriate than u32.
>
> Btw, if you have a loop that does:
>
>         for (i = 0; i < UINT_MAX; i++) {
>
> that loop works exactly the same if "i" is an int or if it's a u32
> because of type promotion.

You are right.

Perhaps, in hindsight, the following were natural:


   unsigned int num_parents = clk_hw_get_num_parents(hw);
   ...
   int i;


I am fine with this if it is not too late.
But, Stephen has already picked up this patch.





>  So you have to look really hard to find a
> place where changing a loop iterator from int to u32 fixes bug in real
> life.
>
> regards,
> dan carpenter



-- 
Best Regards
Masahiro Yamada

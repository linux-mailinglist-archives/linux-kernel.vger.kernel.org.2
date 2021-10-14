Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC65942D912
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhJNMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:13:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8305FC061570;
        Thu, 14 Oct 2021 05:11:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so23247988edv.12;
        Thu, 14 Oct 2021 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjunbPmLmTCHaDr1XFmiTYq62IyZTicb7wJjyiRmRZA=;
        b=k1g+ewsT6tZT2k2DdXFuBV0VAEJGyoHMGjBtx7czRNjnlPd/iszs9Aq/bkgzSrBQfa
         SOqtaUQ4uJrIubsrV6GCgYJo9KIi3OidljseX927z53EparhoxN72stIaB6KMiq2qd05
         tGcDgySBBWS3uClbplw13TlwP2H9LYQUTRQwQYGWikyi8X5QqgiK0BZlYzrUTJlRFFoF
         +/66BaVVku+6EnxMnFqmspWmFZe5nxz9P5qFTPu1uc9SYqukZyFZcfDXpJ7msHkYsN7v
         nPbzVwV6znvHtPvqm+zRCGBTwkp/E8JylSYrwAlfSsFXgzltDPDi4HXOnuJI6D2Tww+r
         x9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjunbPmLmTCHaDr1XFmiTYq62IyZTicb7wJjyiRmRZA=;
        b=X2x3Nl/SCbDdnQpcgrhcW4bd6TTqeU6mOmxXeOBhm0F06Ah16FlRdFEKpoMpkmd27O
         5yzZznzEuKTUiGM0JWTj3hiV17wmvUftAtsFLWWI82A9fWxn8SSGUQU7FqXqWUFzYiZG
         iWlWxG3fxCJkIuatcsa6mR1Bh14jUpALPEA5hY3f1D3aLqIUI/drnStxZr4ocshP8hQQ
         X0UvPU4pZEHhmQhWR/3xY/KLoX0O2Oe7nYzh9t4L/azXA/esDWE7XzsdcjJ4TNU3kO3v
         mwA0dN2l7z9h9X70vXZaJO4AsYyI0y8PmSpy6wRODCcmSQg/JLNOCzX81i484O1DM+Tm
         8zxw==
X-Gm-Message-State: AOAM530ctb+oFIL5LVaXiC7gCGSRApCmMGc/pQo8ocuxeiIpxjPl9VQS
        Wz6NttkL0nmWIPAI1qdkUJ3FQu73s8R9FxshKBrrYPJnyUg=
X-Google-Smtp-Source: ABdhPJx5EU+lmleEWQbrw1JraAtpjBxu2zDOu7TUNMfV09yvsoCuePUhiHL65M9Jh8js7gQxOyToclWUSYEw2GFi+xA=
X-Received: by 2002:a05:6402:3186:: with SMTP id di6mr8028114edb.225.1634213508002;
 Thu, 14 Oct 2021 05:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-2-martin.blumenstingl@googlemail.com> <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com>
In-Reply-To: <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 14 Oct 2021 14:11:37 +0200
Message-ID: <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up
 .determine_rate by default
To:     Alex Bee <knaerzche@gmail.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Oct 14, 2021 at 11:55 AM Alex Bee <knaerzche@gmail.com> wrote:
[...]
> This breaks lot of clocks for Rockchip which intensively uses
> composites,  i.e. those clocks will always stay at the initial parent,
> which in some cases  is the XTAL clock and I strongly guess it is the
> same for other platforms,  which use composite clocks having more than
> one parent (e.g. mediatek, ti ...)
Sorry for that and thanks for bisecting this!

> Example (RK3399)
> clk_sdio is set (initialized) with XTAL (24 MHz) as parent in u-boot.
> It will always stay at this parent, even if the mmc driver sets a rate
> of  200 MHz (fails, as the nature of things), which should switch it to
> any of its possible parent PLLs defined in
> mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p (see clk-rk3399.c)  - which
> never happens.
My question to Stephen et. al. is: where is the correct place to solve this?
What I came up with so far (in no particular order):
1) not using clk-composite from clock drivers and letting CCF take
care of re-parenting clocks as needed (and as specified with
CLK_SET_RATE_NO_REPARENT)
2) clk-composite.c: extending the logic so "rate" clocks with
.determine_rate include the existing logic which only applies to
.round_rate (which means clk-composite.c is then responsible for
finding the best possible parent clock)
3) clk-divider.c: extending the logic here to account for clk_hws with
multiple parents

For 3) I am wondering whether this would even work because it seems
that clk-composite uses multiple struct clk_hw.
Letting the divider handle multiple parents means it would need to
know about the information which is only available in mux_hw - whereas
clk-composite currently passes rate_hw (struct clk_hw for the
divider).

I am happy to work on a patch for this if I can get some help with
testing (since I don't have any board with Rockchip SoC).

> Reverting this commit makes it work again: Unless there is a quick and
> obvious fix for that, I guess this should be done for 5.15 - even if the
> real issue is somewhere else.
Reverting this patch is fine from the Amlogic SoC point of view.
The main goal was to clean up / improve the CCF code.
Nothing (that I am aware of) is going to break in Amlogic land if we
revert this.



Best regards,
Martin

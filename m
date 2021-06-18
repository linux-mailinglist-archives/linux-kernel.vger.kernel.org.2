Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA793ACD87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhFROdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFROdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:33:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:31:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y7so10959078wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=YSr1xCzITLF/CWHeqxDLjzvl354aJ3tXZwCogE8rb8c=;
        b=Jgi1NBFwn0O29BGpktjuEhMh7FpWKz1Q4Sy067SvtCk0yg7PmyHMl5/4VuN8azjOhX
         1Bykr3U62EdMum+0t1GEO72SZ7zqhTGWgTHbplhglmDwm4E9UhGfqfuyMVfgEQdJ9uCb
         M7DWIL+SCoFnw8xPYyBzp3dbqpSjKAWMNbI3MtZ4rGgnWpTE6Znr6cuVPwXdk9tFoi0q
         v2Yq0VK40fae8TqVeN7V1dx8YHyI7dAV0JP138Xxr1chO+XjcHBkK1oEUiAhtr+yHIGo
         zXQeywxUJ6W31/CCW59z7k5Y3ZDlAXp7uIcj6+mD1cVnFjPcy8LSABNDTROB9xv/hq0F
         1rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=YSr1xCzITLF/CWHeqxDLjzvl354aJ3tXZwCogE8rb8c=;
        b=t7FT1DhQgRCnLnerQymLdcrFGcoI04C5+bjZysPQqQTSMQXEY/Q6UEExyPT5BcVOHD
         vrsiaOdpmABTLm+Po34cdH+djdM4jhOkztEUn2oG97Tuy2WaEvvsHQpbCb19fku166ES
         IuxyjHfCcflnbGwGBAVO6SdMR07YNBiXk2jajv/BZTwD7AN6CIsCT2N2SVkFKEfgkXiu
         8+z3A/96wOH0IlrebsJKmSdH42/zecvROWR6qLgrPCRRDyhOoWlhorC+VxuOcfMjT/uE
         YYEvYFVYrzldoTWMl0eQPK/H3UcULVXpCvGFWp+IlSGpeCT8iYGWqQxbheLI6Vl1qTi0
         90wA==
X-Gm-Message-State: AOAM530Tax70HP8PL0RUMjUEd7+Vp8QuCaKdLpleYlx4HKpjMaTOhpln
        qmPfqGfTNuUxA5zbI8OSppbEBw==
X-Google-Smtp-Source: ABdhPJx7b+KubVPotYb5zFb9dnK6xuStWlWjPKSZltgOK+Gz/00RhyjwEQp2L4Cr0tMdkIP713jz1g==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr2019653wrq.269.1624026660412;
        Fri, 18 Jun 2021 07:31:00 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id v18sm9157091wrb.10.2021.06.18.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:31:00 -0700 (PDT)
References: <20210528113403.5374-1-peng.fan@oss.nxp.com>
 <162262192433.4130789.1017942859005253343@swboyd.mtv.corp.google.com>
 <a5833012-3e86-5be0-71f2-de4d9b32a152@pengutronix.de>
 <1j1r9kobln.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, mturquette@baylibre.com
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] clk: support regmap
In-reply-to: <1j1r9kobln.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jzgvnfdng.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 18 Jun 2021 16:30:59 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 02 Jun 2021 at 11:32, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Wed 02 Jun 2021 at 10:21, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
>> On 6/2/21 10:18 AM, Stephen Boyd wrote:
>>> Quoting Peng Fan (OSS) (2021-05-28 04:34:00)
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> To i.MX8ULP, a PCC register provides clk(mux, gate, divider) and peripheral
>>>> reset functionality, so we need make sure the access to the PCC register
>>>> be protected to avoid concurrent access from clk and reset subsystem.
>>>>
>>>> So let's use regmap here.
>>>>
>>>> The i.MX specific code will be posted if this patchset is ok for you.
>>> 
>>> We have a couple regmap clk drivers in the tree. Either combine the
>>> different regmap clk drivers or duplicate it into the imx directory. I'd
>>> prefer we combine them but last time I couldn't agree on the approach
>>> when Jerome wanted to do it. Maybe now is the time to combine them all
>>> into one common piece of code.
>>
>> IMHO for the basic drivers, such as gate, divider, mux, mux-div, etc... it makes
>> no sense to have them in an arch specific subdir, like meson.
>
> Indeed, those basic types were not meant to remain platform
> specific. Some framework (ASoC for ex) make heavy use of regmap and
> could welcome regmap based basic clock types.
>
> At the time, Stephen (qcom) and I (meson) had slightly different
> approaches. Before having those types spread through the kernel, I think
> testing things out was a good thing ... this is why these are platform
> specific ATM.
>
> It's been 3 years now ... and it has not been a total disaster :)
>
> In the end things are not so different. Let's compare:
> a. Both have a generic "clk_regmap" type common to all regmap based
>   types. This is very useful to easily fix the regmap pointer in static
>   clocks (which are heavily used by both platform)
>
> b. Meson uses a generic pointer to store the type specific info.
>   Qcom embeds the generic clk_regmap into the specific type one.
>   => In the end, I don't see any advantage to the meson
>   approach. Switching to the qcom method would be quite a big bang
>   for meson but it is doable (nothing difficult, just a huge line count)
>   
> c. Qcom basic regmap type deviates a bit from the regular basic ones
>   when it comes to the actual data. The qcom "clk_regmap" also provides
>   the gate, mux have the qcom "parent_map". In meson, I tried to keep as
>   close as possible to regular basic types ... at least what they were 3
>   years ago. Only the register poking part should be different actually.
>   => I'd be in favor of keeping close to meson here.
>
> A possible plan could be:
> 1. Rework meson as explained in [b] above.
> 2. reword types in qcom where necessary to avoid name clashes (add
>    "_qcom" extension for ex)
> 3. Move the clk_regmap implementation out of meson to drivers/clk
> 4. Things are yours to play with ...
>
> I can take care of 1. and 3. I would welcome help for 2. especially since
> I won't be able to test it.
>

Hi Stephen,

What do you think of the proposition above ?
There rework is going to take some time to do. I'll start only if this
OK with you.

Cheers
Jerome

>>
>> regards,
>> Marc


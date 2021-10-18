Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C343B4317B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJRLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJRLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:47:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C175C06161C;
        Mon, 18 Oct 2021 04:44:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y30so51944616edi.0;
        Mon, 18 Oct 2021 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEsxZ3O1mk7PChv7vz5Z0iqmE+aipOaKaFUC4ugt0HI=;
        b=PmN8QFKOKioU2foRHAA5okAAN5N4bMfte+owkgFjLKehpAIrYtSHCWcxS080oOE9I5
         5k/9tfxdRDiQEoBRjoG80KbZRaW4uPJ9yZzP4/Ym3DEYQWUGT1wM5DesLZW6lzavmHfR
         sa9H0B2Yum/I18d0n2PIZ04I6+jMbv99xi3YJN+LJv9uA/zbk8JtXu7hp2ymGPL5TPVm
         Q5MAE9zyjbPEQ4uNmECrpPewu5we/x5Syuo3xtCH2mgpCW0WEYYhyIp4k38QzjABPJ24
         jVRYK4bWlYXiWLwzAca1JLt6SRJITPQFS9YOgfYDviu0Boi83TJuv5ZfpVgYkKrmMCRh
         M3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEsxZ3O1mk7PChv7vz5Z0iqmE+aipOaKaFUC4ugt0HI=;
        b=h5ulqNl5e4m0j8VfLjJXHAO4/4EdYzMto5OpmbaU5ziFj9aAMv5yxbJAgnnnTgK8K1
         WV+4MzvkVzPDYuuxETCwa+GVaNNM2SfuRF982E792p/Z7mOqNg79pVp7YipynG6XihTj
         bmNtU5DwvjLHIGXBJjd9MZff57SACEFVqhGq8e1/zCSe67gRRgGtu4357VXMVzCk883z
         WM2V6FtOIjLcaVlngQlOkVHtb8rn0l2QW+xvwxEjLaus63PRocuXktS99qjFR5O5PyuP
         /i1bRm0KnEgxKSCTJHsWb94H0mhviu8s6gc6hjKfqWBzChwPUIjogSg1orefUcXW89bS
         x3aQ==
X-Gm-Message-State: AOAM530N8bFSBMkKSwDDkDmlTkNSOkWRQdo2bt3sEHzZTLUGdg/ONjhf
        wtpkJM+dhc/UuCxFVa7ckfKk2FN/mTtfjHkpLhyG5xKuZws=
X-Google-Smtp-Source: ABdhPJw0zF+HiS1YmJukOua82SZK7pUVcvH3fPcFCdBlxV/8b282W9eA+SQY/dem5eqHXs3ukpIm4qt25lwuQpy1x3o=
X-Received: by 2002:a17:906:f2cd:: with SMTP id gz13mr28303283ejb.278.1634557486136;
 Mon, 18 Oct 2021 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211016145939.15643-1-martin.blumenstingl@googlemail.com> <1j5ytuvdmw.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j5ytuvdmw.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Oct 2021 13:44:35 +0200
Message-ID: <CAFBinCBGZi3MRqTRshyCkq8AAaqHi2NkZVV80ppZr4Lx=xWOWA@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0
 on GXBB
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Oct 18, 2021 at 12:19 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sat 16 Oct 2021 at 16:59, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Christian reports that 48kHz audio does not work on his WeTek Play 2
> > (which uses a GXBB SoC), while 44.1kHz audio works fine on the same
> > board. He also reports that 48kHz audio works on GXL and GXM SoCs,
> > which are using an (almost) identical AIU (audio controller).
>
> The above is a bit "personal" - it is not great fit for the commit
> description. Please rephrase or put it in comment section bellow
sure, I can rephrase that

[...]
> > Add the SSEN (spread spectrum enable) bit and add the
> > CLK_MESON_MPLL_SPREAD_SPECTRUM flag to enable this bit for MPLL0. Do
> > this for GXBB *only* since GXL doesn't seem to care if this bit is set
> > or not, meaning that meson-clk-msr always sees (approximately) the same
> > frequency as common clock framework.
>
>  1 - it is odd that we need to poke a bit in the register related to the
>  fixed PLL but ok ...
>  2 - 3.14 does yes, 4.9 does not soooo ... no real proof there
The fact that 4.9 doesn't do it is also no proof for anything either.
Amlogic hasn't ported forward GXBB support to their 4.9 kernel. Even
"mesongxbb.dtsi" is missing there [0]
So in my opinion the code from Amlogic's patched 4.9 kernel cannot be
used as reference for anything GXBB related. Only the 3.14 code can be
used as reference.

[...]
> So 2 things:
>  - If this bit really enables spread spectrum on MPLL0 (or worse, the
>  Fixed PLL) - checking clk measure is not enough. It is just a mean of
>  the rate seen by the SoC itself. You would not see the effect of the
>  spread spectrum here ... you need to capture the clock output with a
>  scope for that.
I suspect that a board with pin headers is needed to route the signal there?
Personally I don't have any GXBB board(s).

>  - Or the bit is incorrectly documented (or DDS0_SSEN does not mean
>  spread spectrum). If it is not a spread spectrum function, then this
>  patch seems to indicate it is and it is misleading.
>
> Either way, I'm not OK with it.
>
> To me, the rate drop that happens when you flip this bit looks more like
> the effect SDM_EN should have.
>
> Could you check the internal values (n2 and sdm) compare this to the
> output rate you actually get ? see if this leads to anything ? does
> SDM_EN really has an effect on this MPLL ? it is a combination of both ?
Christian has provided a dump of the HHI registers (via userspace,
regmap makes them accessible).
On GXBB WP2 HHI_MPLL_CNTL7 is set to 0x0006f208
On GXL Le Potato (which he used for comparison as it wasn't affected
by the MPLL0 issue) HHI_MPLL_CNTL7 is set to 0x0006b208

If you're interested in the full HHI register dump you can find it here: [1]
GXBB WP2 is on the left and GXL Le Potato is on the right.

The difference here is BIT(14). un-setting BIT(14) (documented as
EN_DDS0) did not change anything according to Christian's test.
That also means that SDM, SDM_EN and N2 have the expected values.
I manually did the maths:
(2000000000Hz * 16384) / ((16384 * 6) + 12808) = 294909640.7Hz
which matches what clk_summary sees:
294909641Hz

Just to clarify that I am not wasting Christian's time when I ask him
to test something:
next up we'll set SDM_EN to 0 (instead of 1) and see the reaction using clk-msr?


Best regards,
Martin


[0] https://github.com/hardkernel/linux/tree/db88db3864c5d6903fb11f6528874887d1c473ce/arch/arm64/boot/dts/amlogic
[1] https://pastebin.com/raw/1cjPFsfa

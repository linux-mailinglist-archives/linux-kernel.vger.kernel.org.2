Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595BC3B97D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhGAVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhGAVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:00:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E85C061762;
        Thu,  1 Jul 2021 13:57:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so10336890eds.1;
        Thu, 01 Jul 2021 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VP2Ta3q4Jb5bQwDLseeiEQMAjQJRQEWeQWwTkmKx76w=;
        b=oFhKI2MluGQ+1JEDG+4WRkFCVYSvgWmO2VdGPZACvIvnMtFoBQgspl2ad58ZMjJV+W
         ETLgvMSdz/PERb15fCCBpqIZedtpqGW0INO/6KtOcswUhQRRPkbC6dwdUgvdikgiGmTx
         koMzO50VYzCzdm70ANUenku2hdL3KQZuyqEo7Anzl1oHy5ZhsiVyCnPZ9GXdmp4z2Zk0
         s4Z3c7XoW+QEMEvEEPKLCXiZk7kZOjJ9tKt/ag2ZGCPA2SJzR6MVokWbMY24BXMDfPUe
         D1lPAOqzBqNk2eMIT0UEDZP8askASHnnoUqlNqrsmlqn+MJLkO2KBwMcdiGPoQNo3RAz
         Rsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VP2Ta3q4Jb5bQwDLseeiEQMAjQJRQEWeQWwTkmKx76w=;
        b=qvcZTF7iaVzQt+ddzM697P5KvVM4iOQFp8vy3rQVGtjm+zarsYjvm3MHC+xNfA8Krj
         LRzf2rNOo9Tao1DKV53+nnDk/07yOdynP8g6xOqKIKJTxyAxFJIFAF5cGTjdN8arM9nl
         MnQFQMcphEhq9Cky2xDvBtAQ32ubj3vcSwZZI3dCd7E58ilUQ3H8HTVdlpmYR+R/9ONa
         ghUWSEeJnjZt4DigKQTVy1/VWP/wKdYA+hK8Fc4t/IDqRfjydESkD+9q0VtR0eflMAVY
         fYXtA7KhwwDKbW0SM3rkJ1YgXyo4dQN4lGMkf9RhnQ5kp64Vmoj+KIiWy+2d4p2WRJ3F
         0kfA==
X-Gm-Message-State: AOAM530kZeQ1Vzl4GaFsWZg8VEuSiWPUGg5QFbtg4SUGtsUh8QCW1U0L
        nztKdrfFg9Pimcm6pxprL0oeFhpAzg9iWD+Dw5uiowqN7l4=
X-Google-Smtp-Source: ABdhPJz058h3NcfrAlPBkFZPCdJ8Yg2KK8FXz3FF0CRf4Elqcwf033TfCCNu9O9waMMBHAjYk8tHzNXd+/uDHMhwPJE=
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr2238223edd.179.1625173059565;
 Thu, 01 Jul 2021 13:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
 <20210627223959.188139-3-martin.blumenstingl@googlemail.com> <20210701202540.GA1085600@roeck-us.net>
In-Reply-To: <20210701202540.GA1085600@roeck-us.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Jul 2021 22:57:28 +0200
Message-ID: <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, Jul 1, 2021 at 10:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
[...]
> [    0.000000] [<c07be330>] (clk_core_determine_round_nolock) from [<c07c5480>] (clk_core_set_rate_nolock+0x184/0x294)
> [    0.000000] [<c07c5480>] (clk_core_set_rate_nolock) from [<c07c55c0>] (clk_set_rate+0x30/0x64)
> [    0.000000] [<c07c55c0>] (clk_set_rate) from [<c163c310>] (imx6ul_clocks_init+0x2798/0x2a44)
> [    0.000000] [<c163c310>] (imx6ul_clocks_init) from [<c162a4e4>] (of_clk_init+0x180/0x26c)
> [    0.000000] [<c162a4e4>] (of_clk_init) from [<c1604d34>] (time_init+0x20/0x30)
> [    0.000000] [<c1604d34>] (time_init) from [<c1600e0c>] (start_kernel+0x4c8/0x6cc)
> [    0.000000] [<c1600e0c>] (start_kernel) from [<00000000>] (0x0)
> [    0.000000] Code: bad PC value
> [    0.000000] ---[ end trace 7009a0f298fd39e9 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>
> Bisct points to this patch as culprit. Reverting it fixes the problem.
sorry for breaking imx6 - and at the same time: thanks for reporting this!

Do you have some additional information about this crash (which clock
this relates to, file and line number, etc.)?
I am struggling to understand the cause of this NULL dereference
My patch doesn't change the clk_core_determine_round_nolock()
implementation and the new determine_rate code-path (inside that
function) doesn't seem to be more fragile in terms of NULL values
compared to the round_rate code-path.
Instead I think it's more likely that the problem is somewhere within
clk_divider_determine_rate() (or in any helper function it uses), but
that doesn't show up in the trace

I don't have any imx6 board myself and so far I am unable to reproduce
this crash on any hardware I have.
However, if it's a problem in my clk-divider.c changes then I'd like
to find the cause (ASAP) because possibly more SoCs may be broken...


Best regards,
Martin

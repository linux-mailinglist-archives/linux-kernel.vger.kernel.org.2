Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7123F44BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 07:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHWF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhHWF4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 01:56:11 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CD1C061575;
        Sun, 22 Aug 2021 22:55:29 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id e9so10345899vst.6;
        Sun, 22 Aug 2021 22:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMw/3kI8eARoe7WvfrrHdgvyGXgR3UzQdKK0JiaKTgE=;
        b=IHsmwzfa7Hwqu2vy9ogbqC8qGaTJGPmBfVh5w7fUKbWv1sOQ3QdWqGCiVDRKeEAX25
         gdaKP9hUZ+uh02j9cpAIOliAqSTwjb4bZLO0cGY9D5LZnfGQg4SlAmmp33U2YTFpbup+
         hvL4xVqsOUkoiq0PFd12GgYvkzeX6kaTSUAmDHbiab865d4n9myeY+KtRoSK01p7U2yz
         ADutriU1GxWiTIxLOqEZvFQ9+fUFASfnkjiwDtgPPxiJ9KWG9joRGzj7E6/8aMvsxK5V
         42B6XBtFBR9p8p+ss9PaY8m/kGeXKwmQS16OCI55gXNwx6/3RF/YVPbMD24YrP7OpDPq
         MdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMw/3kI8eARoe7WvfrrHdgvyGXgR3UzQdKK0JiaKTgE=;
        b=f8MKypQlTZkZwSR+s0xseCo51NV+8NXc4HAcnI5vGvqvFs0HexcsaF2dPPhpKfk8cK
         gYkUxdrQfisKhRFNZr+a1WN7/wvzL3Ki0trR6WzgWrNnONhtqIS6EGq/Z7mB621pdOwX
         zWeDSTxA+P1b/9KIBFVT8oAU06hItlgrN0WS2GzicaluNsP4ZwllbtUuPZ+9BQJCeXMs
         JmlJvsK5EOmtbiua/V2MPVgedHMBHlJcqp8kjpKp/oo71YUJY0fj7W891PHtP5n7cF5a
         kogc8lmGKwN5N7pmgPhWxpq1F4QYVbyNnriBoY22mxQ8DCDmcVyfvH5DzxoQcjlwmi6R
         z/Aw==
X-Gm-Message-State: AOAM5322HKGJhNDdQ/quktOric7qSZpLcGXszjNxqAbROwhvObyOBEjj
        bG7drIo+Mn20j0oJ4lR1xslAZ2DM5V1tA5/fZGa1rIymc4DfGw==
X-Google-Smtp-Source: ABdhPJxfs2GU9WEvQris9fst/H0J4EMs6+EYOpCY4cBcEgqriSTK6C8FNtsh9EJS5HlZ9eLHkL6g8XrVE348NKKGdso=
X-Received: by 2002:a05:6102:2150:: with SMTP id h16mr5610908vsg.28.1629698127944;
 Sun, 22 Aug 2021 22:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210727055537.11785-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210727055537.11785-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 23 Aug 2021 07:55:16 +0200
Message-ID: <CAMhs-H85uEWHZqTU0VXGXHUD9nt6n1dbZsWg2mMKa5RE1WzZaQ@mail.gmail.com>
Subject: Re: [PATCH] clk: ralink: avoid to set 'CLK_IS_CRITICAL' flag for gates
To:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DENG Qingfang <dqfext@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 7:55 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> 'clk_init_data' for gates is setting up 'CLK_IS_CRITICAL'
> flag for all of them. This was being doing because some
> drivers of this SoC might not be ready to use the clock
> and we don't wanted the kernel to disable them since default
> behaviour without clock driver was to set all gate bits to
> enabled state. After a bit more testing and checking driver
> code it is safe to remove this flag and just let the kernel
> to disable those gates that are not in use. No regressions
> seems to appear.
>
> Fixes: 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/clk/ralink/clk-mt7621.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Hi Stephen,

Are you ok with this?? It has been a while without response.

Thanks in advance for your time.

Sergio Paracuellos

>
> diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
> index 857da1e274be..a2c045390f00 100644
> --- a/drivers/clk/ralink/clk-mt7621.c
> +++ b/drivers/clk/ralink/clk-mt7621.c
> @@ -131,14 +131,7 @@ static int mt7621_gate_ops_init(struct device *dev,
>                                 struct mt7621_gate *sclk)
>  {
>         struct clk_init_data init = {
> -               /*
> -                * Until now no clock driver existed so
> -                * these SoC drivers are not prepared
> -                * yet for the clock. We don't want kernel to
> -                * disable anything so we add CLK_IS_CRITICAL
> -                * flag here.
> -                */
> -               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +               .flags = CLK_SET_RATE_PARENT,
>                 .num_parents = 1,
>                 .parent_names = &sclk->parent_name,
>                 .ops = &mt7621_gate_ops,
> --
> 2.25.1
>

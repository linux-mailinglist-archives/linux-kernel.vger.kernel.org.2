Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4943899BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhESXT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:19:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:18:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so21565000lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+8r9AtPlzZj+9/cRqukpg3AdDA3FSYfxc2gkenh29A=;
        b=WvOd79n8o4q0G6YzVMJuOJ+x3g042hRVyBYLTk4sElhutqNTtCy0pl/WC6F1WZ3+jq
         JDAd9fX6qk4tvQDgR1fWDNUedqEvDqoCqHOClM4vkAbOajn9LRYuMUcSh7hMf6hndhEI
         bV7KyzRCzLiwhgyjQHbvh2pdZCEeyxg5K2qfAXKQTPYxW+1g4zqoktYgkUvjMkwOyacz
         +PGs9dW6MoJUhpyN1I9sZ18QcjL6m91zKmwHInSIg2hAZR9E/wJGzyLJJjkmBql7IP3w
         uWmpzE8h/KL15o/imfoVGTt1QUfyL9rWKb+wwaLdxvk6sQA2f/M7gnpz30Hrj3e4LE7q
         QpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+8r9AtPlzZj+9/cRqukpg3AdDA3FSYfxc2gkenh29A=;
        b=sESXsSZt2i0WlMUt60xCq/EWphE13HQhcY7mjMcOangU42H43oUskx1cROzy9FZ2Ap
         t5Smeg7u4yfZqs8FQBGSnPNlpJYhPql/VO64lYgP1WiY6vh3m6g8fLXklb9D8YCRpvdR
         jns7+nlGdxaVoIMZR/mWKeL3uroyMABi8z5wcYjX2MXQQIxKznzBhcPCIa19VUFYC5bc
         PcemE9qiuVzNKL+t88uPHvLyjeB94XGN+EdUjvlWZDSsIem8O367nonMmOoCk1o5vlZJ
         IMDvNtfg9JmJnEV4RVMaBUEXSp6pujHQk+TJB3in2MgzOMHKRsb8aLQ0et4L9T5VCCgp
         WGZw==
X-Gm-Message-State: AOAM531xupMxZsgujYoS6pWTSEITP/c9xHk2ZuB5BHMokUItGYTFGGFz
        YfTIR2tAKA9IMQlZKig0CLM3oTSHVEOXEU7awYGO3Q==
X-Google-Smtp-Source: ABdhPJwoRGeMvc0HB7Ita61Vbufx14BhMJonsMgYo6AgL9tBerER2OwNehn9mXrmS55JmIhaZwgfna9MnK8gb6f9B0g=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr564130lfr.586.1621466315389;
 Wed, 19 May 2021 16:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210510063602.505829-1-jay.xu@rock-chips.com>
 <20210510063722.506009-1-jay.xu@rock-chips.com> <7622756.lOV4Wx5bFT@phil>
In-Reply-To: <7622756.lOV4Wx5bFT@phil>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:18:24 +0200
Message-ID: <CACRpkdbRONGkiukppCROFFLFkCz+vDJFj_OGC=8MSR4JpZaXrQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] gpio/rockchip: always enable clock for gpio controller
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:49 PM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 10. Mai 2021, 08:37:22 CEST schrieb Jianqun Xu:
> > Since gate and ungate pclk of gpio has very litte benifit for system
> > power consumption, just keep it always ungate.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> I do agree with the reasoning and as an added benefit, we
> also drop all the clk_enable calls that don't do proper error
> handling right now ;-)

Heiko what is your general stance on the rest of the patches?
I was thinking I should merge them soon if you're not
against.

Yours,
Linus Walleij

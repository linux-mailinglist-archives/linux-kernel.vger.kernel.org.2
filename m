Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDCD403C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349248AbhIHPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhIHPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:11:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:09:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s16so2657478ilo.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRPp5IHtHZbh2VaC3A/pPLLamUQg+uMH0n8xJchofN8=;
        b=I2IrUovC0NAik8gQxEeKQbBh/+E3r1Ftc2iriNrtCYRmaOT/WfeH2y3O4YSWdUy8sq
         6jAWU0V6WXZyy9beh89xVm0hzWeWloejNkfBnlYCfYncR05Lt/w1j02hKERMBtQ0dJe9
         1rPWIKVprNObr/nlryClStiA51vf+aQWK6+as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRPp5IHtHZbh2VaC3A/pPLLamUQg+uMH0n8xJchofN8=;
        b=3ou3JE8QfB0g7jc8IYwSgVtmEvzhBWe3gMXaWUvlDCDuPtU0k//6zRom6qQKOMdS6K
         5vEBrT6XMJ5LvnsasATcpuPn0yWnnPOXBsJA3DQzzkv3P5xu82KXL8NAMwijeLV881LO
         tPj3EmlaqjzSAK4Om2mbKKgLQImUFeRGEvDLxW4BFuSGTT4Z8AFjk8nchhgBqQeWGY6s
         22Ksv+W6JI70Y8o3vSIEPZVo/3jav+Mb9j0OJbqbA30QwpRCmgroJUo9zJandGESl3VZ
         PUfAlj9E2pTcb18fKfHi6H9OZBaik7Hv/HviUsGz3kFCLzhOkUHNBv/VVYTIJTlNxHW8
         VWgg==
X-Gm-Message-State: AOAM531CtefVPEchR12j5imFYKO2w5/lzVtU+zYjTC7SUZfI52fzIrZQ
        DGLolN8pb/lRyUl2/z/tqhG6d1sFMGFQwQ==
X-Google-Smtp-Source: ABdhPJzSzWLKmrpgL1ZaJGmUobiBa/Cg1G8P5jh5ygZuAB3hLkbcdcUKZy+IHFi0iovh+wKszKP28A==
X-Received: by 2002:a92:cda4:: with SMTP id g4mr262464ild.236.1631113797651;
        Wed, 08 Sep 2021 08:09:57 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id o2sm1272854ilg.47.2021.09.08.08.09.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:09:57 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id x10so2646994ilm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:09:56 -0700 (PDT)
X-Received: by 2002:a92:cb52:: with SMTP id f18mr274812ilq.120.1631113795742;
 Wed, 08 Sep 2021 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
 <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
In-Reply-To: <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Sep 2021 08:09:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uo7oK6a8X69KGneP8CvXE127ZxU7U59Rrz+_Dv6D5t3g@mail.gmail.com>
Message-ID: <CAD=FV=Uo7oK6a8X69KGneP8CvXE127ZxU7U59Rrz+_Dv6D5t3g@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] arm64: dts: rockchip: add Coresight debug
 range for RK3399
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 7, 2021 at 9:46 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Per Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt.
>
> This IP block can be used for sampling the PC of any given CPU, which is
> useful in certain panic scenarios where you can't get the CPU to stop
> cleanly (e.g., hard lockup).
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 48 ++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 3871c7fd83b0..c8c62637b600 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -433,6 +433,54 @@ usbdrd_dwc3_1: usb@fe900000 {
>                 };
>         };
>
> +       debug@fe430000 {

I think your sort order is wrong? 0xfe430000 comes before 0xfe900000?

Other than that this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

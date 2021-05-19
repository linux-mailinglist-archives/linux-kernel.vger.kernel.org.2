Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73D38933C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbhESQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbhESQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:07:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:05:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so13213682qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgMoICu8rR/IW1eQMMzk4MHApS2BtnfRdBWMe2gT6bk=;
        b=h+UM8LCakd3xicL67AYTK3McsW7So2YlPlnF5ddViK5EX4/zLL6fgFJCBExK3DiZSx
         HUWQhMQmcMrYZLVRL2jJ/xeQpu+0xz+KtnhpYj4EuMbXYHXEaTsFA5pWe+O1altaY43v
         AA1UnTSkMKBgnT+NrY7kLvooya4zA7BhG7Q9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgMoICu8rR/IW1eQMMzk4MHApS2BtnfRdBWMe2gT6bk=;
        b=UNkSTo0F7yXLurGueeDLq09UB6MgFe9JcR7vDfeGBvYUKwMSvoTNtIRxrzVSg2DlFS
         csuJmzo3FdePODzZ4JIEpM3N7hPk4loZlCfutZC/E7bIDKQXHx2dbSuskQ0ZzGzbnbhz
         KN3f8Q0AmqtCFzgBlSpMcVcCZj7mUIW3C6ER/3lBHNEQDehXMP6b+Q77z6FMcPbu5615
         /r8TXdKnjSew4DmETtrTPVb3x0DOLl02KlFCCKTirjyD4Pj9nPgyGrsGVOQB+HZB1vWz
         UsonkwUWt4Z1LciSB6NOe6QVf705uyQZjuzF38a/7CMA60J/vIQsYqpi73C1pCIKGs63
         NIcQ==
X-Gm-Message-State: AOAM532rsVyBYe+1XkxBYxVwP9mbE6na971WouCmLBDPZrAf8OKuH6X4
        AolkLZWsmQ3wjBEZeITklqgCbIGe3qn9pQ==
X-Google-Smtp-Source: ABdhPJyLQLwyutmpIEel+MEXGAbqLxy30f1nom1RhIWFalov1fW2bpdp4574JYixwKwA+Yy8J9B+EQ==
X-Received: by 2002:a37:4396:: with SMTP id q144mr63461qka.44.1621440341115;
        Wed, 19 May 2021 09:05:41 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id f19sm78137qkg.70.2021.05.19.09.05.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:05:40 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id b13so17394521ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:05:40 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr324651ybp.476.1621440340101;
 Wed, 19 May 2021 09:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210519054030.3217704-1-swboyd@chromium.org>
In-Reply-To: <20210519054030.3217704-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 May 2021 09:05:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UarqLwPu6mJ7QU8qXWoaizqMHHbjqF4q=KPYvDZrhT-A@mail.gmail.com>
Message-ID: <CAD=FV=UarqLwPu6mJ7QU8qXWoaizqMHHbjqF4q=KPYvDZrhT-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Update flash freq to
 match reality
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 10:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This spi flash part is actually being clocked at 37.5MHz, not 25MHz,
> because of the way the clk driver is rounding up the rate that is
> requested to the nearest supported frequency. Let's update the frequency
> here, and remove the TODO because this is the fastest frequency we're
> going to be able to use here.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 24d293ef56d7..af3c0e1e2223 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -335,8 +335,7 @@ flash@0 {
>                 compatible = "jedec,spi-nor";
>                 reg = <0>;
>
> -               /* TODO: Increase frequency after testing */
> -               spi-max-frequency = <25000000>;
> +               spi-max-frequency = <37500000>;
>                 spi-tx-bus-width = <2>;
>                 spi-rx-bus-width = <2>;
>         };

Thanks. Looks right to me. I confirmed that the clock is 150 MHz in my
"clk_summary" which is 4x 37.5.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug

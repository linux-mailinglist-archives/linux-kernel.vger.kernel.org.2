Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B469347CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhCXPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbhCXPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:32:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F0C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:32:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v70so18400178qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVb2QbYSbal4tLqCqk3qMZlVKf8EJnP6RzZIU2b/Gbg=;
        b=hAnApmAFjU4lv9213jcldZTaZ5s2KhQhYnd4rknFmPZzC4RkUkKgncqV6u2V058lBg
         LV9UVLtxKrtK10baBKnXk4Lzd/8E09LglXGiHW1+rl9gYBZyAn8w5kAKS427+wtIPTkb
         KdoAlmuuIl2k5nnaZQcSqy4/nO/mHB+5nBXSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVb2QbYSbal4tLqCqk3qMZlVKf8EJnP6RzZIU2b/Gbg=;
        b=AR5OaJA4DeyTT5bFD/RWXkea3jx0Zc34KcV7VJ7haWaD37r15sF0Z9n4sq/lnhdEln
         dDe+cSXc+8D/BKrSEzIKmMG4fw9Ce5kWnzlfo2l8DjCUAyv5/SglF4YotBkhTPHjWzeo
         AatukO2ZuwcdT7QUzOs2QVBo2t7+TvSYrSpdIUA0uCiEjFfQsFE01o1haJROcfo+jkGp
         Jzq023BdRZJiftcYCfOhcXJRUjBqctgV/Me/rsOcwpJj7XuVTMuYAaxi+fRvTEHbzvMo
         puPX9WtTMp3FdP0R/16yPxaQLtt8XLreLHsqVUUrL4S7QKnLKyFQbDePBsInF+BQAKVX
         RYhA==
X-Gm-Message-State: AOAM530aAv++nzShvCfStOkFKzFMa5yyngppnZ6z3WoN25cFmeqbKBZX
        JvSQqsVxTdFPYynHG7qHrJZkbUMnOwt1vw==
X-Google-Smtp-Source: ABdhPJwuV/AkLI2IxNkJkmSzvRjP+n5t0NhgmcMegpOI8YuKKvAXgbUqHHWLhm8YwdpxyBEtyKTF3A==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr3471124qke.143.1616599933036;
        Wed, 24 Mar 2021 08:32:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id l8sm1622746qtr.19.2021.03.24.08.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 08:32:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id l15so3479565ybm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:32:12 -0700 (PDT)
X-Received: by 2002:a25:b443:: with SMTP id c3mr5809966ybg.32.1616599932107;
 Wed, 24 Mar 2021 08:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210324025534.1837405-1-swboyd@chromium.org>
In-Reply-To: <20210324025534.1837405-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Mar 2021 08:32:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfM10w60VUuTW5yXdykC8oXuxqq=FLfZYDP2aUh0P0_g@mail.gmail.com>
Message-ID: <CAD=FV=VfM10w60VUuTW5yXdykC8oXuxqq=FLfZYDP2aUh0P0_g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: trogdor: Add no-hpd to DSI bridge node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 23, 2021 at 7:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We should indicate that we're not using the HPD pin on this device, per
> the binding document. Otherwise if code in the future wants to enable
> HPD in the bridge when this property is absent we'll be wasting power
> powering hpd when we don't use it on trogdor boards. We didn't notice
> this before because the kernel driver blindly disables hpd, but that
> won't be true for much longer.
>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 07c8b2c926c0..298af6d7fb4a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -595,6 +595,8 @@ sn65dsi86_bridge: bridge@2d {
>                 clocks = <&rpmhcc RPMH_LN_BB_CLK3>;
>                 clock-names = "refclk";
>
> +               no-hpd;
> +

Sigh. I can't believe that I added this for cheza in commit
0d1ce0d14bd7 ("arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on
cheza") but forgot trogdor. Thanks.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: if you were feeling charitable you might consider sending a
patch for "sdm850-lenovo-yoga-c630.dts" as well.  I don't personally
know if HPD is hooked up on that system, but presumably even if it is
it's just as useless as it is on other systems where the bridge is
used for eDP. If nothing else setting it preserves existing behavior.
Someone (I forget who) requested that I word the bindings specifically
to say that "no-hpd" was OK to specify in cases like that, since the
bindings say:

>      Set if the HPD line on the bridge isn't hooked up to anything or is
>      otherwise unusable.

-Doug

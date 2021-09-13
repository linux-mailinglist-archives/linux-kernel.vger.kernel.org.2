Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5440839C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhIMEyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 00:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhIMEyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 00:54:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 21:53:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h16so18323242lfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GP94oI8tMu6AWKPmeh+Mi99FWEewPUjupFIyk9Vgy8=;
        b=dy5jiiVGzeuUU3o2/KUgrSZ5nU4dGqicgHDbYfCkZ+dTO+28QM6vPMBSnfZB9xA0vR
         JsrU7k163qDyuxipvfEBNOaVwCopH6Us6ZtfnezWtK6Nov6EHU1jzPll20Y6SymwwAVO
         /qH/doGQpsWz0mI2+fGUQJ75Vw/WLAHwY8piw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GP94oI8tMu6AWKPmeh+Mi99FWEewPUjupFIyk9Vgy8=;
        b=gTnjWcdZn6h0L0PaJZ38LkjeQ1hYjeQ7X0DXGMXkNOF9g5YoAJJZo/kjg7v4QAiQBd
         pgOfTsifIYxPG1syxUcYOX1XNkAIk3VWNAZ0h6hiewFUKZmikMGzUNWuHBijemnvebf/
         24/bf0hFtU+yMuWeujlwubDvaFNAnxBNNOHyIX/fcCzw6H3ZZbRAzvJYd9xQALNla8hf
         mnwqQ4Yvp1IKGaU15V+oCOwf16ID2A8cATDYgoDYDpDACUZBOESJ/XENnaQ6BtkNjEIy
         O7zbmmdPXpsIGok0lskwRRMMqtWqhDHTRfdp7E3JmCxpHkEDfkNZx6RhqG1nzst8WmKe
         FAbg==
X-Gm-Message-State: AOAM531EbiyXx0EkvttAmtMGmvX8jPFTckfHhyfBHEknwyb2VzkzRzZv
        w6Y6FY11Qk/u7K+cIawzJ9jWBXe1dzIOMVIJKXtlP5jJmgyJxA==
X-Google-Smtp-Source: ABdhPJz/3Qrvat1JZ3K+cjHFjhNfQ1Dn3Xyi3uZH6ast4XQTlgibkT6qLsGdMg9yDmhhz9D5dLFRiduzFLzRZJkmR20=
X-Received: by 2002:a05:6512:c16:: with SMTP id z22mr8054334lfu.482.1631508781305;
 Sun, 12 Sep 2021 21:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
 <CAD=FV=Wp=zqx4j=srryypAfpRusHQinuhXjmu4G_HuBo7+PN1g@mail.gmail.com>
In-Reply-To: <CAD=FV=Wp=zqx4j=srryypAfpRusHQinuhXjmu4G_HuBo7+PN1g@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 13 Sep 2021 12:52:50 +0800
Message-ID: <CAGXv+5H-NJnUQ3WCdbdw9yz9FPHCHK7siLW2YsCfjiruj6B5pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: rockchip: rk3399: make CPU clocks critical
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 3:44 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Sep 8, 2021 at 11:14 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > The CPU clocks don't currently have any owner (e.g., cpufreq-dt doesn't
> > enable() them -- and even if it did, it's not early enough compared to
> > other consumers -- nor does arch/arm64/kernel/smp.c), and instead are
> > simply assumed to be "on" all the time.
> >
> > They are also parents of a few other clocks which haven't been
> > previously exposed for other devices to consume. If we want to expose
> > those clocks, then the common clock framework may eventually choose to
> > disable their parents (including the CPU PLLs) -- which is no fun for
> > anyone.
> >
> > Thus, mark the CPU clocks as critical, to prevent them from being
> > disabled implicitly.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > Changes in v2:
> >   - New, split from the patch that requires this change
> >
> >  drivers/clk/rockchip/clk-rk3399.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

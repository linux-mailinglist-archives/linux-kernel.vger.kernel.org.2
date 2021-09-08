Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5183B403FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352261AbhIHTpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352156AbhIHTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:45:42 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6CC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 12:44:34 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a1so3556715ilj.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEG9NavySLWdy1upAVmaIf1dDuKJCYTqEzed8oQQGD8=;
        b=CyIBEhnLQsXDqwARbirekG1YFjYcD7oCdYRow3tyboeFb2XGoxYLtD/l0BL7Bk6YuR
         VEri7WBhM4wJhhos/70mFl1baUzbF7QxtuXIcXDif2oN5A4UNXoK2kAVr+j7VQxqYp0/
         GOicdMMTXJOOZzusEjRQZxvyE8i5sPbVxqc0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEG9NavySLWdy1upAVmaIf1dDuKJCYTqEzed8oQQGD8=;
        b=ihFN/syqiwiGQaZgVyY6AIAduqhXNUxeFyjjq3cMDF24DKPkRTqvYqCPy0D/UhHu38
         3mQFTBZad78Prxt/xxU5+L4ulzJwL7XSIlWQUyEpALlHkVnEGU6reIjcqueWFyYgni/B
         KAMQF8dSaia803jofaPhLnVxtTQcizxb2wwy72X/mFBVswjeVXRnX6wGiizdZkjMDtHX
         Nn81gliGjRnGnV7nSxw2piifKtgiI+USisOSMoANTckCyow/C0E1LhTMNsAyIL9/Q/ZX
         VT4f2Za6nj+cgdVMPda18KFomCHzq89AZHVXpyMfSmoYOZoIpA9cE5u+82WWGKpHjfeq
         QVFw==
X-Gm-Message-State: AOAM532k8IRrg5WldtvPg6u9bx2K3cRbCXjOnIFDNv2gVBTKyMYJFL+e
        n/7uejCi8PdqwKO4VpiiItn9Tu+iLkNpsg==
X-Google-Smtp-Source: ABdhPJxh4qjKMvpMysLjUW8E/2U027MGKcl69BjSawVcyOE39aQRowJyJiPGPRqTxJL7ytpArZLRyA==
X-Received: by 2002:a05:6e02:2168:: with SMTP id s8mr1078449ilv.323.1631130273414;
        Wed, 08 Sep 2021 12:44:33 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id s10sm29492iom.40.2021.09.08.12.44.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 12:44:31 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id a20so3551089ilq.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:44:31 -0700 (PDT)
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr1096154ilv.142.1631130271165;
 Wed, 08 Sep 2021 12:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
In-Reply-To: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Sep 2021 12:44:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wp=zqx4j=srryypAfpRusHQinuhXjmu4G_HuBo7+PN1g@mail.gmail.com>
Message-ID: <CAD=FV=Wp=zqx4j=srryypAfpRusHQinuhXjmu4G_HuBo7+PN1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: rockchip: rk3399: make CPU clocks critical
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 8, 2021 at 11:14 AM Brian Norris <briannorris@chromium.org> wrote:
>
> The CPU clocks don't currently have any owner (e.g., cpufreq-dt doesn't
> enable() them -- and even if it did, it's not early enough compared to
> other consumers -- nor does arch/arm64/kernel/smp.c), and instead are
> simply assumed to be "on" all the time.
>
> They are also parents of a few other clocks which haven't been
> previously exposed for other devices to consume. If we want to expose
> those clocks, then the common clock framework may eventually choose to
> disable their parents (including the CPU PLLs) -- which is no fun for
> anyone.
>
> Thus, mark the CPU clocks as critical, to prevent them from being
> disabled implicitly.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>   - New, split from the patch that requires this change
>
>  drivers/clk/rockchip/clk-rk3399.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

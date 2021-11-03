Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C4444A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKCVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:16:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3BAC061714;
        Wed,  3 Nov 2021 14:13:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f4so13858561edx.12;
        Wed, 03 Nov 2021 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTUaMxsJMGNeazWvO7/OQ8xtaQLlSaqiemGWBJDhd2A=;
        b=HykZx+HdVjivDNlo3vODAh2ZD8GYrMym8EG8ZWJ6LuM/XH1W7qTRgeXMREoQCccm1E
         +qEaXy3hEkLljqeOXuI74nc4aFLghGcLBYToz9VtdqiDeTeRzNmuFLO4nAs6DPyfGYSx
         qwvNhG9IBkeRP8plNyQ6ARfs+h+zJ8CPk4SlulyB1ayiSa+LXo2NfLPBoX1PL+adBFax
         vtUmYU6DXUsrlvdZQvEjIgjXdmAjfiJSR1ZP9lyRMj3/zmM+jmKIQeW9mU0pAn2l/5z9
         e8xkolY9FdLE7CYowikzx6qakXk6VRZNoP94OcO9H7GyN0pbBLCT4xd8pm13jnsQ11Ol
         Fitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTUaMxsJMGNeazWvO7/OQ8xtaQLlSaqiemGWBJDhd2A=;
        b=UChvTRuiopROVJSvJR8lsVNjQbR5gmq5uo2WIPCX0IgwlP9wXOqrUppqWLKaV6v5Xq
         b0H9yv4Dsrl1oWY1qpxCCiLy6dyZOgUr7wH2nnbzjj9BxVvJy6u0381D2HQEEkPnsRjb
         C4Mv2T+Bvz/1T1l9UH6iUHsfXNKu8KKgjtPHvTQFPpJCRkk8ecI5qs5ZiUreoDJMsCXV
         xdcKSTRjcC5ueB0SrGCFUFB29s+2fRDYkB/6O2pzOrCVBpGkRQZnkgJCTbx0SEMerHpr
         o+JJg3g4MLwnwh4f0s+NqjAl71fS+zVk8ZZaZtZv4iKwqoP6Vu0Q+N1hU6X5mkUhhi5f
         IhRw==
X-Gm-Message-State: AOAM532SaO3X6EgHIPm6Ajf+PNbNXtOXOaNxM5rbtrFYG4m8fsR3kqkK
        QKK3N2mvtWE8s7F0aLSndW5NQeUlkviWRlR5xIfIkGUXJtk=
X-Google-Smtp-Source: ABdhPJwOl2+jLDK2/mU+yJe3MiYTPpozq/JGcqlu924DHo7nViEkylw7VwL4o1O5tOEf1fBaNpGhK74qfkJuxW/jcV4=
X-Received: by 2002:a50:8e44:: with SMTP id 4mr5086537edx.45.1635974019583;
 Wed, 03 Nov 2021 14:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211103122441.3208576-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20211103122441.3208576-1-alexander.stein@ew.tq-group.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Nov 2021 22:13:28 +0100
Message-ID: <CAFBinCCMKk-dKvVuhLyoNLkK_D-kYbv99c5-w6C2gKXd53e5Aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: composite: Fix 'switching' to same clock
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Wed, Nov 3, 2021 at 1:24 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> During commit 6594988fd625 ("clk: composite: Use rate_ops.determine_rate
> when also a mux is available") setting req->best_parent_hw got lost,
> so best_parent_hw stays NULL during switch to the same parent. This
> results in the (debug) message:
>   clk_calc_new_rates: lcdif_pixel not gated but wants to reparent
> and the following rate change is dropped.
Thanks for investigating and fixing this!

note to myself: only clocks with CLK_SET_RATE_NO_REPARENT are affected.
This might be the reason why it wasn't spotted on Rockchip SoCs (yet).
I have Cc'ed Alex and Chen-Yu in case they're investigating breakage
on Rockchip SoCs with linux-next

> Fixes: 6594988fd625 ("clk: composite: Use rate_ops.determine_rate when also a mux is available")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin

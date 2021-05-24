Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130CF38F21D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhEXRQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEXRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:16:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C2C061574;
        Mon, 24 May 2021 10:15:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id df21so32867641edb.3;
        Mon, 24 May 2021 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NqymAOfKkJSvsQ9cL9DRucWC0MzQQIr199sZKb1IYM=;
        b=Y3oJTV7yKehEVsznvxHyHGR9MACEMlTosuXANvqXj+TKXkico5Q1nWxe87O3mhMu+y
         q5sUZl6rY3onoY6gDEHJiPoZ25WOoxsLCXuaQBePhn3L4N4L0D/bRNJdmp3xfY7uwll3
         1SMt/rKRlhHl3E9/FvL9S5U/3XqL8hV4YDipZtbpBht4WU3YmK6E4ImC4TA8adUJOAV2
         k1nWmzizfos4yQ7SM3DeXDodKYvk8A3dIE3EImzmavHmEPUmsWh4DT3EWS8byDWtz6ra
         xd2kdLFp9r4+XrCgzM9jcPINsYZ29hweQ2PYiq0OyK65JFgL6PHxOum3UeFlYUC8gyT5
         PksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NqymAOfKkJSvsQ9cL9DRucWC0MzQQIr199sZKb1IYM=;
        b=guJf1wImabc0bS618FSjkya5LfV3D5GD0pz1jPB/Jxkl1BLRqRbJ44JBLHcE6XVLLg
         1FIaFmyyUKOnhRW3KV/cm8oLa2ZiRZ5brUnsPYQ+sHw0zGVysBNNmWkpaL7z/U/w19NG
         5Xvr9qHrWUaIlgxEGaRdlNY5qfpehXTDgSNot+u9jHc7l/OQVy4C3sg4/fAgwPKIXTVK
         DQrd0eInoQuTzhiuim75nzbW0i12KuoLy+xdzfylYnRijxGTjHhxjrnVFqelvx9IB0v+
         sUvnkfylgeMLcWDrOCEw2GgZezc8h3N/sUSnZejjNrw9hcqFBoFPF0ICGVrCRCnqfnB9
         W6jQ==
X-Gm-Message-State: AOAM530+Ln1VG9VdFVt3RSu3x4r2xrPR8N7zqheRxgAQsOt2Bggvqfj1
        dkw4bzJ91eyF32EOmBwI3IU1Zpwsdm1NVWuU+KHM1MDN
X-Google-Smtp-Source: ABdhPJzbauczmKWwr8OghHMny4dnkH5wJ73w40kBJBuHpYhBIe6XjgJRNeCTMtESQ4MBP9Htvbs3jaoGwJIB25n9x/o=
X-Received: by 2002:a50:d54c:: with SMTP id f12mr26271733edj.301.1621876507863;
 Mon, 24 May 2021 10:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210524134517.687089-1-martin.blumenstingl@googlemail.com> <1jmtskb3w2.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jmtskb3w2.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 24 May 2021 19:14:57 +0200
Message-ID: <CAFBinCA-JADYi4C4P0cm4fpD6Bg5GyOo0iwferhB0mDW2XEk0w@mail.gmail.com>
Subject: Re: [PATCH v2] clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, May 24, 2021 at 4:30 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 24 May 2021 at 15:45, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Use CLK_SET_RATE_NO_REPARENT for the vclk{,2}_in_sel clocks. The only
> > parent which is actually used is vid_pll_final_div. This should be set
> > using assigned-clock-parents in the .dts rather than removing some
> > "unwanted" clock parents from the clock driver.
> >
> > Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > After a hint from Jerome (thanks) this is the improved version of
> > "clk: meson: meson8b: Don't use MPLL1 as parent of vclk_in_sel" from [0]
> >
> >
> > [0] https://patchwork.kernel.org/project/linux-clk/patch/20210524104533.555953-1-martin.blumenstingl@googlemail.com/
> >
> >
> >  drivers/clk/meson/meson8b.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> > index a844d35b553a..0f8bd707217a 100644
> > --- a/drivers/clk/meson/meson8b.c
> > +++ b/drivers/clk/meson/meson8b.c
> > @@ -1175,7 +1175,7 @@ static struct clk_regmap meson8b_vclk_in_sel = {
> >               .ops = &clk_regmap_mux_ro_ops,
>
> I just noticed that these muxes are read-only ATM.
> It does not make this change (or the previous one) wrong but it does not
> make much sense as the mux won't ever change.
indeed, as-is the patch is a no-op

> I suppose you make this mutable with another patch later on ?
correct, I have a patch in my queue which will make all relevant
clocks in the vclk and vclk2 trees mutable
my idea behind this is to not mix any _ro_ops to _ops conversion with
other types of changes (so the actual reason for a change is still
documented in the git history)


Best regards,
Martin

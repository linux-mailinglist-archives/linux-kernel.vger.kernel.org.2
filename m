Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DD388E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353295AbhESMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhESMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:33:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6884C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:31:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so3223161wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=bAo7Ei/TUi10dkjUS5XYUKLdKDhp8o5GDEEhLvW8E/8=;
        b=oL1E6C3sCn5SHZuQHZQ4qSR511zUkj1ReiFbYY7jMF3nHEXzAwrJBxV5BlKQfH5J4o
         RP7yi+L6XxHJn7+zxVHoPJa0rOXsTP3b/bODa1ijp9XrcLFVIs8L0JGMjxcSSswU0LeS
         jybN7+Bw8gTm3Ru3oTvtzkLVn1YlrM0zMXUv0+mNX5NrcAFh9+W+stJKmRHzv/7xAqr+
         fmTYrsF+ZlDhafMfvFJTkjDOTLrYgCGMcCqASE96TXMJbuP7/CsJPZM07Tt889kaAskz
         QUctp0dN9NOVjtNLssocI3ukWFH6O/rSqk7dKPcnuProg7E/pu0p9okkQ4i2uXvEkUqv
         qJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=bAo7Ei/TUi10dkjUS5XYUKLdKDhp8o5GDEEhLvW8E/8=;
        b=KKOO0z9De/TcB+TBmUAiuXp4ljl+TVglNdm/qPY1z6QOtPcfz5Ug1pFTAmm6zjlg3O
         SNX9qmm6XUtzx43iBI9clSmetvLwILC7dZcEgy/PNxuL6TJTgCbmm4vHhGnCW8xeIntp
         IcJ0dPI/dq0sZp9g4CotT4uMUeC9P0p+NzatdEi5Gn35jrz6QNIsJWVxQkXIU8yWwJib
         qLvm86gKtlgR59HnmDpwB7b13lRoxSHvQ5n3AXT3+Dp0XHdd0OElUbjE9VJxoU7MNPSs
         PL7n2TsnTG2hPOSt4g6FzHhgXd8MC8nXe2wuTyG9Q8wKY/A4NrTk98ZeYl4axni56TZu
         zrWw==
X-Gm-Message-State: AOAM530pC2RJfwDfx467mYXVRZir/LvVVdDd+FlxeIWmBvIy746zZHqM
        lcKyF6CrgIAyX2hHsHzBZjr0dg==
X-Google-Smtp-Source: ABdhPJxuxG5efFOAKNN/YpLS+nSoJ6UYkSczlvIdgyrB9oZNqJ9617YPnFDTyRH3uyrAmV13niYQGQ==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr11538782wmq.185.1621427502264;
        Wed, 19 May 2021 05:31:42 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id u19sm1185904wmq.7.2021.05.19.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:31:41 -0700 (PDT)
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
 <20210517203724.1006254-2-martin.blumenstingl@googlemail.com>
 <1jtun01o5p.fsf@starbuckisacylon.baylibre.com>
 <CAFBinCB+5bFH0LW4rqYGCiO-X-xmer67cp5kXpyU0d-OfxiOvw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v1 1/3] clk: divider: Add re-usable determine_rate
 implementations
In-reply-to: <CAFBinCB+5bFH0LW4rqYGCiO-X-xmer67cp5kXpyU0d-OfxiOvw@mail.gmail.com>
Message-ID: <1jv97eaor6.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 19 May 2021 14:31:41 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 18 May 2021 at 22:33, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Tue, May 18, 2021 at 9:44 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> > +int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
>> > +                           const struct clk_div_table *table, u8 width,
>> > +                           unsigned long flags, unsigned int val)
>> > +{
>> > +     int div;
>> > +
>> > +     div = _get_div(table, val, flags, width);
>> > +
>> > +     /* Even a read-only clock can propagate a rate change */
>> > +     if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
>> > +             if (!req->best_parent_hw)
>> > +                     return -EINVAL;
>> > +
>> > +             req->best_parent_rate = clk_hw_round_rate(req->best_parent_hw,
>> > +                                                       req->rate * div);
>> > +     }
>> > +
>> > +     req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
>> > +
>> > +     return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(divider_ro_determine_rate);
>>
>> For a final version, could you factorize the code with the .round_rate()
>> variant ? It would remove a bit of duplication.
> my first idea was to basically let the new _determine_rate code just
> forward all relevant parameters to _round_rate
> however, I discarded that as it turned out to be less understandable
> for me as parameters need to be mapped in both ways
>
> while writing this mail I noticed that the opposite direction
> (meaning: _round_rate forwards to _determine_rate) will probably work.
> I'll give it a try in the next days
> if you had anything else in mind then please let me know

Yep, the idea would be to use the determine_rate() part as the common
implementation. AFAICT, all you need is to build req_rate structure in
the round_rate() part.

>
>> Maybe determine_rate() can also replace round_rate() in the generic
>> divider ops ?
> sure, I'll add that as a separate patch in this series
> note to myself: testing can be done with the MMC drivers as we're
> using the generic clk_divider_ops there
>
>
> Best regards,
> Martin


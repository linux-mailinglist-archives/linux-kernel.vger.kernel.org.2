Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45193388173
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbhERUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:35:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B5C061573;
        Tue, 18 May 2021 13:34:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id di13so12778927edb.2;
        Tue, 18 May 2021 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL0CiSI2cCMpvavhlqOGujTCEJkTFDfxgkJ3VFbEVN0=;
        b=tCf4kXKZGny3QAzUEQsa42a3Pz4W7zBX0TeOv1Q2bQcYu8GlWd4+5YNLmGj3m0cOcI
         lyiE/Qa1agYrgU9q/OTa7uhmSSWIJCkaF7ZaaRpA7lPNQDtw1gFB2gg3m7hB0skg7ZlM
         DIihpuethbuhsPuugQhEUpZYnDfwgrnoVl6te07kNgrYEKyKwq/DHUq1puu7Ddq214pt
         Evq2WkkaiYfzHt9dFHqJOXXfx8kSiEpC62vYZLQRwk1zw8Em3Del2yTPc2onTNzgsT7v
         NkXiwvA5VVTLTlo9upGkv1KzM4Xm4ML76CyRz+T8boS0L/rin+0/lYaqroVQCCp3e74e
         IoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL0CiSI2cCMpvavhlqOGujTCEJkTFDfxgkJ3VFbEVN0=;
        b=TqQ8jdkfwAMnZemCnvjproE6z36dnWZ7q927y/0f3eDr/q8eJK6dQEFtOkC2yyT/4P
         mutOJAEFz2DZsbm+xOaybfMKKq+EhH8Dhaq0fOf6HVnlvxFQVqrzE4WzSps3nqpkAPf1
         4XWdJXrfBiD42JrpfK8IiHx92hzz6fJ4DwOhYvyFq6cxVZzMbcaDSqwSR8LcgI4uoBXI
         AYqywZvCfO4OsUmKtzr6gZIKzViEgTdg68EHi0PEAYkb4QGtKtwygVu/nKM0Nr5MQ0om
         3Gpob6phgwHj0EDRrw43Ta4eL0Ea9jDc9KdBdFmMnhAFQm+E7Z29K9niQewSx1Omzk8w
         NRyg==
X-Gm-Message-State: AOAM533eYcJDTczvJDj9JLhGar1faGfDm0QcMedvdDF1fpNARgVuZXVo
        tKU7Qhf5rWRf5nT7952f6WMcfqJUTOlnMWtfaXU=
X-Google-Smtp-Source: ABdhPJxFsjBTmyqIIgerb2xmITvpZs23MeN0JixS8tgK6778SQkUt7m40fSCNQkRan58QA2fHYFlANPEyZx6nlUKHik=
X-Received: by 2002:a50:9346:: with SMTP id n6mr9158222eda.365.1621370041309;
 Tue, 18 May 2021 13:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
 <20210517203724.1006254-2-martin.blumenstingl@googlemail.com> <1jtun01o5p.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jtun01o5p.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 18 May 2021 22:33:50 +0200
Message-ID: <CAFBinCB+5bFH0LW4rqYGCiO-X-xmer67cp5kXpyU0d-OfxiOvw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/3] clk: divider: Add re-usable determine_rate implementations
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, May 18, 2021 at 9:44 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > +int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
> > +                           const struct clk_div_table *table, u8 width,
> > +                           unsigned long flags, unsigned int val)
> > +{
> > +     int div;
> > +
> > +     div = _get_div(table, val, flags, width);
> > +
> > +     /* Even a read-only clock can propagate a rate change */
> > +     if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
> > +             if (!req->best_parent_hw)
> > +                     return -EINVAL;
> > +
> > +             req->best_parent_rate = clk_hw_round_rate(req->best_parent_hw,
> > +                                                       req->rate * div);
> > +     }
> > +
> > +     req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(divider_ro_determine_rate);
>
> For a final version, could you factorize the code with the .round_rate()
> variant ? It would remove a bit of duplication.
my first idea was to basically let the new _determine_rate code just
forward all relevant parameters to _round_rate
however, I discarded that as it turned out to be less understandable
for me as parameters need to be mapped in both ways

while writing this mail I noticed that the opposite direction
(meaning: _round_rate forwards to _determine_rate) will probably work.
I'll give it a try in the next days
if you had anything else in mind then please let me know

> Maybe determine_rate() can also replace round_rate() in the generic
> divider ops ?
sure, I'll add that as a separate patch in this series
note to myself: testing can be done with the MMC drivers as we're
using the generic clk_divider_ops there


Best regards,
Martin

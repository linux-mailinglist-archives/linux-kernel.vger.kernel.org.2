Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD69427AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhJIOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhJIOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:52:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF54C061764
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 07:50:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z11so43266430lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u5boEiOHXRTtFCRA3j2LCxqfGEF272vdjbUJEc+y8o=;
        b=obn0VTqUprwckfAtkMfS7NilcpVJSLbr67SZIErNjZ3L0+Mhco3Ks+pssD9/tVLYC7
         CAHBh6+rVURtCxdy+PUzvvqIKP3ggVPixJlTMI7Strf3nRCmhpWfbBV+6iCRqPWOQJxk
         AWlDTyKHoGT/xAIsUPP7wMxGS0mnDpVrQcCs+nHKdOJl6qLJWduBeABtuQWILnoaCa7r
         rpzBANeFR/mKuBfbtd2KUKmwGRfJHapX3PiKlOA9egGIitOn9Hm0E3FHRMU3pzgSTspL
         g/CvH1jUhJvIHwkTL3HVmqLBkGocNhZBiGGLD3eWhnq8K1V8V7/LwoF3TlOdK0noa5vU
         3PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u5boEiOHXRTtFCRA3j2LCxqfGEF272vdjbUJEc+y8o=;
        b=1qJFa4+PoCHgkAEepjIXbcOpz/OjnBSeI6rVwbj0dZLf3So/2J3wwEh3FEhyI+HpML
         XDTkErQcxTmFTwvnJKX28ewCc/kmU4V2KsCKFzbfp5gGa81QBDmykqwygvD+/qOgn7SK
         vb53cjoSAmtdZL2m0JVIf4W5udTNHD41A01JLR9uRlfPvGENsZK+z4Ga05ypgAPFPAY8
         UFo1dy842NUreQuZdOCHSdKO4U4T3Y1DFSAK0jZMmXZPglx5XcYLUekY5VhJVnM+IQAe
         cHb4BnH5TjH7WDk7bVsKW/t11vGktg0O0nWDJVdUd35FApIzc6YUec9BGIU3VTh5wRg2
         yjxg==
X-Gm-Message-State: AOAM533m5SRwAQONrEhRAHACfFlYmwGMase19xABQQemii2voMUjKxea
        LwUPzlZpqvo9/yixLZelqDsTaVq0fznyUVNMXjUNYA==
X-Google-Smtp-Source: ABdhPJxtuXZ2/oVwpPI2elX8ZhhW1XWmKYZgF4HVbCs0z8jixVibVyqOlr1AvgW2bP3P4v/92tRBNAfhf8gV2g11n9k=
X-Received: by 2002:a2e:9c56:: with SMTP id t22mr10447062ljj.85.1633791032730;
 Sat, 09 Oct 2021 07:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211009025858.3326725-1-osk@google.com> <20211009025858.3326725-2-osk@google.com>
 <0674a2d0-f0a2-d6bc-33e3-483614602bae@roeck-us.net>
In-Reply-To: <0674a2d0-f0a2-d6bc-33e3-483614602bae@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 10:50:16 -0400
Message-ID: <CABoTLcTL42a23=P501UoqNWr76A3fmEoxwjymz1-g0MNMyYPRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: (nct7802) Make temperature sensors configurable.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

Thanks for the review!

> > +     return sprintf(buf, "%u\n",
> > +                     ((mode >> MODE_BIT_OFFSET_RTD(sattr->index)) &
> > +                             MODE_RTD_MASK) + 2);
>
> Please split into two patches to simplify review. The changes from
> constant to define are logically separate and should thus be in a
> separate patch.
Ok, will do.

> > +     if (index >= 30 && index < 38 &&                        /* local */
> > +         (reg & MODE_LTD_EN) != MODE_LTD_EN)
>
> This is just a single bit, so "!(reg & MODE_LTD_EN)" is sufficient.
Ack.

> > +static bool nct7802_get_input_config(struct device *dev,
> > +     struct device_node *input, u8 *mode_mask, u8 *mode_val)
>
> Please align continuation lines with "(".
Oh, even if that would result in a lot of extra lines? Or just start
the first argument on a new line?

> The function should return an error code.
Ok, I'll look into that.

> > +     if (reg >= 1 && reg <= 3 && !of_device_is_available(input)) {
>
> reg will always be >=1 and <=3 here.
Good catch!

> > +             *mode_val &= ~(MODE_RTD_MASK
> > +                     << MODE_BIT_OFFSET_RTD(reg-1));
>
> space around '-'
Oh yeah, I'm sorry. Is there a code formatter I should have run? I did
run "checkpatch.pl", hoping that it would catch those.

> > +             *mode_mask |= MODE_RTD_MASK
> > +                     << MODE_BIT_OFFSET_RTD(reg-1);
>
> Unnecessary continuation lines. There are several more of those;
> I won't comment on it further. Please only use continuation lines if
> the resulting line length is otherwise > 100 columns.
Argh, yeah. After refactoring that function, I thought I caught all of
them, but obviously I didn't. According to [1] we should stay within
80 columns (and use tabs that are 8 spaces wide). I assume that still
applies? The rest of this code follows that rule.

> > +     if (dev->of_node) {
> > +             for_each_child_of_node(dev->of_node, input) {
> > +                     if (nct7802_get_input_config(dev, input, &mode_mask,
> > +                                     &mode_val))
> > +                             found_input_config = true;
>
> This is mixing errors with "dt configuration does not exist".
> nct7802_get_input_config() should return an actual error if the
> DT configuration is bad, and return that error to the calling code
> if that is the case.
Ok, I'll change that. I wasn't sure whether we'd rather configure "as
much as we can" or fail completely without configuring anything. Shall
we allow all of the configuration to be validated before erroring out?
That would make it easier to get the DT right in one pass, but makes
the code more complicated.

> > +     if (!found_input_config) {
> > +             /* Enable local temperature sensor by default */
> > +             mode_val |= MODE_LTD_EN;
> > +             mode_mask |= MODE_LTD_EN;
> > +     }
>
> This can be set by default since nct7802_get_input_config()
> removes it if the channel is disabled, meaning found_input_config
> is really unnecessary.
Ok. Should we actually phase out the "LTD enabled by default"
completely? Or is that for a future change?

Thanks
Oskar.

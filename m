Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2976393A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhE1Al4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhE1Alz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:41:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F614C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:40:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so2746885lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95QELRGt3WnpgXBZfUKFp2QKTKq0EmitnNeYW0Z4b00=;
        b=JHzOGH3Rc3QzKK/Ko1E2bnUdXa+dF2SXbNLvEC4WOMB3ME0NjEkkXjIOu3vhgBjmSm
         xAoBuWZf2Y6gaqTX/uwq1QXNRyDtR5Z5gYvpan34I6clp7Y8269dChWGB1qbHrdX17jr
         /trAilTK5HE8H4ZDJlTAMIy1g6uo7GsCv18lyPxl4t2yXjZtlUzMx3q6MNAqs+33rrJA
         tKUCWcKbHoZEtZf4z8/P0bKU1AJ7nqUh8r9SWzWCXhSMfZP6/CFK66voUTGP2UGzRSNq
         iqVdcHJYDaIgzmJiBuBdesk7XwXASckGaB/X7onHSIyusXxH7q3+ds6lU5Jj9mDUUD40
         DIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95QELRGt3WnpgXBZfUKFp2QKTKq0EmitnNeYW0Z4b00=;
        b=CnjUR7v/LpVbHHFWMplQGuVlH8tyRWFfMTMfYH9IG4NMPRXKCP7FwiaHlBQP4pH6on
         /uqzpqDPC4sNSEfMD4k9b5okQ8WcorUA0NyORGCQorD2kRdJMT66mwxHQUcJ6NSqU4Ta
         TIAsTmVcwNLYRVBh+Kc13Q8P3cSB/6qDQnJVlsbpqdL3BxVH1MOROv+skfhE6UyN4rMc
         Ia+f4RiOUu5xBR3pR77ehWaonVXb9rnB5yHJKOuy80n1J/VQS3Ofa3RYdMyC5VsHthv6
         mX/Wm6d4prNksIpXkS31U0ujN84kRDf4NkTk8f3qV/9TUs9SdsUHty2Y4kAbz5XKvK0u
         fGqg==
X-Gm-Message-State: AOAM532yVa526/qMwo6BvvwgR9rF16DQU9QOtCZXvbVwKe4iodKcfdeF
        6uWhJjXsXiUJg3cBFdNqa/3SWzJvOrMLEGPlLSaxsNV01n4=
X-Google-Smtp-Source: ABdhPJxEixXA4BPRFM+cBv+IPP3s69di5inm8bv4P3Ri4UI4g+TG+2aZl637Yx4KUShZQ/2GEO2QmWrdPgelI9kY9pI=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr3928339lfp.649.1622162418755;
 Thu, 27 May 2021 17:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 02:40:07 +0200
Message-ID: <CACRpkdYpi5-aednXopjCgbey722T+LEagovGidb13yv6z84MnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Split fastpath array to two
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 8:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Split fastpath array to two, i.e. for mask and for bits.
> At the same time declare them as bitmaps.
>
> This makes code better to read and gives a clue about use of
> bitmap API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Excellent code!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

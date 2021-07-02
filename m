Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA53B9DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGBJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhGBJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:22:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE348C061764;
        Fri,  2 Jul 2021 02:19:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so12316264edc.7;
        Fri, 02 Jul 2021 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgGUwiD86E754SHPP5c8vn9EyEoNKXunTKK1V9Pgukg=;
        b=M7SiC9cbH6MuqHUMzemWrXHCkuSRqABHEz674QXB0rpS8JD+5XXrJTmLG7A+atareB
         bNhGKhcSiOdeygKFSU2ITr6TpgEtDSkaTDSO7eEEP6+943nYaXu4ZqsJ54d27jxLuP/j
         u+c2aJsMJvm6bhWsWUgpvXNiiydkrpCVu0qULXRlxlGxsRqsXw4wYbxHVXevgRbSOBWW
         4x3P4jLmLYZ2FSlhQ2TkvrIfSug0zi4pul4grzYf7YnFBAFZqiZZDEab81pTXqejRryt
         ix/3O+pSo5XgFAT+eSZoxs0W5/RhsL4EBakDgqMEak5iWtpM5AIQUebQGu54x/D79Gb7
         inUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgGUwiD86E754SHPP5c8vn9EyEoNKXunTKK1V9Pgukg=;
        b=t9S9x258bXxqGxTYrVDpI6RGSupbZGoBkZAl30t4gNO9hThPhFsi5MCH3lpboUAzE6
         V2gncVm+CRITpqJbHNbjMy9JJRGdUBk5B7JKZqPxT3EGWhE0nDh+M+dulAzwE0B4cUmK
         epyVnyHRmNvdSP5QzjnNIP1vHgZZ8yy+F4L/ltHjhUxEEbcNJpHWigCdedqyypU1DTFu
         3rGCrTtQwU8PrlD0EePIvFyDfnQ5XX1HJ6fjBQAYtUn2D29vkY8ykrNr3qdtksRx2MFU
         /zaVI7VTqcxQgZ4B6szp6dB07pqDnKDUwUqe8UGf2Sgt/x2E+6XJmecfORf1FrXRYLZF
         IjXw==
X-Gm-Message-State: AOAM532NK+DOgD8iBkgdlxkVujwHt9oQnshLhZS5eKcy39zcX3H6QFP4
        ia/WQYAidZLrDYoxnGWDPS0NZwhgMUs6bXmZULw=
X-Google-Smtp-Source: ABdhPJx8QgM9bN4Uq0tmvV5svPS+Z8nWgUa2hYgaxYeKj2MVtNlhe96O4xXkIR714oJMYujtWcbzVeYmOzCKbmukwXk=
X-Received: by 2002:a50:ec08:: with SMTP id g8mr5484634edr.98.1625217588288;
 Fri, 02 Jul 2021 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
 <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
 <20210701202540.GA1085600@roeck-us.net> <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com>
 <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com>
In-Reply-To: <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 2 Jul 2021 11:19:37 +0200
Message-ID: <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jul 2, 2021 at 3:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
[...]
> My guess is that we have drivers copying the clk_ops from the
> divider_ops structure and so they are copying over round_rate but not
> determine_rate.
I just learned something new - thanks for investigating this as well!

$ git grep "clk_divider_ops\.round_rate" drivers/
drivers/clk/bcm/clk-bcm2835.c:  return clk_divider_ops.round_rate(hw,
rate, parent_rate);
drivers/clk/clk-stm32f4.c:      return clk_divider_ops.round_rate(hw,
rate, prate);
drivers/clk/clk-stm32h7.c:      return clk_divider_ops.round_rate(hw,
rate, prate);
drivers/clk/clk-stm32mp1.c:             req->rate =
clk_divider_ops.round_rate(hw, req->rate, &best_parent_rate);
drivers/clk/imx/clk-divider-gate.c:     return
clk_divider_ops.round_rate(hw, rate, prate);
$ git grep "clk_divider_ro_ops\.round_rate" drivers/
$

Changing these over to use clk_divider_ops.determine_rate doesn't seem too hard.
The part that I am not sure about is how to organize the patches.
1) amend the changes to all relevant drivers (from above) to this patch
2) multiple patches:
- adding .determine_rate to the default divider ops (but not removing
.round_rate)
- a single patch for each relevant driver (from above)
- removing .round_rate from the default divider ops

Another approach is to first create clk_divider_determine_rate() (as
done here) and export it.
Then I could have one individual patch for each relevant driver (from
above) to use:
  .determine_rate = clk_divider_determine_rate,
Then finally I could remove clk_divider_round_rate() and switch over
the default divider ops to .determine_rate as well.

Which way do you prefer?


Best regards,
Martin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9135832A9FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835342AbhCBSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384765AbhCBQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:10:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3897C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:09:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so32092924lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cACSwzPT9Tad/UgCbDi2G+cU13fcnP499kD2jiD09qs=;
        b=NJEiwMLgHFNNJlVEd6adJjw4zF5BqE8QNvPbKlU2qcF5nTbpvSfDqBcSIuLL2KrUG6
         o4ZRMnW5m5wifSfjNQCh/iV5R+WDo020X3Va3Y8ITQgT8aY0KjjMv93nxbBrMzWeQwvr
         MV/yt9UmqPHGnd1769eSqMi/PH2vZuoeJEYufm2h62VWUqAa0i5521oYCBx7oIar/YS9
         zeNA/8Ui0uVsSrNy8cMBB3ZT35D3bMnig3CWx5MuyCzQ0UlNDG/TjQ5OrQTbN8aYq+pT
         yNgOA9VdMye8b1idb0bhysNzSimNMKDFKCGWkCanMgcDb7V+qWvA1qNJsc/12iLfhR+H
         CNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cACSwzPT9Tad/UgCbDi2G+cU13fcnP499kD2jiD09qs=;
        b=p4yOFTvW5LvrpRgJ9xG40GSPyuQQTk/bpz+j1DHZFiN6CVJnOBnJdSeuPOKdkRNedF
         dDI7i67CEMboNmRTiItCyUVVmirKgeOQ5YXWC76iUjEhEFZDbU3WxxvRuPLCW66BWK2Y
         S1H0qE8VgZ3h8yyiRZXqwAPDkXeLOCr7VH+Hg9b6F+MS5Mxdfk8J9gRFlEWeR5RbNv4M
         k6Tl3Jq0QUBe8/vqrwbihZSP7KSru9ucdwvd5PHCKo9nWmYYdinuHmxx9K9fBGqapK2q
         yKIg3qrCzOhQHcnPMrG17vECcSvLBE7uiBxQDpYDHIHG03Be5qvHz8gny0uAAexGuhyL
         puQw==
X-Gm-Message-State: AOAM530V7l06wcXyNo0zShmt7wKy9DYFNAu4dP8KKlAk5sZCXn984kYc
        Pv5Mhh5o+K2f7isYaCAlhh5Mumnwsw2C64ikC5JEtQ==
X-Google-Smtp-Source: ABdhPJydOO1OZgkTglTXFR9GH+FnIBDVeX/ZEwc/b8GDNcDcujJOMYreC/Hdjimh7pS7t4PRVV+TgNPXC3wo4iruuGE=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr12469725lfa.291.1614701373147;
 Tue, 02 Mar 2021 08:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20210301165932.62352-1-andriy.shevchenko@linux.intel.com> <20210301165932.62352-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210301165932.62352-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 17:09:21 +0100
Message-ID: <CACRpkdYsqF_Z4NpfxRCcTb5F2gZ1tLgVr0qALBfVm=LyfQWwiA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: aggregator: Replace custom get_arg() with a
 generic next_arg()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 6:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> cmdline library provides next_arg() helper to traverse over parameters
> and their values given in command line. Replace custom approach in the driver
> by it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wow how nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

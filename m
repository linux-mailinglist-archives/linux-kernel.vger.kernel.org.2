Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F753E93E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhHKOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhHKOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:45:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0DC0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:45:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m17so1245023ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v9hHCZVHAmYgbnWmMzGUr44DlUe75gTidfZaeJXFqM=;
        b=ixasY3I7+egTqHiYwBpn7xtvMOB0ubWh0dHree5YQRsOXjfoZLiZcoMtIJ+YZMA1KC
         QLIH+wpRjXQ+40tIMdWVHT5fHp2+y4BlqZOXDkt3LERoqmIYNij8izzIYqtmT8kInG/y
         8e/b19oe2nAPywFHDVO4W2kMB6/e+tEFf05dEiOWavZs7/dXkRLdwBPdABA63ebtcxLE
         GHhiqYKTqhzsudkCEB8ktzP3FkUIdnjYUVeZ2+83X7hRDrPkhK1sOqwnNNngBH9y/HP4
         kQaJq1h5gX9j6hUFcgyXckbDJDPP0t3ZzIeWAvDjGY+SG6AfNpv8j8aVvFGP4os2KnLU
         FjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v9hHCZVHAmYgbnWmMzGUr44DlUe75gTidfZaeJXFqM=;
        b=UMODSItxJvxx5/VnnxNCbY0BtDc4JWZAZ7cFuhxxPM0uHFgoT6zDC+Rwh86V+60VSG
         rCzu1z8YyBpQUEFgD8xIM70LIYp3i83PsWoMzfYXzEHVrRWudaptOa0Mbrb+QV8nA78h
         5/PuETmwz49QnCmVhBcYGEFVBvDd6fmxWGVcKvVgMZkbvfO2ipnoxsRyq3vw6sEWUgCV
         QCf805edNQSpbDi9TBTG7MmHHTpY+j6ZW821iHZVj9h5jWLQFjN0NqlMcjFrWPXtjxFA
         k3uUADJEkxJmnjArt4rMhdVRc/N3/9C7Itpqe1E7SWGe1xQMiFd4X8ONDB3Cka2W+7np
         OYbg==
X-Gm-Message-State: AOAM531yGhlQBpwXsQ8ESbliMhBByl6IyMUX9T90GXhjvOGnmZlhWHq9
        HZoFRc/GdB1wE62zBQJIwjjqgp8aZ108K8zFnPdbpQ==
X-Google-Smtp-Source: ABdhPJxLhduWN/mt3ervtvbNLFqT3qSQ+hT6DmUXLPRYj76K2NG8pRMv3ca/z6GWKiGtYDR8kRc+zxzqFBMKyYGGHDg=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr24076891ljp.74.1628693115248;
 Wed, 11 Aug 2021 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210805174219.3000667-1-piyush.mehta@xilinx.com>
 <20210805174219.3000667-4-piyush.mehta@xilinx.com> <CACRpkdZ=WRhTTQOvQcDEQhbf5Fone0GHopZfJhsQfsS-NRQUUw@mail.gmail.com>
 <974df9ef-6cdb-cb7b-2b9d-2eddaf1171f7@xilinx.com>
In-Reply-To: <974df9ef-6cdb-cb7b-2b9d-2eddaf1171f7@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 16:45:04 +0200
Message-ID: <CACRpkdZ5owo0rfOqysLpu+La+0p5SgNkjW6OFbG9tsOmtNJEtA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] gpio: modepin: Add driver support for modepin GPIO controller
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Piyush Mehta <piyush.mehta@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Zou Wei <zou_wei@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, wendy.liang@xilinx.com,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, rajan.vaja@xilinx.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, git <git@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 3:30 PM Michal Simek <michal.simek@xilinx.com> wrote:

> They are bootmode pins because that pins are designed and used by ROM to
> get information which boot device should be used.
> But after this is it is really behaving as generic purpose I/O pins.
> Xilinx is using them for years for usb phy resets. I have also seen them
> to be used for other reset functionality.

OK if they are used for general purpose tasks then a GPIO driver
is fine, I was worried that it was just a way to read these pins from
userspace.

Go ahead with this patch series!

Yours,
Linus Walleij

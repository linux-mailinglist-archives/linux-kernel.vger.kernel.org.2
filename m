Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EE32A9A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581184AbhCBSlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhCBPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:45:47 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93AC061356
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:41:34 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r23so24491655ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybajfdG4+XkNN0Eukc7RPPGwhIH7By1tE7lla85kmJc=;
        b=x3uMqpuYYn8yTaEpHXoMeoMWgE0stXI0Wn3MLfP4xfjSObNN6BJL810H+i46bQxYTK
         oPOmAZqvh5L3ZRln/qeZLEMbvggkWh82bdWuKkzV1RKDngtKx+Tv2IxA3KKGdJh2COe0
         VXS6tZ6UEKVopM38XktErr33T0ntwCB2igeONXinb30ZgD92lCOu5OqCcFCruqNjymvA
         02ah+8RS+d3AKwNWm29lwvx4lncQ0r5T24GRW1kNuxnAnWuKzfiraGt1GRR/kxu8h8EF
         p2fJFfgAEWzCxdd9EtcU0MVgdAe2t5Y94uOZKyT+zrM8LCTgAr4kFpDmEVhiwtDF8rF7
         QJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybajfdG4+XkNN0Eukc7RPPGwhIH7By1tE7lla85kmJc=;
        b=iPOTBd8va6r8eJquALxd2dSzzAi6Ihhzb3R/7NqhzliNMWpEpJzt6y6DG9jQxhegYK
         ntDCaCU6PF4jonatz/0T/c87fRqbXeo0Me7uDvO45yxOWnqZ8CEsBYY/YOoIBwvlURXF
         EzRPbG1e4qzRqIX15zFaZihyTGG4j+TqbYpVpb0px8CjIW+cUAbKwRGpT0SK5TltBEsN
         /CwTnVM2lW0uiJWjbnHiwumYO9X6qvUwg/G/QE1FkxV5ZpDX220UqeOI1AfaZmY1WjA8
         Nv+l2xFUQlNZYsFiK+O39uq2WDbncPVG7C36wnjfTIDY3kULbSIjYvBCbh6usubieiku
         AfUA==
X-Gm-Message-State: AOAM532qVbgS/tKnXyGdHHSDQIji+6My4j7InCsVWcq6miVStqFWWXrA
        UUThaBp+MZS20//dAGlhpMzk1xu8uVXFcalWs0kx6g==
X-Google-Smtp-Source: ABdhPJyGRcal8oh4wEsKDXo3e1ko8oALR8+bEfijE+4OEhIOkd8cDG7rUgwD/FbX4GT+mVXJ1yOxbFeEp+72WpADCUA=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr10146762ljj.200.1614699693457;
 Tue, 02 Mar 2021 07:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20210301090519.26192-1-johan@kernel.org> <20210301090519.26192-3-johan@kernel.org>
In-Reply-To: <20210301090519.26192-3-johan@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:41:21 +0100
Message-ID: <CACRpkda7HQf55r7=f2TVvetaV7KavD_Q43CT4P6z97MWM7VjLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: fix gpio-device list corruption
To:     Johan Hovold <johan@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:05 AM Johan Hovold <johan@kernel.org> wrote:

> Make sure to hold the gpio_lock when removing the gpio device from the
> gpio_devices list (when dropping the last reference) to avoid corrupting
> the list when there are concurrent accesses.
>
> Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
> Cc: stable@vger.kernel.org      # 4.6
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Excellent fix as well,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABF3A9518
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhFPIdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhFPIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:33:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:31:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l4so2743857ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQWVokfQZgVGHdyHPg/yFmcebJpq41KrWGaOdOQKipI=;
        b=m0/Lt4BIjXjdpqGSJBLEKjOIX3eirzK2CqDEpDte2Sj3Gc7g8xgdCxCBn5e95uOn1v
         ydDh6KT8HjktRKBXr1sdmueW7V4AkYTsqPeNXbUVcW/kihKPAvf6QZEZ26aLyCwGCXrg
         B0NFEy2eKiuPOZbOScS8JT/qvFA26HvVb5TVNHXylkJDGQ+WF7lLmhyxfj0lH189yFUe
         WbameZzm/vatSMhg+KQhcKgMzrom/GUB5AQ4qAJPeNo2uMheV3oy2PfOEwlMbfyR503e
         S6lCpLduJS7PzOZ448xLpkvuUTIhu8BKQefZo9YXer3ULTU44FfVpVAeNhv+OXRp2LkD
         kCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQWVokfQZgVGHdyHPg/yFmcebJpq41KrWGaOdOQKipI=;
        b=CNAWIDs+HyOEBDbMsCtvLqctNlZEmzmqs6/uIWdKDEP3JGsSISuZMMKPZHS2WFMjv3
         mnUwsz0mACW3F7HzXbY2yuWOA5WLy2Ql/1wB8QsGar6rbwkqY6kf5pHRj4mQmWZ+7pfz
         QtdqV2EE+T+ZqH4XNfnLkEaZ8VU6sUlclcZYhJ9u5cgOw2GlPgDk+MUoWH+UBMVuK5Hb
         jJiY9YxEaP+MgOaP3kRDyDYoVuoDzPv4FmFfj59n1ws/hSFfz8iQ639ibTddlI+xcRg2
         fAIqK994ptYOcEeYxE7xyxdRTByLMEHX2utG82E/Hd7+YOhL7pbzbnjJs30T12k01C+x
         B43Q==
X-Gm-Message-State: AOAM530DyJZNcThnRX20465SqUkpKiPotLmGydXsq5OhUGoCnQCJ8toI
        iLvSe1eiv0CASUEX4j4t2UEP5FNsy0wOkZcGVWl9OA==
X-Google-Smtp-Source: ABdhPJzxWPvgV7p6eSpQF1eWW888O48hzZKsx5O5oRnUA6LyT2IOxPBYEipMULn1541CTP+g3/b9As5YqpuN8cY58j0=
X-Received: by 2002:a05:651c:1501:: with SMTP id e1mr3610433ljf.74.1623832272136;
 Wed, 16 Jun 2021 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174911.973-1-info@metux.net>
In-Reply-To: <20210615174911.973-1-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jun 2021 10:31:00 +0200
Message-ID: <CACRpkdbwLOOT6nuhpkT5x-AZVipsD2qG8Qu4xoiRotHQNknwzw@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Tue, Jun 15, 2021 at 7:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Introduce new GPIO driver for virtual GPIO devices via virtio.
>
> The driver implements the virtio-gpio protocol (ID 41), which can be
> used by either VM guests (e.g. bridging virtual gpios from the guest
> to real gpios in the host or attaching simulators for automatic
> application testing), as well as virtio-gpio hardware devices.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

So now there are two contesting patches for this and that creates a
social problem for us as maintainers. I am not too happy about that.

This situation activates the kernel management style document so
I advise involved parties to familiarize themselves with it:
https://www.kernel.org/doc/html/latest/process/management-style.html

Can we get the discussion down to actual technical points?
We really need a virtio GPIO driver, no doubt, so if everyone could
just work toward that goal and compromise with their specific pet
peeves that would be great.

Yours,
Linus Walleij

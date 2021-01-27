Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA9305E80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhA0Olf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA0Oj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:39:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AADC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:39:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f1so2687228edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEyKW0OOeD4bMUfDmmY4ocDleZrgI9OkhPdKV5qoR9Q=;
        b=NpkcQrhNC4YHc9tjgqzG7DBQsgSQqM+chQ4UTHFp+TY/c7PVyiUpubswyJzTAL1yaN
         FPat2TWT/YofF982tghVVSNvEu0sfx/bDwbrUdZoQEjq0pZkcheI5UP+vi65N0hIWPVd
         VifIeF5iOuQvWvw3ze/3rvHxzLRiKcT9JydM8UGDc0ENAJ4bLPRw0l0R0nIY2v1Z/1Ao
         zt06xy34R8cuLJfdczhgeM0Lyd4l1teb4vCe1UoCPz6yr2gwqOlkH9WJWIagSD5CMH9v
         YVEKM8xhDJa6x5Cqf6C2zHE2AJx4IjB/UgkJ2/OS4dBtECctzEY9Uetkk1q4Rvglk3wG
         jSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEyKW0OOeD4bMUfDmmY4ocDleZrgI9OkhPdKV5qoR9Q=;
        b=jdKA4kg9RYrWaarOrg8arwZydvqQI0EYUeKtHSP1+dprcGyTJyaqLopkPepuu1cosY
         HOoPhql5rBFzarOp5rEwC1bKeD1mVKe8zt9d6vT0oCYukzQwKLijA34ea8apQ1edFGZ/
         hdxigE614JL5MR6F6mGgdFj68CP0RPUHwzTLc1qBf/pTvasWdogwbguSj1v/M+fBUA9h
         gexPw6IjF0pp0wE3bt0rVnils5wuO8yu3BGwGZDjGtmyb53VxJdT0/ble6rU57UPO6Z9
         XeEkjNi4OshmOyVgZCAAWLHUkFkHoLvkCsk9YXkc1tG+D8mMxgJwVxJlBRS6EbVOxrZY
         frQQ==
X-Gm-Message-State: AOAM532Zfn70nnJbpdhkPDcCbhoKm4WWlXWuNENzLbudbr7Ft+cSIlnr
        z9pUlj8LwtV7RaHq7wHq8jCXQPniXRP6UPAxOXfrSCv+ns0=
X-Google-Smtp-Source: ABdhPJxwP7vlLvBkETSQDDl3Zo3nlrn5s4PVm8Xh/te4H7ksBYhxc09YD60i7DSnCBOBaUnzlCM58jr0O8r6Su8dRHI=
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr9213196edw.88.1611758356543;
 Wed, 27 Jan 2021 06:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20210122195959.4197-1-digetx@gmail.com>
In-Reply-To: <20210122195959.4197-1-digetx@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Jan 2021 15:39:05 +0100
Message-ID: <CAMpxmJVYnxnrq87hmHKnEbCh7pqYUDSCgzWSjvVx4TP0YvKrDA@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: tegra: Improve formatting of the code
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 9:00 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Don't cross 80 chars of line length in order to keep formatting of the
> code consistent.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Patch applied, thanks!

Bartosz

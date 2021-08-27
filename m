Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4283FA185
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhH0Wdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhH0Wdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:33:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B7C061796
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:32:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id i28so13997864ljm.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+9FDw9/QHU2Wo0eFuG7huo1QGMU+3uWfi8hED0MPa4=;
        b=Qo0VtEQt9lZ/c4e4HiAlFNwq9xr+tQMoyt3Wt7RQdgGwL6HgKUf67dATllg2noTt43
         ebC3SuIY1bxw7zwtpsh0PwaKUvUNKNrS1E1lcuTZih1hnrP9JNGmh9U1oWei2OKqIYFS
         ThVca1wMlnWwYP8VcFrWdXuS1iaPSbx6mtmD56wsTVuH8qmUo65InU8ka+YolKM3eSEO
         Apv02vDyTjmJDoKoJVMR792nF69SeO2wJj7g+/twoAfIf8PmoGQCujgvOOjTo5xijnxv
         TlL9dvx7wo4NwuhnJutyvv3B2ttUKY3nVbAczzV5SjgPWNxj0BMVu507Bu9dkLTN9fEb
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+9FDw9/QHU2Wo0eFuG7huo1QGMU+3uWfi8hED0MPa4=;
        b=dMy2zkrmE7IyIeJM6UoyPo+e9HDI1eoyxyiBTWryaEfu7tFro30Qia0meS/9L1rYeL
         rA+sPKZsNCQq17ZaTEkYZE53h6WuJv/V38hQCCWAD4WwvC6S1Sz8lwLcQhRlG10YbsU7
         AQYlQZp3eE2dfjlrpcWzMdzFyFLwc49Wp3wGu0FJ+Hi2Nnf6CEsQIyKYy9YPDlAt1HDo
         Um5cb8y/P+oJosezbWUEjsWBzgmB7Olouj95IKfT7/v3d+EYMqX88l+VqSpxd7uNWmu6
         Cukib8TZ7k0jOFZCfvNKj31OEf6Mc2gNbpEntP5/k4D0xik97rpPURzDiUi6UufaBh8E
         24Zw==
X-Gm-Message-State: AOAM533Yqmwu/cR05SEFTCE0optwNsV6Hb5/oig7tqK7qegmWS7kp6Di
        sjqKrItEOIyz7Ny3FthEXJPxwCRY5pwjT73B1wf6DA==
X-Google-Smtp-Source: ABdhPJw46DrzRYYB5g0PAK5nKm45fNvdCMqobT6783q1X9zEgrOyWSNtHtBiY+lX4PQM2zxUc0deGo6RdtGGOb5ANXU=
X-Received: by 2002:a05:651c:4c7:: with SMTP id e7mr4392319lji.438.1630103567258;
 Fri, 27 Aug 2021 15:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210823112204.243255-1-aardelean@deviqon.com> <20210823112204.243255-4-aardelean@deviqon.com>
In-Reply-To: <20210823112204.243255-4-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:32:36 +0200
Message-ID: <CACRpkdZRRODGR57U2308QMCf6pCoNNWRXxc0YWHW14+CX-a0Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: st_sensors: remove st_sensors_power_disable() function
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:22 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> This change converts the st_sensors_power_enable() function to use
> devm_add_action_or_reset() handlers to register regulator_disable hooks for
> when the drivers get unloaded.
>
> The parent device of the IIO device object is used. This is based on the
> assumption that all other devm_ calls in the ST sensors use this reference.
>
> This makes the st_sensors_power_disable() un-needed.
> Removing this also changes unload order a bit, as all ST drivers would call
> st_sensors_power_disable() first and iio_device_unregister() after that.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

We should at some point add proper runtime PM to the ST sensors
(cf drivers/iio/gyro/mpu3050-core.c) but that can certainly be built
on top of this patch.

Yours,
Linus Walleij

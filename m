Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AFF37164F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhECN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhECN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:57:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B5C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 06:56:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s25so6910215lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q+7uJXapdV8m314egEDhU1V6QX5TMcQtPenPurNvJI=;
        b=mB9ivoZ5UNR6sRV3Ovqt7vd7xn9D15y2o3MzdcFjXGmgf4bPp/mvmDOdDDjhhM1Cy9
         ltvH9p9ujkHd/tUWQXTkc4sweaeYUbImuQE/c/WVZAV/yM2XUStBEa9RzyZ0JpAgS435
         aBHieP5DMWq4tA3dk5SvEXu2jJHqg+L+7y3WVAeTCFKKJaEqFBo0HjruFvzsS4HjvhmK
         BnXZZDQIHrspQyrgfXHZ438/TNBQC0BHxB8BxuUIkaDE67InzMulYvSl9GQBITdGAn3I
         9uUCkcX38acfp3EbBLihE7dPm55cemEEcGJiobDc07w05sa9IHaY/v4onAt8B/CrBVpv
         A9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q+7uJXapdV8m314egEDhU1V6QX5TMcQtPenPurNvJI=;
        b=pmb3clNOLOdDA4vMF6cFzDcY5fpJnOivr2metin7DJCs5MCjs2VTymiZrBVzG3fsnS
         deNWgBgvtLC6NnkgUdxV7iFFVEeeevsAswgDuasWQIdNHBAiQPCNtEqxxcmeKLC683lR
         fV+77Gb4BWreJ0+DoUvrAdYTxS8EWPkXTCqkm1zkl0wOboKHjlwhsADF0XBjh/s4Cl/o
         34V7DT2WvbFtgNLaXQlKGzEntXGDYHTcq1gJVbVO+cbJJrYRDWK4Lhdi1Jz8Cdt3KrBq
         b6LJhpmM4FD5Zl+ikr3f/Q9SM1Qh09z9KaCRgJ8FFSygM4ckYc6EZUMmFmxbFVFjio5p
         znwA==
X-Gm-Message-State: AOAM532KzYgSRnH+lb8ZJNbzjqBZpKypMPZWoKkmmQ8JwcHhvSMDP1/M
        NbfWl1j9M7nlZYIVcquFGGWt9IwAmiAFPSG4IYocxQ==
X-Google-Smtp-Source: ABdhPJwlWQnXCrmKiTAOa3jhSluTazGyhbsHW0pzxJ09qCbZcja+66TPxZcJ3B8UKkjTi+69c/QyGQTJFa42WvhxDrE=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr4801339lji.438.1620050172462;
 Mon, 03 May 2021 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210428150815.136150-1-paul@crapouillou.net> <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
 <CY4PR03MB311245DA10E715A44DDC10C099409@CY4PR03MB3112.namprd03.prod.outlook.com>
 <20210503120615.64b396bd@jic23-huawei>
In-Reply-To: <20210503120615.64b396bd@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 May 2021 15:56:01 +0200
Message-ID: <CACRpkdaA5dgG3f8fEqkSny_uUYC_1nFu3=GAPtwS=aoy7qYsJg@mail.gmail.com>
Subject: Re: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 1:05 PM Jonathan Cameron <jic23@kernel.org> wrote:

> So, I did a bit of detective work on this one.  Seems this change in error
> code was actually introduced as a side effect of Alex's recent rework of
> the IOCTLs.  Prior to that we returned -ENODEV for this case and now
> we do indeed return EINVAL.
>
> So we may need to figure out how to fix that, or decide that such is life
> and modify this code to give the right error message as done in this patch...
>
> Linus / Alex, thoughts?  It's always been a bit messy because we also
> return -ENODEV in the path where the ioctl hits a driver that is going away
> so it hasn't uniquely identified a lack of support for a long time, even
> if that is by far the most likely reason for this return code.

Normally this would be ABI if any existing userspace can break because
of the wrong error code being returned. Linus (the other one) has
clearly stated that the ABI is a contract that cannot be broken.

So I would just try to fix the errorpath to go back to returning -ENODEV.

Yours,
Linus Walleij

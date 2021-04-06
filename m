Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A53549D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhDFBBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhDFBBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:01:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7391DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 18:01:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 12so19924107lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zVKmQWoY5kDCFVTKphIi89O5naAa9hmJVDmMhUdz3Q=;
        b=QegWQwg8yFEvjEQfCigibIGZ4Y4SYCt82rKXcB7nZdTouPX1K6tx0HwrMnL7qNUP5A
         iQHl4FMr64tDr0GroFsiVKYVYlrhoihPg0Sj4TxCkAQZsRt0silaTlbK6bWEm+pwPiGW
         Mry4qd38bWVMl92hpz6pwjc6VScW/Ph1BYcms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zVKmQWoY5kDCFVTKphIi89O5naAa9hmJVDmMhUdz3Q=;
        b=chcTtHfNqPGc63QhFJxQUBMCAWTFJnTpmrFZFpws84NBS5XqwoipBy3xgY8kQ7X18J
         T3F1YcuuyRNq+a67eg+t1JXKU8YCx8ZdGrg8rYuDSxGZh9a3CFkR9xoWOxWZzuBkJ1Vr
         morbVH9GHvTexgELmx4F1tCrh/RiSbjAHS8j/BRoT2aisz2aI9vkrN8LqKIwbh0PcIW8
         gFyTMn40CmRJKDMUukfA2ysMCaffac5FmcTNGJuMgrfXZ2egU05iKnwlI0xZQ6lOxJcj
         hm5wUveJbp27y+GIpWxe6N7NhxO1oEhrdcdXF/ktBMYL4H6k8RWgI6vt4u7KYgqVILkc
         onGg==
X-Gm-Message-State: AOAM531u3IMxrRbOcu01bGoBeiHgGFb40yOj6X262b5tOSNPrOdWQvZt
        eBUZnREEs+8FFYNa/6XcdlWAePT1kz2JGg==
X-Google-Smtp-Source: ABdhPJw64FRaopy6rUWkvCZhFEY0Pnyqd944pjiuOX8OWN6b97px6e3R0MmslIzHeAV/n055+SBGnw==
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr19728933lfv.102.1617670892761;
        Mon, 05 Apr 2021 18:01:32 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b34sm1999204ljf.137.2021.04.05.18.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 18:01:31 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id b4so20054132lfi.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 18:01:31 -0700 (PDT)
X-Received: by 2002:ac2:4e88:: with SMTP id o8mr2166614lfr.552.1617670891135;
 Mon, 05 Apr 2021 18:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210325123446.v2.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
 <049946ac-5263-21ee-9651-7295f0bcf387@linaro.org> <CAP8nV8rv6bKARZ31fVqcjVgMe+5UyVG8UAyNsm1hDCP2BbRSgw@mail.gmail.com>
 <67eed9a2-2b97-be1b-3290-948da662ea65@linaro.org>
In-Reply-To: <67eed9a2-2b97-be1b-3290-948da662ea65@linaro.org>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Tue, 6 Apr 2021 11:01:04 +1000
X-Gmail-Original-Message-ID: <CAKz_xw1ZSuvqnBHDRVLAV3FZKuen0F9L+gjjP=Hedo6G74ow4w@mail.gmail.com>
Message-ID: <CAKz_xw1ZSuvqnBHDRVLAV3FZKuen0F9L+gjjP=Hedo6G74ow4w@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/clocksource/mediatek: Ack and disable
 interrupts on shutdown
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Evan Benn <evanbenn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 1:15 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > That said I am happy to upload that version if people think it is better.
>
> IMO, it is not in the normal flow to disable/enable the interrupts.

Hi Daniel, no problem.

I will upload the suspend/resume version. Please note the similar fix
to the other timer in this file:

https://patchwork.kernel.org/project/linux-mediatek/patch/1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com/

Is doing the same ack/disable.

>
> Does this timer belong to an always-on power domain ?
>

I'm not sure sorry, the datasheet does not seem to say. Maybe mediatek
can answer.

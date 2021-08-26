Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9543F8BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbhHZQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbhHZQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:20:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE349C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:19:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a21so4489691ioq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUk9NbaQrBGgCHXxaScTJSpGIkLEuFKO3aGI4etH/+I=;
        b=REpM3LMb/FDeoEXU8v6kQhgxjh5NgDt67VvzYQGmLNcmDjH3C4lB0BwCUcuQRLeP0Z
         rGgGpq8wh2EmjRmqvFVPR24QGsJ+3wS+dO7uvLeIFIORrLsbwHkelsdky+cRRx8i3hub
         3ih1O4z+gqjz43rs/I17tHmjcOrwFP2MtLyz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUk9NbaQrBGgCHXxaScTJSpGIkLEuFKO3aGI4etH/+I=;
        b=TMew1rKhb03xkGhFDuUl4FPZCguAv2V84pkOTsJ8VFa3wiFOwadgH8oQ8A8yQLvrUl
         qqxT7RqIW4F2h2TKnO8KQiSNOFCo9rFmIuOO0L1Hp40+k78uW9IdfIarWbP4Mv/xyZZP
         8iBiT0aZm8/StgdKhmpPfFomxPokCQsRacXIxq59WKj0iQ/tbb68ouhGayISLEiOlt0/
         0XtzvNRWIUAOzJLpS6gD05ouuUvFdweNDWJ1w1Qb63MEhsGYuHBSFUWbp0jSFwbGFvc2
         b9espiXfU4ABR7sBa6VKgVgC0kacRuI3tNBO2BYv90BB8hpkdc2yDzT/Awj6NyidhLSF
         9NOg==
X-Gm-Message-State: AOAM533IkL6oACizTFw3+Tbwy9QXxiCUHSQtqdAkVwR2ZIo/Pp3PqyGi
        8CBwzwTwHZIq+nOcSlltuuUKm6pvKKRbSQ==
X-Google-Smtp-Source: ABdhPJzzM1zUDZ7IiwnRzmqkmDVyr1UMiPquXM4eF1GVCv05pGz1ovnh208xPWyZ+rjlolJ+91yzcQ==
X-Received: by 2002:a5d:9ad0:: with SMTP id x16mr3780148ion.182.1629994798275;
        Thu, 26 Aug 2021 09:19:58 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id j13sm1935943ile.85.2021.08.26.09.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:19:57 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id b10so4454387ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:19:56 -0700 (PDT)
X-Received: by 2002:a02:644:: with SMTP id 65mr4176713jav.84.1629994796361;
 Thu, 26 Aug 2021 09:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210825222514.2107728-1-jiancai@google.com>
In-Reply-To: <20210825222514.2107728-1-jiancai@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Aug 2021 09:19:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VAkWz0QSN7GivNrkv9uv3JKisush4C+Tb-PMpNokt8Wg@mail.gmail.com>
Message-ID: <CAD=FV=VAkWz0QSN7GivNrkv9uv3JKisush4C+Tb-PMpNokt8Wg@mail.gmail.com>
Subject: Re: [PATCH] coresight: syscfg: fix compiler warnings
To:     Jian Cai <jiancai@google.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 3:25 PM Jian Cai <jiancai@google.com> wrote:
>
> This fixes warnings with -Wimplicit-function-declaration, e.g.
>
> ^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
>         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
> ^[[0;1;32m                     ^
>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>  1 file changed, 1 insertion(+)

Can you figure out which patch introduced these warnings and add a "Fixes" tag?

-Doug

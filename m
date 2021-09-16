Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783EC40ECE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhIPVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:50:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC31C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:48:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b18so22635552lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLmpS256d6dWCIxzsmhG9HA5MAvk2tpnzJgjN4h0+AQ=;
        b=nfqXMiK+N0xAtyxTar98ZiBX1mIw4UxLohfvIM3Y0BKEem3uEKscqFo49HdT50aReU
         0thvc1nqVbw3XuQpQS8nyOoZv1DA9CT85C8QUC1eTqOUr9BE5AoRrKWDcDrm5VY04DAL
         BxCX6sqyn2rXTX4x5/PifBORZdDPLtYENMFNzaLItNBua8EBMcT4I+uloJ7k5nXRWh9l
         xZD7O6tjLO+9aXn51yqj/jT6anq7Ma6abX0SpKcquh3BTHEyUhIpS2K/kzmJql8RotcY
         bbt73Mlv+rCMP6LDQL1YqhKCxzIHY8J0FRCFnq2fT2EsjZLQLRoPM1aMEYBfLC0EBnBB
         h+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLmpS256d6dWCIxzsmhG9HA5MAvk2tpnzJgjN4h0+AQ=;
        b=mT/TA47o4wobcP9MFwb9jkZN6hH2iMpdr/kZXOiCpq96pn68Vi6fzOkv2+noLUhD1z
         L2WiZYVJwiZ3ZEPjoV01bIsgTrM/LEgr0ZggOkMiTNbMrUzKOz2w7tmw8upx6qFP59am
         hSMJcBhcVeSoWfqiE14fQKzb4uFgehybGV6Joj/HY3+C33L9yTxaXv5iUgvtnIdw32VT
         fiGYJ0NDC+PUEPEI6khXiG5bwfUAM0J9yrkNiW38Cb4yre9zgUx6jb1ZboQ/+oD675/H
         KvybH5mtPBb+sWu42T+655ubQDPYL4d+i4DquUM3TOHMxsramHqieBKBQSMEeWPlSwFq
         7KoQ==
X-Gm-Message-State: AOAM532XCosphCHqca+NmxifA0xSX0P5xwa8z7qymhHA0tBUpOhUAOW7
        1AhODyrdfK3rJcEpe8wGr7YyshKIXztJB5If2xFIvA==
X-Google-Smtp-Source: ABdhPJy1caAyjEHrOBLZXHsJxtW/QKOHhtWhFubD0dGvYAFGwzT18czxRCJqb24HabDYFoCgOKNER6POGkVvwVqE7fI=
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr6741306ljn.19.1631828927612;
 Thu, 16 Sep 2021 14:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com> <20210824164801.28896-9-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210824164801.28896-9-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 23:48:36 +0200
Message-ID: <CACRpkdZMGcYW7HjKegKCn6yT=f88KQ5BZfA37iyfrzv2s1hsNA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 08/20] kernel: time: Add system time to system
 counter translation
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Christopher Hall <christopher.s.hall@intel.com>
>
> The GPIOlib event generation interface supplies a time in terms of the
> realtime system clock. The driver must translate the system clock to
> something meaningful to the hardware.
>
> The Intel(R) PMC Timed I/O hardware uses ART to trigger events. For
> most Intel(R) platforms that use TSC for timekeeping this added
> function translates from system clock to TSC. The relation between TSC
> and ART is easily derived from CPUID[15H].
>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

I don't quite understand what this patch does, but it looks very generic.
I think the exact usecase needs to be in the commit message.

In either case, this is a patch TGLX et al needs to look at, we can't
merge timekeeping code without their consent.

Yours,
Linus Walleij

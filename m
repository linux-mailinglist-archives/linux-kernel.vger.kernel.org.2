Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03003EC4D6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhHNTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHNTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 15:52:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A98C061764;
        Sat, 14 Aug 2021 12:51:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so16210125pll.1;
        Sat, 14 Aug 2021 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxxGG+b1/SO8O7pZQFU6nsAVt6WPk1hghVx+kIHzs1U=;
        b=ce4Hm7thxTM0nRMTHfVtf7tM3GYn+4Kc3WuDFAzeUQ+kuQzj+aokoG92fDE9WfMJ8R
         9DDZGwmCb3o1iWicjVTFKKjr64stYimATPF8dT2Q1BAFQLmVZ7DnZVGyH7ZYE9tYf+zx
         gDdb/hCYQqbFwx64yHLefc/l9oKhyiFDC+mU/6LhumT2SsMZsZH8vStKRqcRn0xsWxE6
         knXkZ9ZKjzGRkmGf+otJglsgitOsUJo84edaFIuMkv5bk5EFKANxYqvFK7D2XrLsnyBj
         oqykMyQT5IcyyS8SnJjwmsrCmEEn4HkSj8amL09pMDDmEhYch3tkA9K7xS/Dfr8FqXgk
         12LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxxGG+b1/SO8O7pZQFU6nsAVt6WPk1hghVx+kIHzs1U=;
        b=N00TYuBJEXxjZkzoIKuIoHJo8HZQSExPhoiFhlHQUBZxYMDGJbwHBlcvVFrGp7YLtP
         dC1QEp0pdLWZHNGiqzO+AZI5D1gMfdjRvi2huRxUBFxhYKhwTeaDdroCuXQwI1m1RZLI
         4TUuILQ2l1PZysg3rtiA15YIsFdT7numiAIayppsS74O99fVRa54qsaLguiluu+tR8Rb
         voVEuruitMMOQ6KrbqafAGNvhJFwisX7T77WCB/2PkSH8o5vLopxoQ5q8ueA4kLtWeC9
         nrooYcrFtR6UQq5uQj/JghP4vAIB+z9WyOCg2snPEfHnekyNfXrvQXTwNvVpd+N+wYdu
         v1Lw==
X-Gm-Message-State: AOAM531EqMVsUGRlD+VKJY5rE+vgbGo4IHeNtm1c+nTLS9d48u/84F7c
        wP/AkLrsH0HM6nF5rnpbKpyH2FAk+IvZ7NIdneg=
X-Google-Smtp-Source: ABdhPJz1RVJrAZDM6jzLNgZfJaGyWPQ09MSmLz9bOP3ak1gQUnqkZmLyTc9guQBg+sr6l6+wAKk64xTN4MWnpZj8fUU=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr8355749pfi.7.1628970713254; Sat, 14 Aug
 2021 12:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210814043103.2535842-1-luke@ljones.dev> <20210814043103.2535842-2-luke@ljones.dev>
 <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
 <UCVTXQ.8ME64G0S1BQ8@ljones.dev> <T6YTXQ.N7QG3527OXWU1@ljones.dev>
In-Reply-To: <T6YTXQ.N7QG3527OXWU1@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 22:51:17 +0300
Message-ID: <CAHp75VfytvCwAgFdo+J_MnRJ3knYmmD8MR80ZbyX0re4hB0vTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 3:47 PM Luke Jones <luke@ljones.dev> wrote:
> A very quick question: should I be enabling platform_profile by default
> if asus_wmi is enabled in kconfig?

Very quick for you, but me. I dunno. I think the best thing is what
Hans can tell here.

Nevertheless, I think that this kind of default should be applied to
all modules (yes, I know there might be possible exceptions).

-- 
With Best Regards,
Andy Shevchenko

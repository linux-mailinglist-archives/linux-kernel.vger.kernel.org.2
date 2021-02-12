Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9627319B96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBLJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBLJBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:01:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:00:49 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u4so10678103ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pP8IfofSQOMTyTQK3QurwdHzvMKt17mfyF6G06VuY4=;
        b=BE2sVqkpY8iV5KlzoqSFgIqejZnRPNqnhM6tgGP/yYdQ5eOPscSlPOQMmId00RYG30
         ffQLABcNE9F/fSol9dy+3knyrjhm+jHJZna5fQGWPplxbdiCVw/O6qoNlngMsDpM6lhO
         8kM32MuSPmnt5z793i75BDy+Tn9TMlZ1XXOekIVckGv6jF4BVCEQpkJdWnMuIkNJSgPK
         c80L0q2OYeM03ahUi24Ot0UkVLhzoDfXFQ1Atrr84vOjSYKIA3t4+FebplC6XijIDqwq
         2CiZiybl0OOCSYfnQGO0QUcGfHMtoh83kEbKj8Rs9BLd6F3iK+pVI58GVOc++DgSs5PM
         gmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pP8IfofSQOMTyTQK3QurwdHzvMKt17mfyF6G06VuY4=;
        b=iXw9Old2Lndeg1VIbv2nq7n98ESGKtAcXJouoXOxIGjEt6TvAaCBmyI5ujwZISC6kw
         WJLP1U1NgSvt0wae/2/gQwWy07tWwEnquJVowEz7J1P3rU7KeJbDXaaKTy6/5nDOfnca
         lKQqlTUi0LHgBLzWtrp9bKFvLncjgdKitDmFyIaU85MchNnwxi3EMorHt/7hMitunSsh
         Mwum6RfdrOKo438BTH8/LwtlZTvRUEuUFcWD9go64PJFZoymRTCLA/gz2Gzu87d+6rYX
         ctG9Ng84y2cO4vP9MOAbZuI7KqN1LpSSK7dEJ6C3x6kJZdFWPOrh1YUD6/rRGdZd265i
         DmXg==
X-Gm-Message-State: AOAM533YPvR5aizZtsFKb9sUIGLQeoXUfkmcrtXbkktfxJ1QNAGwQFnW
        Vv0wagSrnla5HVnDuZzxUYiPE1I41KI3Oyem8RYGBg==
X-Google-Smtp-Source: ABdhPJxp220Yhyu3KHp6tFzIhAqaKO6NgKCwcJhjjshCAICA/X6GwVjbfUpJnmZIwex3hBvnP48RP/kcS+Py2GYQhOc=
X-Received: by 2002:a2e:8998:: with SMTP id c24mr1221309lji.74.1613120448271;
 Fri, 12 Feb 2021 01:00:48 -0800 (PST)
MIME-Version: 1.0
References: <1612688430-54282-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1612688430-54282-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 10:00:37 +0100
Message-ID: <CACRpkdZho-zSTjVFNSrcQ_VWdgKpW_jpc-bX+EcA_dzdGgOKrA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: convert stream-like files from
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 10:00 AM Yang Li <yang.lee@linux.alibaba.com> wrote:

> Eliminate the following coccicheck warning:
> ./drivers/gpio/gpiolib-cdev.c:2307:7-23: WARNING: gpio_fileops: .read()
> has stream semantic; safe to change nonseekable_open -> stream_open.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This doesn't make any sense to me.

It is pretty clear from context that this file should *not* be
seeked and it seems just dangerous to randomly allow that.
Better safe than sorry.

I don't know if the function nonseekable_open() has an unintuitive
name if it means anything else than that. I burnt myself on the FS
before.

Yours,
Linus Walleij

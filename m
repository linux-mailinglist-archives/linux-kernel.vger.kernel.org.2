Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3E39C9D3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFEQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:27:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1AC061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 09:25:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a1so9073273lfr.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrCDT9/BrFc5JTZQvS/vmJq/oRXt2DZtyVSWmdgwMSk=;
        b=NO+aHNUK9eeNAXYlgZh+KdSaJPd0/ddCUtczvY28depLkTGy6F3fT05tmVi3sw7ycH
         mmYh2Bm0ignR2mXzhBksbvf7IWCw2xPhxUDKmkjXKTn82/F7eM53hqh2AMHwnd5Gy46E
         gEB06bXm8YCNWp79uD48Qml1bYDafyzKoRGlWfvddfZF7QO7hyFf3ysWGfRSF3knwOa7
         udtK0E82puJ3rfpuNk/cdlQT3m1z17G6YOeGaI5TVniO182hHOKEhOlhfNgbjt6eLtvr
         SYO+A+5/hgcIh0sb4YSr1VHJKVPm3Y9FD+pV3Tld07I+yHuKa9ma52CuKb4FviJkbn7X
         QzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrCDT9/BrFc5JTZQvS/vmJq/oRXt2DZtyVSWmdgwMSk=;
        b=oIjEmFF1RBuyhqCuQX4VrZ8nkDbIQfCEa9XURcZKgbBhX82y0Bg4R12MKiXxifAu2G
         hDsWptpQ6QxjVvjfz+F5M8rYt3HmdeqOz6OtuURfQG+Nk9USC9bRZ0iWBWzRpcRGLGle
         zX5X/xgu55HiQlnScFo/7c1XMkW/2C5lET9Apk2FwqqQ1XDbLF3PkhezFxW6F3shjVW8
         UX8qZbpFPFmP8rBNZD0m7s3qzK1jklZzIYGDOsy0Jssx7d51kTEHG/S2ixAeTNEZrcRh
         bpWBnSo2fqpsX54qwY8SCHg9nZ7ZJOsyLBnlooUJDpyrX9xxdLdLPUhhps0tGTPq5mGW
         QDYw==
X-Gm-Message-State: AOAM530zbdV5cSDICuCU1QCV+oqezyenTmPt/NS/72sfPiI6GTYSwpRW
        +jtg0lQtFQd2PE5ZUGt9szHjsy6q1vsSv1XjCAh0kg==
X-Google-Smtp-Source: ABdhPJwWXh8YFjT5OUKlc/yT0+RpQOtLPrqc9AOXSBB/yaIWf+9GL/lva+Gj/FpKd1g/afqGfRV8xMUi4XrTt8covsg=
X-Received: by 2002:a19:c753:: with SMTP id x80mr6370090lff.586.1622910349250;
 Sat, 05 Jun 2021 09:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622898327.git.mchehab+huawei@kernel.org> <ed02be4feb78dc86dbd17ddfa2e896d8dda7fa8d.1622898327.git.mchehab+huawei@kernel.org>
In-Reply-To: <ed02be4feb78dc86dbd17ddfa2e896d8dda7fa8d.1622898327.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 18:25:38 +0200
Message-ID: <CACRpkdYYioDfJFEGREhjxmT7YU5_3nrJR8wP3BAC4b=ihqVY5Q@mail.gmail.com>
Subject: Re: [PATCH 18/34] docs: driver-api: gpio: using-gpio.rst: avoid using
 ReSt :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 3:18 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

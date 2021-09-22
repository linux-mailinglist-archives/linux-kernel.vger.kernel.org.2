Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B786341451D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhIVJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhIVJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:29:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:27:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 138so7183214qko.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tilLj76TPuTpGDBFmhCvj0XM+49+fiZL/DQswhreJ10=;
        b=nofHkNUbYZJvR4FoyoBpnjRnqf1qNSRV6vW8PlecT60OgNgezJSuZ8F8xsvsTa4RiX
         qstp+7BG0ldBR15Yrt+ebdFB9rpBPDvkSkIp2nVChS2b/BEqM2iOhGdz8FUQsJZPEbw6
         CNXKjna7Sq+FlRpCA7dhwAxDfHWDG/xOYceelI0KuyWtkHWDnHsG/dP0uJmm8/gWvLjG
         vrBnB74DHp20uq43sdBTOwZq/3HND/7TSQVKuj5BOHprjA6KCdJd+Xj3mmmNs4abR88I
         sxW8jNG7sCScDebqqIrSZCE8zz1UpezSpxb+T1LfXiMWyvo4WHTXHW88K1phn79BJWRH
         xRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tilLj76TPuTpGDBFmhCvj0XM+49+fiZL/DQswhreJ10=;
        b=itjEEvjeIqCDPIS3hSlUjG7kStfz5GFiu4v2Q2G1CqvAkzI9BAv8VmzppLey3uG5C0
         l8Rl3sVg+LLOdPTySya9mNh89cRP5lBg5jEcUDuUoeCk48ZyNHDHykyj0OLj5T9sGQyA
         dsoqWaj0GTKnxBxacoobkctCTdR973yjFWtQY6KM+bCKhSQaGZ2t1xyLbbSFSkPqAzFe
         fVBFtlnm3+NXWNubGfJal+ZfrwvDTwHiUYhjcW/U7oGqJttERQcIqIDwJwUL6VqYyQnU
         ze9TtetJyRjbifJ7UaupLL4xEcJ9PhSD6KRMa3tWvxq5GgfJgdEQdf4kCLjuD7YcV2PE
         Q7Uw==
X-Gm-Message-State: AOAM533241zlkKyO1sFh0kLpBQfzD16WxI9FJlobaDkHWtTh++Q5YrH4
        g+00V8SmN8FMpDF7KlTUH3aaLUrjvUtFLHyZ99vUPQ==
X-Google-Smtp-Source: ABdhPJx+7jMUDAlovngPB82cNaH261sjiihbmIpUdUWI+Yq4Gh0SgtwiTP2LNAxQ2CQe+tUN/BPbism8KQnVzsefdz4=
X-Received: by 2002:a5b:783:: with SMTP id b3mr40104169ybq.328.1632302857487;
 Wed, 22 Sep 2021 02:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210917105412.595539-1-thierry.reding@gmail.com> <20210917105412.595539-2-thierry.reding@gmail.com>
In-Reply-To: <20210917105412.595539-2-thierry.reding@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 11:27:26 +0200
Message-ID: <CAMpxmJW5XkwrawJX0ypJ9BVV4_LEO6g3EkptGKG0LCxsmHKriQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: tegra186: Support multiple interrupts per bank
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:54 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Tegra194 and later support more than a single interrupt per bank. This
> is primarily useful for virtualization but can also be helpful for more
> fine-grained CPU affinity control. To keep things simple for now, route
> all pins to the first interrupt.
>
> For backwards-compatibility, support old device trees that specify only
> one interrupt per bank by counting the interrupts at probe time.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Applied, thanks!

Bart

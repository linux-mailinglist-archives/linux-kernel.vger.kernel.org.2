Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9909410D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 21:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhISTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhISTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 15:43:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2ACC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 12:42:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g1so58427418lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=267Y5GG4wv3jBVNFLCjYNg4eEpoY547mjd1IsPwkZZ4=;
        b=aCEfsATQGKUcZ6Gbf07F1Ad396sTKdrW+S3XJ9iraG9sqiyz/afeQxWCIk/lwOXWWu
         vmHOByZNuk5iXVZOfH39JWTuJ43DVu5kYyEflMaLVzqKsLtvGXOT5Z5MH7JYhHgR2Vg7
         0+uN2m38f58OtVTQBeetop+lFeFnf9ATVg1sHCh9OsjFUIHSd7e/f33b171Sch/cqbQ1
         5KdGzTp0kNomZzOClhbZFDzi0Cf8L3whqyfMhoIe9RgyAuYV3bA5/j3l4kQhBIkCgIWm
         kvE825n+8A0Ad3rA/rnww53FxHBs6uWAoPA6JCYRETNN/Sn0KDQ3VuyQV314Qby5eqZ1
         dAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=267Y5GG4wv3jBVNFLCjYNg4eEpoY547mjd1IsPwkZZ4=;
        b=MRf4s+4pauYD9G2bBqkVlAfQd1KjNbjK89fA1G4jyWPXtyTt1RwD/iU2434PvVgWk/
         HocElqKQclVhULFrK73VM6zn3X4n89bKqyD/AnCHU5yix1+/dJuquAUc0rLW88RN/JGF
         FTLbrZmuo5PqopgHwIbbyArrfqqQhnDM9aN+NmCZDnrG3sWca+orwKAmFytayvSK16My
         WN8ZDP4uw3u7kb/xGj2Z9m7y3Yl3NXOK7WGoWuvfdZ9saA0Pqrw3m2a0XCjF4VCQF1Hx
         O4vO8ad+QMyYonwMGJgNuvreMv5RrXw9wCCpJobHNZV1WZA6w/RxKZBjjofREAWksOAt
         oLRQ==
X-Gm-Message-State: AOAM531FPJ8DU66FnRI4javpgySFAW0iHZSBwPVxOXYVdC28rWHzl8tC
        IL9eRFmGMi2awIB1VxSXcQDq1HbpIXRkeKVXv+8aKVfnCrE=
X-Google-Smtp-Source: ABdhPJyOo0GRxViJevniGs7x1CN7wVCSU7UZCda+WhFRVhOAhvLyfjPAJB50V+BaC7FyiDJ/fYxFy0KgzWfbWa2BcZw=
X-Received: by 2002:a2e:4c19:: with SMTP id z25mr13156944lja.145.1632080520043;
 Sun, 19 Sep 2021 12:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210917105412.595539-1-thierry.reding@gmail.com> <20210917105412.595539-2-thierry.reding@gmail.com>
In-Reply-To: <20210917105412.595539-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Sep 2021 21:41:49 +0200
Message-ID: <CACRpkdboaxpVhLHRmWw8vtuXNZB8z5okSYLCBae-WzNjpbyK-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: tegra186: Support multiple interrupts per bank
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:54 PM Thierry Reding
<thierry.reding@gmail.com> wrote:

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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329F942C2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhJMOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhJMOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:22:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0231C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:20:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w10so6834402ybt.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyKByRZ/GuGOHDrRuueIn6LgYP5RDSup2vvE0IokD8s=;
        b=NGVzezf7p6vJzoklIghoKhL+hht/BTn6fN63XbvwLmauHIhu+i5d6IBDzZvC2qqyYk
         uHeQhTjzYWS7OxYDmE8fkd48I89FwtnaXQEDsZeXGyMPGZg9aPbyHMDGuL/RTjtk3iPI
         5OOJHX8tG4O/1Zdwb8tR9u3lFOgtRIib17pIhxnrgedf2YoHOUm/WJDao21wON8zlT1W
         15TIF6h46SvTMavAPk1KFie9YtZPDQsqw+KDPM3C6qsvdOA0sJ4L9i9lexeRa7ES260L
         favwo//Q4VQfBbjKvTEhZX7xdGJcLkwl0uL7uAIjfamm2+I8WVT+6mQZtK1kyD2Eau6r
         qS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyKByRZ/GuGOHDrRuueIn6LgYP5RDSup2vvE0IokD8s=;
        b=PdRSS4b8dG9LoqX35UxDBsAEeXBCkzcu5w1n8vl3JFmC0f8zvWwkRSQfHlwq897d5f
         Da5oRIT3gJJ6pO0kF3as8DtAnP4P3BXrpnYhli26Rktd1taqztldV0KHpSELceXSmX4Z
         VawmkhSpZIL6sfrltqKA8eLAbcQPvNue7NDUrTRrKyPEMne7sriXnUw0Lwgy4IsjZ3qC
         BLOA9A9aIXEwnHHqElGjj8w0zIrfWJH2U2loVLxOWN99TZtfQljQmudDGyc1GuPo9B83
         GA9PkuhOYJn2XnHyHj0tgi8qnWLfjF9b3RB7laJv9NGm1B1FgKXoDB5Vj4UQ1tTCDyUn
         Lxmw==
X-Gm-Message-State: AOAM530+QVi3NVeLY/8UBO/ZYc8c5JNqn8c2KP0bWm5FggJeRSbT1phQ
        TvIT5pSMj2dp9FCopd46A+zZt51jgI7LdqQZphjezQ==
X-Google-Smtp-Source: ABdhPJzV7FvDqXnP2/c+tIkKIHJgVm5PoSKUOXLUcbwUa/7LqAgQit9Ik4/FZYygnuN3nD9Isi9aMbdateBo811erno=
X-Received: by 2002:a25:5402:: with SMTP id i2mr35635403ybb.312.1634134826062;
 Wed, 13 Oct 2021 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <a9af5139b6b8eb687495ffae69d32acd305ac2f3.1633351482.git.geert+renesas@glider.be>
In-Reply-To: <a9af5139b6b8eb687495ffae69d32acd305ac2f3.1633351482.git.geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Oct 2021 16:20:15 +0200
Message-ID: <CAMpxmJUgewcoK7YDi0MPNhmxefgeTaeaAQ19ey61740KDJz_KQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Wrap access to gpiochip_fwd.tmp[]
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 2:45 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The tmp[] member of the gpiochip_fwd structure is used to store both the
> temporary values bitmap and the desc pointers for operations on multiple
> GPIOs.  As both are arrays with sizes unknown at compile-time, accessing
> them requires offset calculations, which are currently duplicated in
> gpio_fwd_get_multiple() and gpio_fwd_set_multiple().
>
> Introduce (a) accessors for both arrays and (b) a macro to calculate the
> needed storage size.  This confines the layout of the tmp[] member into
> a single spot, to ease maintenance.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks!

Bart

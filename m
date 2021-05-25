Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC638F6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhEYA2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYA2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:28:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:27:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so6170897lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggN1ZyfpjeoPcK+b5TpMOSXo8A025wCmUM01aYg2EFg=;
        b=yOT2sHQJz8nvp4O5Q4NWuzU2gw8PBgy3p+S3aN5f0xs7BIpw9pWlTB5YBfiIhph5Gq
         3e33psxLGjctQdgqQbZapy3ir0V8qNI8Hjjc0YzhqWOMydI9tBoaYv+LsXyzCHmMJG7y
         3bzpcXma78Www3l4uL1lNF6jOMiRuS4OwYSzkY117QzTmLdGPIVMsQWdHnww5QxrwNxN
         Ulxqccg8A1YclQdQqkSYCME5+iV+SosXJAtPDM+vJqs2lj8beVe96oGlR0SY2QoklGvy
         CNIeUM5pZJodgZSHoa+B+0UDGT/lp6TjDK1VsxnDxZeBma79xT4cd3vOuzmRsk1H4iI5
         sOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggN1ZyfpjeoPcK+b5TpMOSXo8A025wCmUM01aYg2EFg=;
        b=rqkd0MCHPEHIR24xm7EhDXXQ98nOBVd7OlOsi2f7Lyj4+ZSc3Zcb+1w+6jZyYWcZSV
         p08u4BztMPIxjnjHSABMjQzUAVbD1tHWjplyBVLnQxD2EBtUWpzUiIoWAOLWbHbpek7M
         8jbveD8EFRykbwhjToIv/gOstVYKKtTdtSJcMSf3hw1CVYOuvoTiOqgKwV/aQUn5QwbY
         MhE5S0X+8Qo28p6NF+uruk2cMxfW1D/UOzjZGEMRKU4yvQEQwbO8MjfleWE/73Y2hHlt
         5AyeewgKoOiCgra9ehPvJWAupZPClfqrhRpmG6OA8hUfdg1JTbvxhmW4KETcDwFp+D0Z
         Xowg==
X-Gm-Message-State: AOAM533yPQbIlsna42sNyJmaHhOzfxIIdhwtcVrwdq9VNptnOIWfqTAG
        KOmtE0gz0a/EzZTQ3qNOeX8P29LD17uC33oQxCc6Lw==
X-Google-Smtp-Source: ABdhPJyTefEIZ5y+qK7V+5Tec9ATzRvj6RgLSmVl0ftrBQcwXR6JAiYbyr8zFfudSZ+XDMF1phSLLmlUZr5h2L0Zwic=
X-Received: by 2002:ac2:5145:: with SMTP id q5mr12322949lfd.529.1621902431406;
 Mon, 24 May 2021 17:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210518155013.45622-1-andriy.shevchenko@linux.intel.com> <20210518155013.45622-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210518155013.45622-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 May 2021 02:27:00 +0200
Message-ID: <CACRpkdZad8huHXpNrJ4eeMpxnEkPBpQy1paOM8OmG5TQ0q3Tww@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: Introduce gpiod_request_user() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The gpiod_request_user() is a special helper to avoid propagating stuff
> to user space that should not be propagated, e.g. internal error codes.
>
> For now, hide EPROBE_DEFER with ENODEV.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This looks like a good solution.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

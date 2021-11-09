Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1059344A5FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKIFBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhKIFBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:01:47 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51ADC061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:59:01 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so6599330oop.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irWfmlcyPuQHKKPir8OlxwwVnibLr6uWK7muZHmIMsk=;
        b=WzK18Y5A4egmuKvtBbizvoyHLqZQwgphFe0O19EbuiJRo0oG70FWWhAqECIkojaMTE
         LGei/ky0WwZacG7gqMOVuP6JrODhZG0ZvLRWrSl1p4XkO+hxU5UAlejPj2KacG1fLPBP
         AURwVMA7gLsyTMVWlEkcqjb2T0KilFe1jhZ4kXAO/tCscD2iZzmaN7LJz+web0hb/av/
         sXy9+WTDxPk9gzQW9iODIOP4T+mGKZZnWeYnlfwzLWcYbWGWZn3wmw/1GYD9qh1FjAMI
         vco1WzrmtuHAJaTFKzZ4GX4+Wazy1QgHkWe47k5aI/ouwH+EJxoTJddSpN4RMJzlY0O5
         X3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irWfmlcyPuQHKKPir8OlxwwVnibLr6uWK7muZHmIMsk=;
        b=VM6HJNHJVdOKIXTyu4sjlZ6DpVCaEPgnd6HtLn7rUuhJTf2/YUfkG8HuGUw4KnvQV/
         lYQs0tKYLttJKFXi1K7IPsbcwya3TrepDbEwQBAOn5xjNnyp0/YRxRihg6nPAGAujpAw
         9m1YWduJ9ACdDX5kI3uCTv5jEaO5niNzBsvX62aVVy5EECND3UzNVewuUQOPIJj/+qB0
         /AAbLr3wili39LcvKEmuzF/V7xlc1lRFq+r4M6wKEuY8RPUGYI4mbelb2hboHiURo7lo
         Are/C1ANeBXr7tDdNwRi8wyxK+p4am61Sdb7Bdysrd9qlKZiWrsseaiRRowr72pRH70l
         F83w==
X-Gm-Message-State: AOAM533SY/hIO9TbceBkz0OTKEGg74f+W4FblH83YgMNkRXCINQJ/C28
        BAudQZdGjJcEtM2YWSJT2wmu5XGAeb5B17RYCM42aQ==
X-Google-Smtp-Source: ABdhPJzA0fBJmolcF9ydwIK4LPh8g10cwPkTOJq8YZWFOGCxYdG35tZxSmMOA+s7P/3EH5wClIkzSAPkiWKZInwliPU=
X-Received: by 2002:a4a:5b85:: with SMTP id g127mr2368667oob.86.1636433941005;
 Mon, 08 Nov 2021 20:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20211029092703.18886-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20211029092703.18886-1-kavyasree.kotagiri@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:58:49 +0100
Message-ID: <CACRpkdb6-Wa8KGnx9kD5zhPLBw1YDZQgfDPm35VJzNnt27d3Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Extend pinctrl-ocelot driver for lan966x
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        quentin.schulz@bootlin.com
Cc:     robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:27 AM Kavyasree Kotagiri
<kavyasree.kotagiri@microchip.com> wrote:

> This patch series extends pinctrl-ocelot driver to support also
> the lan966x.

Alexandre Belloni and Quentin Schultz worked on this
driver a lot, so paging them for feedback/review.

Yours,
Linus Walleij

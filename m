Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D1307573
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhA1MC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhA1MBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:01:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE81C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:01:12 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f11so5975463ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9EOKkeTY2+d1Fa4iHB/4cHa37Z0fzFo4OzOK4oM6Q4=;
        b=F/CmSMOuSr5zNpyIz8oDpfs0uxO2NhcU5b2INzxjrItESHLsnvvNX/yf1410eKA9ve
         VQpoXLUK241FEkj9ofwBDSWNFjyOlJ1/B0w503sD1RjI/Sv8Mpy9AuKTl4v9unPAbVpt
         o2NhCHR1kO8BzF2uLKVtJlY/eb6hmEA6dxkoKIZIDA//svyJxEpWliH0+/KoPRpX6yuQ
         xOaOhiqgJROQ4qzL4Ai4Vu8QEK7vHTmjcR+D0QSzio07rhzy0JmaMHDNZNHoYvUzzBdq
         PIk0qSMqBACkwRrT1oeqoueNhsZKSRQyiROFe5pXaQq2lZ0IVc3HI0/lPCj4ym1EPKe0
         BuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9EOKkeTY2+d1Fa4iHB/4cHa37Z0fzFo4OzOK4oM6Q4=;
        b=j1kZj9h1vSxABGy7V+ZWoGKgr6yo2z7pGk4Pwws31qU79sZDUwGBWjGKqs0fKukBrq
         +xYXQR6tCZ5ASBfSbPnjcNNJyOSGhbJkpUjqFU0GBm2k1XCBPjc/dsm2Vohozz9xuSGA
         FBf4JJQvAnLJfk8cU4cUlDSyxZWW6RMqQtql1bHL0zhfOAWK/ZangoXcvl4v/s0PACL6
         5GzoReGb0QLrFxITJHpdDJC2LE/IPnjLQ2k7UFgteameYZmn2vhuxUuxoC1JLNGnTKza
         vhD7NcIAOd+qeIZUYuOiufMDkoxjeFn/6vvTrkcgk7vfclvm2ImUYBsHusRHnNIR/c4Q
         o+pw==
X-Gm-Message-State: AOAM531UeDq1Rg6RozVFAKzCOKcZI08DLzHU2xZ/FO1S8Iyywkimx0Ki
        zqs/RCuXdGbmHf08/dR+oUBdBbAioTlcw2W9SwbUXw==
X-Google-Smtp-Source: ABdhPJypbRkZO7oNmfkvuCEOFNhZkoDt3uSClsJKrU2bBbdo1JdlUWBieGzbeMl4eG6ef0bI+oE4Ri5xIQqzgGc6PuE=
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr7938969ljl.467.1611835271030;
 Thu, 28 Jan 2021 04:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20210127000303.436595-1-drew@beagleboard.org>
In-Reply-To: <20210127000303.436595-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jan 2021 13:01:00 +0100
Message-ID: <CACRpkdam4gY3iU1DBtczgdnxQ-t0OkrRMZ-Y9e1W0FQOrYnndw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x-pocketbeagle: unique gpio-line-names
To:     Drew Fustini <drew@beagleboard.org>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:04 AM Drew Fustini <drew@beagleboard.org> wrote:

> Based on linux-gpio discussion [1], it is best practice to make the
> gpio-line-names unique. Generic names like "[ethernet]" are replaced
> with the name of the unique signal on the AM3358 SoC ball corresponding
> to the gpio line. "[NC]" is also renamed to the standard "NC" name to
> represent "not connected".
>
> [1] https://lore.kernel.org/linux-gpio/20201216195357.GA2583366@x1/
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

This certainly looks better!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

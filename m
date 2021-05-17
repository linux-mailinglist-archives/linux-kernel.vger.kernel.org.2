Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0F3829C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhEQK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEQK1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:27:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BAAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:26:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e11so6510138ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TABM48q860KIIr5PxtnzEvdl0N8ZAcbff2DSZQYX9FQ=;
        b=DFOwNqZzH3LgNcrSdw/Uy8RJXi0IHbACsyD2QcUBdAuGL9d+Rl46Gs27xrsbnYwctP
         PY5UAYk6szw/UjjC+5Km++3YZdlzR29hatmAM5g1n5uEsVTU4F1THp6bJiNu1NbfsGx2
         evh3lkswyVPbI0feh8liiShu0AeCLPlxOiZxziy6AQ487e/nXzl/CK1/Hh0Ocf6/Vgag
         dRejebsGWU2W3Ji8rQ4HYrw44vjdolffNxMOQTgML6z4x+sigvg+TePqtEvstpIGoJ7M
         njEFushs67lFinE8EuLgKo5JGGoB8KxZYJvuyxtO1gXojCDrGVi1srnyteXk2SC0bMO4
         B1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TABM48q860KIIr5PxtnzEvdl0N8ZAcbff2DSZQYX9FQ=;
        b=K18AFiWxN7Vv8ip0DblOgyT/EGYYjCAusQnEMcochP3TZRHarhd1S1Ue26mCwEafjI
         UzbeG31ZjAzf4DigzBPGUaX0eTpuhs+76UQcYHVQLHbDCFptAXgJtVHAENfoorEwlQWV
         4oE4YaF/cBk24L7OJyWEDpZwx++z38f1GDvyK+pO2ZWLdkpSN29HGoj4ZEcSRK6BbW1K
         860iPLg4OlibW+f1TIpjVr56dMjlG68vKzKO84puFGo7U7QsXvpqjoiZLW1hkYauNbhV
         XAcgKEBtzdaa6y3etzsmU6phRO9lIOIbqFWyhcAjcEd/7PA+utFz3UjU5XleYKMTSCqS
         EEKg==
X-Gm-Message-State: AOAM532FSdNTJeNUzKKC5t65BWobJR2yJndweV2o59Q830EngjJ1HRZx
        yCRl03Jk3cAZn2RrMQckc3hGdDd44RaEZK1VrIFNpQ==
X-Google-Smtp-Source: ABdhPJxWoQYefeTGAUQ3FV7Srjws4aPms4JUP73DPTY+Y87Ey6NVw+RkHp2kdVWionVILEOUvztOvQ941rAhRMwLGy0=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr36942164lji.326.1621247172915;
 Mon, 17 May 2021 03:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210511021656.17719-1-ansuelsmth@gmail.com> <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain> <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
In-Reply-To: <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 12:26:02 +0200
Message-ID: <CACRpkdYM5Rk9qxhkpsWqaGp-uZDoHJ3_r0605vC9SLQw6=BCAQ@mail.gmail.com>
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 6:26 AM Ard Biesheuvel <ardb@kernel.org> wrote:

> I used to carry a PCIe serial port
> card to UEFI plugfests because that was the only thing that would stop
> working if a system configured its I/O resource window incorrectly

I've been looking for a thing like that for testing, I was actually
thinking that it would perhaps be a good idea to add a I/O-resource
requiring device to QEMU just to be able to test this kind of
thing for completeness.

Yours,
Linus Walleij

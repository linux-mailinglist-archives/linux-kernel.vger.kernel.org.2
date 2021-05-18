Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916DC38823F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352529AbhERVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhERVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:40:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F21C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:38:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o8so13243535ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W1+DjjDR1PzHAHB0iKIOBjqYLk0N/OCWglAnEURxiU=;
        b=XqonLZtzFwD9xdcn38HwBYY4vD6yrVbdymfeBBbcMFYaXsW/826cqUlemFTFHt0fMA
         Ci8cJvxNl9KEmUe6ckfjpfYtuRLVKVfRxw0O7608KrlKv13OIV8QqtCYntAYRQBowJQQ
         pjb5RSJSX6zxH49Hif78cQ4DtPv3UejY3vn7XDhiCBmZp/c9c1BFnb8fYYno0bNIe4Zw
         swFh8N4Z124VSQirOR0fq8CqhchL6vSSZRhsvhXG66JP3qR44/ZrqdJTTeXaKlP3iFrE
         t3uib9NKcaND1NOifZF6DuUcwbrUJrAxs0J58UbUBvx157a5aeh8jb7to2Yk/fETbrgs
         UZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W1+DjjDR1PzHAHB0iKIOBjqYLk0N/OCWglAnEURxiU=;
        b=oQJAmw17JvBPMJFGuWtqB/mvKMeSHWIzH73HAleGDFBX2t1vyopRpxBwTpytH6gXxn
         4TC9SWF7Ret44dkH6r6kKKz83AzyQ/XZ1jvayrvRfC1LHFak+Xv9ofBpaO9sXa+gmTqG
         4XgehDK0FGfsNrphHM3xGa1+lZF6vHbf6WHqPT/FiC6NZHQqQ6M9ziM8aTPuZnsAJbPA
         dbo3cLK8tABvJRnvK2+SIQWBka47cqL48loGTDuDqFe1zyH3ZIx6CxAPYzUQXIxOOnOI
         uoa4YEK6V+GJARULQyRK5CMovjzZ48yWFyFNNHf97uuWC76EvYJ/qetro0LnD2p0LcvP
         lAdg==
X-Gm-Message-State: AOAM532/GkxlhtXXfkFQSY50YPDBXLCrWYiGAh6SHQz3wt0lS2Q7n3t6
        D7AU2RWPUyIGXFD/bUuz3gzIbHNrxW8vvNaEdYv4yg==
X-Google-Smtp-Source: ABdhPJwRq7lDUNPROHEDF3nFQT2fbxp88IB7Z6nRtmRVI5xugU4a27mWVnbK4uJcIJfR10aiX4AiRMKIg9kg99+34Fc=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr5624837lji.273.1621373929345;
 Tue, 18 May 2021 14:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210518151655.125153-1-clabbe@baylibre.com> <20210518151655.125153-2-clabbe@baylibre.com>
In-Reply-To: <20210518151655.125153-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:38:38 +0200
Message-ID: <CACRpkdZ5ced+S6fQBAMeMuYhC3RN1q88DLyEr=gaPO6h=i26vA@mail.gmail.com>
Subject: Re: [PATCH 1/5] db-dinding: crypto: Add DT bindings documentation for sl3516-ce
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:17 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> This patch adds documentation for Device-Tree bindings for the
> SL3516-ce cryptographic offloader driver.
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Apart from misspelled subject "db-binding" I don't see any problems
so
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

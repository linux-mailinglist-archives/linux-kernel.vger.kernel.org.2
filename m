Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0B375248
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhEFK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhEFK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:27:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:26:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v5so6364196ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7Lt8jBe6wv03L7Ev9R6s3zonVps5OT2POfrWhLS1O0=;
        b=NFJsPlS4lkvyLn3LRx72UHEDMNshTOZzxwz0yMZzQM6RudpaF5F5pOomw4noNlH8dy
         reociugEQom2ZHSOMYToiAPYZdzIJO/p8iL9V5JcvEJH9qsqf/wq7jrSTNKNIMD3T7Ld
         Uf6ZntZVT3+DdZ4u5NHcPdG/4UmvQWRE12E5GxaYNuVob8DwmjsDnbyrGsa69KccIcKT
         WWJ6pFdJtiJjnqHni4xcUxmZ4pQnJPX4UvBwrFvh5npNzgcNKa2lnh+DgpP/1S9x3EdP
         vinGZfVu/Dm2a6PBStO/6vI4c4a8O7ijr0qWEy65WJnaGUpeYh0oue0/LPAUxPNS70pA
         egFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7Lt8jBe6wv03L7Ev9R6s3zonVps5OT2POfrWhLS1O0=;
        b=KsySmZ8WdMaSbCQeJCfmz2mCKSiz9QpvOcD8O3QyklZ5Xwr0gdC+VgCDovd5jA7xYX
         WMuw/yWg0TYK8rVEjdJVYoM+3juq7E/hr+4Bc9J+85qU5ed/SQuwEBtYhZWGjwT4BN6b
         /ZZ8Mpb+mSqWaAyhhTafQH/crAAP4uuyCOfsH1M87kaptlXzsJr1zkjXUZYzOUkaNkvk
         3ezaWK+/47p/NGJT08dBLV1ymPNgIzVE3dFHmBwA50sJ9/9mrmIwlp0tkjIzhCVjd8HQ
         7N2Ed1hW6TtHPJNaNWL+E5au7IUImL2kCExwrTbNO3ynCSfUKHkehwUy5UvEo2x+RlC0
         BIWQ==
X-Gm-Message-State: AOAM531+avcOHcTH3VrkgUNQn9w2T2f0NURBndgncJh3ocw6thAATwkj
        TzdO3b6rQiHiP4IhpF1bjHaejPxXA+0ZY+MS5RyggA==
X-Google-Smtp-Source: ABdhPJxci8zA6ho0aB6xDVxMD+TN9K2noCf9jKls117BIuDpVHkP+exwEZFomfQiAE5eaq4sUwzXLRUcJth0e2ZqDP8=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr2938854ljg.74.1620296803490;
 Thu, 06 May 2021 03:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210428175503.3692090-1-clabbe@baylibre.com>
In-Reply-To: <20210428175503.3692090-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:26:32 +0200
Message-ID: <CACRpkdY43=Uh+EVSOPHqNgrhVfgpubZNtXRzO5nW335R6aJGbg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gemini: rename to nand-controller
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 7:55 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> We must use nand-controller instead of flash.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Hm, this flash memory isn't NAND, it is just memory-mapped
NOR flash.

The example for CFI NOR flash in
Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
clearly uses the node name "flash@"

There is however a real NAND and serial flash memory
controller at 0x65000000, but I haven't seen a platform
that uses it.

The extra compatible string "cortina,gemini-flash"
turns on some Gemini-specific checks, but it
goes into the global system controller, not the NAND
controller, as the system controller confusingly have
some registers for detecting NOR memory config.
drivers/mtd/maps/physmap-gemini.c

Yours,
Linus Walleij

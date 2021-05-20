Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9638BA68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhETXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhETXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:35:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:34:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m11so27002731lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llK59j8OFMxBzF3JzQxhmdaQJIsvVzuuTKWfTfzd8M8=;
        b=SMo82Y1lpv+DuTIy8w/IeeH42vK/crTaxnuvjNz/miZs34KxNdhASSVDoamnHJBmnI
         JcTi8z6q8nS3T15FIarT/kr1O1dnfvQpuzV6T41C3+jLk6nrWiwaWnLUyWFB6xptI8BJ
         g21l8HFK3nI3jmWuBPbONWsy2WJLLf5K3nuA2+ONcD1aMZNC+7uuLNqEYZ7ZXBHiFR98
         tCkfM4ShtMsypA/RVUbgNVHSScAKzpa8vbbQ8psK62I+EgdUUDOb105MirQFV9Kd72gl
         9i5Z8vjVqr4+kMtp3w8kg24iBeW5I2m/nPL7sTEcQZ4fP7oTeR4MeGqQBDyChMnrfFN3
         0k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llK59j8OFMxBzF3JzQxhmdaQJIsvVzuuTKWfTfzd8M8=;
        b=Tctjf0jB9rim+6D8PbaRS9JyhOkNJhV3ZYoCgQFLaQygG38PPiIgg4X6DqeI6eSLXU
         FINDFsnXgUgiX3/oPcoJqQGHnzzayuCassjEaKCx/CBEW7bJvW42NRQNy5VKhtlNA08l
         wLNAf9GK5cXdKzHzUbxE3ol5VHu8vD3tm2jqY6ijkN4VbMq11v6mZeYC8O4+KsbLl7yX
         WCnsghzRD3p5NIkfReeyJeL7eUFDS8hhh/swnjLdQbpT6azOofBvI/wsNFmYTuDKo05w
         k2srKNiIz2LaFJE8gg+vcLCedJ2DDfKoNt1ZK2nL1E3Ir7OQRJrIZaMRm2lFVqhRYq02
         Pm4g==
X-Gm-Message-State: AOAM533xPBZ0qsUWmU3AI5SqjxDsEWp/Ber+qmhnlcM0dgN//HzalnlD
        MuNoeudR6dLrVtkkSczDxH8xabQjjoVzpwYOdN+f5Q==
X-Google-Smtp-Source: ABdhPJyqaPguBcc4YTpDvZkq8sMJNEc8SbDnXLRI45CbzFNmsvwZ2VCXuidQCIIy7f80mz/wJrhWnAANfiO8vNLIrqY=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr4724933lfn.465.1621553650026;
 Thu, 20 May 2021 16:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org>
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 May 2021 01:33:58 +0200
Message-ID: <CACRpkdZpn3x-P9rsoMUE0uG_19aG5jHWvv7FD7srtmW92Q1oag@mail.gmail.com>
Subject: Re: [PATCH 00/39] irqdomain: Simplify interrupt handling
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:37 PM Marc Zyngier <maz@kernel.org> wrote:

> Wouldn't it be nice if the irqdomain
> would cache the irq_desc instead of forcing the core code to look it
> up on each and every interrupt? This is what this long series is all
> about.

For gpio and pinctrl bulk conversions:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I agree that Rob's idea to create a bitmap walker may be helpful
if you have the energy for it, but this as a whole is nevertheless good.

Do they have to be applied en masse?

I think there could be some clashes and new drivers that will
create weirdness in that case so an immutable branch for
maintainers to pull in will be needed if you want it all in the
next merge window.

Unless you plan to merge the bottom
patches and then let subsystem maintainers convert each
subsystem in the next merge window.

Or a base to be pulled in and then each subsystem can
apply the bulk conversion to their subsystem only.

So looking for a merging strategy!

Yours,
Linus Walleij

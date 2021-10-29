Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C884401A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJ2SHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ2SHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:07:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3452C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:05:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n7so18162968ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6KCBeD/pNCG9HZQnIVtuH+wCZVkgQgovkR8K6qXsz0=;
        b=DK+Tp3O/3gtk6Mj6EirsKfvX8mAe0+szIVxVBHJaMcoxLOtuvV48Rqi0Ta0I9gUMTR
         F0btd8b3EQOXM97fEoJPbO3hLFaaM//stWMVDGe6zk5xsGZmTRz6EQE2YKHKyw7CXr/F
         N8UoFNI/13+/GBJUOvYX4fRekOCCnOhfYNR30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6KCBeD/pNCG9HZQnIVtuH+wCZVkgQgovkR8K6qXsz0=;
        b=K28UVlyPf8Mro90f0wTSPcApw/xyFXj3YVPwX4iIH/mrndN4oQkl6l2MPgjqSCRA0w
         biKnDmXDMrNgJI8XC/OrSmA2eGN+CmmeZ+f5MoyrLtyDkfY1f/eYEb1ajLOG8gv831lt
         ADwLFzeHGh3Aa2QZ5CfDVnzyWlvxz427vsVsheZcBK2xHaRSd4sui08LAHlLKzC4/K/A
         5fNTrIEvZueGNSkz0ClcjneDxVqmxTpMxTrXRgQtJF21bKZhQOPrxHqPM+eNwLky+Emm
         Qy/dpohF+g/XTOrmmj3BnvUYk52JgpZvE1cQ8taCzkBa8YQr/VId274bojQiKgTzvKK4
         hALQ==
X-Gm-Message-State: AOAM532CxPV3zK7WrddHzjPuSHzWENyL18TNAeVuSWnR+kI6J+fNzLYO
        SKI0PAMSPLpp3njl/TofhvzltR5Mr6R8AnSI8eQ=
X-Google-Smtp-Source: ABdhPJzya/lzrO9DL2ryTlBealZp+01dVqf1iSSw4UOyWtKSyAaSsOW1epXEq6D8vZPo+nM5KeJpRw==
X-Received: by 2002:a05:651c:1686:: with SMTP id bd6mr13442552ljb.480.1635530710395;
        Fri, 29 Oct 2021 11:05:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id bd19sm680474ljb.28.2021.10.29.11.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:05:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id f3so14423325lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:05:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr9826124lfu.402.1635530709299;
 Fri, 29 Oct 2021 11:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211029120709.79366-1-ulf.hansson@linaro.org>
In-Reply-To: <20211029120709.79366-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 11:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
Message-ID: <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc8
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>  - winbond: Silences build errors on M68K

I think this one is wrong.

I think the problem is that m68k declares "claim_dma_lock()" in the
wrong header file. It's in <asm/floppy.h> instead of <asm/dma.h>

I'm somewhat surprised that this doesn't hit m68k in other places -
there are other drivers that use that same ISA DMA interface.

I've pulled this, but I hate how random that fix is.

(And on the topic of hate - the merge messages are just auto-munged
from the commit line - please spend a _bit_ more time on it, ok? Or at
least make it closer to proper English - things like "Re-enable card
irqs after a reset in tmio driver" instead of "tmio: Re-enable card
irqs after a reset")

              Linus
